From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Wed, 26 Dec 2007 22:30:39 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200712262230.39993.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Buildbot: Error building sim on branch 2.3
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

Thanks everybody for helping to clean up the errors! I have a lot more
successful build now than three days ago. 

As soon as I have some more time to spend on the buildbot. I will try
to cleanup the remaining failures which are probably more problems with
the buildbot setup than in the xenomai source.

But the sim has a regression (only in the 2.3 branch) as shown in
http://ngiger.dyndns.org/buildbot/builders/sim_q/builds/26
http://ngiger.dyndns.org/buildbot/builders/sim_q/builds/26/steps/make_sim/logs/stdio
building the simulator failed with:
make[1]: Entering directory `/var/buildbot/slave/sim_q/build/nucleus'
../gcic/gcic -DHAVE_CONFIG_H -I. -I../include -I../../xenomai/sim/nucleus  -D__IN_XENO__ --gcic-backend=/var/buildbot/test/bin/sim/libexec/gcic --kernel-code  -I../../xenomai/sim/nucleus/../include -I../../xenomai/sim/../include   -g -MT heap.o -MD -MP -MF .deps/heap.Tpo -c -o heap.o ../../xenomai/sim/../ksrc/nucleus/heap.c
../../xenomai/sim/../ksrc/nucleus/heap.c: In function `xnheap_alloc':
../../xenomai/sim/../ksrc/nucleus/heap.c:491: `CONFIG_XENO_OPT_DEBUG_NUCLEUS' undeclared (first use in this function)
../../xenomai/sim/../ksrc/nucleus/heap.c:491: (Each undeclared identifier is reported only once
../../xenomai/sim/../ksrc/nucleus/heap.c:491: for each function it appears in.)
../../xenomai/sim/../ksrc/nucleus/heap.c: In function `xnheap_test_and_free':
../../xenomai/sim/../ksrc/nucleus/heap.c:698: `CONFIG_XENO_OPT_DEBUG_NUCLEUS' undeclared (first use in this function)
make[1]: *** [heap.o] Fehler 1
make[1]: Leaving directory `/var/buildbot/slave/sim_q/build/nucleus'

The build #27 for the v.2.4 branch completed successfully as shown in
http://ngiger.dyndns.org/buildbot/builders/sim_q/builds/27.

No problems with the trunk neither as shown in
http://ngiger.dyndns.org/buildbot/builders/sim_f/builds/4

Best regards

-- 
Niklaus Giger

