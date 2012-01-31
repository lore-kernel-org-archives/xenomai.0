Message-ID: <4F28287D.7090804@domain.hid>
Date: Tue, 31 Jan 2012 18:44:29 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAJp2OCNsfC96pT9T3Ya6=z_5bydrt84=4hLy6AySuh4Ec7cVTA@mail.gmail.com>	<4F2814E2.7060302@domain.hid>
	<CAJp2OCMk4tp5b5KKxBn7a2akAhbjpOamnx0StaNsohpp5c3wkQ@mail.gmail.com>
In-Reply-To: <CAJp2OCMk4tp5b5KKxBn7a2akAhbjpOamnx0StaNsohpp5c3wkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] "How to Adapt ARM I-pipe patch to S3C6410" -
 still not solved
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Alex Nikitenko <alexzoidbergnikitenko@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 01/31/2012 05:49 PM, Alex Nikitenko wrote:
> Sorry for that mess.
> 
> I'm trying to adapt adeos-ipipe-2.6.35.9-arm-1.18-03.patch to a S3C6410
> (Tiny6410 board) with kernel ver. 2.6.36 in order to run xenomai on this
> board.
> 
> The problem is that the boot process hangs not entering the
> start_kernel() function.
> I used printascii at arch/arm/kernel/head.S to trace the execution. It
> hangs just before calling start_kernel(). But ONLY with CONFIG_IPIPE
> enabled.
> If I disable this config everything boots just fine.
> 
> I also used printk("some string") at the very begining of start_kernel().
> If CONFIG_IPIPE not set - string is printed out and kernel boots.
> If CONFIG_IPIPE  - hang after calling start_kernel.
> So, printascii works well on mz hardware.

If you are indeed using printk and not printascii this does not prove
that printascii works, and that you have successfully enabled the
earlyprintk mechanism.

When linux boots on arm, when the serial console is enabled, the
backlog, everything which has been printed before with printk, is
printed. If the kernel fails before enabling the console, nothing is
printed, but it does not mean that the kernel did not go farther than
your first printk.

The cure is to use printascii. I am not sure printascii works in head.S,
I believe it does, but you can:
- use printascii for some traces you would like to add (for instance in
ipipe_mach_acktimer to see if the timer is ticking)
- add a call to printascii in printk.c right after the call to
vscnprintf. If you do this, when the console is enabled, everything is
printed twice.
- enable CONFIG_EARLY_PRINTK in addition to CONFIG_DEBUG_LL, and pass
"earlyprintk" on the kernel command line. This will cause the printks
before console is enabled to use printascii, and then switch to the real
console.

You should make sure that printascii indeed works for your platform
without CONFIG_IPIPE before trying to use it with CONFIG_IPIPE, by
testing it separately from printk.

-- 
					    Gilles.

