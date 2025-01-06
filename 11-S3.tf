#Because buckets need unique names, I added randomizer string as a suffix
#This is a random string generator
resource "random_id" "bucket_suffix" {
  byte_length = 6
}
#create Images bucket
resource "aws_s3_bucket" "images_bucket" {
  bucket = "${var.images_bucket_name}-${random_id.bucket_suffix.hex}"
  tags = {
    Name = "Images"
  }

}

#memes folder
resource "aws_s3_object" "memes_folder" {
  bucket = aws_s3_bucket.images_bucket.bucket
  key    = "memes/"
}
#Do I need to create an archive folder?
resource "aws_s3_object" "archive_folder" {
  bucket = aws_s3_bucket.images_bucket.bucket
  key    = "archive/"
}
#30 days transition to Glacier Lifecycle policy 
resource "aws_s3_bucket_lifecycle_configuration" "images_lifecycle" {
  bucket = aws_s3_bucket.images_bucket.id

  rule {
    id     = "images-transition"
    status = "Enabled"

    filter {
      prefix = "memes/" // Apply to all objects in the memes folder
    }

    transition {
      days          = 90
      storage_class = "GLACIER"
    }
  }
}

#create Logs bucket
resource "aws_s3_bucket" "logs_bucket" {
  bucket = "${var.logs_bucket_name}-${random_id.bucket_suffix.hex}"
  tags = {
    Name = "Logs"
  }
}
#active folder, in Logs bucket
resource "aws_s3_object" "active_folder" {
  bucket = aws_s3_bucket.logs_bucket.bucket
  key    = "active/"
}

#inactive folder, in Logs bucket
resource "aws_s3_object" "inactive_folder" {
  bucket = aws_s3_bucket.logs_bucket.bucket
  key    = "inactive/"
}

#log access role name
resource "aws_iam_role" "ec2_write_to_logs" {
  name = var.logs_access_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

#Policy to allow writing to logs bucket
resource "aws_iam_policy" "write_to_logs_policy" {
  name        = "write_to_logs_policy"
  description = "Policy to allow writing to logs bucket"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:PutObject",
          "s3:PutObjectAcl"
        ]
        Effect   = "Allow"
        Resource = "${aws_s3_bucket.logs_bucket.arn}/*"
      }
    ]
  })
}
#Attach policy to role
resource "aws_iam_role_policy_attachment" "attach_write_to_logs_policy" {
  role       = aws_iam_role.ec2_write_to_logs.name
  policy_arn = aws_iam_policy.write_to_logs_policy.arn
}


#90 days transition to Glacier Lifecycle policy 
resource "aws_s3_bucket_lifecycle_configuration" "active_lifecycle" {
  bucket = aws_s3_bucket.logs_bucket.id

  rule {
    id     = "move objects older than 90 days to glacier-active"
    status = "Enabled"

    filter {
      prefix = "active/" // Apply to all objects in the bucket
    }

    transition {
      days          = 90
      storage_class = "GLACIER"
    }
  }

  #90 days delete policy 
  rule {
    id     = "delete objects older than 90 days-inactive"
    status = "Enabled"

    filter {
      prefix = "inactive/" // Apply to all objects in the bucket
    }

    expiration {
      days = 90
    }
  }
}

