NOTES
===

Dockerfile.exploded
---

This is an example file that puts the coral recipes and files into the container one at a time,
instead of putting the whole chef directory in at once.  The advantage of doing it this way,
is that you can use the docker cache to debug recipes.  If something goes wrong in recipe 9 of 10,
the docker cache will save you the time of running recipes 1-8 all over again.
