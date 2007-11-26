Message-ID: <2ff1a98a0711260716ra7f453cg8fe0450b99e1fbae@domain.hid>
Date: Mon, 26 Nov 2007 16:16:08 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <5a4b7020711260705jc350e52n3bba457b0c0b4a53@domain.hid>
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

On Nov 26, 2007 4:05 PM, jie zhang <xenomai.rtai@domain.hid> wrote:
> Hi gilles,
> I really have problem with my laptop, I carefully select the kernel
> configurations, but oh my god, there are still kernel panic
> kernel panic - not syncing: VFS unable to mount root fs on unknown-block(0,0)
> and it sees that is because root=/dev/sda? have problem
> the following is my menu.lst
>
> title           xenomai
> root            (hd0,5)
> kernel          /vmlinuz-2.6.23-xenomai  root=/dev/sda6(What should I
> wrote here?)   ro
>
> title           Ubuntu 7.10, kernel 2.6.22-14-generic
> root            (hd0,5)
> kernel          /vmlinuz-2.6.22-14-generic
> root=UUID=4db354f4-1591-42a0-a09b-f551dd8405f8 ro quiet splash
> initrd          /initrd.img-2.6.22-14-generic
> quiet
>
> when I use df
> /dev/sda7             22588240   4031060  17409740  19% /
> varrun                  513156       148    513008   1% /var/run
> varlock                 513156         0    513156   0% /var/lock
> udev                    513156        92    513064   1% /dev
> devshm                  513156         0    513156   0% /dev/shm
> lrm                     513156     34696    478460   7%
> /lib/modules/2.6.22-14-generic/volatile
> /dev/sda6               474440     38167    411776   9% /boot
> /dev/sda8             61519876   5132588  53262248   9% /home
> /dev/sda1             19525456   5738448  13787008  30% /media/sda1
>
>
> what should I do to resolve the kernel panic,

Please do not drop xenomai@xenomai.org from your answers.

The message "unable to mount root" means that well, the kernel is
unable to mount a root filesystem.

This may be normal if you reused a kernel configuration which uses an
initrd (initial ram disk image). If you want this configuration to
work, you should create an initrd for your kernel (if the kernel
installation did not do it by itself), usually you do this by calling
mkinitrd with some parameters like the kernel version (mkinitrd --help
is your friend). You then have to tell grub or lilo to use the initrd
which you just created.

The other way to work around this problem is to create your kernel
with built-in drivers for your root device disk controller (from your
various posts, I would say that you have a PIIX Sata controller) and
your root filesystem (probably ext3). This way you can completely get
rid of an initrd, unless you use the Logical Volume Manager, in which
case you have to boot from an initrd.

-- 
                                               Gilles Chanteperdrix

