# frozen_string_literal: true

Browserino.config.define do
  # Aside from the logic going on in this file, the order in which things are
  # written is important! If you would move the :midori matcher below the
  # :safari matcher and you would run rspec, you would see failures due to
  # the change in order. The order can be changed - no problem,
  # as long as the tests keep running

  # a set of global matchers that will use formatted properties found earlier
  # they will also be applied to every matcher unless that matcher has it's own
  # (or inherited a property through like) property set up for
  # the defined smart matcher
  smart_match :version,        with: ':name[\s/]?v?([\d\._]+)', flags: [:i]
  smart_match :engine_version, with: ':engine[\s/]?([\d\._]+)', flags: [:i]

  # a simple set of global matchers that will be merged and scanned
  # with a specific matcher when the final client object is created
  match do
    locale           %r{(?<!nintendo)[;\s(]([a-z]{2}(?:\-[a-z]{2})?)[;)]}i
    architecture     %r{((?:(?:x|x86_|amd|wow|win)64)|i[36]86|arm)}i
    mobile           %r{(bolt|nokia|samsung(?!b)|mobi(?:le)?|i?p(?:[ao]d|hone)
                        |android|bb\d+|blackberry|iemobile|fennec|bada|meego
                        |tizen|vodafone|t\-mobile|opera\sm(?:ob|in)i)}xi
    platform         %r{.*(xbox|wii|nintendo\sds|playstation|windows(?:\sphone)?
                        |macintosh|mac\sos\sx|android|tizen|ip(?:[ao]d|hone)
                        |blackberry|cros|linux|ubuntu|x11|bsd|s(?:unos|olaris)
                        |amigaos|w(?:eb)?os|risc)}xi
    platform_version %r{(?:windows(?:\sphone(?:\sos)?)?|nt|android|linux/?
                        |mac\sos\sx(?:\s\w+\s)?|(?:cpu\s|ip(?:[ao]d|hone)\s)os
                        |blackberry|bb|s(?:unos|olaris)/?|w(?:eb)?os/|tizen
                        |amigaos/?|cros\s[\w-]+)\s?([\d\._]+)}xi
  end

  # automatically set type to :browser for each defined matcher
  browsers do
    # a single matcher that will create a matcher for a specific match
    # matchers are added in an array in order of definition - higher is better
    # aliasses are prepended to the list instead of appended (e.g. like blocks)
    # this ensures that aliasses will be matched before any regular matcher
    match %r{maxthon}i do
      # define properties by calling a method with the desired name and:
      #  -- value   # => will create a static method that returns that value
      #  -- /(pat)/ # => will create a method that scans the UA and
      #                  saves the first capture group
      #  -- { blk } # => will create a dynamic method that returns the result
      #                  of the block, it will be executed within an
      #                  instantiated Client object (right after creation)
      name           :maxthon

      engine         %r{(webkit|presto|gecko|trident)}i
    end

    match %r{ucbrowser}i do
      name           :ucbrowser

      engine         %r{(trident|gecko|webkit|presto)}i
    end

    match %r{edge}i do
      name           :edge
      engine         :edge
      modern?        true
    end

    match %r{ope?ra?\smini}i do
      name           :opera_mini

      version        %r{ope?ra?\smini/([\d\.]+)}i
      engine         %r{(presto|webkit)}i
    end

    match %r{opera[^\w]}i do
      name           :opera

      version        %r{(?:opera[\s/]|version/)([\d\.]+)}i
      engine         %r{(presto|webkit)}i
    end

    match %r{msie|trident}i do
      name           :ie
      engine         :trident

      version        %r{(?:(?:ms)?ie\s|rv:)([\d\.]+)}i
      modern?        { version >= 10 }
    end

    match %r{chrome(?:ium)?}i do
      name           :chrome

      version        %r{chrome(?:ium)?/([\d\.]+)}i
      engine         %r{(webkit|blink)}i
      modern?        { version >= 50 }
    end

    match %r{(?<!(?:net))surf}i, name: :surf
    match %r{amigavoyager}i,     name: :amigavoyager
    match %r{midori}i,           name: :midori,    engine: :webkit
    match %r{qupzilla}i,         name: :qupzilla,  engine: :webkit
    match %r{shiira}i,           name: :shiira,    engine: :webkit

    match %r{firefox|phoenix}i do
      name           :firefox

      engine         %r{(gecko|servo)}i
      engine_version %r{(?:rv:\s?|servo/)([\d\.]+)}i
      modern?        { version >= 50 }
    end

    match %r{safari}i do
      name           :safari
      engine         :webkit

      version        %r{(?:safari|version)/([\d\.]+)}i
      modern?        { version >= 9 }
    end

    match %r{epiphany}i,       name: :epiphany, engine: :webkit
    match %r{uzbl}i,           name: :uzbl,     engine: :webkit
    match %r{adobeair}i,       name: :adobeair, engine: :webkit
    match %r{dooble}i,         name: :dooble,   engine: :webkit,
                               locale: %r{\((\w{2}(?:[-_]\w{2})?)\)}i
    match %r{retawq}i,         name: :retawq,   text: true,
                               locale: %r{\[(\w{2}(?:\-\w{2})?)\]}i
    match %r{amaya}i,          name: :amaya,    text: true
    match %r{lynx}i,           name: :lynx,     text: true
    match %r{linemode}i,       name: :linemode, text: true
    match %r{elinks}i,         name: :elinks,   text: true
    match %r{links}i,          name: :links,    version: %r{links\s\(([\d\.]+)}i
    match %r{netsurf}i,        name: :netsurf
    match %r{flashfire}i,      name: :flashfire
    match %r{contiki}i,        name: :contiki
    match %r{konqueror}i,      name: :konqueror
    match %r{mosaic|ibrowse}i, name: :mosaic
    match %r{dillo}i,          name: :dillo
    match %r{hotjava}i,        name: :hotjava
    match %r{netpositive}i,    name: :netpositive
  end

  # automatically set type to :bot for each defined matcher
  bots text: true do
    match %r{googlebot}i,                   name: :googlebot
    match %r{yahoo\!\sslurp}i,              name: :yahoo_slurp
    match %r{msnbot}i,                      name: :msnbot
    match %r{bingbot}i,                     name: :bingbot
    match %r{baiduspider}i,                 name: :baiduspider
    match %r{yandexbot}i,                   name: :yandexbot
    match %r{sosospider}i,                  name: :sosospider
    match %r{exabot}i,                      name: :exabot
    match %r{sogou\s?spider}i,              name: :sogou_spider
    match %r{nutch}i,                       name: :nutch
    match %r{scrapy}i,                      name: :scrapy
    match %r{dataparksearch}i,              name: :dataparksearch
    match %r{holmes}i,                      name: :holmes
    match %r{(?:ask)\sjeeves}i,             name: :ask
    match %r{duckduckgo}i,                  name: :duckduckgo
    match %r{beslistbot}i,                  name: :beslistbot
    match %r{twitterbot}i,                  name: :twitterbot
    match %r{linkedinbot}i,                 name: :linkedin
    match %r{instagram}i,                   name: :instagram
    match %r{pinterest}i,                   name: :pinterest
    match %r{tumblr}i,                      name: :tumblr
    match %r{ia_archiver}i,                 name: :alexa
    match %r{4anything}i,                   name: :four_anything
    match %r{autoemailspider}i,             name: :auto_email_spider
    match %r{boston[_ ]project}i,           name: :boston_project
    match %r{atomz}i,                       name: :atomz
    match %r{atomic_email_hunter}i,         name: :atomic_email_hunter
    match %r{altavista}i,                   name: :altavista
    match %r{alkaline}i,                    name: :alkalinebot
    match %r{acoi}i,                        name: :acoi
    match %r{acoon}i,                       name: :acoon
    match %r{accoona}i,                     name: :accoona
    match %r{face(?:bookexternalhit|bot)}i, name: :facebook
    match %r{linkdexbot}i,                  name: :linkdexbot
    match %r{aitcsrobot}i,                  name: :aitcsrobot
    match %r{alexibot}i,                    name: :alexibot
    match %r{aqua_products}i,               name: :aqua_products
    match %r{arachnophilia}i,               name: :arachnophilia
    match %r{aspider}i,                     name: :aspider
    match %r{asterias}i,                    name: :asterias
    match %r{auresys}i,                     name: :auresys
    match %r{b2w}i,                         name: :b2w
    match %r{backdoorbot}i,                 name: :backdoorbot
    match %r{backrub}i,                     name: :backrub
    match %r{big\sbrother}i,                name: :big_brother
    match %r{bizbot}i,                      name: :bizbot
    match %r{black\shole}i,                 name: :black_hole
    match %r{blackwidow}i,                  name: :blackwidow
    match %r{blexbot}i,                     name: :blexbot
    match %r{bspider}i,                     name: :bspider
    match %r{bullseye}i,                    name: :bullseye
    match %r{emailcollector}i,              name: :emailcollector
    match %r{emailsiphon}i,                 name: :emailsiphon
    match %r{emailwolf}i,                   name: :emailwolf
    match %r{ecatch}i,                      name: :ecatch
    match %r{flaming\sattackbot}i,          name: :flaming_attackbot
    match %r{getright}i,                    name: :getright
    match %r{harvest}i,                     name: :harvest
    match %r{huaweisymantecspider}i,        name: :huaweisymantecspider
    match %r{mj12bot}i,                     name: :mj12bot
    match %r{litefinder}i,                  name: :litefinder
    match %r{ahrefsbot}i,                   name: :ahrefsbot

    match %r{megaindex}i,        name: :megaindex,
                                 version: %r{megaindex\.ru/([\d\.]+)}i
    match %r{mass\sdownloader}i, name: :mass_downloader,
                                 version: %r{mass\sdownloader/([\d\.]+)}i
    match %r{safetynet\srobot}i, name: :safetynet_robot,
                                 version: %r{safetynet\srobot\s([\d\.]+)}i
    match %r{internet\sninja}i,  name: :internet_ninja,
                                 version: %r{internet\sninja\s([\d\.]+)}i
    match %r{go\!zilla}i,        name: :gozilla,
                                 version: %r{go\!zilla\s([\d\.]+)}i
    match %r{larbin}i,           name: :larbin,
                                 version: %r{larbin_([\d\.]+)}i
    match %r{download\sdemon}i,  name: :download_demon,
                                 version: %r{download\sdemon/([\d\.]+)}i
  end

  # automatically set type to :validator for each defined matcher
  validators text: true do
    match %r{cse\shtml\svalidator}i, name: :cse_html_validator
    match %r{csscheck}i,             name: :csscheck
    match %r{htmlparser}i,           name: :htmlparser
    match %r{p3p\svalidator}i,       name: :p3p_validator
    match %r{wdg_validator}i,        name: :wdg_validator
    match %r{w3c_validator}i,        name: :w3c_validator

    match %r{cynthia}i, name: :cynthia,
                        version: %r{cynthia\s([\d\.]+)}i

    match %r{w3c_css_validator}i,
          name: :w3c_css_validator,
          version: %r{w3c_css_validator_jfouffa/([\d\.]+)}i
  end

  # automatically set type to :library for each defined matcher
  libraries text: true do
    match %r{Go-http-client}i, name: :golang, version: %r{-client/([\d\.]+)}i
    match %r{python}i,         name: :python, version: %r{-urllib/([\d\.]+)}i
    match %r{php}i,            name: :php
    match %r{perl}i,           name: :perl
    match %r{java}i,           name: :java
    match %r{pycurl}i,         name: :pycurl
    match %r{curl}i,           name: :curl
    match %r{wget}i,           name: :wget
    match %r{webfetch}i,       name: :webfetch
  end

  # inherit properties a standard set of properties by the name of a
  # previously defined matcher, overwritten by properties added within matchers
  # inherit properties from matcher where name == :chrome, (except :version)
  like :chrome, except: [:version] do
    match %r{brave}i,         name: :brave
    match %r{vivaldi}i,       name: :vivaldi
    match %r{bluechrome}i,    name: :bluechrome
    match %r{colibri}i,       name: :colibri
    match %r{rockmelt}i,      name: :rockmelt
    match %r{flock}i,         name: :flock
    match %r{comodo_dragon}i, name: :comodo_dragon
    match %r{yabrowser}i,     name: :yabrowser
  end

  # inherit properties from matcher where name == :safari, (except :version)
  like :safari, except: [:version] do
    match %r{icab}i,           name: :icab
    match %r{bolt}i,           name: :bolt
    match %r{stainless}i,      name: :stainless
    match %r{arora}i,          name: :arora
    match %r{samsungbrowser}i, name: :samsungbrowser
    match %r{omniweb}i,        name: :omniweb

    match %r{webos|wosbrowser}i,
          name: :webosbrowser,
          version: %r{(?:version|w(?:eb)?osbrowser)/([\d\.]+)}i
  end

  # inherit properties from matcher where name == :firefox, (except :version)
  like :firefox, except: [:version] do
    match %r{k-meleon}i,   name: :kmeleon,  version: %r{k-meleon/([\d\.]+)}i
    match %r{camino}i,     name: :camino,   locale: %r{\s(\w{2}(?:\-\w{2})?),}i
    match %r{waterfox}i,   name: :waterfox, architecture: :x664
    match %r{prism}i,      name: :prism
    match %r{firebird}i,   name: :firebird
    match %r{netscape}i,   name: :netscape
    match %r{icecat}i,     name: :icecat
    match %r{iceweasel}i,  name: :iceweasel
    match %r{seamonkey}i,  name: :seamonkey
    match %r{superswan}i,  name: :superswan
    match %r{lunascape}i,  name: :lunascape
    match %r{kazehakase}i, name: :kazehakase
    match %r{shiretoko}i,  name: :shiretoko
    match %r{galeon}i,     name: :galeon
    match %r{classilla}i,  name: :classilla
  end

  # never thought a browser would want to be like IE...
  like :ie do
    # version does not have to be supplied because we simply want to use
    # the version supplied by the MSIE token instead (there is no version on
    # the avant browser or slimbrowser etc... UA itself)
    match %r{avant\sbrowser}i,    name: :avant_browser
    match %r{slimbrowser}i,       name: :slimbrowser
    match %r{greenbrowser}i,      name: :greenbrowser

    # because of this, we now have to explicitly define version patterns
    # for the user agents that follow the 'regular' pattern
    match %r{netcaptor}i,         name: :netcaptor,
                                  version: %r{netcaptor\s([\d\.]+)}i
    match %r{simulbrowse}i,       name: :simulbrowse,
                                  version: %r{simulbrowse\s([\d\.]+)}i
    match %r{aol}i,               name: :aol,
                                  version: %r{aol\s([\d\.]+)}i
    match %r{sleipnir}i,          name: :sleipnir,
                                  version: %r{sleipnir/([\d\.]+)}i
    match %r{deepnet\sexplorer}i, name: :deepnet_explorer,
                                  version: %r{deepnet\sexplorer\s([\d\.]+)}i
  end
end
