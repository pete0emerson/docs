# Testing Markdown

* Here is [Relative file link](../../examples/for-production/infrastructure-live/second.md) with some text
* [Relative path link](/examples/for-production/infrastructure-live/)

![](images/grunty.png)

Here is an included `main.tf`:

```
resource "foo" "bar" {
	...
}

resource "foo" "baz" {
	...
}
```

Here is the second resource only (lines 5-7)

```
resource "foo" "baz" {
	...
}
```
