output arn {
  value = module.lambda.arn
}

output function_name {
  value = module.lambda.function_name
}

output invoke_arn {
  value = module.lambda.invoke_arn
}

output role_name {
  value = module.lambda.lambda_role.name
}
