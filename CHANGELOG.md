# Changelog
_dates are in dd-mm-yyyy format_

### 12-10-2017 VERSION 4.2.2

- Added support for `high_sierra`

### 11-06-2017 VERSION 4.2.1

- Fixed a bug which caused arguments in the form of `version: v` to return true by default
- Added 174 additional clients
- Added some global properties
  - `smarttv?` and `tablet?` in addition to `mobile?`
  - Added device detection using `device? :namOfDevice`
- Added `not` method that allows calling `client.not.firefox?`. It simply inverts the original result
- Added `not?` method which is the opposite of `is?`
- Added `:mediaplayer` type

### 30-04-2017 VERSION 4.1.0

- Changed some internal naming
- Added ~200 additional browsers / bots
- Added list of browsers / bots and platforms to the documentation

### 22-04-2017 VERSION 4.0.0

- Complete rewrite
- Complete documentation rewrite

#### 14-11-2016 VERSION 2.12.0

- Added support for SamsungBrowser
  - Added `samsungbrowser?` method
  - Added support for `:samsungbrowser` (`Symbol` and `String`) in methods
- Added support for Tizen
  - Added `tizen?` method
  - Added support for `:tizen` (`Symbol` and `String`) in methods
- Added support for WebOS
  - Added `webos?` method
  - Added support for `:webos` (`Symbol` and `String`) in methods
- Added support for WebOSBrowser
  - Added `webosbrowser?` method
  - Added support for `:webosbrowser` (`Symbol` and `String`) in methods
- Added Android Nougat (7.0 and 7.1) detection
- merged OS map files into _/core/mappings.rb_ and removed the _lib/maps_ folder
- Reduced amount of (overkill) tests

#### 13-11-2016 VERSION 2.11.0

- Add `:macos` alias for `:macintosh` systems.
- Added support for MacOS `:sierra` alias in methods.
- Added deprecation notice for dropping support of Ruby < 2.0.0

#### 19-10-2016 VERSION 2.10.1.1

- Test on ruby 2.3.1
- Fix missing questionmarks on method names in the README.
- Change gem homepage to io domain

#### 25-08-2016 VERSION 2.10.1

- Replaced `require` with `require_relative` where possible
- Fixed cli not loading due to failing `require`

#### 24-07-2016 VERSION 2.10.0

- Added support for the servo browser:
  - Added `servo?` method

- Added detection for various programming languages:
  - Added `library?` method
  - Added `php?` method
  - Added `perl?` method
  - Added `python?` method
  - Added `java?` method
  - Added `curl?` method
  - Added `pycurl?` method

#### 29-05-2016 VERSION 2.9.0

- Stricter checking for:
* `social_media?`
* `bot?`
* `browser?`
* `platform?`

These methods used to be callable with unrelated symbols
(e.g `agent.platform?(:firefox) # => true`), they will now correctly return false.
- Added support for consoles
* Added `console?` method
* Added `wii?`, `playstation?`, `xbox?` and `nintendo_ds?` methods
- Added general `name` method to store any browser / bot / search engine / social media agent
- `social_media_name`, `search_engine_name` and `bot_name` are now aliasses of `name`
- removed `:bot_name` from data structure (now stored in a general `name` property)
- removed `:browser_name` from data structure (now stored in a general `name` property)
- Added `console_name` method to get the name of a console

#### 27-05-2016 VERSION 2.8.2

- Removed Guard gem dependency

#### 26-05-2016 VERSION 2.8.0

- Added `search_engine?` method
- Added `holmes?` method
- Added `ask?` method
- Added `duckduckgo?` and alias `ddg?` methods
- Fixed `respond_to?` method signature
- Added executable for parsing useragents in terminal

#### 02-03-2016 VERSION 2.7.0

- Added `solaris?` method

#### 22-01-2016 VERSION 2.6.0

- Fixed `to_a` method
- Fixed `to_s` method
- Removed **bot** suffixes from every bot name
  - Replaced `googlebot?` with `google?`
  - Replaced `msnbot?` with `msn?`
  - Replaced `bingbot?` with `bing?`
  - Replaced `yandexbot?` with `yandex?`
  - Replaced `exabot?` with `exa?`
- Added `platform?` method
- Added `browser?` method
- Added `social_media?` method
- Added `facebook?` and `fb?` methods
- Added `twitter?` method
- Added `linkedin?` method
- Added `instagram?` method
- Added `pinterest?` method
- Added `tumblr?` method
- Added support for the Brave browser and the `brave?` method
- Added `ff?` method

#### 20-01-2016 VERSION 2.5.4

- formatted / refactored code with rubocop
- iOS `system_name full: true` returns the version no. of iOS if found

#### 19-01-2016 VERSION 2.5.3

- Minor refactoring of code

#### 15-01-2016 VERSION 2.5.2

- **DEPRECATE** Custom return values (passed through `Browserino.parse`) will no longer alter the output of the agent object
- Added support for windows phone detection
- Added `windows_phone?` method

#### 12-01-2016 VERSION 2.5.1

- Patched blackberry mapping, this used to be done by model number instead but is now corrected

#### 12-01-2016 VERSION 2.5.0

- Added support for the Vivaldi browser
- New method `#vivaldi?`
- Added support for the bsd family of operating systems
- New method `#bsd?`
- Fixed using symbols for system version identification (e.g. `:vista` or `:el_capitan`) without a version number

#### 11-01-2016 VERSION 2.4.1(.1)

- Caching the agent object in Rails
- **DEPRECATE** Using a custom return value for when a property isn't found

#### 10-01-2016 VERSION 2.4.0

- Added rails integration

#### 06-01-2016 VERSION 2.3.0

- Added `#compat?` method to test if IE is in compatibility mode
- Extended `#browser_version` to now also take an argument
- Added `#locale` method
- Empty UA's are identified as bots through `#bot?`

#### 04-01-2016 VERSION 2.2.0

- Added more bots
- `#bot?` method can now take a bot name as argument to check for an exact bot

#### 04-01-2016 VERSION 2.1.0

- Small restructuring of test suite
- Added bot detection
- Added `#bot?` method
- Added dynamic method support for bots
- Added support for the seamonkey browser

#### 03-01-2016 VERSION 2.0.0

- **IMPORTANT** Changed behaviour of all dynamic methods to include version as an argument rather than in the method name.
- **IMPORTANT** Changed the behaviour of version checking to be more strict
- Changed tests to reflect new behaviour
- Added convenience methods `#win?`, `#osx?` and `#bb?`

#### 03-01-2016 VERSION 1.6.0

- Added more tests
- Added more browsers to check: *(bolt, opera mini and ucbrowser)*
- Added `#known?` method to check if the agent is known
- Added a `#ua` method to return the User Agent string as given to `Browserino.parse()`
- Added `#x64?` and `#x32?` convenience methods to check system architecture
- Added `#mobile?` to check wether or not a user agent is mobile
- Moved older changelogs to its own [CHANGELOG.md](https://github.com/SidOfc/browserino/blob/master/CHANGELOG.md) file
- Changed `#to_s` to add dashes (`-`) between browser names if they have a space
- `#to_s` now has an optional (`sep = ''`) parameter that allows info and version numbers to be seperated

#### 31-12-2015 VERSION 1.5.3

- Added blackberry support
- Added tests for blackberry user agent strings

#### 31-12-2015 VERSION 1.5.2

- Added user agents
- Patterns could falsely identify a 64bit system, made the pattern more strict
- using `X11` in a user agent as a synonym to a `#linux?` system

#### 23-12-2015 VERSION 1.5.1.1

- Removed print statements from method
- Builds are now executed for Ruby 1.9.3 as well as 2.2.1

#### 20-12-2015 VERSION 1.5.1

- Fixed `respond_to?` method which would first return inverted results (e.g. false when it should be true)

#### 19-12-2015 VERSION 1.5.0

- Implemented to_s to return a concatenated string of property values
- Implemented to_a to return an array with arrays containing property name-value pairs
- Implemented to_h to return a hash containing property name-value pairs
- Removed unused code

#### 19-12-2015 VERSION 1.4.0

- Added not method to invert questions about browser / system
- Added random test cases to verify that all inverted answers are correct

#### 17-12-2015 VERSION 1.3.0

- Added Edge detection
- For supported browsers, it is now possible to check name and version through `method_missing?`

#### 16-12-2015 VERSION 1.2.0

- Opera tests didn't run before
- For supported systems, it is possible to check OS and version through `method_missing?`

#### 15-12-2015 VERSION 1.1.2

- User definable 'unknown' return value
