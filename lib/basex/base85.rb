#!/usr/bin/env ruby

require "basex"

module BaseX

  # Uses the Safe85 alphabet
  # with "<" for the padding character
  # https://github.com/kstenerud/safe-encoding/blob/master/safe85-specification.md
  # Ideal for digital text
  class Base85 < BaseX

    def initialize
      super(
        output_base: 85,
        input_ratio: 4,
        output_ratio: 5,
        output_symbol_table: "!$()*+,-.0123456789:;=>@ABCDEFGHIJKLMNOPQRSTUVWXYZ[]^_`abcdefghijklmnopqrstuvwxyz{|}~",
        padding_symbol: "<"
      )
    end

  end

end
