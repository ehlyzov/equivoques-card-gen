# -*- coding: utf-8 -*-
require 'prawn'
require "prawn/measurement_extensions"
require 'pathname'

module Generators
  class Regular

    def self.data_dir
      @_data_dir ||= Pathname.new("./assets").expand_path
    end

    def self.assets
      @_assets ||= {
        fonts: {
          regular: self.data_dir + 'KievitPro-Regular.ttf',
          bold: self.data_dir + 'KievitPro-Bold.ttf',
          crc: self.data_dir + 'CRC55.ttf'
        },
        graphics: {
          foreground: self.data_dir + 'Equivoques Inside CardReg.png',
          background: self.data_dir + 'Equivoques Cover CardReg.png'
        }
      }
    end

    def initialize(options)
      @title = options[:title]
      @words = options[:words]
      @author = options[:author]
      @pdf = Prawn::Document.new(
        margin: [0,0],
        page_layout: :portrait,
        page_size: [60.mm, 85.mm]
      )

      @x = 26.mm

      @labels = [
        "Решительный отказ",
        "Навуходоносор",
        "Билет",
        "Хлеб всему голова",
        "Ирония Судьбы"
      ]

      @lines_y_offsets = [
        70.mm,
        57.mm,
        47.mm,
        37.mm,
        27.mm
      ]

      @lines_heights = [
        10.mm,
        6.mm,
        6.mm,
        6.mm,
        6.mm
      ]
      
      @pdf.image self.class.assets[:graphics][:foreground], width: 60.mm
      
      @pdf.font(self.class.assets[:fonts][:regular], size: 8) do
        print_title
        print_words
        print_author
      end

      @pdf.image self.class.assets[:graphics][:background], width: 60.mm
      
    end
    
    def render
      @pdf.render
    end

    private

    def print_title
      @pdf.text_box @title,
        at: [5.mm, 77.5.mm],
        valign: :center,
        align: :center,
        width: 50.mm,
        height: 6.mm
    end

    def print_words
      @words.each_with_index do |word, i|
        @pdf.text_box word,
          at: [@x, @lines_y_offsets[i]],
          valign: :center,
          align: :left,
          overflow: :shrink_to_fit,
          min_font_size: 5,
          width: 27.mm,
          height: @lines_heights[i]
      end
    end

    def print_author
      @pdf.text_box @author,
        at: [5.mm, 14.mm],
        valign: :center,
        align: :center,
        width: 50.mm,
        height: 6.mm
    end    
    
  end
end
