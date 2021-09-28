# Testing Markdown

* [Relative file link](../../examples/for-production/infrastructure-live/second.md)
* [Relative path link](/examples/for-production/infrastructure-live/)

![](images/grunty.png)

Here is an included `main.tf`:

include::../../examples/for-production/infrastructure-live/main.tf

Here is the second resource only (lines 5-7)

include::../../examples/for-production/infrastructure-live/main.tf[5..7]
