package main

import data.s3.s3_buckets_without_aes256.s3_buckets_without_aes256
import data.s3.s3_buckets_non_private.s3_buckets_non_private

deny[msg] {
	count(s3_buckets_without_aes256) > 0
  msg := sprintf("bucket %s has an invalid encryption algorithm", [s3_buckets_without_aes256[_]])
}

deny[msg] {
  count(s3_buckets_non_private) > 0
	msg := sprintf("bucket %s is not set to private", [s3_buckets_non_private[_]])
}

allow {
	count(deny) == 0
}