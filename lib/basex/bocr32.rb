#!/usr/bin/env ruby

require "basex"

module BaseX

  # Modified base32
  # https://www.monperrus.net/martin/perfect-ocr-digital-data
  # Adds 2, 4, uses = for padding
  # Ideal for OCR, use Inconsolata font
  class Bocr32 < BaseX

    def initialize
      super(
        output_base: 32,
        input_ratio: 5,
        output_ratio: 8,
        output_symbol_table: "!(+./23467;?acdefghjkmnoprstwxz}",
        padding_symbol: "="
      )
    end

  end

end
