From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Sun, 18 Jun 2006 01:38:18 +0200
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200606180138.20289.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Buildbot progress: runs xeno-test on one board
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

Hi

I just managed to put my newest version of the buildbot online. The following 
new features are present:
- Updated to buildbot 0.7.3.
- Generate a file "localversion" in the build directory which contains the
  svn revision number (using the new got_revision property in buildbot 0.7.3)
- For my embedded target HCU I build now two variants:
  a) hcu3: with APERIODIC timer and the skins native, uvm, posix, psos 
     (as modules)
  b) hcu_vx: with PERIODIC timer and the skins native, vrtx and vxworks
     (built-in). This variant has known startup problems, see:
     http://ngiger.dyndns.org/buildbot/hcu_vx/builds/7/step-xeno-test/0
- After compiling and installing the new kernel, modules and xenomai into
  a nfs-root on the server, the last step calls a Ruby script. It patches
  xeno-* to use my busybox variants. Then it powers the target on, waits till
  it is ready, logs in.  and calls xeno-test. Logs are not yet mailed to
  xenomai-data, as there are still some unresolved problems with this
  particular board.

An example output may be found going to:
http://ngiger.dyndns.org/buildbot/hcu3/builds/101/step-xeno-test/0

I hope this will generate a few more visit to the buildbot to verify whether 
your changes broke something or not.

Specifying this test is done by the following Ruby code snippet:

    # DefaultTTY  = "/dev/ttyUSB0"
    # DefaultPM   = ["172.25.1.211", 2]
  def runTest(device=DefaultTTY, pmIp = DefaultPM )
    res = false
    checkXenoTestPatch
    pm211 = PowerModule.new(pmIp[0], pmIp[1])
    scc   = File.open(device, "w+")
    CommDevice::setHCU3(scc)
    hcu3  = RmtTstRunner.new(scc, pm211, LogName)
    hcu3_steps = 
      [ TestStep.new("U-Boot", 5, nil),                        # Wait till 
U-Boot is awake
	TestStep.new("main_loop", 10, nil),                    # Wait till U-Boot 
loads kernel
	TestStep.new("Transferring control to Linux", 10),     # U-Boots job is 
finished now 
	TestStep.new("Linux version", 5, nil),                 # Linux is alive!
	TestStep.new("Freeing unused kernel memo", 10, nil),   # Linux init finished
	TestStep.new("Willkommen", 10, nil),
	TestStep.new("login", 5, "root"),
	TestStep.new("/usr/xenomai/bin $", 5, "cd /usr/xenomai/bin"), 
	TestStep.new("xeno-test: started", 5, "./xeno-test -T #{XenoRunTime}"),
	TestStep.new("xeno-test: finished", (30 + XenoRunTime)*NrXenoTests, nil)
      ]
    res = hcu3.runTest(hcu3_steps)
    hcu3.power.power(false)
    puts "#{Time.now.strftime("%H:%M:%S")}: Running xeno-test reported #{res}. 
Will dump output"
    system "cat #{LogName}"
    return res
  end
end

If you are interested in more details, take a look at 
http://ngiger.dyndns.org/xenomai-date. The API of the used Ruby code is found 
at http://ngiger.dyndns.org/xenomai-data/doc
All the sources (and the a little bit outdated documentation of the buildbot 
setup) can be checkedout via
http://ngiger.dyndns.org/svn/admin/hcu3_linux/doc/buildbot/.

Next steps will be documentation cleanup, improving xeno-test and adding a x86 
slave. (I just receveived an old x86-pc box, which I hope to make it boot via 
NFS.) But do not expect a lot of progress in the next 6 weeks as in 10 day I 
will leave for a 3 week vacation to Korea.

I am just puzzled that during the test, I get
>cat: /proc/xenomai/sched: No such process
>Sat Jun 17 21:48:53 UTC 2006
>running: cat /proc/xenomai/stat
>cat: /proc/xenomai/stat: No such process
Why do I get this answer? (xeno-test calls cat only for existing files?)

Best regards

-- 
Niklaus Giger

