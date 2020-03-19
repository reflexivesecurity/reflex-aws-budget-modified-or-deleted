# reflex-aws-budget-modified-or-deleted
A Reflex Rule for detecting the modification or deletion of an AWS Budget.

## Usage
To use this rule either add it to your `reflex.yaml` configuration file:  
```
rules:
  - reflex-aws-budget-modified-or-deleted:
      version: latest
```

or add it directly to your Terraform:  
```
...

module "reflex-aws-budget-modified-or-deleted" {
  source           = "github.com/cloudmitigator/reflex-aws-budget-modified-or-deleted"
}

...
```

## License
This Reflex rule is made available under the MPL 2.0 license. For more information view the [LICENSE](https://github.com/cloudmitigator/reflex-aws-budget-modified-or-deleted/blob/master/LICENSE) 
