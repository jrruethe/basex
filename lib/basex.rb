#!/usr/bin/env ruby

module BaseX

  class BaseX
    BINARY = 0.upto(255).map{|i| i.chr.to_s}.to_a

    def initialize(
      input_base: 256,
      input_ratio: nil,
      input_symbol_table: BINARY,
      output_base: nil,
      output_ratio: nil,
      output_symbol_table: nil,
      padding_symbol: nil
    )
      @input_base          = input_base
      @input_ratio         = input_ratio
      @input_symbol_table  = input_symbol_table
      @output_base         = output_base
      @output_ratio        = output_ratio
      @output_symbol_table = output_symbol_table.split("")
      @padding_symbol      = padding_symbol

      @padded_input_symbol_table   = @input_symbol_table + [@padding_symbol]
      @padded_output_symbol_table = @output_symbol_table + [@padding_symbol]
    end

    def self.encode(data)
      self.new.encode(data)
    end

    def self.decode(data)
      self.new.decode(data)
    end

    def encode(input_data)
      input_data = input_data.split("").map{|i| @input_symbol_table.index(i)}
      raise "Error" if input_data.any?(nil)
      output_data = encode_raw(
        input_data: input_data,
        input_base: @input_base,
        output_base: @output_base,
        input_ratio: @input_ratio,
        output_ratio: @output_ratio
      )
      return output_data.map{|i| @padded_output_symbol_table[i]}.join
    end

    def decode(input_data)
      input_data = input_data.chomp.split("").map{|i| @padded_output_symbol_table.index(i)}
      raise "Error" if input_data.any?(nil)
      padding_length = input_data.count(@output_base)
      input_data.map!{|s| s != @output_base ? s : @output_base - 1}
      output_data = encode_raw(
        input_data: input_data,
        input_base: @output_base,
        output_base: @input_base,
        input_ratio: @output_ratio,
        output_ratio: @input_ratio
      )
      padding_length.times{|i| output_data.pop}
      return output_data.map{|i| @input_symbol_table[i]}.join
    end

    private

    def encode_raw(
      input_data: nil,
      input_base: nil,
      input_ratio: nil,
      output_base: nil,
      output_ratio: nil
    )
      input_length = input_data.length
      input_nearest_length = nearest_length(input_length, input_ratio)
      padding_length = input_nearest_length - input_length
      output_length = (input_nearest_length / input_ratio) * output_ratio

      output_data = [0] * output_length
      input_data += [0] * padding_length

      (0...input_nearest_length).step(input_ratio).each do |i|
        store = 0

        (0...input_ratio).each do |j|
          symbol = input_data[i + j]
          symbol *= (input_base ** (input_ratio - j - 1))
          store += symbol
        end

        (0...output_ratio).each do |k|
          index = ((i / input_ratio) * output_ratio) + k
          temp = (output_base ** (output_ratio - k - 1))
          symbol = store / temp
          output_data[index] = symbol
          store -= (symbol * temp)
        end

      end
      (output_length - padding_length...output_length).each do |i|
        output_data[i] = output_base
      end

      return output_data
    end

    def nearest_length(length, ratio)
      overlap = length % ratio
      overlap == 0 ? length : (((length - overlap) / ratio) + 1) * ratio
    end

  end

end
