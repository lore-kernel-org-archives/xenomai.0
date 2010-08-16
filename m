From: Hemal C.Bavishi <Hemal.Bavishi@domain.hid>
Date: Mon, 16 Aug 2010 21:38:15 +0530
Message-ID: <E2CAE7F7B064EA49B5CE7EE9A4BB167D14FD2A1992@domain.hid>
References: <76E258664B189C4CBEF125491CA11ECC9458403922@domain.hid>
	<76E258664B189C4CBEF125491CA11ECC9458403925@domain.hid>
	<1281597159.1730.71.camel@domain.hid>
	<E2CAE7F7B064EA49B5CE7EE9A4BB167D14FD14F757@domain.hid>,
	<4C642F04.4020008@domain.hid>
	<E2CAE7F7B064EA49B5CE7EE9A4BB167D14FD065786@domain.hid>,
	<4C651A5D.9030101@domain.hid>,
	<E2CAE7F7B064EA49B5CE7EE9A4BB167D14FD065788@domain.hid>
	<E2CAE7F7B064EA49B5CE7EE9A4BB167D14FD065789@domain.hid>
	<4C695C36.1030308@domain.hid>
In-Reply-To: <4C695C36.1030308@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] 2.6.32.18/x86 (Ubuntu) hangs at boot w/ Xenomai
 2.5.3 [was: HELP]
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Dear Stefan,

The behavior was quite peculiar and it has nothing to do with the "building=
 debian packages howto". However, it would be good if you specify these ste=
ps into howto under building debian packages for smooth installation for ne=
w comers:) =


Nevertheless, I resolved this issue by explicitly calling the update-initra=
mfs -c -k with the image name. I was bit surprised with the behavior but it=
 worked for me. =


However, I am still facing the problem of hang up issue at boot(blank scree=
n which other users also has reported) some time (it generally boots after =
every 3/4 starts). I don't know what's an issue but I observed this behavio=
r in 4 different system. Do you have any solution for this issue? Do I have=
 to build xenomai with the newer kernel version 2.6.32.34? Would that solve=
 current issue?

Thank you for your support and have a look if you can also resolve task ord=
ering issue?

Best Regards,
Hemal Bavishi

-----Original Message-----
From: Stefan Kisdaroczi [mailto:kisda@domain.hid] =

Sent: Monday, August 16, 2010 5:42 PM
To: Hemal C.Bavishi
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] 2.6.32.18/x86 (Ubuntu) hangs at boot w/ Xenomai=
 2.5.3 [was: HELP]

Hi,

On 13.08.2010 12:28, Hemal C.Bavishi wrote:
> Dear Stefan,
>
> I have taken the snapshopts of the command prompt and attached below =

> for your reference
>
> root@domain.hid:~# update-initramfs -c -k all
> update-initramfs: Generating /boot/initrd.img-2.6.32-24-generic
> update-initramfs: Generating /boot/initrd.img-2.6.32-21-generic
> root@domain.hid:~# update-grub
> Generating grub.cfg ...
> Found linux image: /boot/vmlinuz-2.6.32.15-xenomai-2.5.4
> Found linux image: /boot/vmlinuz-2.6.32-24-generic Found initrd image: =

> /boot/initrd.img-2.6.32-24-generic
> Found linux image: /boot/vmlinuz-2.6.32-21-generic Found initrd image: =

> /boot/initrd.img-2.6.32-21-generic
> Found memtest86+ image: /boot/memtest86+.bin Found Microsoft Windows =

> XP Professional on /dev/sda1 done root@domain.hid:~#
>   =


According to your "Task execution order"-mail it seems you finally fixed
this initrd-problem.
What did you do to solve the issue ? Is something wrong/unclear in the
"building debian packages howto" that could be improved ? Do I need to
add the "update-initramfs, update-grub" to the howto for ubuntu lucid ?

Thanks. Stefan

> [cut]



