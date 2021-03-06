# Package Indexer

This simple package indexer has been built in Ruby and accepts connections from concurrent clients on port 8080. This has been tested with a test suite written in Go, as captured in the video below.

[![asciicast](https://asciinema.org/a/4fz2shzizionrzqtciyzq7lwf.png)](https://asciinema.org/a/4fz2shzizionrzqtciyzq7lwf?autoplay=1)

## Setup

``` sh
$ git clone https://github.com/michdsouza/package-indexer
$ cd package_indexer
$ bundle install
$ ruby ./lib/tcp_server.rb
```

## Run Tests

Used Rspec3 for testing

``` sh
$ cd package_indexer
$ rspec
```

## Docker

A Dockerfile has been included. 

``` sh
$ docker build -t tcp_server .
$ docker run --rm -p 8080:8080 tcp_server ruby /package_indexer/lib/tcp_server.rb
```

## Rubocop

To stay within the guidelines enforced by the community [Ruby Style Guide](https://github.com/bbatsov/ruby-style-guide), Rubocop was used for static code analysis and styling.

## Design Choices

At the core of the design is the use of a Graph to represent the linkages between indexed packages. The [Adjacency Matrix](https://en.wikipedia.org/wiki/Adjacency_matrix) data structure was used to represent the graph in the code. Packages can be added (indexed), removed and queried using a list of libraries. The adjacency matrix in the <b>Graph</b> object covers the scenario where packages can have multiple dependencies, which need to exist as "nodes" in the graph before the package itself can be indexed. 

The current implementation is an in-memory graph. No external persistence was implemented.

The <b>InputProcessor</b> class is used to validate, split and process commands.

The TCP Server was the simplest possible implementation to satisfy 100x concurrency, along with thread synchronization via Mutex.
