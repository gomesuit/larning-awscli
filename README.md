# larning-awscli



```
aws iam list-access-keys --output text | awk '{print $2}' | xargs -n 1 aws iam get-access-key-last-used --access-key-id --output table
```



