#!/usr/bin/env ruby

require "basex"

module BaseX

  # Standard base32 (RFC 4648)
  # A-Z, 2-7, =
  # Ideal for analog text
  class Base32 < BaseX

    def initialize
      super(
        output_base: 32,
        input_ratio: 5,
        output_ratio: 8,
        output_symbol_table: "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567",
        padding_symbol: "="
      )
    end

  end

end
