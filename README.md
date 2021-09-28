# docs

Generate docs like this:

```
./generate_docs.sh pete0emerson/terraform-aws-fake tutorials/fake fake v0.0.3
```

This will check out the `pete0emerson/terraform-aws-fake` repository and copy the `tutorials/fake` content from it into `content/fake`.
It will also figure out included content (`include::` directive) with or without line number limiters.

You can see that generated content [here](content/fake/v0.0.3).

If you want to see some changes, run this:

```
./generate_docs.sh pete0emerson/terraform-aws-fake tutorials/fake fake v0.0.4
```

Tou can now see the files ready to be committed and deployed:

```
 docs git:(main) ✗ $ git status -u
On branch main
Your branch is up to date with 'origin/main'.

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	content/fake/v0.0.4/README.md
	content/fake/v0.0.4/images/grunty.png

nothing added to commit but untracked files present (use "git add" to track)
```

Feel free to cut a new release and try the whole cycle out.

Some observations:

* This handles versioning well
* The coding for this quickly gets beyond my shell capabilities. I'd write it in golang. There's stuff I just can't do as easily with my bash skills.
* Links that we might want to rewrite to link to the original repository are not being re-written.
* The logic just isn't that difficult, but I'm interested in finding where this is going to get really hard (other than hitting my limitations with bash)
* I started out with a `site.yml` file, it may make sense to use something like this to generate the parameters that need to be passed to `generate_docs.sh`. At any rate, it won't be difficult to write some code to pull repo names and release versions and loop the call.
* I am still convinced having tutorials like these live near the code is the right thing to do from a developer experience
