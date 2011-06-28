From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4E09E2F4.1000100@domain.hid>
References: <4E09D058.10906@domain.hid> <4E09DBC0.30705@domain.hid>
	<4E09E2F4.1000100@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 28 Jun 2011 16:24:00 +0200
Message-ID: <1309271040.2101.76.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai 2.6.5 with Linux 2.6.38.8 kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniele Nicolodi <daniele@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2011-06-28 at 16:19 +0200, Daniele Nicolodi wrote:
> On 28/06/11 15:48, Gilles Chanteperdrix wrote:
> > On 06/28/2011 03:00 PM, Daniele Nicolodi wrote:
> >> Hello,
> >>
> >> is the Xenomai 2.6.5 supposed to work with Linux 2.6.38.8 kernel and
> >> adeos patch 2.6.38.8-x86-2.10 supposed to work?
> >>
> >> The above combination gives me an error compiling
> >> arch/x86/xenomai/hal_32.c in function rthal_arch_init where nmi_watchdog
> >> and NMI_IO_APIC are not defined. Indeed those are not defined anywhere
> >> in the kernel or xenomai source tree.
> > 
> > Disable NMI watchdog.
> 
> Thanks Gilles for the quick answer, but that's not the problem, NMI
> watchdog option is already disabled (and looking at the source code
> looks like the error comes from a section of the code that is not
> affected by XENO_NMI_DEBUG_LATENCY.
> 
> Cheers,

https://mail.gna.org/public/xenomai-help/2011-06/msg00142.html

-- 
Philippe.



