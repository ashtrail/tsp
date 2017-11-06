#!/usr/bin/env ruby

require './parser'

Parser.new.parse_file($*.first).check_graph