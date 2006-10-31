From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Tue, 31 Oct 2006 07:37:58 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610310737.58954.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Buildbot finds unresolved symbols
	`xnarch_atomic_xchg'
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

I see the following failure since revision 1771. e.g. 
http://ngiger.dyndns.org/buildbot-full/ppc_f/builds/56/step-mk_kernel/1

kernel/built-in.o: In function `xnintr_irq_handler':
intr.c:(.text+0x34334): undefined reference to `xnarch_atomic_xchg'
intr.c:(.text+0x34424): undefined reference to `xnarch_atomic_xchg'
kernel/built-in.o: In function `xnpod_schedule':
(.text+0x38470): undefined reference to `xnarch_atomic_xchg'
kernel/built-in.o: In function `xnpod_schedule_runnable':
(.text+0x39f28): undefined reference to `xnarch_atomic_xchg'
kernel/built-in.o: In function `xnpod_init':
(.text+0x3a770): undefined reference to `xnarch_atomic_xchg'
make: *** [.tmp_vmlinux1] Fehler 1

Best regards
-- 
Niklaus Giger

