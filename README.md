Terraform IP Whitelist
======================


An example project to set up Terraform IP whitelist


Please do not forget to read the related blog post at https://jonnyzzz.com/blog/2019/04/29/terraform-waf/

The root folder shows and example if the `ip-whitelist` module. 

In the `sg` folder you'll find an usage of the module with Security Groups

The `waf` dirrectory illustrates WAF rules configuration for CloudFront

License
-------

MIT, see LICENSE file on the repository


Running
-------

You may run the example module, for that, simply say the following commands (on Lunix or macOS with Docker):

```
./terraform init
./terraform apply
```

Checkout `sg` and `waf` folders for more examples!


