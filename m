Date: Wed, 13 May 2009 12:06:38 -0700 (PDT)
From: Martin Shepherd <mcs@domain.hid>
In-Reply-To: <4A0AE726.5090107@domain.hid>
Message-ID: <Pine.LNX.4.64.0905131152460.1027@domain.hid>
References: <4A0AC1C8.4050006@domain.hid> <4A0AC3F9.9090103@domain.hid> 
	<4A0AC8A6.1000701@domain.hid> <1242220962.26544.955.camel@domain.hid>
	<4A0AE726.5090107@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Xenomai-core] [PATCH] Fix host IRQ propagation (was: Troubles
	with switchtest)
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>


On Wed, 13 May 2009, Jan Kiszka wrote:
>...
> Martin, could you check if this helps you, too?

It doesn't appear to help. To check, first I turned on the HPET and PM
timer options, and recompiled the kernel without your patch, to verify
that this reproduced the problem. I then manually applied your patch
to include/asm-generic/xenomai/hal.h in the kernel source tree,
recompiled the kernel, installed etc, and rebooted. However even with
the patch in place, whenever I ran:

  dd if=/dev/zero of=/dev/null count=20000000

then initially top showed that dd was getting very little CPU time
(<10%), then after 30 seconds or so, the system became completely
unresponsive until the dd ended. This is how it acts without the patch
as well. So it doesn't appear that the patch has made any difference
to this problem.

Note that I applied the patch to Xenomai 2.5-rc1 in linux kernel
2.6.29.1. If the patch somehow relies on head, tell me, and I'll
endeavor to set up a new kernel using that.

Martin

