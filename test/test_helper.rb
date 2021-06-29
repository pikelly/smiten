# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "smiten"
require "common"

require 'yaml'

require "minitest/autorun"

Conygred = { name: 'conygred', player_id: 720885066, xbox_id: 2535432204002199, steam_id: 724806491 }.freeze

