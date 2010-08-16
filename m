From: Zafar Iqbal <Zafar.Iqbal2@domain.hid>
Date: Mon, 16 Aug 2010 11:13:16 +0530
Message-ID: <76E258664B189C4CBEF125491CA11ECC945840392E@KCINPUNHJCMS01.kpit.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai-help] HELP:  Xen kernel on non-Xen host
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>, "Hemal C.Bavishi" <Hemal.Bavishi@domain.hid>

Dear Sir,

I followed the way as Instructed in the website http://www.xenomai.org/inde=
x.php/Building_Debian_packages, for the installation of Xenomai patch in my=
 Ubuntu Machine.

I am reminding you that I am using UBUNTU 10.04.
Kernel version linux-2.6.32.18
xenomai-2.5.4.

While Building everything was fine and I was able to create the images succ=
essfully.
The following packages was made sucessfully:
     linux-image-2.6.32.18-xenomai-2.5.4
     linux-headers-2.6.32.18-xenomai-2.5.4 =


But at the time of Installation with the following command =

dpkg -i linux-image*.deb

I got the problem in the following steps. and the bootloader(GRUB) was not =
updated with the xenomai patched kernel image

Searching for default file ... found: /boot/grub/default
Testing for an existing GRUB menu.lst file ... found: /boot/grub/menu.lst
Searching for splash image ... none found, skipping ...
Ignoring Xen kernel on non-Xen host: vmlinuz-2.6.32.18-xenomai-2.5.4

Please Suggest me the possible solution for the above problem.

Thanks and Regards,
Zafar



