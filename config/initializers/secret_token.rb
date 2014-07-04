# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Evented::Application.config.secret_key_base = '3d99c1652b14447a1db887dd676930e6c02a5cffc57a192337d10c95cafe1664694c01ebc7313b77825aad41242d316ce209962430da4c0c6fa03bbcc2bed25b'
