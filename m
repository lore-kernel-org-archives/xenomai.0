From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Mon, 4 Sep 2006 08:35:09 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609040835.10868.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Buildbot reorganisation
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

Hi

I refactored the whole buildbot quite a lot. The following changes are worth 
mentioning and were applied last saturday morning:

- upgraded to buildbot 0.7.4 (required to for better warning/logs)

- to speed up builds during the day reorganised the buildbot to

- quick builds which only calls svn update, run 2 minutes after a checkin.
  Found at the usual place http://ngiger.dyndns.org/buildbot/
  They should be finished normally 20 to 30 minutes after a checkin.

- full builds at 1 AM in the night, takes about 2 hours. Found at
  http://ngiger.dyndns.org/buildbot-full/

- Using the AnyBranchScheduler to permit builds of branches/v2.2.2, in order
  to catch failures like the one reported yesterday "v2.2.x broken (r1534)".
  Here I am not totally sure whether everything will work as intended, but I 
  will have a close look on it.

- Reworked documentation, see
  http://ngiger.dyndns.org/xenomai-data/xeno_buildbot.{pdf|lyx}

- Warnings (if any) during compilations are found in the "HTML" log file of
  a compile step, e.g. build
  http://ngiger.dyndns.org/buildbot/hcu3_vx_q/builds/0
  leads to
  http://ngiger.dyndns.org/buildbot/hcu3_vx_q/builds/0/step-mk_kernel/2
  I hope, that Gilles is satisfied, if not, please propose a better layout.

- During build time it should be possible to watch warnings coming in
  realtime. But beware, that if the slave and master run on the same machine,
  this will be really slow, for reasons still unknown to me.

- Added a help script extract_script.rb, which allows me to extract all
  the steps run a build. Handy for debugging.

- Added a robots.txt to avoid incoming traffic on my machine. Everything robot
  is no disallow to search anything under the buildbot/.

- Corrected test_sim.rb to output segmentation errors, check for error status
  of all called test programs.

Buildbot has the very nice feature to be able to run a lot of steps
B E F O R E checking in the changes. See 
http://buildbot.sourceforge.net/manual-0.7.4.html#try
If any of the committers  would like to test the feature, I would love to add 
this feature to the buildbot and would do all the necessary to give him the 
necessary privilege on the buildmaster. I never tested this feature yet, but 
would invest the necessary time if you drop me note that you are interested.

TODO:
- investigate why the sim segfaults on ppc
- why does the hcu3 test run with the quick but not the full build.

Best regards

-- 
Niklaus Giger

