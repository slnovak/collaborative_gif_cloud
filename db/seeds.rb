# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
gifs = [{
    title: "Annoyed",
    description: "It ain't easy bein' the cap'n.",
    tag_list: "giphy, star trek",
    metadata: { source: "http://i.giphy.com/119XyLewLGmT0k.gif" },
    image: open("http://i.giphy.com/119XyLewLGmT0k.gif"),
    user: User.first
  },{
    title: "Nooppppeeee.",
    description: "David tennant nods 'nope!'",
    tag_list: "giphy, doctor who",
    metadata: { source: "http://i.giphy.com/EVbEdEW3kuu0o.gif" },
    image: open("http://i.giphy.com/EVbEdEW3kuu0o.gif"),
    user: User.first
  },{
    title: "Of course!",
    description: "David Tennant figures it out",
    tag_list: "giphy, doctor who",
    metadata: { source: "http://i.giphy.com/mAyKtbkBTTpFm.gif" },
    image: open("http://i.giphy.com/mAyKtbkBTTpFm.gif"),
    user: User.first
  },{
    title: "Lost",
    description: "Even the Doctor gets lost every now and then",
    tag_list: "giphy, doctor who",
    metadata: { source: "http://i.giphy.com/3TIzY5q49YXok.gif" },
    image: open("http://i.giphy.com/3TIzY5q49YXok.gif"),
    user: User.first
  },{
    title: "Kitteh in reverse",
    description: "The gif that started it all",
    tag_list: "cats, reverse",
    metadata: { source: "http://i.imgur.com/HyERHlZ.gif" },
    image: open("http://i.imgur.com/HyERHlZ.gif"),
    user: User.first
  },{
    title: "The kitteh escape",
    description: "A cat makes an awkward escape",
    tag_list: "cats",
    metadata: { source: "http://i.imgur.com/4XiFgJp.gif" },
    image: open("http://i.imgur.com/4XiFgJp.gif"),
    user: User.first
  },{
    title: "Excited!",
    description: "Lucille is excited!",
    tag_list: "arrested development, excited",
    metadata: { source: "http://i.giphy.com/q6QHDGE3X4EWA.gif" },
    image: open("http://i.giphy.com/q6QHDGE3X4EWA.gif"),
    user: User.first
  },{
    title: "A huge tiny mistake",
    description: "I've made a huge tiny mistake.",
    tag_list: "arrested development, mistakes",
    metadata: { source: "http://i.giphy.com/1rBCI5HKJPd0k.gif" },
    image: open("http://i.giphy.com/1rBCI5HKJPd0k.gif"),
    user: User.first
  },{
    title: "A huge mistake",
    description: "I've made a huge mistake",
    tag_list: "arrested development, mistakes",
    metadata: { source: "http://i.giphy.com/S7aF5YPXDMMwM.gif" },
    image: open("http://i.giphy.com/S7aF5YPXDMMwM.gif"),
    user: User.first
  },{
    title: "The banana stand",
    description: "There's always money in the banana stand",
    tag_list: "arrested development",
    metadata: { source: "http://i.giphy.com/nkOqBHEJ1hcTm.gif" },
    image: open("http://i.giphy.com/nkOqBHEJ1hcTm.gif"),
    user: User.first
  },{
    title: "No touching!",
    description: "No touching!",
    tag_list: "arrested development",
    metadata: { source: "http://i.giphy.com/vLx3t1tVQGzwA.gif" },
    image: open("http://i.giphy.com/vLx3t1tVQGzwA.gif"),
    user: User.first
  }]

gifs.each do |gif|
  GIF.create(gif)
end
