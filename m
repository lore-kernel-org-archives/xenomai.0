From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Thu, 22 Jun 2006 23:37:29 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_a2wmEjPhLAkdRf9"
Message-Id: <200606222337.30022.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Improved xeno-test: Ready for checkin
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

--Boundary-00=_a2wmEjPhLAkdRf9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

Here is my patch for improved versions of xeno-info/load/config/test
as well as a Ruby test script for the maintainers.

The modified scripts pass the test for most options to xeno-test. The only 
exception is "-v" for verbose. As I have no clue how/what this option should 
do I left it as is.

The modifications are:
- busybox supported
- The load jobs (dd) are killed correctly
- two new lines for my buildbot "xeno-test started" and "xeno-test finished"
- the options -m / -L are no more silent, but echo also on the standard out.
  If the old behaviour is preferred, it would be simple to restore it. But
  the actual behaviour is easier to debug and fits better into the buildbot
  logs.

The tests under the busybox are not as good as with a normal shell, but work 
good enough with my buildbot. I will try to integrate them later into the 
Ruby test script.

Attached are also all log files of my testruns, if you want to verify that 
everything work as expected. A manual inspection of all logfiles did not 
reveal anymore hidden bugs to me (after quite a few runs to improve my test 
cases -).

After generating all logs, the testscript resumed the results like this:
> Thu Jun 22 23:31:34 CEST 2006: 14 PASSED:   0 seconds. opts <-M
> niklaus@domain.hid -xxxx > returned 0 Writing tst to
> /mnt/data.ng/hcu/kernel/xenomai-head/scripts/test/logs/xeno-test.store Thu
> Jun 22 23:31:34 CEST 2006:  9 PASSED: -N marker:
> ["markertest-2.6.14-1252M-ppc-060622.232920"] Thu Jun 22 23:31:34 CEST
> 2006:  8 PASSED: -L: ["/tmp/test-2.6.14-1252M-ppc-060622.232417",
> "/tmp/test-2.6.14-1252M-ppc-060622.232452",
<..>
> "/tmp/test-2.6.14-1252M-ppc-2006-marker-06-marker",
> "/tmp/test-2.6.14-1252M-ppc-060622.233100"] running all Checks
> CHK 10 FAILED opts -v could not find xeno-test: finished
>   searched in
> /mnt/data.ng/hcu/kernel/xenomai-head/scripts/test/logs/test_xeno_test.log.1
>0 CHK 10 FAILED, could not find xeno-test: finished in
> /mnt/data.ng/hcu/kernel/xenomai-head/scripts/test/logs/test_xeno_test.log.1
>0 completed all Checks

Unless you spot any error in my tests, I will not improve my scripts nor the 
xeno-test scripts in the near future. Also I would appreciate go know whether 
the error is already present in the current version of xeno-test.

As rc3 is still not out, I do not see any reason not to check in this patch.
But I would like to see this happen soon, as I will not be able to fix errors 
after next Wednesday.

Best regards

-- 
Niklaus Giger

--Boundary-00=_a2wmEjPhLAkdRf9
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="scripts.patch2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="scripts.patch2"

Index: scripts/xeno-config.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- scripts/xeno-config.in	(Revision 1254)
+++ scripts/xeno-config.in	(Arbeitskopie)
@@ -1,4 +1,4 @@
=2D#! /bin/bash
+#! /bin/sh
=20
 staging=3D${DESTDIR}
 prefix=3D"@prefix@"
Index: scripts/xeno-info
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- scripts/xeno-info	(Revision 1254)
+++ scripts/xeno-info	(Arbeitskopie)
@@ -1,31 +1,46 @@
=2D#!/bin/sh
+#! /bin/sh
 #
 # This file has been lifted 'as is' from linux/scripts/ver_linux.
=2D#
+# Adapted to be run also under the BusyBox. If you want to test it under t=
he BusyBox use
+# busybox sh xeno-info=20
=20
 PATH=3D/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/sbin:$PATH
 echo 'If some fields are empty or look unusual you may have an old version=
=2E'
 echo 'Compare to the current minimal requirements in Documentation/Changes=
=2E'
 echo ' '
=20
+withBusybox=3D0
+if sh --help 2>&1| grep -q BusyBox; then
+    withBusybox=3D1;
+# else running a real /bin/sh (bash) shell
+fi
+
+if test $withBusybox -eq 1; then busybox | grep -i "BusyBox v" ; fi
+
 uname -a
 echo ' '
=20
+if test -n "`which gcc`" ; then
 gcc --version 2>&1| head -n 1 | grep -v gcc | awk \
 'NR=3D=3D1{print "Gnu C                 ", $1}'
=20
 gcc --version 2>&1| grep gcc | awk \
 'NR=3D=3D1{print "Gnu C                 ", $3}'
+fi
=20
+if test -n "`which gcc`" ; then
 make --version 2>&1 | awk -F, '{print $1}' | awk \
       '/GNU Make/{print "Gnu make              ",$NF}'
+fi
=20
 ld -v 2>&1 | awk -F\) '{print $1}' | awk \
       '/BFD/{print "binutils              ",$NF}'
=20
+if test 0 -eq $withBusybox ; then=20
 fdformat --version | awk -F\- '{print "util-linux            ", $NF}'
=20
 mount --version | awk -F\- '{print "mount                 ", $NF}'
+fi=20
=20
 depmod -V  2>&1 | awk 'NR=3D=3D1 {print "module-init-tools     ",$NF}'
=20
@@ -50,21 +65,26 @@
 isdnctrl 2>&1 | grep version | awk \
 'NR=3D=3D1{print "isdn4k-utils          ", $NF}'
=20
+if test -n "`which ldd`" ; then
 ls -l `ldd /bin/sh | awk '/libc/{print $3}'` | sed \
 -e 's/\.so$//' | awk -F'[.-]'   '{print "Linux C Library        " \
 $(NF-2)"."$(NF-1)"."$NF}'
=20
 ldd -v > /dev/null 2>&1 && ldd -v || ldd --version |head -n1 | awk \
 'NR=3D=3D1{print "Dynamic linker (ldd)  ", $NF}'
+fi
=20
 ls -l /usr/lib/lib{g,stdc}++.so  2>/dev/null | awk -F. \
        '{print "Linux C++ Library      " $4"."$5"."$6}'
=20
+if test 0 -eq $withBusybox ; then=20
 ps --version 2>&1 | awk 'NR=3D=3D1{print "Procps                ", $NF}'
+fi=20
=20
 ifconfig --version 2>&1 | grep tools | awk \
 'NR=3D=3D1{print "Net-tools             ", $NF}'
=20
+if test 0 -eq $withBusybox ; then=20
 # Kbd needs 'loadkeys -h',
 loadkeys -h 2>&1 | awk \
 '(NR=3D=3D1 && ($3 !~ /option/)) {print "Kbd                   ", $3}'
@@ -74,6 +94,7 @@
 '(NR=3D=3D1 && ($2 ~ /console-tools/)) {print "Console-tools         ", $3=
}'
=20
 expr --v 2>&1 | awk 'NR=3D=3D1{print "Sh-utils              ", $NF}'
+fi=20
=20
 if [ -e /proc/modules ]; then
     X=3D`cat /proc/modules | sed -e "s/ .*$//"`
Index: scripts/maint/test-xeno-test.rb
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- scripts/maint/test-xeno-test.rb	(Revision 0)
+++ scripts/maint/test-xeno-test.rb	(Revision 0)
@@ -0,0 +1,301 @@
+#!/usr/bin/env ruby
+
+# Funning xeno-test once with each option takes a long time (around 15 min=
utes)
+# For each test a full log is stored in the logs subdirectory.
+# Therefore the results of the tests (the ruby variable) is stored using P=
store in
+# the file logs/xeno-test.store.
+# If this file exists and is newer than xeno-test and the first parameter =
is !=3D clean
+# The tst variable is fetched from the file.
+# This is convenient if you want to add new checks.
+#
+# Todo: - Why do the mailing tests not work  ?
+#       - How does xeno-test react to Ctrl-C ?
+#       - Thorougher analyses of the log files
+#
+require 'timeout'
+require 'ostruct'
+require 'ftools'
+require 'pstore'
+require 'tempfile'
+
+XenoInstall =3D "/usr/xenomai/bin"
+XenoHead    =3D File.expand_path(File.dirname(File.dirname(__FILE__)))
+XenoTestOrg =3D XenoHead+'/xeno-test.in'
+XenoTestRun =3D XenoInstall+'/xeno-test'
+LogDir      =3D XenoHead+'/logs'
+MainLog     =3D LogDir+'/runtest.log'
+StorageName =3D LogDir+'/xeno-test.store'
+withFinished =3D `grep finished /usr/xenomai/bin/xeno*`
+withFinished.size > 0 ? FinishedMsg =3D "xeno-test: finished" : FinishedMs=
g =3D nil
+
+$clean  =3D ARGV[0] =3D=3D 'clean' && ! (
+	  File.exists?(XenoTestRun) &&
+          File.exists?(StorageName) &&
+          File.stat(XenoTestRun).mtime >  File.stat(StorageName).mtime
+          )
+if $clean && File.exists?(StorageName) then
+  puts "Do you really want to run all tesst? <Ctrl-C> to abort"
+  STDIN.getc
+end
+
+class XenoTest
+  attr_reader :mainLog
+  attr_reader :blockDevice
+  attr_writer :maxTimeout
+  attr_writer :chkProc
+
+  def initialize(options)
+    @from    =3D XenoHead
+    @inst    =3D XenoInstall
+    @busybox =3D false
+    File.makedirs(LogDir) if defined?(LogDir) && ! File.directory?(LogDir)
+    @@mainLog =3D open(MainLog,"w");
+    @@mainLog.puts("#{Time.now}: started run")
+    @@mainLog.sync =3D true
+    options.each { |name,val|
+      if val.class =3D=3D String then
+        cmd =3D  "@#{name}=3D'#{val}'"
+      else
+	cmd =3D  "@#{name}=3D#{val}"
+      end
+      eval cmd
+    }
+  end
+
+  def add(opts,  chkProc=3Dnil)
+    @nr   =3D -1        if !defined?(@nr)
+    @tsts =3D Array.new if !defined?(@tsts)
+    @nr  +=3D 1
+    elem =3D OpenStruct.new({'nr' =3D> @nr, 'opts'=3D>opts})
+    elem.chkProc =3D chkProc if chkProc
+    @tsts << elem
+    return elem
+  end
+
+  def runTests
+    @tsts.each { |x| runOneTest(x) ; }
+  end
+
+  def XenoTest::writeLogEntry(tst, logMsg)
+    msg =3D "#{Time.now}: #{sprintf("%2d", tst.nr)} "+ logMsg
+    if ! File.exists?(MainLog) then
+      puts msg
+    end
+    outs =3D [ STDOUT]
+    outs << @@mainLog if defined?(@@mainLog) && @@mainLog
+    outs.each {|dev| dev.puts msg }
+  end
+
+  def runOneTest(x)
+    puts "runOneTest #{x.inspect}"  if $VERBOSE
+    opts =3D x.opts
+    startTime =3D Time.now
+    tstRes =3D nil
+    x.tst  =3D `which xeno-test`.chomp
+    x.log  =3D "#{LogDir}/test_xeno_test.log.#{x.nr}"
+    x.cmd  =3D "#{x.tst} -T 1 #{x.opts} | tee #{x.log}"   # -T 1 to make t=
he test time shorter
+
+    # Start thread to enfore maxTimeout
+    if @maxTimeout then
+      @rThread =3D Thread.new{
+	    puts "@rThread: "+Process.pid.to_s if $VERBOSE
+	    writeLogEntry(x, "started: #{opts} Timeout #{@maxTimeout}")
+	    sleep(@maxTimeout);
+	    writeLogEntry(x, "rThread will kill #{$childPid.inspect}")
+	    system("kill -9 #{$childPid}") if $childPid
+	    raise Timeout::Error=20
+      }
+    end
+    # Now we are doing calling our script
+    $childPid =3D nil
+    Dir.chdir(@inst)
+    res =3D IO.popen(x.cmd) { |f|
+      puts "cmd: "+Process.pid.to_s if $VERBOSE
+      $childPid =3D Process.pid
+      f.each{|a| puts a}
+    }=20
+    tstRes =3D $?
+  rescue Timeout::Error =3D> details
+    puts detail.backtrace.join("\n")
+    writeLogEntry(x, "FAILED: #{opts} Timeout error #{$childPid}")
+    system("kill -9 #{$childPid}")
+  rescue =3D> details
+    writeLogEntry(x, "FAILED: #{opts} runtime error #{@rThread.inspect} pi=
d #{$childPid.inspect}")
+    puts details.backtrace.join("\n")
+    system("kill -9 #{$childPid}")
+    @rThread.kill if defined?(@rThread)
+  ensure
+    # save results,
+    # clean up dd process if there are any, if xeno-test did not clean it =
up as it should have
+    endTime =3D Time.now
+    duration =3D (endTime-startTime).round
+    if duration <=3D 5 then
+      str    =3D  "FAILED"
+      tstRes =3D  'too fast'
+    else
+      str =3D tstRes ? 'PASSED' : 'FAILED'
+    end
+    x.tstRes   =3D tstRes
+    x.duration =3D duration
+    XenoTest::writeLogEntry(x, "#{str}: #{sprintf("%3d", duration)} second=
s. opts <#{x.opts}> returned #{tstRes}")
+
+    IO.popen("ps -ef | grep -w dd") { |f|
+      line=3D f.gets
+      if ! line.index('grep') then
+	msg =3D "#{Time.now}: #{sprintf("%2d", x.nr)} FAILED: dd not killed \n   =
 >>> #{line}"
+	[ STDOUT, @@mainLog].each {|dev| dev.puts msg if dev}
+	system "killall dd"
+      end
+    }
+    @rThread.kill if @rThread
+    @rThread =3D nil
+  end
+
+  def runChecks
+    puts "running all Checks"
+    @tsts.each { |aTst|
+      checkFinished(aTst)
+      chks =3D aTst.chkProc
+      next if ! chks
+      z =3D eval "#{chks[0]}"+"(aTst, chks[1])" if chks[1]
+    }
+    puts "completed all Checks"
+  end
+
+  def checkFinished(tst)
+    return if ! FinishedMsg
+    logInhalt =3D IO.readlines(tst.log)
+    finished  =3D false
+    logInhalt.each{|line|
+      finished =3D  true if line.index(FinishedMsg)
+    }
+    if !finished then
+      puts "CHK #{tst.nr} FAILED opts #{tst.opts} could not find #{Finishe=
dMsg}"
+      puts "  searched in #{tst.log}"=20
+    end
+  end
+
+  def getTstByOpt(opts)
+    @tsts.each{ |aTst|
+      return aTst if aTst.opts =3D=3D opts
+    }
+    return nil
+  end
+end
+
+# Here follow the various routines, that check the effect of each options
+def expectInLogFile(x, string)
+  puts "x #{x.inspect}\nlooking for #{string}" if $VERBOSE
+  logInhalt =3D IO.readlines(x.log)
+  found =3D false
+  logInhalt.each{|line|
+    found =3D true if line.index(string)
+  }
+  puts "CHK #{x.nr} FAILED, could not find #{string} in #{x.log}" if !found
+end
+
+# Get a name for a temporary file as a target to upload via curl (option -=
U)
+tf =3D Tempfile.new("xeno-test")
+TstUrlTarget =3D tf.path
+tf.close
+File.delete if File.exists?(TstUrlTarget)
+
+tst   =3D nil
+store =3D nil
+File.delete(StorageName) if $clean &&  File.exists?(StorageName)
+if File.exists?(StorageName) then
+  # Read in our saved test state (if we have a valid combination)
+  store =3D PStore.new(StorageName)
+  puts "reading tst from #{StorageName}"
+  store.transaction do
+    tst =3D store['tst']
+  end
+else
+  # we prepare to run our tests
+
+  # Get the first block-Device
+  blockDevices =3D `mount | cut -d\\  -f1 | egrep -ve 'sysfs|proc|depts'`
+  blockDevices =3D blockDevices[0..blockDevices.index("\n")].chomp
+  bDev =3D blockDevices
+
+  tst =3D XenoTest.new({'blockDevice' =3D> bDev})
+  tst.maxTimeout =3D 120
+
+  # Define test run for each option and/or combination thereof
+ =20
+  # Test for a bad option. This happens to be fast, too
+  tst_0  =3D tst.add("-O",                [ 'expectInLogFile', "xeno-test =
[options]"])
+  tst_1  =3D tst.add("",                  [ 'expectInLogFile', FinishedMsg=
])
+  tst_2  =3D tst.add("-T 5")
+  if true then # To speed up our test,s we may turn off defining more test=
runs
+      tst_3  =3D tst.add("-p 200",        ['expectInLogFile',"Sampling per=
iod: 200 us"])
+      tst_4  =3D tst.add("-w 2",          ['expectInLogFile',FinishedMsg])
+      tst_5  =3D tst.add("-d #{bDev}",
+	  ['expectInLogFile',"creating workload using dd if=3D#{bDev}"])
+
+      tst_6  =3D tst.add("-w /bin/dd #{bDev}",
+					['expectInLogFile',FinishedMsg])
+      tst_7  =3D tst.add("-P 'echo marker'",=20
+					['expectInLogFile',FinishedMsg])
+      tst_8  =3D tst.add("-L",            ['expectInLogFile',FinishedMsg])
+      tst_9  =3D tst.add("-N marker",     ['expectInLogFile',FinishedMsg])
+      tst_10 =3D tst.add("-v",            ['expectInLogFile',FinishedMsg])
+      tst_11 =3D tst.add("-U #{TstUrlTarget}",
+                                        ['expectInLogFile',FinishedMsg])
+      tst_12 =3D tst.add("-D '%Ymarker%Mmarker%D'",=20
+                                        ['expectInLogFile',FinishedMsg])
+#      tst_13 =3D tst.add("-M #{ENV['USER']}@localhost",=20
+#					['expectInLogFile',FinishedMsg])
+#      tst_14 =3D tst.add("-m",            ['expectInLogFile',FinishedMsg])
+  end
+
+  # Remove files, we might have left behind in a previous test
+  ( Dir.glob("/tmp/test-#{`uname -r`.chomp}*") +=20
+    Dir.glob("#{XenoInstall}/marker*")).each { |file|
+    puts "Removing #{file}"
+    File.delete file
+  }
+  tst.runTests
+
+  # Now we are ready to store our testresult (our ruby variable) to file
+  puts "Writing tst to #{StorageName}"
+  store =3D PStore.new(StorageName)
+  store.transaction do
+    store['tst'] =3D tst
+  end
+end
+
+# If we did run the curl/-N, -L test, did it generate the expected file?
+{
+ "-U #{TstUrlTarget}" =3D> TstUrlTarget,
+ "-L" =3D> "/tmp/test-#{`uname -r`.chomp}*",
+ "-N marker" =3D>  "#{XenoInstall}/marker*",
+}.each { |opt, path|
+  myTst  =3D tst.getTstByOpt(opt)
+  if myTst && Dir.glob(path).size =3D=3D 0  then
+    XenoTest::writeLogEntry(myTst, "FAILED: #{opt}: no file #{path} found")
+  else=20
+    XenoTest::writeLogEntry(myTst, "PASSED: #{opt}: #{Dir.glob(path).inspe=
ct}")
+  end if myTst
+}
+
+# This string is probably wrong, but I think xeno-test doesn't accept this
+# string as it should neither
+myTst  =3D tst.getTstByOpt("-D '%Ymarker%Mmarker%D'")
+tstString =3D "-D #{Time.now.strftime('%Ymarker%Mmarker%D')}"
+tstString =3D "marker"
+expectInLogFile(myTst, tstString) if myTst
+
+# Test whether we really take more time with -T 5 than with the default -T=
 1
+long  =3D tst.getTstByOpt("-T 5")
+short =3D tst.getTstByOpt("")
+if long and short then
+  if long.duration < short.duration + 5
+  then
+    XenoTest::writeLogEntry(long,=20
+      "FAILED: with '#{short.opts}' #{sprintf("%3d", short.duration)} "+
+      "+ 5 not smaller <  #{sprintf("%3d", long.duration)} seconds with '#=
{long.opts}'.")
+  end
+end
+
+tst.runChecks

Eigenschafts=E4nderungen: scripts/maint/test-xeno-test.rb
___________________________________________________________________
Name: svn:executable
   + *

Index: scripts/xeno-load.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- scripts/xeno-load.in	(Revision 1254)
+++ scripts/xeno-load.in	(Arbeitskopie)
@@ -1,7 +1,9 @@
=2D#! /bin/bash
+#! /bin/sh
 # Xenomai application loader script.
 # (Processes the .runinfo files)
 # June 2004, <rpm@xenomai.org>
+# Adapted to be run also under the BusyBox. If you want to test it under t=
he BusyBox use
+# busybox sh xeno-info=20
=20
 usage=3D'usage: xeno-load [[dir:]target]'
 prefix=3D"@prefix@"
@@ -23,7 +25,7 @@
   shift
 fi
=20
=2Dif test "x$1" =3D x--; then
+if test -z "$1" || test "x$1" =3D x--; then
   target_dir=3D`pwd`
   target_name=3Ddefault
 else
@@ -80,7 +82,7 @@
=20
 eval $user_moddir
=20
=2Dif `$sudo $modprobe -nq xeno_nucleus >& /dev/null`; then
+if `$sudo $modprobe -nq xeno_nucleus > /dev/null 2>&1`; then
    target_deps=3D"${target_deps}nucleus+"
 else
    target_deps=3D
@@ -92,8 +94,8 @@
=20
 test $verbose =3D 1 && echo "Running $target_name from $run_info_file"
=20
=2Dif test \! "x`type -t sudo`" =3D x; then
=2D  sudo=3Dsudo
+if test -n "`which sudo`"; then
+  sudo=3D`which sudo`
 fi
=20
 if test \! "x$target_mesg" =3D x; then
@@ -161,7 +163,7 @@
 	   echo "ERROR: cannot load $xeno_moddir/xeno_$mod$modext"
 	   break
         fi
=2D     elif `$sudo $modprobe -n xeno_$mod >& /dev/null`; then
+     elif `$sudo $modprobe -n xeno_$mod > /dev/null 2>&1`; then
         test $verbose =3D 1 && echo "+ $modprobe xeno_$mod"
         $sudo $modprobe xeno_$mod
         inslist=3D"xeno_$mod $inslist"
Index: scripts/xeno-test.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- scripts/xeno-test.in	(Revision 1254)
+++ scripts/xeno-test.in	(Arbeitskopie)
@@ -1,5 +1,7 @@
=2D#!/bin/bash
=2D
+#! /bin/sh
+# Adapted to be run also under the BusyBox. If you want to test it under t=
he BusyBox use
+# busybox sh xeno-test=20
+# A BusyBox >=3D 1.1.3 with a make defconfig should provide all needed app=
lets.
 myusage() {
     cat >&1 <<EOF
 xeno-test [options]
@@ -37,11 +39,52 @@
     exit 1
 }
=20
+echo "xeno-test: started $*"
 #set -e	# ctrl-C's should end everything, not just subshells.=20
 	# commenting it out may help to debug stuff.
=20
 set -o notify	# see dd's finish immediately.(or not!)
=20
+withBusybox=3D0
+if sh --help 2>&1| grep -q BusyBox; then
+    withBusybox=3D1;
+# else running a real /bin/sh (bash) shell
+fi
+echo withBusybox is $withBusybox
+pidFile=3D/var/lock/`basename $0.$$`.pids
+
+checkUtilities() {
+  # Check for needed helper utilities
+  local neededApplets=3D"awk basename cut date dd dirname egrep grep getopt
+		       head kill md5sum mount sleep test top uname zcat"
+  local foundAll=3D1
+  for  _j in $neededApplets
+  do
+    if test -z "`which $_j`"; then
+      echo "Please build busybox with support for applet $_j"
+      foundAll=3D0
+    fi
+  done
+  if test $foundAll -eq 0 ; then exit 3 ; fi
+}
+
+checkHelpers() {
+  local foundAll=3D1
+  if test -z "`which script`" -a -n "$logging"; then
+      echo "You will not be able to log (-L option) as script is missing"
+      foundAll=3D0
+  fi
+  if test -z "`which mail`" -a "$sendit" =3D 'm' ; then
+      echo "You will not be able send mail (-m/-M options) as mail is miss=
ing"
+      foundAll=3D0
+  fi
+  if test -z "`which curl`" -a "$sendit" =3D 'm' ; then
+      echo "You will not be able to upload (-U option) as curl is missing"
+      foundAll=3D0
+  fi
+  if test $foundAll -eq 0 ; then exit 3 ; fi
+}
+
 loudly() {
     [ "$1" =3D "" ] && return
     # run task after announcing it
@@ -53,31 +96,46 @@
=20
 # defaults for cpu workload=20
 device=3D/dev/zero=09
=2Dtypeset -a dd_jobs
=2Ddd_jobs=3D()
+dd_jobs=3D
=20
 # used in generate-loads
=2Dmkload() { exec dd if=3D$device of=3D/dev/null $* ; }
+mkload() { dd if=3D$device of=3D/dev/null $* & }
=20
 generate_loads() {
=2D    local jobsct=3D$1; shift;
+    local jobsct=3D$1;
+    # if test -z "$1"; then echo Skipping generate_loads; return; fi
+    shift 1
+    if test 0 -eq $withBusybox ; then
+	reaper() { echo something died a $! or $* ; sleep 1;  }
+	trap reaper CHLD
+	trap cleanup_load EXIT	# under all exit conditions
+    fi
+    while test $jobsct -ge 1; do=20
+        jobsct=3D$((jobsct-1));=20
+        mkload
+        dd_jobs=3D"$dd_jobs $!" ;
+    done
=20
=2D    reaper() { echo something died $*; }
=2D    trap reaper CHLD
=2D    trap cleanup_load EXIT	# under all exit conditions
=2D   =20
=2D    for (( ; $jobsct ; jobsct-- )) ; do
=2D	mkload &
=2D	dd_jobs[${#dd_jobs[*]}]=3D$!
=2D    done;
=2D
=2D    echo dd workload started, pids ${dd_jobs[*]}
+    echo dd workload started, pids $dd_jobs stored in $pidFile
+    echo  $dd_jobs > $pidFile
 }
=20
 cleanup_load() {
     # kill the workload
=2D    echo killing workload pids ${dd_jobs[*]}
=2D    kill ${dd_jobs[*]};
+    if test -z "$dd_jobs" -a -r $pidFile; then
+      dd_jobs=3D`cat $pidFile`
+      rm -f $pidFile
+    fi
+
+    if test -z "$dd_jobs" ; then
+        echo "cleanup_load: no dd_jobs found"
+    else
+	for _j in $dd_jobs
+	do
+	  ps | grep $_j
+	  kill $_j
+	done
+    fi
     unset dd_jobs;
 }
=20
@@ -85,21 +143,20 @@
=20
=20
 boxinfo() { # static info, show once
+    loudly `dirname $0`/xeno-config --verbose
+    loudly `dirname $0`/xeno-info
=20
=2D    loudly ./xeno-config --verbose
=2D    loudly ./xeno-info
=2D
     loudly cat /proc/cpuinfo	# bogomips changes under CPU_FREQ
=2D    loudly cksum /proc/cpuinfo	'# cpuinfo fingerprint'
+    loudly md5sum /proc/cpuinfo	'# cpuinfo fingerprint'
=20
     # how much of the config do we want ?
=2D    local cmd=3D"zgrep -E '$whatconf'"
=2D    [ "$verbose" =3D 1 ] && cmd=3Dcat
=2D
=2D    if [ -f /proc/config.gz ]; then	# get the config
=2D	loudly $cmd /proc/config.gz
=2D    elif [ -f /lib/modules/`uname -r`/build/.config ]; then
=2D	loudly $cmd /lib/modules/`uname -r`/build/.config
+    local filter=3D" grep -E '$whatconf'"
+    [ "$verbose" =3D 1 ] && filter=3D
+    if test -f /proc/config.gz; then # get the config
+         loudly zcat /proc/config.gz | $filter
+    elif test -f /lib/modules/`uname -r`/build/.config
+    then
+	loudly cat /lib/modules/`uname -r`/build/.config | $filter
     fi
=20
     [ -d /proc/adeos ] && for f in /proc/adeos/*; do loudly cat $f; done
@@ -107,7 +164,6 @@
 }
=20
 boxstatus() {     # get dynamic status
=2D
     loudly cat /proc/interrupts
     loudly cat /proc/loadavg
     loudly cat /proc/meminfo
@@ -117,7 +173,11 @@
 	for f in /proc/xenomai/*/*; do [ -f $f ] && loudly cat $f; done
     fi
     [ -n "$prepost" ] && loudly $prepost
=2D    loudly top -bn1c | head -n $(( 12 + $workload ))
+    if test 0 -eq $withBusybox ; then
+	loudly top -bn1c | head -n $(( 12 + $workload ))
+    else
+	loudly top | head -n $(( 12 + $workload ))
+    fi
 }
=20
=20
@@ -129,25 +189,34 @@
     loudly generate_loads $workload
     boxstatus
     (
=2D	cd ../testsuite/latency
+        cd `dirname $0`/../testsuite/latency
 	loudly ./run --  $opts -t0
 	loudly ./run --  $opts -t1
 	loudly ./run --  $opts -t2
     )
=2D    (	cd ../testsuite/switch=20
+    (	cd `dirname $0`/../testsuite/switch
 	loudly ./run --  '# switch'
     )
=2D    (	cd ../testsuite/cyclic
+    (	cd `dirname $0`/../testsuite/cyclic
 	loudly ./run -- -p 10 -n -l 1000 '# cyclictest'
     )
=2D
     boxstatus
+    cleanup_load
 }
=20
=2D
 #####################
 # MAIN
+checkUtilities
=20
+if [ -f /proc/config.gz ] ; then
+
+    # check/warn on problem configs
+    eval `zcat /proc/config.gz | grep CONFIG_CPU_FREQ` ;
+    if [ ! -z "$CONFIG_CPU_FREQ" ] ; then
+	echo "warning: CONFIG_CPU_FREQ=3D$CONFIG_CPU_FREQ may be problematic"
+    fi
+fi
+
 workload=3D1	# default =3D 1 job
=20
 # *pass get all legit options, except -N, -L
@@ -155,7 +224,7 @@
 loadpass=3D	# pass thru to subshell, not to actual tests
=20
 logging=3D	# no logging by default
=2Dlogfile=3D	# defaults to test-`uname -r`-<datestampe>
+logfile=3Dtest-`uname -r` # defaults to test-`uname -r`-<datestampe>
 logprefix=3D/tmp/	# someplace usually there
 prepost=3D	# command to run pre, and post test (ex ntpq -p)
=20
@@ -168,18 +237,20 @@
=20
 sendit() {
     local file=3D$1
=2D   =20
=2D    if [ "$sendit" =3D=3D 'm' ]; then
+    if test "$sendit" =3D 'm' ; then
 	echo "mailing $file to $email"
=2D	if [ "$file" !=3D '' ]; then
+	if test -n "$file" ; then
 	    mail -s 'xeno-test results' $email -- -F $sentby < $file
 	else
 	    cat - | mail -s 'xeno-test results' $email -- -F $sentby
 	fi
=2D    elif [ "$sendit" =3D=3D 'u' ]; then
+    elif test "$sendit" =3D 'u' ; then
+	echo "uploading $file to $url"
 	which curl && curl -T $file $url
 	# -x $proxy >/tmp/.submit_result
 	# which wget && curl -T $file $url \
+    else
+	echo "sendit unsupported option '$sendit'"
     fi
 }
=20
@@ -199,7 +270,7 @@
 	    if !(mount | grep -q ^$device) ; then
 		echo d option must be a block device, ie one of:
 		mount | cut -d\  -f1 | egrep -ve 'sysfs|proc|depts'
=2D		exit;
+		exit 1;
 	    fi
 	    loadpass=3D"$loadpass -d $device"
 	    ;;
@@ -245,27 +316,39 @@
     handle_options;
 done
=20
+checkHelpers
+
 # all args have been handled, and split into 2 passthrus
 shift $(($OPTIND - 1));
=20
+if test -f pidFile && ! test -w $pidFile ; then
+  echo  "pidfile $pidFile not writable ";=20
+  exit 4
+fi
=20
=2Dif [ "$logging" !=3D "" ]; then
+echo "xeno-test: running tests"
+
+wfile=3D$logprefix$logfile-`date $dateargs`
+if test "$logging" !=3D "" ; then
     # restart inside a script invocation, passing appropriate args
=2D    wfile=3D$logprefix$logfile-`date $dateargs`
=2D    script -c "./xeno-test $loadpass $pass $*" $wfile && sendit $wfile
+    script -c "`dirname $0`/xeno-test $loadpass $pass $*" $wfile
+    res=3D"$?"
+    if test "$res" =3D=3D "0" ; then
+	sendit $wfile
+    fi
 else
=2D    if [ "$altwork" !=3D "" ]; then
+    if test "$altwork" !=3D "" ; then
 	mkload() { exec $altwork; }
     fi
=2D    echo starting $0 $pass $loadpass $*
=2D    if [ "$sendit" !=3D '' ]; then
=2D	run_w_load $pass $* 2>&1 | sendit
=2D    else
=2D	run_w_load $pass $*
+    run_w_load $pass $* 2>&1 | tee $wfile
+    res=3D"$?"
+    if test "$sendit" !=3D '' && test $res -eq 0  ; then
+       sendit $wfile
     fi
 fi
=20
=2Dexit;
+echo "xeno-test: finished"
+exit 0
=20
=20
 #################################################
@@ -297,15 +380,20 @@
 will eventually finish, and should be restarted to keep the load up.
 Figure out why killall didnt work properly.
=20
=2D2. Much more testing.  Heres a weak start..
+2. Much more testing.  Heres a weak start. You migth be better off
+using and improving test/test-xeno-test.rb.
=20
 #!/bin/bash
 PATH=3D.:$PATH
 xeno-test -L
 xeno-test -N foo -T 18 -l 6 -s
 xeno-test -L -N foo1-
+xeno-test -m
+xeno-test -T 1 -M $USER@localhost
 xeno-test -N foo0 -w0 -l 5 -T 30 -h
 xeno-test -L -N foo4- -w4
 xeno-test -L -N foo4W- -w4 -W 'dd if=3D/dev/hda1 of=3D/dev/null'
=20
=2D3.
+3. Repeat the same tests under the BusyBox.
+
+4. Check for border cases like missing awk, curl, mail, script, /proc/conf=
ig.gz

--Boundary-00=_a2wmEjPhLAkdRf9
Content-Type: application/x-tbz;
  name="logs.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="logs.tar.bz2"

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
kinChIO/4Ow4

--Boundary-00=_a2wmEjPhLAkdRf9--

