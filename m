MIME-Version: 1.0
Date: Fri, 11 Sep 2009 10:00:41 -0300
Message-ID: <4303dd240909110600tf787b85td93b46086953a0d9@domain.hid>
From: Flavio de Castro Alves Filho <flavio.alves@domain.hid>
Content-Type: multipart/alternative; boundary=001485f631e04271f604734ce7f1
Subject: [Xenomai-help] Problems with instalation of xenomai in ubuntu
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--001485f631e04271f604734ce7f1
Content-Type: text/plain; charset=ISO-8859-1

Hello,

I am new with Xenomai and I am having problems in booting a compiled kernel
into Ubuntu 8.10. I could compile the kernel with the appropriate patch,
configured grub to load the new kernel. But, when I boot the new kernel, it
performs all the boot configurations and at the end, when the gnome is about
to be loaded, the computer starts to blink the display and then blocks.

I am using the following configuration:

- x86 platform (my notebook ... an intel core2duo machine)
- xenomai version 2.4.9
- linux 2.6.30
- ubuntu linux 8.10
I performed the following steps:

- downloaded file linux-2.6.30.tar.bz2 from kernel.org
- downloaded file xenomai-2.4.9.tar.bz2 from xenomai website
- from my home directory, I decompressed both files
- applied the patch, running the "scripts/prepare-kernel.sh" and provided
the path for my source files "/home/flavio/linux-2.6.30". The script had
correctly found the patch to be applied to my sources.
- make xconfig:
   - disabled HPET timer support
   - disabled PC Speaker
   - disabled Power Management Support
   - disabled CPU frequency scaling
   - enabled VxWorks emulator
   - enabled RTAI emulator
   - enabled Testing drivers
- make
- make modules
- sudo make modules_install
- sudo make install
- cd /boot
- sudo update-initramfs -c -k 2.6.30
- created an entry in grub list:

title Xenomai 2.4.9 Linux 2.6.30
root (hd0,2)
kernel /boot/vmlinuz-2.6.30 root=/dev/sda3 ro
initrd /boot/initrd.img-2.6.30
savedefault
boot

Just as a remark, I performed before the same procedure, except for the
xenomai patch, and I could execute the linux 2.6.30 kernel in my computer.

Had anybody passed by the same experience? I have no idea what the problem
could be.

Best regards,

Flavio

-- 
Flavio de Castro Alves Filho
Embedded Software Services
www.phiinnovations.com
+55 11 84 94 56 76

--001485f631e04271f604734ce7f1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hello,</div>
<div>=A0</div>
<div>I am new with Xenomai and I am having problems in booting a compiled k=
ernel into Ubuntu 8.10. I could compile the kernel with the appropriate pat=
ch, configured grub to load the new kernel. But, when I boot the new kernel=
, it performs all the boot configurations and at the end, when the gnome is=
 about to be loaded, the computer starts to blink the display and then bloc=
ks.</div>

<div>=A0</div>
<div>I am using the following configuration:</div>
<div>=A0</div>
<div>- x86 platform (my notebook ... an intel=A0core2duo machine)</div>
<div>- xenomai version 2.4.9</div>
<div>- linux 2.6.30</div>
<div>- ubuntu linux 8.10<br clear=3D"all"></div>
<div>I performed the following steps:</div>
<div>=A0</div>
<div>- downloaded file linux-2.6.30.tar.bz2 from <a href=3D"http://kernel.o=
rg">kernel.org</a></div>
<div>- downloaded file xenomai-2.4.9.tar.bz2 from xenomai website</div>
<div>- from my home directory, I decompressed both files</div>
<div>- applied the patch, running the &quot;scripts/prepare-kernel.sh&quot;=
 and provided the path for my source files &quot;/home/flavio/linux-2.6.30&=
quot;. The script had correctly found the patch to be applied to my sources=
.</div>

<div>- make xconfig:</div>
<div>=A0=A0 - disabled HPET timer support</div>
<div>=A0=A0 - disabled PC Speaker</div>
<div>=A0=A0 - disabled Power Management Support</div>
<div>=A0=A0 - disabled CPU frequency scaling</div>
<div>=A0=A0 - enabled VxWorks emulator</div>
<div>=A0=A0 - enabled RTAI emulator</div>
<div>=A0=A0 - enabled Testing drivers</div>
<div>- make</div>
<div>- make modules</div>
<div>- sudo make modules_install</div>
<div>- sudo make install</div>
<div>- cd /boot</div>
<div>- sudo update-initramfs -c -k 2.6.30</div>
<div>- created an entry in grub list:</div>
<div>=A0</div>
<div>title Xenomai 2.4.9 Linux 2.6.30</div>
<div>root (hd0,2)</div>
<div>kernel /boot/vmlinuz-2.6.30 root=3D/dev/sda3 ro</div>
<div>initrd /boot/initrd.img-2.6.30</div>
<div>savedefault</div>
<div>boot</div>
<div></div>
<div>=A0</div>
<div>Just as a remark, I performed before the same procedure, except for th=
e xenomai patch, and I could execute the linux 2.6.30 kernel in my computer=
.</div>
<div>=A0</div>
<div>Had anybody passed by the same experience? I have no idea what the pro=
blem could be.</div>
<div>=A0</div>
<div>Best regards,</div>
<div>=A0</div>
<div>Flavio</div>
<div><br>-- <br>Flavio de Castro Alves Filho<br>Embedded Software Services<=
br><a href=3D"http://www.phiinnovations.com">www.phiinnovations.com</a><br>=
+55 11 84 94 56 76<br></div>

--001485f631e04271f604734ce7f1--

