---
title: "Installing taglib-ruby and id3lib-ruby on Apple's ARM Silicon"
layout: post
date: 2022-01-27 01:03:23 +0000
tags: [arm64, arm, apple silicon, macbook pro, id3lib, id3lib-ruby, taglib, taglib-ruby]
---

[Take me to the solution.](#now-the-solution)

As you may or may not know, Apple is transitioning away from Intel chips on their Macs to their own <a href="https://en.wikipedia.org/wiki/Apple_silicon" target="_blank">Apple’s Silicon</a> ARM-based chip. Most general users won't care too much about the transition, but for developers who use their Macbook Pros as a main driver, this gives some reason for pause.
 
I received a new Macbook Pro with the M1 Pro chip from work. Which was much needed, as I was working on an older i5 8GB 256GB loaner until the shop was able to give me a new machine.
 
I was excited to be able to run my rake tasks without having to watch the wheel spin. I was, however, unprepared for the headache of watching my builds fail. The new territory of developing on the ARM and the combination of our application using outdated gems was a new challenge. One particular challenge was trying to build the <a href="https://github.com/robinst/id3lib-ruby" target="_blank">id3lib-ruby</a> and <a href="https://github.com/robinst/taglib-ruby" target="_blank">taglib-ruby</a> gems.
 
<a href="https://en.wikipedia.org/wiki/Information_foraging" target="_blank">Information foraging</a>[^1] failed me. This challenge was unique and relatively new. Not a whole lot of logs exist on this. So, this had me stumped. And for a good reason: **I learned that I still had a lot to learn about being a better programmer.** I depended too much on information foraging and I've finally met a challenge that someone else hadn't solved.
 
I learned an important lesson: I spent too much of my time foraging the internet for a solution, when I could have been a better programmer. I could have earlier cloned the failing gems/libraries/modules and dug through the code to find the faulty line. I learned that I didn't have the confidence to trust myself as a professional. I didn't think I was smart enough to evaluate someone else's code.
 
After hours of foraging, I eventually realized that I had to solve this build failure on my own. Big revelation, I know...
 
I eventually cloned the id3lib-ruby and taglib-ruby gems onto my local machine. I dug through the code base and used the error logs to figure out where the failure was occuring. That wasn't so hard...

## The Error Messages:

**id3lib-ruby error message:**
```bash
Building native extensions. This could take a while...
ERROR:  Error installing id3lib-ruby:
        ERROR: Failed to build gem native extension.
 
    current directory: /Users/USERNAME/.gem/gems/id3lib-ruby-0.6.0/ext/id3lib_api
/Users/USERNAME/.rbenv/versions/2.6.5/bin/ruby -I /Users/USERNAME/.rbenv/versions/2.6.5/lib/ruby/2.6.0 -r ./siteconf20220126-61097-15xkr2v.rb extconf.rb
checking for -lstdc++... yes
checking for -lz... yes
checking for -liconv... yes
checking for id3.h... no
You must have id3lib installed in order to use id3lib-ruby.
*** extconf.rb failed ***
Could not create Makefile due to some reason, probably lack of necessary
libraries and/or headers.  Check the mkmf.log file for more details.  You may
need configuration options.
 
Provided configuration options:
        --with-opt-dir
        --with-opt-include
        --without-opt-include=${opt-dir}/include
        --with-opt-lib
        --without-opt-lib=${opt-dir}/lib
        --with-make-prog
        --without-make-prog
        --srcdir=.
        --curdir
        --ruby=/Users/USERNAME/.rbenv/versions/2.6.5/bin/$(RUBY_BASE_NAME)
        --with-stdc++lib
        --without-stdc++lib
        --with-zlib
        --without-zlib
        --with-iconvlib
        --without-iconvlib
 
To see why this extension failed to compile, please check the mkmf.log which can be found here:
 
  /Users/USERNAME/.gem/extensions/-darwin-21/2.6.0/id3lib-ruby-0.6.0/mkmf.log
 
extconf failed, exit code 1
 
Gem files will remain installed in /Users/USERNAME/.gem/gems/id3lib-ruby-0.6.0 for inspection.
Results logged to /Users/USERNAME/.gem/extensions/-darwin-21/2.6.0/id3lib-ruby-0.6.0/gem_make.out
```

**taglib-ruby error message:**
```bash
Gem::Ext::BuildError: ERROR: Failed to build gem native extension.
 
    current directory: /Users/USERNAME/.gem/gems/taglib-ruby-1.1.0/ext/taglib_base
/Users/USERNAME/.rbenv/versions/2.6.5/bin/ruby -I /Users/USERNAME/.rbenv/versions/2.6.5/lib/ruby/2.6.0 -r ./siteconf20220126-46818-1p3xheg.rb extconf.rb
checking for -lstdc++... yes
checking for -ltag... yes
creating Makefile
 
current directory: /Users/USERNAME/.gem/gems/taglib-ruby-1.1.0/ext/taglib_base
make "DESTDIR=" clean
 
current directory: /Users/USERNAME/.gem/gems/taglib-ruby-1.1.0/ext/taglib_base
make "DESTDIR="
compiling taglib_base_wrap.cxx
taglib_base_wrap.cxx:1179:1: warning: function 'Ruby_Format_OverloadedError' could be declared with attribute 'noreturn' [-Wmissing-noreturn]
{
^
taglib_base_wrap.cxx:1871:10: fatal error: 'taglib/taglib.h' file not found
#include <taglib/taglib.h>
         ^~~~~~~~~~~~~~~~~
1 warning and 1 error generated.
make: *** [taglib_base_wrap.o] Error 1
 
make failed, exit code 2
 
Gem files will remain installed in /Users/USERNAME/.gem/gems/taglib-ruby-1.1.0 for inspection.
Results logged to /Users/USERNAME/.gem/extensions/-darwin-21/2.6.0/taglib-ruby-1.1.0/gem_make.out
 
  /Users/USERNAME/.rbenv/versions/2.6.5/lib/ruby/2.6.0/rubygems/ext/builder.rb:99:in `run'
  /Users/USERNAME/.rbenv/versions/2.6.5/lib/ruby/2.6.0/rubygems/ext/builder.rb:51:in `block in make'
  /Users/USERNAME/.rbenv/versions/2.6.5/lib/ruby/2.6.0/rubygems/ext/builder.rb:43:in `each'
  /Users/USERNAME/.rbenv/versions/2.6.5/lib/ruby/2.6.0/rubygems/ext/builder.rb:43:in `make'
  /Users/USERNAME/.rbenv/versions/2.6.5/lib/ruby/2.6.0/rubygems/ext/ext_conf_builder.rb:62:in `block in build'
  /Users/USERNAME/.rbenv/versions/2.6.5/lib/ruby/2.6.0/tempfile.rb:295:in `open'
  /Users/USERNAME/.rbenv/versions/2.6.5/lib/ruby/2.6.0/rubygems/ext/ext_conf_builder.rb:29:in `build'
  /Users/USERNAME/.rbenv/versions/2.6.5/lib/ruby/2.6.0/rubygems/ext/builder.rb:185:in `block in build_extension'
  /Users/USERNAME/.rbenv/versions/2.6.5/lib/ruby/2.6.0/monitor.rb:235:in `mon_synchronize'
  /Users/USERNAME/.rbenv/versions/2.6.5/lib/ruby/2.6.0/rubygems/ext/builder.rb:181:in `build_extension'
  /Users/USERNAME/.rbenv/versions/2.6.5/lib/ruby/2.6.0/rubygems/ext/builder.rb:229:in `block in build_extensions'
  /Users/USERNAME/.rbenv/versions/2.6.5/lib/ruby/2.6.0/rubygems/ext/builder.rb:226:in `each'
  /Users/USERNAME/.rbenv/versions/2.6.5/lib/ruby/2.6.0/rubygems/ext/builder.rb:226:in `build_extensions'
  /Users/USERNAME/.rbenv/versions/2.6.5/lib/ruby/2.6.0/rubygems/installer.rb:830:in `build_extensions'
  /Users/USERNAME/.gem/gems/bundler-2.3.6/lib/bundler/rubygems_gem_installer.rb:71:in `build_extensions'
  /Users/USERNAME/.gem/gems/bundler-2.3.6/lib/bundler/rubygems_gem_installer.rb:28:in `install'
  /Users/USERNAME/.gem/gems/bundler-2.3.6/lib/bundler/source/rubygems.rb:204:in `install'
  /Users/USERNAME/.gem/gems/bundler-2.3.6/lib/bundler/installer/gem_installer.rb:54:in `install'
  /Users/USERNAME/.gem/gems/bundler-2.3.6/lib/bundler/installer/gem_installer.rb:16:in `install_from_spec'
  /Users/USERNAME/.gem/gems/bundler-2.3.6/lib/bundler/installer/parallel_installer.rb:186:in `do_install'
  /Users/USERNAME/.gem/gems/bundler-2.3.6/lib/bundler/installer/parallel_installer.rb:177:in `block in worker_pool'
  /Users/USERNAME/.gem/gems/bundler-2.3.6/lib/bundler/worker.rb:62:in `apply_func'
  /Users/USERNAME/.gem/gems/bundler-2.3.6/lib/bundler/worker.rb:57:in `block in process_queue'
  /Users/USERNAME/.gem/gems/bundler-2.3.6/lib/bundler/worker.rb:54:in `loop'
  /Users/USERNAME/.gem/gems/bundler-2.3.6/lib/bundler/worker.rb:54:in `process_queue'
  /Users/USERNAME/.gem/gems/bundler-2.3.6/lib/bundler/worker.rb:91:in `block (2 levels) in create_threads'
 
An error occurred while installing taglib-ruby (1.1.0), and Bundler cannot continue.
 
In Gemfile:
  taglib-ruby
```

# Now, the solution:

The <a href="https://github.com/robinst/id3lib-ruby" target="_blank">id3lib-ruby</a> and <a href="https://github.com/robinst/taglib-ruby" target="_blank">taglib-ruby</a> gems are attempting to find the <a href="https://taglib.org/" target="_blank">taglib</a> and <a href="http://id3lib.sourceforge.net/" target="_blank">id3lib</a> packages in a location native to the x86 architecture. <a href="https://brew.sh" target="_blank">Homebrew</a> and its packages are installed in a different location: `/opt/homebrew` and `/opt/homebrew/Cellar`

<p class="message">
  You may need to uninstall Homebrew and reinstall it via:
  <a href='https://github.com/mikelxc/Workarounds-for-ARM-mac' target="_blank">Homebrew ARM install</a>
</p>

***We just need to export the new locations as environment variables for our gems to use.***

You’ll need to export two variables:

id3lib-ruby:

```bash
export CONFIGURE_ARGS="--with-opt-dir=$(brew --prefix id3lib)"
```
taglib-ruby:

```bash
export TAGLIB_DIR="$(brew --prefix taglib)"
```
Of course, make sure to check your id3lib and taglib locations by using:

```bash
brew info taglib
```

```bash
brew info id3lib
```

After you've exported your `CONFIGURE_ARGS` and `TAGLIB_DIR`, you can run:

```bash
bundle install
```

I hope this has helped you! Thanks for reading.

-----
## Footnotes
[^1]: I learned this term from my fiancée, who is doing her Master's in Educational Psychology at the University of Minnesota. This is a skill that a lot of programmers depend on. Scouring forums, blogs, Stack Overflow, GitHub Issues, etc.
