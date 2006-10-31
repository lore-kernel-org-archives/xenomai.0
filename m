Message-ID: <45470076.8030601@domain.hid>
Date: Tue, 31 Oct 2006 08:51:18 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Buildbot finds unresolved
	symbols	`xnarch_atomic_xchg'
References: <200610310737.58954.niklaus.giger@domain.hid>
In-Reply-To: <200610310737.58954.niklaus.giger@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Niklaus,

Niklaus Giger wrote:
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

I lost track somehow. What version of the Linux kernel, ADEOS-IPIPE and 
Xenomai are you using?

Thanks.

Wolfgang.


