Message-ID: <4DCD267F.7040300@domain.hid>
Date: Fri, 13 May 2011 14:39:27 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <294B28951EBE8146839AF99A61CB5FCE6B3F1A7A76@domain.hid>
In-Reply-To: <294B28951EBE8146839AF99A61CB5FCE6B3F1A7A76@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] WG: Xenomai 2.5.X - 32 bit X86 is not running on
 newer Kernel Versions
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Benner Bernd (MH/EES)" <B.Benner@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/13/2011 02:36 PM, Benner Bernd (MH/EES) wrote:
> Hi,
>=20
>   i am using a old grub grub-0.97. There is no problem with booting or =
early printk messages. The xenomai services and the linux system includin=
g X11- Desktop is starting very well.
>   The system is frozen after the creation of the first real time task i=
n user mode. ( latency,clocktest etc. )
>=20
>   We are using a Tinycore 3.x Live Linux distribution for our system wh=
ich runs originally with a Kernel 2.6.33. ( but there
> is no X86-ADEOS patch for this Kernel ) I have test kernel 2.6.34.5 and=
 2.6.35.13 and kernel 2.6.37.6.
>   Kernel 2.6.37 do not work with tinycore ( probable UDEV- problems ).
>   Systems 2.6.34 and 2.6.35 are working. The ADEOS/Xenomai patched vers=
ions are working very well, if nobody starts a realtime
> thread.
>=20
>   Here is my Kernel config for Kernel 2.6.35.13, xenomai-2.5.6
>=20
>   When I debug the xenomai latency application the system freeze happen=
s after activation of the display task.
> The display task reports the warming up message. The system is frozen b=
efore the latency task is created.
>=20
>=20
> Mit freundlichen Gr=C3=BC=C3=9Fen / Best Regards
> Bernd Benner
> MH/SGT3
> moehwald
> Bosch Group
> Moehwald GmbH
> Michelinstra=C3=9Fe 21
> 66424 Homburg
> GERMANY
> www.moehwald.de
> b.benner@domain.hid
> Moehwald GmbH, Sitz/Registered Office: Homburg/Saar, Zentrales Handelsr=
egister/Registered Court: Saarbr=C3=BCcken HRB 2812
> Gesch=C3=A4ftsf=C3=BChrung/Managing Directors: Jens Last, Wolfgang Geen=
en
>=20
>=20
> -----Urspr=C3=BCngliche Nachricht-----
> Von: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Gesendet: Freitag, 13. Mai 2011 12:43
> An: Benner Bernd (MH/EES)
> Cc: xenomai@xenomai.org
> Betreff: Re: [Xenomai-help] Xenomai 2.5.X - 32 bit X86 is not running o=
n newer Kernel Versions
>=20
> On 05/13/2011 11:55 AM, Benner Bernd (MH/EES) wrote:
>> Hi,
>>
>>    we have a well running X86 Realtime system with Kernel 2.6.29 and
>> xenomai-2.4.10. The system is able to boot from a stick and runs on
>> all our computers.
>> To fix some X11- problems with newer graphic chipsets, we try to
>> upgrade to a newer Kernel version.
>>
>>    We are starting with Kernel 2.6.34.5 and xenomai-2.5.5.2 using the
>> latest ADEOS-patches. This system works on some test machines, but on
>> some Core 2 Duo 3 GHz systems with Intel Desktop Chipset ( Lenovo and
>> HP
>> ) the system freeze and/or produces strange console outputs ( only
>> line feeds ) after a start of latency or clocktest.
>> We are not able to get a kernel log from this systems.
>>
>>   All permutations of Kernel 2.6.34.5, Kernel 2.6.35.13,
>> xenomai-2.5.3, xenomai-2.5.5.2, xenomai-2.5.6 has the same problems on=

>> the Core 2 Duo 3 GHz machines.
>> On other machines with slower Mobile Core 2 Duo or Pentiom M
>> processors the system runs or has sometimes the same problem.
>>
>>   I have try some changes in the Kernel configuration, without any
>> success.  I have also try a combination of Kernel 2.6.35.13. and
>> xenomai-2.4.10 with some changes in the xenomai headers to run with
>> newer Kernels. This version has the same problem on the Core 2 Duo 3
>> GHz systems.
>>
>>   Is there any way to find the reason of this problems with Xenomai
>> 2.5.X and newer Kernels 2.6.3X with 32 bit X86 or has anybody similar
>> problems fixed.
>=20
> Have you tried with something more recent than 2.6.34? We had a problem=
 revealed by grub2, I do not remember which version fixed it. Otherwise, =
you have to enable early printk and redirect the console to serial port o=
r netconsole, in order to capture it from another computer. Without these=
 logs, there is not much we can do.

If you want to see the logs:
- remove quiet from the kernel command line, if the bootloader passes it
- do not launch X, run in console, or enable serial console, netconsole,
and capture the output from another computer.

--=20
					    Gilles.


