Subject: Re: [Xenomai-core] Buildbot finds unresolved symbols
	`xnarch_atomic_xchg'
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200610310737.58954.niklaus.giger@domain.hid>
References: <200610310737.58954.niklaus.giger@domain.hid>
Content-Type: text/plain
Date: Tue, 31 Oct 2006 09:27:37 +0100
Message-Id: <1162283258.4996.20.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai-core <xenomai@xenomai.org>

On Tue, 2006-10-31 at 07:37 +0100, Niklaus Giger wrote:
> Hi 
> 
> I see the following failure since revision 1771. e.g. 
> http://ngiger.dyndns.org/buildbot-full/ppc_f/builds/56/step-mk_kernel/1
> 
> kernel/built-in.o: In function `xnintr_irq_handler':
> intr.c:(.text+0x34334): undefined reference to `xnarch_atomic_xchg'
> intr.c:(.text+0x34424): undefined reference to `xnarch_atomic_xchg'
> kernel/built-in.o: In function `xnpod_schedule':
> (.text+0x38470): undefined reference to `xnarch_atomic_xchg'
> kernel/built-in.o: In function `xnpod_schedule_runnable':
> (.text+0x39f28): undefined reference to `xnarch_atomic_xchg'
> kernel/built-in.o: In function `xnpod_init':
> (.text+0x3a770): undefined reference to `xnarch_atomic_xchg'
> make: *** [.tmp_vmlinux1] Fehler 1
> 

Fixed, thanks.

> Best regards
-- 
Philippe.



