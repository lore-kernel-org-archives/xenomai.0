Message-ID: <2ff1a98a0711260808p2d4a1116lf3c1aeb970f52975@domain.hid>
Date: Mon, 26 Nov 2007 17:08:40 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <5a4b7020711260729q4445f615m2cd187541abb6621@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5a4b7020711260424v76ccb304m2ebf177bf9050d2b@domain.hid>
	<2ff1a98a0711260528nd5b56b1he0a41f0239b2236e@domain.hid>
	<5a4b7020711260612h66cf0433ye80d50ce64a41a45@domain.hid>
	<2ff1a98a0711260617t68810bddte96ec8636efb45ff@domain.hid>
	<5a4b7020711260641t79d5caccvf75baf4c30b6694d@domain.hid>
	<2ff1a98a0711260647x63170d86p7a085738e2a0f95e@domain.hid>
	<5a4b7020711260705jc350e52n3bba457b0c0b4a53@domain.hid>
	<2ff1a98a0711260716ra7f453cg8fe0450b99e1fbae@domain.hid>
	<5a4b7020711260729q4445f615m2cd187541abb6621@domain.hid>
Subject: Re: [Xenomai-help] NOTE: Xenomai conflicts with PC speaker support.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jie zhang <xenomai.rtai@domain.hid>
Cc: Xenomai <xenomai@xenomai.org>

On Nov 26, 2007 4:29 PM, jie zhang <xenomai.rtai@domain.hid> wrote:
> Hi gilles,
> except initrd , what should I wrote on the "Kernel
> /vmlinuz-2.6.23-xenomai  root=/dev/??????(sda?) " does it have
> relation ship with the kernel panic, I was confused now, I am so sorry
> for trouble you. by the way , do you know some thing about UUID?

Please do send mails to the xenomai@xenomai.org mailing list, not only to me.

Your problem is with initrd, so try and solve the initrd problem
first. My advice is to run mkinitrd and to make your grub entry look
exactly like the non-Xenomai entry. If your grub.conf entry has an
initrd entry, grub will generate the correct command line for your
kernel, so you do not have to specify a root=something to the Xenomai
entry.

If, on the other hand, you build the kernel with built-in support for
the root device disk controller and root filesystem, you can get rid
of the initrd item, but specify a root=/dev/sda? on the image command
line.

UUID is another way to specify a partition name which is independent
of the number of disks on your system.
If for instance, UUID 4db354f4-1591-42a0-a09b-f551dd8405f8 is
/dev/sda6 and you plug another disk on your system, what was
previously called /dev/sda6 becomes /dev/sdb6, its UUID will still be
valid.
So, you can use the same root=UUID argument for Xenomai as for your
original kernel.


-- 
                                               Gilles Chanteperdrix

