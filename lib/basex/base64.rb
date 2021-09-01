#!/usr/bin/env ruby

require "basex"

module BaseX

  # Standard base64 (RFC 4648)
  # A-Z, 0-9, +, /, =
  # Ideal for compatability
  class Base64 < BaseX

    def initialize
      super(
        output_base: 64,
        input_ratio: 3,
        output_ratio: 4,
        output_symbol_table: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/",
        padding_symbol: "="
      )
    end

  end

end
