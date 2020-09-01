require 'json'
require 'date'
require 'digest'

json = JSON.parse(open('./_data/bookmarks.json').read)

json.each do |b|
  next if b['get'] != 'true'
  date = Date.parse b['date']
  content = <<-EOS
---
date: #{date.iso8601}
layout: post
title: #{b['title']}
subtitle: 
description: >-
  #{b['description']}
image: #{b['image']}
category: #{b['category']}
tags:
  - #{b['tags'].split(",").join("\n  - ")}
author: goofmint
paginate: true
---
#{b['summary']}

[#{b['title']}](#{b['url']})
  EOS
  f = open("./_posts/#{date.strftime('%Y-%m-%d')}-#{Digest::SHA256.hexdigest(b['title'])}.md", 'w')
  f.write(content)
  f.close
end
