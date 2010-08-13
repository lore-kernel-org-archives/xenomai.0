Message-ID: <4C651A5D.9030101@domain.hid>
Date: Fri, 13 Aug 2010 12:11:41 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <76E258664B189C4CBEF125491CA11ECC9458403922@domain.hid>	<76E258664B189C4CBEF125491CA11ECC9458403925@domain.hid>	<1281597159.1730.71.camel@domain.hid>	<E2CAE7F7B064EA49B5CE7EE9A4BB167D14FD14F757@domain.hid>,
	<4C642F04.4020008@domain.hid>
	<E2CAE7F7B064EA49B5CE7EE9A4BB167D14FD065786@domain.hid>
In-Reply-To: <E2CAE7F7B064EA49B5CE7EE9A4BB167D14FD065786@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig082A6D621A147AAA32FD2C9D"
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
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig082A6D621A147AAA32FD2C9D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 13.08.2010 09:43, Hemal C.Bavishi wrote:
> Dear Stefan,
>
> Thank you very much for your response and showing your interest in reso=
lving this issue. We tried building debian package to install xenomai as =
suggested by you and followed the same steps as described but it hangs up=
 after reboot. After some initial analysis, I found that it's not generat=
ing initrd entry in boot kernel despite of upddate -initramfs -c -k all c=
ommand. Do you have any clue?
>  =20

Did you call update-grub after update-initramfs?

Stefan

> Thanks,
>
> Best Regards,
> Hemal Bavishi
> ________________________________________
> From: xenomai-help-bounces@domain.hid [xenomai-help-bounces@domain.hid] On Be=
half Of Stefan Kisdaroczi [kisda@domain.hid]
> Sent: Thursday, August 12, 2010 10:57 PM
> To: xenomai@xenomai.org; Zafar Iqbal
> Subject: Re: [Xenomai-help] 2.6.32.18/x86 (Ubuntu) hangs at boot w/ Xen=
omai 2.5.3 [was: HELP]
>
> Hi,
>
> to build and install Xenomai on Ubuntu try the "Building Debian package=
s" howto [1].
> You need probably to call update-initramfs as mentioned here [2].
>
> Please use exactly the xenomai and kernel versions as described in the =
howto.
>
> Regards Stefan
>
> [1] http://www.xenomai.org/index.php/Building_Debian_packages
> [2] http://www.mail-archive.com/xenomai@xenomai.org
>
> Am 12.08.2010 17:40, schrieb Hemal C.Bavishi:
>  =20
>> Dear Mr. Gerum,
>>
>>
>>
>> We have followed following steps to install xenomai patch on UBUNTU. A=
fter repeated attempt in multiple system, still we are facing
>> same issues.
>>
>>
>>
>> We have used following version for installing xenomai patch on UBUNTU
>>
>>
>>
>> 1. linux Kernel: linux-2.6.32.18
>>
>> 2. Xenomai patch: xenomai-2.5.4
>>
>> 3. Operating System: UBUNTU 10.04
>>
>>
>>
>>
>>
>> Following Steps have been followed to install xenomai patch on UBUNTU:=

>>
>>
>>
>> 1. Copied the linux tar file into /usr/src
>>
>> 2. Copied the xenomai tar file into /usr/src
>>
>> 3. untar the linux and xenomai file
>>
>> 4. cd /usr/src/xenomai-2.2.0/scripts/prepare-kernal.sh and appropriate=
 linux directory, architecture(i686) and adeos path were given
>>
>> 5. Make a copy of the .config file of the running kernel in the presen=
t directory.
>>
>> 6. Next ran make menuconfig and made the following changes:
>>
>>
>>
>> I.          Selected Processor and feature -> Preemption Mode
>>
>> II.         Power Management option
>>
>>             a. Disabled ACPI.
>>
>>             b. Disabled Frequency Scaling
>>
>> 7. Build the Kernel(make command)
>>
>> 8. copying the image of the kernel to the boot folder
>>
>>     cp arch/x86/boot/bzImage /boot/vmlinuz-2.6.32.18-xenomai-2.5.4
>>
>> 9. At last, I tried to reboot the system in the new kernel image and f=
ound the following issues:
>>
>>
>>
>>
>>
>> dev_node is not supported in this system.
>>
>> IO APIC#0 ID is already in use.
>>
>> PnBIOS: Unable to get nod information.
>>
>> Sdb1 could not mount because of the unsupported optional Feature.
>>
>>
>>
>>
>>
>> Best Regards,
>>
>> Hemal Bavishi
>>
>> Principal Engineer
>>
>>
>>
>> KPIT Infosystems GmbH | Franziska - Bilek - Weg 9 | 80339 Munich
>>
>> Phone: +49(0) 89 45 23 5 83 - 06 | Mobile: +49 162 426 9950 | Fax: +49=
 (0) 89 45 23 5 83 - 07
>>
>>  http://www.kpitcummins.com <http://www.kpitcummins.com/>| mailto:Hema=
l.Bavishi@domain.hid
>>
>> _Frankfurt Branch Office_:
>> KPIT Infosystems GmbH | Mainzer Landstrasse 176 | 60327 Frankfurt | Ge=
rmany
>>
>> Gesch=E4ftsf=FChrer/Managing Director: Sanjay Mandal
>> Handelsregister/Commercial Register: M=FCnchen/Munich HRB 163288
>> Sitz der Gesellschaft/Place of Business: M=FCnchen/Munich | Umsatzsteu=
ernummer/VAT Number: DE251280557
>>
>> Disclaimer: This message contains information that may be privileged o=
r confidential and is the property of KPIT Cummins. It is
>> intended only for the person to whom it is addressed. If you are not t=
he intended recipient, you are not authorized to read, print,
>> retain copy, disseminate, distribute, or use this message or any part =
thereof. If you receive this message in error, please notify
>> the sender immediately and delete all copies of this message. KPIT Cum=
mins does not accept any liability for virus infected mails.
>>
>> *P** **Please consider the impact on the environment before printing t=
his e-mail*
>>
>>
>>
>>
>>
>>
>>
>>
>>
>> -----Original Message-----
>> From: Philippe Gerum [mailto:rpm@xenomai.org]
>> Sent: Thursday, August 12, 2010 9:13 AM
>> To: Zafar Iqbal
>> Cc: Hemal C.Bavishi; Xenomai-help@domain.hid
>> Subject: Re: 2.6.32.18/x86 (Ubuntu) hangs at boot w/ Xenomai 2.5.3 [wa=
s: HELP]
>>
>>
>>
>> On Thu, 2010-08-12 at 11:46 +0530, Zafar Iqbal wrote:
>>
>>    =20
>>> Dear Sir,
>>>      =20
>>    =20
>>>      =20
>>    =20
>>>      =20
>>    =20
>>> I am Using Ubuntu 10.4 in my system with kernel version 2.6.32.18.
>>>      =20
>>    =20
>>> I downloaded xenomai-2.5.3 and ptached into linux-2.6.32.18 after tha=
t I compiled the whole kenel.using make.
>>>      =20
>>    =20
>>> After that I made the image of the compiled kernel : make bzImage
>>>      =20
>>    =20
>>> then copied the image to the location as in the boot folder with the =
following command cp arch/x86/boot/bzImage
>>>      =20
>> /boot/vmlinuz-2.6.32.18-xenomai-2.5.3
>>
>>    =20
>>> then I updated my GRUB with the command update-grub.
>>>      =20
>>    =20
>>>      =20
>>    =20
>>> When I Tried to reboot the System with the Xenomai patched Kernel my =
system hanged up and it is not able to boot with the new
>>>      =20
>> kernel image.
>>
>>    =20
>>>      =20
>>    =20
>>> Can you please suggest whats the wrong here.
>>>      =20
>>
>>
>> A few hints:
>>
>>
>>
>> - that question from mainstream x86 distro users is definitely a FAQ o=
n
>>
>> our mailing list. Did you have a look at the mailing list archive, to
>>
>> find common answers to this problem?
>>
>> https://mail.gna.org/public/xenomai-help/
>>
>>
>>
>> - Did you read the TROUBLESHOOTING file at the top of the Xenomai tree=

>>
>> and on our website?
>>
>> http://www.xenomai.org/documentation/xenomai-2.5/TROUBLESHOOTING
>>
>>
>>
>> - Did you read this FAQ?
>>
>> http://www.xenomai.org/index.php/FAQs#Tips_and_tricks_setting_up_your_=
x86_kernel
>>
>>
>>
>> - Do you mind sending a bit more information than "my system hanged up=
"?
>>
>> Any boot log to share? A kernel config file maybe? Did you disable the=

>>
>> quiet boot option to see kernel messages while booting? Are there any
>>
>> messages at all? Our mail archive is full of advices regarding the way=

>>
>> to troubleshoot a boot issue on x86, make sure to read them first.
>>
>>
>>
>> - Please always provide a meaningful subject line, so that people havi=
ng
>>
>> the same issue could later find and reuse the information from that
>>
>> thread.  "HELP" - particularly on a list called xenomai-help - does no=
t
>>
>> qualify, at all. Because it could be seen as a waste of time by your
>>
>> recipients, it may even be counter-productive, and tends to bury your
>>
>> mail.
>>
>>
>>
>> - Please stop posting to xenomai-help-owner, really. This address is f=
or
>>
>> sending requests related to your mailing list subscription, only.
>>
>>
>>
>> - Please do not re-post the very same question multiple times within
>>
>> less than 24 hours. It makes no sense; you can check that your previou=
s
>>
>> message did arrive in our mail archive, so no need to spam the list wi=
th
>>
>> a rehash of your previous post. If people did not answer you yet, it m=
ay
>>
>> be because: 1) you did not provide sufficient input for them to think
>>
>> about your issue, 2) they don't have time to answer you at the moment,=

>>
>> 3) they don't care, 4) they don't know, or any combination thereof.
>>
>>
>>
>>    =20
>>>      =20
>>    =20
>>>      =20
>>    =20
>>> Thanks and Regards,
>>>      =20
>>    =20
>>> Zafar
>>>      =20
>>    =20
>>>      =20
>>    =20
>>>      =20
>>    =20
>>>      =20
>>
>>
>> --
>>
>> Philippe.
>>
>>
>>
>>
>>
>>
>>
>>
>> This message contains information that may be privileged or confidenti=
al and is the property of the KPIT Cummins Infosystems Ltd. It
>> is intended only for the person to whom it is addressed. If you are no=
t the intended recipient, you are not authorized to read,
>> print, retain copy, disseminate, distribute, or use this message or an=
y part thereof. If you receive this message in error, please
>> notify the sender immediately and delete all copies of this message. K=
PIT Cummins Infosystems Ltd. does not accept any liability for
>> virus infected mails.
>>
>>
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>>    =20
>
>  =20



--------------enig082A6D621A147AAA32FD2C9D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkxlGmUACgkQIPTw9rIdn6r1qQCdFzvrUH/7fu5+Rwvj0Gw6YFHa
rD8An3NNqjulWnjl/JgZyu9UieA6iWdm
=Ut0v
-----END PGP SIGNATURE-----

--------------enig082A6D621A147AAA32FD2C9D--

