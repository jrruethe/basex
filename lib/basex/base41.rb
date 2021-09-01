#!/usr/bin/env ruby

require "basex"

module BaseX

  # Model after https://datatracker.ietf.org/doc/draft-faltstrom-base45/
  # But use Base41
  # 0–9, A–Z (upper-case only), space, $, %, *, +, -, ., /, :
  # Drop space, %, /, :
  # Use : for padding
  # Ideal for QR codes
  class Base41 < BaseX

    def initialize
      super(
        output_base: 41,
        input_ratio: 2,
        output_ratio: 3,
        output_symbol_table: "0123456789ABCDEFGHIJKLMNOPQRSTUVQXYZ$*+-.",
        padding_symbol: ":"
      )
    end

  end

end
