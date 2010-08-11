From: Zafar Iqbal <Zafar.Iqbal2@domain.hid>
Date: Wed, 11 Aug 2010 21:00:53 +0530
Message-ID: <76E258664B189C4CBEF125491CA11ECC945840391F@KCINPUNHJCMS01.kpit.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai-help] (no subject)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Hemal C.Bavishi" <Hemal.Bavishi@domain.hid>, "Xenomai-help@domain.hid" <Xenomai-help@domain.hid>, Amit Oza <Amit.Oza@domain.hid>

Dear Sir,


I am Using Ubuntu 10.4 in my system with kernel version 2.6.32.18. =

I downloaded xenomai-2.5.3 and ptached into linux-2.6.32.18 after that I co=
mpiled the whole kenel.using make.
After that I made the image of the compiled kernel : make bzImage
then copied the image to the location as in the boot folder with the follow=
ing command cp arch/x86/boot/bzImage /boot/vmlinuz-2.6.32.18-xenomai-2.5.3
then I updated my GRUB with the command update-grub.

When I Tried to reboot the System with the Xenomai patched Kernel my system=
 hanged up and it is not able to boot with the new kernel image.

Can you please suggest whats the wrong here.


Thanks and Regards,
Zafar



