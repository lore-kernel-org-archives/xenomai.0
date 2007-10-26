Message-ID: <47226F54.4090709@domain.hid>
Date: Sat, 27 Oct 2007 00:51:00 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <47226B5E.2050303@domain.hid>
In-Reply-To: <47226B5E.2050303@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] I-pipe/i386 for 2.6.24-rc1 - x86/x86_64 merge to
	come
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
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> The I-pipe/i386 has been ported to 2.6.24-rc1, so that we could swallow
> the i386/x86_64 merge which just happened upstream, without having to
> fiddle at the same time with the slew of other core changes which will
> hit the street before 2.6.24 is released. You need the latest trunk/ to
> configure Xenomai for this kernel properly, or at least update those two
> files:
> 
> - scripts/prepare_kernel.sh
> - ksrc/arch/i386/Kconfig.
> 
> Please check if this patch runs your x86 hw reasonably well, while I'm
> busy merging ksrc/arch/{i386, x86_64} on the Xenomai side. The plan is
> to have a unified x86* tree for Xenomai 2.4 which has to work with all
> supported kernel releases, including 2.6.24. Yes, I know we are in -rc
> phase, but such merge should mostly reshuffle the directory layout, and
> not the implementation per se, otherwise, it will have to wait for 2.5.
> 
> At the end of the day (i.e. sometime during the v2.4 maintenance cycle),
> we should have the I-pipe/x86_64 merged with the I-pipe/i386 support,
> leading to the I-pipe/x86-2.0 series, on top of 2.6.24, and all of that
> usable with a unified ia32/64

i386/x86_64 I mean...

 Xenomai support, which is basically what
> we already have now on the powerpc side of the universe.
> 
> http://download.gna.org/adeos/patches/v2.6/i386/adeos-ipipe-2.6.24-rc1-i386-1.10-11.patch
> 
> PS: slightly tested here. Looks ok, sun is still shining, birds are
> still singing, hardware is not burning - yet.
> 


-- 
Philippe.

