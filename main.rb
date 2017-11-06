#!/usr/bin/env ruby

require './parser'

Parser.new.parseFile($*.first).check_graph