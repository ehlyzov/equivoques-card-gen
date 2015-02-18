# -*- coding: utf-8 -*-
require 'prawn'
require "prawn/measurement_extensions"
require 'pathname'

module Generators
  class Ekivoki

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
          foreground: self.data_dir + 'Equivoques Inside CardEqui.png',
          background: self.data_dir + 'Equivoques Cover CardEqui.png'
        }
      }
    end

    def initialize(options)
      @title = options[:title]
      @rule = options[:rule]
      @goal = options[:goal]
      @author = options[:author]
      @pdf = Prawn::Document.new(
        margin: [0,0],
        page_layout: :portrait,
        page_size: [60.mm, 85.mm]
      )

      @config = [
        {
          text_box: {
            text: @rule,
            at: [5.mm, 70.mm],
            width: 50.mm,
            height: 20.mm,
            valign: :bottom,
            align: :center,
            font_size: 8,
            font_id: :regular
          }          
        },

        {
          text_box: {
            text: @goal,
            at: [5.mm, 45.mm],
            width: 50.mm,
            height: 20.mm,
            valign: :top,            
            align: :center,
            font_size: 8,
            font_id: :bold
          }          
        }
        
      ]
      
      @pdf.image self.class.assets[:graphics][:foreground], width: 60.mm
      
      print_title

      @config.each do |hash|
        method, parameters = hash.to_a.first
        @pdf.font(self.class.assets[:fonts][parameters.delete(:font_id)], size: parameters.delete(:font_size)) do
          @pdf.send(method, parameters.delete(:text), parameters)          
        end
      end

      print_author
      
      @pdf.image self.class.assets[:graphics][:background], width: 60.mm
    end
    
    def render
      @pdf.render
    end
    
    private
    
    def print_title
      @pdf.font(self.class.assets[:fonts][:crc], size: 10) do      
        @pdf.text_box @title,
          at: [5.mm, 79.mm],
          valign: :top,
          align: :center,
          width: 50.mm,
          height: 6.mm
      end
    end

    def print_author
      @pdf.font(self.class.assets[:fonts][:regular], size: 8) do        
        @pdf.text_box @author,
          at: [5.mm, 14.mm],
          valign: :center,
          align: :center,
          width: 50.mm,
          height: 6.mm
      end
    end        
  end
end
