From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <E2CAE7F7B064EA49B5CE7EE9A4BB167D14FD14F757@domain.hid>
References: <76E258664B189C4CBEF125491CA11ECC9458403922@domain.hid>
	<76E258664B189C4CBEF125491CA11ECC9458403925@domain.hid>
	<1281597159.1730.71.camel@domain.hid>
	<E2CAE7F7B064EA49B5CE7EE9A4BB167D14FD14F757@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 12 Aug 2010 18:44:11 +0200
Message-ID: <1281631451.1730.103.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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
To: "Hemal C.Bavishi" <Hemal.Bavishi@domain.hid>
Cc: "Xenomai-help@domain.hid" <Xenomai-help@domain.hid>, Zafar Iqbal <Zafar.Iqbal2@domain.hid>

On Thu, 2010-08-12 at 21:10 +0530, Hemal C.Bavishi wrote:
> Dear Mr. Gerum,
>=20
> =20
>=20
> We have followed following steps to install xenomai patch on UBUNTU.
> After repeated attempt in multiple system, still we are facing same
> issues.=20
>=20
> =20
>=20
> We have used following version for installing xenomai patch on UBUNTU
>=20
> =20
>=20
> 1. linux Kernel: linux-2.6.32.18
>=20
> 2. Xenomai patch: xenomai-2.5.4
>=20
> 3. Operating System: UBUNTU 10.04
>=20
> =20
>=20
> =20
>=20
> Following Steps have been followed to install xenomai patch on UBUNTU:
>=20
> =20
>=20
> 1. Copied the linux tar file into /usr/src
>=20
> 2. Copied the xenomai tar file into /usr/src
>=20
> 3. untar the linux and xenomai file
>=20
> 4. cd /usr/src/xenomai-2.2.0/scripts/prepare-kernal.sh and appropriate
> linux directory, architecture(i686) and adeos path were given

Are you 100% sure that you are installing Xenomai 2.5.4 as mentioned?

>=20
> 5. Make a copy of the .config file of the running kernel in the
> present directory.
>=20
> 6. Next ran make menuconfig and made the following changes:
>=20
> =20
>=20
> I.          Selected Processor and feature -> Preemption Mode
>=20
> II.         Power Management option
>=20
>             a. Disabled ACPI.

Which is wrong. The mailing list contains several posts regarding the
absolute requirement to keep the ACPI enabled.

>=20
>             b. Disabled Frequency Scaling
>=20
> 7. Build the Kernel(make command)
>=20
> 8. copying the image of the kernel to the boot folder
>=20
>     cp arch/x86/boot/bzImage /boot/vmlinuz-2.6.32.18-xenomai-2.5.4

Which means that your kernel support is fully static? No module to be
installed for the new kernel, at all? Despite you reused a .config
shipped with the distro?

> 9. At last, I tried to reboot the system in the new kernel image and
> found the following issues:
>=20
> =20
>=20
> =20
>=20
> dev_node is not supported in this system.
>=20
> IO APIC#0 ID is already in use.
>=20
> PnBIOS: Unable to get nod information.
>=20
> Sdb1 could not mount because of the unsupported optional Feature.
>=20
> =20

This hardly qualifies for a meaningful boot log. Once again, people on
this list have _very_ limited psychic powers, and not much time trying
to infer what your issue is all about: nobody knows what you are trying
to do (non-matching Xenomai versions, undefined hardware), the way you
do it (undefined kernel config), and what your machine tells you when
you try it (no sensible boot log provided yet). We are not there looking
over your shoulder when all that happens, so we don't know. Really.

Please check the mailing list archive _thoroughly_ first, to solve the
most obvious issues.

>=20
> =20
>=20
> Best Regards,
>=20
> Hemal Bavishi=20
>=20
> Principal Engineer=20
>=20
> =20
>=20
> KPIT Infosystems GmbH | Franziska - Bilek - Weg 9 | 80339 Munich=20
>=20
> Phone: +49(0) 89 45 23 5 83 - 06 | Mobile: +49 162 426 9950 | Fax: +49
> (0) 89 45 23 5 83 - 07=20
>=20
>  http://www.kpitcummins.com| mailto:Hemal.Bavishi@domain.hid
>=20
> Frankfurt Branch Office:
> KPIT Infosystems GmbH | Mainzer Landstrasse 176 | 60327 Frankfurt |
> Germany
>=20
> Gesch=C3=A4ftsf=C3=BChrer/Managing Director: Sanjay Mandal
> Handelsregister/Commercial Register: M=C3=BCnchen/Munich HRB 163288
> Sitz der Gesellschaft/Place of Business: M=C3=BCnchen/Munich |
> Umsatzsteuernummer/VAT Number: DE251280557=20
>=20
> Disclaimer: This message contains information that may be privileged
> or confidential and is the property of KPIT Cummins. It is intended
> only for the person to whom it is addressed. If you are not the
> intended recipient, you are not authorized to read, print, retain
> copy, disseminate, distribute, or use this message or any part
> thereof. If you receive this message in error, please notify the
> sender immediately and delete all copies of this message. KPIT Cummins
> does not accept any liability for virus infected mails.
>=20
> P Please consider the impact on the environment before printing this
> e-mail
>=20
> =20
>=20
> =20
>=20
> =20
>=20
> =20
>=20
> -----Original Message-----
> From: Philippe Gerum [mailto:rpm@xenomai.org
> Sent: Thursday, August 12, 2010 9:13 AM
> To: Zafar Iqbal
> Cc: Hemal C.Bavishi; Xenomai-help@domain.hid
> Subject: Re: 2.6.32.18/x86 (Ubuntu) hangs at boot w/ Xenomai 2.5.3
> [was: HELP]
>=20
> =20
>=20
> On Thu, 2010-08-12 at 11:46 +0530, Zafar Iqbal wrote:
>=20
> > Dear Sir,
>=20
> >=20
>=20
> >=20
>=20
> > I am Using Ubuntu 10.4 in my system with kernel version 2.6.32.18.
>=20
> > I downloaded xenomai-2.5.3 and ptached into linux-2.6.32.18 after
> that I compiled the whole kenel.using make.
>=20
> > After that I made the image of the compiled kernel : make bzImage
>=20
> > then copied the image to the location as in the boot folder with the
> following command cp
> arch/x86/boot/bzImage /boot/vmlinuz-2.6.32.18-xenomai-2.5.3
>=20
> > then I updated my GRUB with the command update-grub.
>=20
> >=20
>=20
> > When I Tried to reboot the System with the Xenomai patched Kernel my
> system hanged up and it is not able to boot with the new kernel image.
>=20
> >=20
>=20
> > Can you please suggest whats the wrong here.
>=20
> =20
>=20
> A few hints:
>=20
> =20
>=20
> - that question from mainstream x86 distro users is definitely a FAQ
> on
>=20
> our mailing list. Did you have a look at the mailing list archive, to
>=20
> find common answers to this problem?
>=20
> https://mail.gna.org/public/xenomai-help/
>=20
> =20
>=20
> - Did you read the TROUBLESHOOTING file at the top of the Xenomai tree
>=20
> and on our website?
>=20
> http://www.xenomai.org/documentation/xenomai-2.5/TROUBLESHOOTING
>=20
> =20
>=20
> - Did you read this FAQ?
>=20
> http://www.xenomai.org/index.php/FAQs#Tips_and_tricks_setting_up_your_x86=
_kernel
>=20
> =20
>=20
> - Do you mind sending a bit more information than "my system hanged
> up"?
>=20
> Any boot log to share? A kernel config file maybe? Did you disable the
>=20
> quiet boot option to see kernel messages while booting? Are there any
>=20
> messages at all? Our mail archive is full of advices regarding the way
>=20
> to troubleshoot a boot issue on x86, make sure to read them first.
>=20
> =20
>=20
> - Please always provide a meaningful subject line, so that people
> having
>=20
> the same issue could later find and reuse the information from that
>=20
> thread.  "HELP" - particularly on a list called xenomai-help - does
> not
>=20
> qualify, at all. Because it could be seen as a waste of time by your
>=20
> recipients, it may even be counter-productive, and tends to bury your
>=20
> mail.
>=20
> =20
>=20
> - Please stop posting to xenomai-help-owner, really. This address is
> for
>=20
> sending requests related to your mailing list subscription, only.
>=20
> =20
>=20
> - Please do not re-post the very same question multiple times within
>=20
> less than 24 hours. It makes no sense; you can check that your
> previous
>=20
> message did arrive in our mail archive, so no need to spam the list
> with
>=20
> a rehash of your previous post. If people did not answer you yet, it
> may
>=20
> be because: 1) you did not provide sufficient input for them to think
>=20
> about your issue, 2) they don't have time to answer you at the moment,
>=20
> 3) they don't care, 4) they don't know, or any combination thereof.
>=20
> =20
>=20
> >=20
>=20
> >=20
>=20
> > Thanks and Regards,
>=20
> > Zafar
>=20
> >=20
>=20
> >=20
>=20
> >=20
>=20
> =20
>=20
> --=20
>=20
> Philippe.
>=20
> =20
>=20
> =20
>=20
> =20
>=20
>=20
>=20
> This message contains information that may be privileged or
> confidential and is the property of the KPIT Cummins Infosystems Ltd.
> It is intended only for the person to whom it is addressed. If you are
> not the intended recipient, you are not authorized to read, print,
> retain copy, disseminate, distribute, or use this message or any part
> thereof. If you receive this message in error, please notify the
> sender immediately and delete all copies of this message. KPIT Cummins
> Infosystems Ltd. does not accept any liability for virus infected
> mails.

--=20
Philippe.



