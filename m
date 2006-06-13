From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Tue, 13 Jun 2006 22:57:00 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606132257.00974.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Breakage in trunk
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

I noticed that, eg.  
http://ngiger.dyndns.org/buildbot/hcu3/builds/80/step-mk_xeno/0
there are build failures. It tells me
Making install in vrtx
make[4]: Entering directory 
`/mnt/data.ng/buildslave/buildbot/quick-hcu3/build/hcu/src/skins/vrtx'
make[4]: *** No rule to make target `event.c', needed by 
`libvrtx_la-event.lo'.  Stop.

Last successfull build for hcu3 was with Revision: 1195

tqm860 still failes as  shown in
http://ngiger.dyndns.org/buildbot/tqm860/builds/97/step-mk_kernel/0
with
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -I/home/buildslave/buildbot/quick-tqm860/build/linuxppc_2_4_devel-2006-04-06-1735/arch/ppc -o 
scripts/split-include scripts/split-include.c
make: *** No rule to make target `include/linux/autoconf.h', needed by 
`include/config/MARKER'.  Stop.

Could someone looking at these failures, please?

Best regards

--
Niklaus Giger


