From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Fri, 16 Jun 2006 22:03:07 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_85wkEPa+CSgztVT"
Message-Id: <200606162203.08516.niklaus.giger@domain.hid>
Subject: [Xenomai-core] A test script to bring xeno-test into a better shape
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
To: xenomai@xenomai.org

--Boundary-00=_85wkEPa+CSgztVT
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi everybody

After working hard to get my ruby script as clean as possible, I would like to 
submit it to you for additional comments.
The attached ruby script must be placed at scripts/maint/test-xeno-test.rb.
It basically calls xeno-test many times with different options, creating log 
files called scripts/maint/logs/test_xeno_test.log.[0..n] (not attached). A 
short evaluation of the results is saved as scripts/maint/logs/runtest.log 
(attached).

In order to minimize the time need for a run I run the tests always with "-T 
1", except a single test with "-T 5" (to be sure, that -T <x> works).

Running xeno-test in less than 5 seconds was considered an error. I have not 
yet a "expected failure" feature for cases like passing a wrong option "-O" 
to xeno-test.

In my opinion this script correctly show the following deficiencies of the 
actual version of xeno-test:
- options -v and -U do not work correctly
- the load process "dd" are not always killed correctly

The options "-m" and "-M" are not tested, as they had a timeout behaviour 
which resisted my initial attempts to enforce a maximal timeout of 120 
seconds. Maybe I will have sometime a better idea how to deal with this 
error. "xeno-test -M user@domain.hid" succeded only if a manually killed 
either the dd jobs or entered Ctrl-C.

The error flagged as " 2 FAILED: with ''  47 + 5 not smaller <   50 seconds 
with '-T 5'." is a false positive, as this error didn't show up during other 
runs (but I think there was a backup job running).

If anybody has other experiences with xeno-test and thinks that my test 
reports false positives or false negatives, I would appreciate a feedback.
Suggestions/critics for improvement are always welcome.

If now serious errors are found in test-xeno-test.rb, I would appreciate if it 
could be checked into the xenomai trunk. Places other than scripts/maint 
would need a small change to the source code.

Once agreed upon this test-tool I would like to continue like this:
1) Switch to busybox compatible shell syntax. (No regression compared to the 
actual version, but not necessarily all bugs fixed). This patch is almost 
ready, but I would like to check-in the test first.
2) Fix the remaining bugs in xeno-test
3) Port all (or at least the most used) xeno-test feature to the busybox. The 
send mail feature will probably not be tested/fixed by me, as my busybox 
system does not have a mail program. Maybe the same for saving to a log file.
4) Add some improvement like better arguments passing to the individual tests, 
e.g. using OPT_$TOOL environment variables.

Steps 2) and 3) have no particular order.

I do not intend to add test-xeno-test.rb to my buildbot, as I consider this a 
test that should be run manually. But integrating a "xeno-test -m" step in 
some buildbots is on my todo list.

Best regards

-- 
Niklaus Giger

--Boundary-00=_85wkEPa+CSgztVT
Content-Type: application/x-ruby;
  name="test-xeno-test.rb"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="test-xeno-test.rb"

#!/usr/bin/env ruby

# Funning xeno-test once with each option takes a long time (around 15 minutes)
# For each test a full log is stored in the logs subdirectory.
# Therefore the results of the tests (the ruby variable) is stored using Pstore in
# the file logs/xeno-test.store.
# If this file exists and is newer than xeno-test and the first parameter is != clean
# The tst variable is fetched from the file.
# This is convenient if you want to add new checks.
#
# Todo: - Why do the mailing tests not work  ?
#       - How does xeno-test react to Ctrl-C ?
#       - Thorougher analyses of the log files
#
require 'timeout'
require 'ostruct'
require 'ftools'
require 'pstore'
require 'tempfile'

XenoInstall = "/usr/xenomai/bin"
XenoHead    = File.expand_path(File.dirname(File.dirname(__FILE__)))
XenoTestOrg = XenoHead+'/xeno-test.in'
XenoTestRun = XenoInstall+'/xeno-test'
LogDir      = XenoHead+'/logs'
MainLog     = LogDir+'/runtest.log'
StorageName = LogDir+'/xeno-test.store'
withFinished = `grep finished /usr/xenomai/bin/xeno*`
withFinished.size > 0 ? FinishedMsg = "xeno-test: finished" : FinishedMsg = nil

$clean  = ARGV[0] == 'clean' && ! (
	  File.exists?(XenoTestRun) &&
          File.exists?(StorageName) &&
          File.stat(XenoTestRun).mtime >  File.stat(StorageName).mtime
          )
if $clean && File.exists?(StorageName) then
  puts "Do you really want to run all tesst? <Ctrl-C> to abort"
  STDIN.getc
end

class XenoTest
  attr_reader :mainLog
  attr_reader :blockDevice
  attr_writer :maxTimeout
  attr_writer :chkProc

  def initialize(options)
    @from    = XenoHead
    @inst    = XenoInstall
    @busybox = false
    File.makedirs(LogDir) if defined?(LogDir) && ! File.directory?(LogDir)
    @@mainLog = open(MainLog,"w");
    @@mainLog.puts("#{Time.now}: started run")
    @@mainLog.sync = true
    options.each { |name,val|
      if val.class == String then
        cmd =  "@#{name}='#{val}'"
      else
	cmd =  "@#{name}=#{val}"
      end
      eval cmd
    }
  end

  def add(opts,  chkProc=nil)
    @nr   = -1        if !defined?(@nr)
    @tsts = Array.new if !defined?(@tsts)
    @nr  += 1
    elem = OpenStruct.new({'nr' => @nr, 'opts'=>opts})
    elem.chkProc = chkProc if chkProc
    @tsts << elem
    return elem
  end

  def runTests
    @tsts.each { |x| runOneTest(x) ; }
  end

  def XenoTest::writeLogEntry(tst, logMsg)
    msg = "#{Time.now}: #{sprintf("%2d", tst.nr)} "+ logMsg
    if ! File.exists?(MainLog) then
      puts msg
    end
    outs = [ STDOUT]
    outs << @@mainLog if defined?(@@mainLog) && @@mainLog
    outs.each {|dev| dev.puts msg }
  end

  def runOneTest(x)
    puts "runOneTest #{x.inspect}"  if $VERBOSE
    opts = x.opts
    startTime = Time.now
    tstRes = nil
    x.tst  = `which xeno-test`.chomp
    x.log  = "#{LogDir}/test_xeno_test.log.#{x.nr}"
    x.cmd  = "#{x.tst} -T 1 #{x.opts} | tee #{x.log}"   # -T 1 to make the test time shorter

    # Start thread to enfore maxTimeout
    if @maxTimeout then
      @rThread = Thread.new{
	    puts "@rThread: "+Process.pid.to_s if $VERBOSE
	    writeLogEntry(x, "started: #{opts} Timeout #{@maxTimeout}")
	    sleep(@maxTimeout);
	    writeLogEntry(x, "rThread will kill #{$childPid.inspect}")
	    system("kill -9 #{$childPid}") if $childPid
	    raise Timeout::Error 
      }
    end
    # Now we are doing calling our script
    $childPid = nil
    Dir.chdir(@inst)
    res = IO.popen(x.cmd) { |f|
      puts "cmd: "+Process.pid.to_s if $VERBOSE
      $childPid = Process.pid
      f.each{|a| puts a}
    } 
    tstRes = $?
  rescue Timeout::Error => details
    puts detail.backtrace.join("\n")
    writeLogEntry(x, "FAILED: #{opts} Timeout error #{$childPid}")
    system("kill -9 #{$childPid}")
  rescue => details
    writeLogEntry(x, "FAILED: #{opts} runtime error #{@rThread.inspect} pid #{$childPid.inspect}")
    puts details.backtrace.join("\n")
    system("kill -9 #{$childPid}")
    @rThread.kill if defined?(@rThread)
  ensure
    # save results,
    # clean up dd process if there are any, if xeno-test did not clean it up as it should have
    endTime = Time.now
    duration = (endTime-startTime).round
    if duration <= 5 then
      str    =  "FAILED"
      tstRes =  'too fast'
    else
      str = tstRes ? 'PASSED' : 'FAILED'
    end
    x.tstRes   = tstRes
    x.duration = duration
    XenoTest::writeLogEntry(x, "#{str}: #{sprintf("%3d", duration)} seconds. opts <#{x.opts}> returned #{tstRes}")

    IO.popen("ps -ef | grep -w dd") { |f|
      line= f.gets
      if ! line.index('grep') then
	msg = "#{Time.now}: #{sprintf("%2d", x.nr)} FAILED: dd not killed \n    >>> #{line}"
	[ STDOUT, @@mainLog].each {|dev| dev.puts msg if dev}
	system "killall dd"
      end
    }
    @rThread.kill if @rThread
    @rThread = nil
  end

  def runChecks
    puts "running all Checks"
    @tsts.each { |aTst|
      checkFinished(aTst)
      chks = aTst.chkProc
      next if ! chks
      z = eval "#{chks[0]}"+"(aTst, chks[1])" if chks[1]
    }
    puts "completed all Checks"
  end

  def checkFinished(tst)
    return if ! FinishedMsg
    logInhalt = IO.readlines(tst.log)
    finished  = false
    logInhalt.each{|line|
      finished =  true if line.index(FinishedMsg)
    }
    if !finished then
      puts "CHK #{tst.nr} FAILED opts #{tst.opts} could not find #{FinishedMsg}"
      puts "  searched in #{tst.log}" 
    end
  end

  def getTstByOpt(opts)
    @tsts.each{ |aTst|
      return aTst if aTst.opts == opts
    }
    return nil
  end
end

# Here follow the various routines, that check the effect of each options
def expectInLogFile(x, string)
  puts "x #{x.inspect}\nlooking for #{string}" if $VERBOSE
  logInhalt = IO.readlines(x.log)
  found = false
  logInhalt.each{|line|
    found = true if line.index(string)
  }
  puts "CHK #{x.nr} FAILED, could not find #{string} in #{x.log}" if !found
end

# Get a name for a temporary file as a target to upload via curl (option -U)
tf = Tempfile.new("xeno-test")
TstUrlTarget = tf.path
tf.close
File.delete if File.exists?(TstUrlTarget)

tst   = nil
store = nil
File.delete(StorageName) if $clean &&  File.exists?(StorageName)
if File.exists?(StorageName) then
  # Read in our saved test state (if we have a valid combination)
  store = PStore.new(StorageName)
  puts "reading tst from #{StorageName}"
  store.transaction do
    tst = store['tst']
  end
else
  # we prepare to run our tests

  # Get the first block-Device
  blockDevices = `mount | cut -d\\  -f1 | egrep -ve 'sysfs|proc|depts'`
  blockDevices = blockDevices[0..blockDevices.index("\n")].chomp
  bDev = blockDevices

  tst = XenoTest.new({'blockDevice' => bDev})
  tst.maxTimeout = 120

  # Define test run for each option and/or combination thereof
  
  # Test for a bad option. This happens to be fast, too
  tst_0  = tst.add("-O",                [ 'expectInLogFile', "xeno-test [options]"])
  tst_1  = tst.add("",                  [ 'expectInLogFile', FinishedMsg])
  tst_2  = tst.add("-T 5")
  if true then # To speed up our test,s we may turn off defining more testruns
      tst_3  = tst.add("-p 200",        ['expectInLogFile',"Sampling period: 200 us"])
      tst_4  = tst.add("-w 2",          ['expectInLogFile',FinishedMsg])
      tst_5  = tst.add("-d #{bDev}",
	  ['expectInLogFile',"creating workload using dd if=#{bDev}"])

      tst_6  = tst.add("-w /bin/dd #{bDev}",
					['expectInLogFile',FinishedMsg])
      tst_7  = tst.add("-P 'echo marker'", 
					['expectInLogFile',FinishedMsg])
      tst_8  = tst.add("-L",            ['expectInLogFile',FinishedMsg])
      tst_9  = tst.add("-N marker",     ['expectInLogFile',FinishedMsg])
      tst_10 = tst.add("-v",            ['expectInLogFile',FinishedMsg])
      tst_11 = tst.add("-U #{TstUrlTarget}",
                                        ['expectInLogFile',FinishedMsg])
      tst_12 = tst.add("-D '%Ymarker%Mmarker%D'", 
                                        ['expectInLogFile',FinishedMsg])
#      tst_13 = tst.add("-M #{ENV['USER']}@localhost", 
#					['expectInLogFile',FinishedMsg])
#      tst_14 = tst.add("-m",            ['expectInLogFile',FinishedMsg])
  end

  # Remove files, we might have left behind in a previous test
  ( Dir.glob("/tmp/test-#{`uname -r`.chomp}*") + 
    Dir.glob("#{XenoInstall}/marker*")).each { |file|
    puts "Removing #{file}"
    File.delete file
  }
  tst.runTests

  # Now we are ready to store our testresult (our ruby variable) to file
  puts "Writing tst to #{StorageName}"
  store = PStore.new(StorageName)
  store.transaction do
    store['tst'] = tst
  end
end

# If we did run the curl/-N, -L test, did it generate the expected file?
{
 "-U #{TstUrlTarget}" => TstUrlTarget,
 "-L" => "/tmp/test-#{`uname -r`.chomp}*",
 "-N marker" =>  "#{XenoInstall}/marker*",
}.each { |opt, path|
  myTst  = tst.getTstByOpt(opt)
  if myTst && Dir.glob(path).size == 0  then
    XenoTest::writeLogEntry(myTst, "FAILED: #{opt}: no file #{path} found")
  else 
    XenoTest::writeLogEntry(myTst, "PASSED: #{opt}: #{Dir.glob(path).inspect}")
  end if myTst
}

# This string is probably wrong, but I think xeno-test doesn't accept this
# string as it should neither
myTst  = tst.getTstByOpt("-D '%Ymarker%Mmarker%D'")
tstString = "-D #{Time.now.strftime('%Ymarker%Mmarker%D')}"
tstString = "marker"
expectInLogFile(myTst, tstString) if myTst

# Test whether we really take more time with -T 5 than with the default -T 1
long  = tst.getTstByOpt("-T 5")
short = tst.getTstByOpt("")
if long and short then
  if long.duration < short.duration + 5
  then
    XenoTest::writeLogEntry(long, 
      "FAILED: with '#{short.opts}' #{sprintf("%3d", short.duration)} "+
      "+ 5 not smaller <  #{sprintf("%3d", long.duration)} seconds with '#{long.opts}'.")
  end
end

tst.runChecks

--Boundary-00=_85wkEPa+CSgztVT
Content-Type: text/x-log;
  charset="iso-8859-1";
  name="runtest.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="runtest.log"

Fri Jun 16 21:20:09 CEST 2006: started run
Fri Jun 16 21:20:10 CEST 2006:  0 FAILED:   1 seconds. opts <-O> returned too fast
Fri Jun 16 21:20:11 CEST 2006:  0 FAILED: dd not killed 
    >>> niklaus  25929     1 64 21:11 pts/1    00:05:25 dd if /dev/zero of /dev/null
Fri Jun 16 21:20:59 CEST 2006:  1 PASSED:  47 seconds. opts <> returned 0
Fri Jun 16 21:20:59 CEST 2006:  1 FAILED: dd not killed 
    >>> niklaus  26401     1 63 21:20 pts/4    00:00:27 dd if /dev/zero of /dev/null
Fri Jun 16 21:21:49 CEST 2006:  2 PASSED:  50 seconds. opts <-T 5> returned 0
Fri Jun 16 21:21:49 CEST 2006:  2 FAILED: dd not killed 
    >>> niklaus  26991     1 71 21:21 pts/4    00:00:34 dd if /dev/zero of /dev/null
Fri Jun 16 21:22:22 CEST 2006:  3 PASSED:  33 seconds. opts <-p 200> returned 0
Fri Jun 16 21:22:22 CEST 2006:  3 FAILED: dd not killed 
    >>> niklaus  27585     1 73 21:21 pts/4    00:00:23 dd if /dev/zero of /dev/null
Fri Jun 16 21:23:16 CEST 2006:  4 PASSED:  54 seconds. opts <-w 2> returned 0
Fri Jun 16 21:23:16 CEST 2006:  4 FAILED: dd not killed 
    >>> niklaus  28176     1 36 21:22 pts/4    00:00:19 dd if /dev/zero of /dev/null
Fri Jun 16 21:24:55 CEST 2006:  5 PASSED:  99 seconds. opts <-d /dev/hda9> returned 0
Fri Jun 16 21:24:55 CEST 2006:  5 FAILED: dd not killed 
    >>> niklaus  28790     1 13 21:23 pts/4    00:00:13 dd if /dev/hda9 of /dev/null
Fri Jun 16 21:25:18 CEST 2006:  6 PASSED:  23 seconds. opts <-w /bin/dd /dev/hda9> returned 0
Fri Jun 16 21:25:58 CEST 2006:  7 PASSED:  40 seconds. opts <-P 'echo marker'> returned 0
Fri Jun 16 21:25:58 CEST 2006:  7 FAILED: dd not killed 
    >>> niklaus  29993     1 68 21:25 pts/4    00:00:26 dd if /dev/zero of /dev/null
Fri Jun 16 21:26:29 CEST 2006:  8 PASSED:  30 seconds. opts <-L> returned 0
Fri Jun 16 21:27:00 CEST 2006:  9 PASSED:  32 seconds. opts <-N marker> returned 0
Fri Jun 16 21:27:00 CEST 2006: 10 FAILED:   0 seconds. opts <-v> returned too fast
Fri Jun 16 21:27:01 CEST 2006: 11 FAILED:   1 seconds. opts <-U /tmp/xeno-test26256.0> returned too fast
Fri Jun 16 21:27:32 CEST 2006: 12 PASSED:  31 seconds. opts <-D '%Ymarker%Mmarker%D'> returned 0
Fri Jun 16 21:27:33 CEST 2006: 12 FAILED: dd not killed 
    >>> niklaus  31893     1 79 21:27 pts/4    00:00:23 dd if /dev/zero of /dev/null
Fri Jun 16 21:27:33 CEST 2006:  9 PASSED: -N marker: ["/usr/xenomai/bin/marker-060616.212629"]
Fri Jun 16 21:27:33 CEST 2006: 11 PASSED: -U /tmp/xeno-test26256.0: ["/tmp/xeno-test26256.0"]
Fri Jun 16 21:27:33 CEST 2006:  8 PASSED: -L: ["/tmp/test-2.6.14-r-060616.212559"]
Fri Jun 16 21:27:33 CEST 2006:  2 FAILED: with ''  47 + 5 not smaller <   50 seconds with '-T 5'.

--Boundary-00=_85wkEPa+CSgztVT--

