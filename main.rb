#!/usr/bin/env ruby

require './parser'

puts Parser.new.parseFile($*.first).size