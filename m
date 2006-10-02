Message-ID: <ac3922a00610020525x26b791e2r63739afa95b7d57b@domain.hid>
Date: Mon, 2 Oct 2006 14:25:23 +0200
From: "Syed Amer Gilani" <amg@domain.hid>
Sender: groove.c@domain.hid
Subject: Re: [Xenomai-help] Xenomai on 2.6.17 ppc
In-Reply-To: <451E8999.2000801@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <ac3922a00609270502s498d99bcv120ccc0f1a9f2a40@domain.hid>
	<451A6E2B.2040901@domain.hid>
	<ac3922a00609270536m396f4af0i4d60929689d4f541@domain.hid>
	<451E8999.2000801@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

2006/9/30, Wolfgang Grandegger <wg@domain.hid>:
> I realized, that the differences to Linux 2.6.18 are quite small and non
> critical. Attached is a ADEOS-IPIPE patch for Linux 2.6.17, which should
> work on your MPC5200 as well (the idle loop problem for 6xx is solved).
> Would be nice if you could test the patch and report the results. It's
> difficult these days to get a 2.6.x kernel built and booted on an
> MPC5200 :-(.
>
> Note: this patch requires another small fix for Xenomai (see
> attachment). Philippe, could you please apply it? TIA.

Thank you for the 2.6.17 patch, but unfortunately it did not work.
I had problems with both patches. The xenomai patch expected 2 lines
in the source that are not in the original xenomai sources. But i
patched it manual.
The Kernel Patch does not work with the prepare-kernel script. It stops with:

grep: /home/amg/linux-2.6.17/include/asm-powerpc/ipipe.h: No such file
or directory
prepare-kernel.sh: /home/amg/linux-2.6.17 has no Adeos support for powerpc

ipipe.h is in asm-ppc so i think it has something to do with the ppc
-> powerpc merge.
So i patched is manually. But in menuconfig the xenomai entries are
missing so i could not activate it to test it.

Syed Amer Gilani

