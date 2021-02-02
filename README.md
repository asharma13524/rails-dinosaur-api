# README

I ran out of time but some things I would want to do:

-   namespace/versioning the api
-
-   add representers
-   Test my create dinosaur route with more robust cases (it may be failing in some cases)
-   seeding the test database
-   abstracting out some of my logic in routes to make my code read easier
-   add model tests and more tests in general

If the application were intented to run in a concurrent environment, I could perhaps use a threaded web server, like Puma. I believe I could use a threaded active job adapter that does have built-in Async which could execute multiple jobs at the same time. I would definitely have to read a bit more about the specifics, but these are a few points.
