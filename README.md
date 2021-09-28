# docs

Generate docs like this:

```
./generate_docs.sh pete0emerson/terraform-aws-fake tutorials/fake fake v0.0.3
```

This will check out the `pete0emerson/terraform-aws-fake` repository and copy the `tutorials/fake` content from it into `content/fake`.
It will also figure out included content (`include::` directive) with or without line number limiters.

You can see that generated content [here](content/fake/v0.0.3).

If you make a change to pete0emerson/terraform-aws-fake/tutorials/fake somewhere, commit it, and do a new release (v.0.0.4), then you can run:

```
./generate_docs.sh pete0emerson/terraform-aws-fake tutorials/fake fake v0.0.4
```

and commit the changes and see them.

Some observations:

* The coding for this gets beyond my shell capabilities. I'd write it in golang.
* Links that we might want to rewrite to link to the original repository are not being re-written.
