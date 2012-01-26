module Facades
  module SassExtensions
    module Icons
      
      def icon_glyph(name)
        name  = name.to_s
        value = icon_translations[name]
        if value.nil?
          raise Sass::SyntaxError, "The icon '#{name}' does not exist."
        end
        Sass::Script::String.new("\\#{value}")
      end
      
      private
      
      def icon_translations
       {
         'pencil'             => 'e001',
         'check'              => 'e002',
         'check-round'        => 'e003',
         'cross'              => 'e004',
         'cross-round'        => 'e005',
         'cancel'             => 'e006',
         'plus-round'         => 'e007',
         'minus-round'        => 'e008',
         'arrow-left-round'   => 'e009',
         'arrow-up-round'     => 'e00a',
         'arrow-right-round'  => 'e00b',
         'arrow-down-round'   => 'e00c',
         'arrow-left-light'   => 'e00d',
         'arrow-up-light'     => 'e00f',
         'arrow-right-light'  => 'e010',
         'arrow-down-light'   => 'e011',
         'arrow-left'         => 'e012',
         'arrow-up'           => 'e013',
         'arrow-right'        => 'e014',
         'arrow-down'         => 'e015',
         'play'               => 'e016',
         'pause'              => 'e017',
         'fast-forward'       => 'e018',
         'rewind'             => 'e019',
         'next-track'         => 'e01a',
         'prev-track'         => 'e01b',
         'stop'               => 'e01c',
         'eject'              => 'e01d',
         'mute'               => 'e01e',
         'volume'             => 'e01f',
         'signal'             => 'e020',
         'battery-empty'      => 'e021',
         'battery-charge'     => 'e022',
         'battery-half-charge'=> 'e023',
         'battery-charged'    => 'e024',
         'battery'            => 'e025',
         'trash'              => 'e026',
         'print'              => 'e027',
         'locked'             => 'e028',
         'un-locked'          => 'e029',
         'folder'             => 'e02a',
         'folder-open'        => 'e02b',
         'document'           => 'e02c',
         'document-alt'       => 'e02d',
         'address-book'       => 'e02e',
         'mail'               => 'e02f',
         'mail-open'          => 'e030',
         'briefcase'          => 'e031',
         'bubble-square'      => 'e032',
         'bubble'             => 'e033',
         'bubbles'            => 'e034',
         'tag'                => 'e035',
         'house'              => 'e036',
         'flag'               => 'e037',
         'calendar'           => 'e038',
         'cart'               => 'e039',
         'clock'              => 'e03a',
         'disk'               => 'e03b',
         'buildings'          => 'e03c',
         'zoom-in'            => 'e03d',
         'zoom-out'           => 'e03e',
         'search'             => 'e03f',
         'wrench'             => 'e040',
         'gear'               => 'e041',
         'heart'              => 'e042',
         'star'               => 'e043',
         'link'               => 'e044',
         'plus'               => 'e045',
         'minus'              => 'e046',
         'key'                => 'e047',
         'bulb'               => 'e048',
         'scissors'           => 'e049',
         'clipboard'          => 'e04a',
         'paste'              => 'e04b',
         'vcard'              => 'e04c',
         'image'              => 'e04d',
         'film'               => 'e04e',
         'alert'              => 'e04f',
         'info'               => 'e050',
         'exclamation'        => 'e051',
         'question'           => 'e052',
         'pin-right'          => 'e053',
         'pin-down'           => 'e054',
         'right-round'        => 'e055',
         'down-round'         => 'e056',
         'left-round'         => 'e057',
         'up-round'           => 'e058',
         'zoom-in-round'      => 'e059',
         'zoom-out-round'     => 'e05a',
         'plus-square'        => 'e05b',
         'minus-square'       => 'e05c',
         'cross-square'       => 'e05d',
         'plus-square-dark'   => 'e05e',
         'minus-square-dark'  => 'e05f',
         'cross-square-dark'  => 'e060',
         'refresh-e'          => 'e061',
         'refresh-w'          => 'e062',
         'transfer'           => 'e063',
         'refresh'            => 'e064',
         'refresh-alt'        => 'e065'
       }
      end
    
    end
  end
end