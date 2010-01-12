MIME-Version: 1.0
In-Reply-To: <1aa9845a1001111053q58e082b1n75599eed79feec5a@domain.hid>
References: <1aa9845a1001110940o6bab200apde40348cc8e21bca@domain.hid>
	<4B4B6D53.8050606@domain.hid>
	<1aa9845a1001111053q58e082b1n75599eed79feec5a@domain.hid>
Date: Wed, 13 Jan 2010 00:24:32 +0530
Message-ID: <1aa9845a1001121054r245187bfq5bf4f65fd031238f@domain.hid>
From: Saravanan S <sarans1987@domain.hid>
Content-Type: multipart/alternative; boundary=0016e64cc78c32c412047cfc2f63
Subject: Re: [Xenomai-help] Xenomai not booting on a dell server
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

--0016e64cc78c32c412047cfc2f63
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Jan 12, 2010 at 12:23 AM, Saravanan S <sarans1987@domain.hid> wrote:

>
>
> On Mon, Jan 11, 2010 at 11:56 PM, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
>
>> Saravanan S wrote:
>> > Hi,
>> >
>> > I am trying to install xenomai on a Dell Poweredge server (R710).The
>> > platform details are given below:
>> >
>> > Two quad Intel(8 cores) Xeon E5506@domain.hid 6,RAM-16
>> > GB,uses SAS disks through a SAS Host Bus Adapter(HBA).
>> >
>> > Drivers for this HBA only available from fedora 10 onwards.
>> >
>> > So I patched xenomai  2.4.10 with linux 2.6.29.4 with fedora 11 as
>> > the host OS.I used fedora 11 config file.I made the following changes
>> > to the config file
>> >
>> > 1.In processor types and features: architecture->Core2/Newer Xeon,
>> > subarchitecture->Generic, thermal throttling disabled,HPET support
>> > enabled
>> >
>> > 2.Power management stopped.
>>
>> Bad. You should enable ACPI, only CONFIG_ACPI_PROCESSOR should be
>> disabled.
>>
>> >
>> > 3.Support for PCI hotplug disabled.
>> >
>> > 4.MSI,MSI-X disabled.
>>
>> No reason to do this. If you enable these options and get problems,
>> please isolate the option which causes a problem and report.
>>
>> >
>> > 5.In real time subsystem all options selected.
>>
>> Please keep the default settings for a first run, verify that it works,
>> then enable the options you want (all of them if you want), if it does
>> not work, then isolate the option which is the cause of the problem.
>>
>> >
>> > 6.SMP support enabled
>> >
>> > 7.MTD support disabled
>> >
>> > 8.All other default options.
>> >
>> > After making and installing the modules ,when i selected the xenomai
>> > kernel on rebooting it didnt boot at all.There was just a blinking
>> > cursor on the screen.
>>
>> Did you rebuild your OS (which is it anyway ?) initramfs/initrd? If you
>> do the same procedure without activating CONFIG_IPIPE and
>> CONFIG_XENOMAI, do you get
>>
>> >
>> > I referred to the following documents while installing
>> >
>> > http://download.intel.com/design/intarch/papers/322386.pdf
>> >
>> > http://stud3.tuwien.ac.at/~e0226686/xenomai/xenomai_implementation.pdf<http://stud3.tuwien.ac.at/%7Ee0226686/xenomai/xenomai_implementation.pdf>
>> <http://stud3.tuwien.ac.at/%7Ee0226686/xenomai/xenomai_implementation.pdf
>> >
>> >
>> >
>> >
>> http://www.lara.ene.unb.br/~phsantana/files/technotes/HowTo_Debian_Embedded.pdf<http://www.lara.ene.unb.br/%7Ephsantana/files/technotes/HowTo_Debian_Embedded.pdf>
>> <
>> http://www.lara.ene.unb.br/%7Ephsantana/files/technotes/HowTo_Debian_Embedded.pdf
>> >
>>
>> That is fine and even flattering to see that there are paper about
>> xenomai all around the web and even on intel's site. However, the
>> website containing authoritative documentation is http://www.xenomai.org
>> If something is missing there, please ask.
>>
>> I read the Intel doc for instance, it contains a lot of things which are
>> a cut and paste of Xenomai documentation, with some added stuff, which
>> unfortunately is quite erroneous:
>> - Adeos is not a real-time kernel
>> - there is no such thing as a list of linux kernels compatibles with a
>> version of Xenomai, each version of Xenomai aims at being compatible
>> with each versions of a Linux kernel for which a patch has been issued
>> at the time of the release. For each architecture, there are several
>> patches contained in the package, you are insured that linux kernel
>> patched with these patches compile, and that the one with the highest
>> linux version has been tested to validate xenomai.
>> - the list of packages to install in order to be able to install xenomai
>> is extravagant. The following packages are not needed:
>> rpm -ivh libgomp-4.1.2-42.el5.i386.rpm (Disk 2)
>> rpm -ivh elfutils-libs-0.125-3.el5.i386.rpm (Disk 2)
>> rpm -ivh redhat-rpm-config-8.0.45-24.el5.noarch.rpm (Disk
>> 2)
>> rpm -ivh ncurses-devel-5.5-24.20060715.i386.rpm (Disk 2)
>> rpm -ivh elfutils-0.125-3.el5.i386.rpm (Disk 2)
>> rpm -ivh libstdc++-devel-4.1.2-42.el5.i386.rpm (Disk 2)
>> rpm -ivh doxygen-1.4.7-1.1.i386.rpm (optional, Disk 2)
>> rpm -ivh unifdef-1.171-5.fc6.i386.rpm (Disk 3)
>> rpm -ivh rpm-build-4.4.2-48.el5.i386.rpm (Disk 3)
>> rpm -ivh emacs-common-21.4-20.el5.i386.rpm (required for
>> emacs-nox, Disk 3)
>> rpm -ivh emacs-nox-21.4-20.el5.i386.rpm (optional,
>> Disk 4)
>> - when building a linux 2.6 kernel, you do not need to run make clean
>> before building the kernel, actually, it is a waste of time
>> - the list of options to disable to run with xenomai is extravagant too:
>> you should not disable power management, you should enable ACPI, and the
>> MSI and MSI-X should work
>> CardBus should work
>> I suspect Toshiba and Dell laptop support should work
>> PCI hotplug should work
>> MTD should work (and actually works on embedded platforms with MTD
>> devices)
>> Fusion MPT should work
>> I2O should work
>> ISDN should work
>>
>> Anyway, if you have problem when enabling these options, writing a paper
>> telling the rest of the world to disable them is the wrong approach, any
>> such issue should be reported on this list.
>>
>> --
>>
>
>
> Thanks for replying first of all.I guess i was mislead by the intel
> document.I will try out what you have said and come back to you.
>
>
> With regards,
>
> S Saravanan
>
>>                                             Gilles.
>>
>
>
I tried out the installation following the guidelines given by xenomai
documents as per your advice .The details are given below:

Xenomai-2.4.10 patched on linux 2.6.29.4,host OS-fedora 11

while patching  xenomai gave arch as x86(Is this correct for my server???)

I used the following options following options in the kernel config

1.Processor -Pentium Pro(Strangely newer xeon option  doesnt work ..kernel
doesnt boot...tried several times)

2.ACPI-Processor disabled

3.APM disabled

4.CPU frequency scaling disabled

5.Check for P4 thermal throttling interrupt disabled.(If enabled gives a
error while making kernel)

5.rest all default options.

After installing i could boot inside xenomai kernel but when i ran xeno-test
program ,got worst case latency of around 88 us which is not good enough.

some other points:

1.Grepping dmesg showed no message "SMI chipset found"(SMI detection was
enabled), so my platform surely does not have SMI chipset(Is this assumption
correct????).

2.There are 4 UHCI USB and 2 EHCI USB embedded controllers in the server.But
anyway the UHCI and EHCI drivers were loaded.

I dont know how to proceed next.Would be very helpful if you could guide me
on where things could be going wrong.

Thanking you,

With Regards,

S Saravanan

--0016e64cc78c32c412047cfc2f63
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Tue, Jan 12, 2010 at 12:23 AM, Sarava=
nan S <span dir=3D"ltr">&lt;<a href=3D"mailto:sarans1987@domain.hid">sarans1=
987@domain.hid</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" st=
yle=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex=
; padding-left: 1ex;">
<br><br><div class=3D"gmail_quote"><div><div></div><div class=3D"h5">On Mon=
, Jan 11, 2010 at 11:56 PM, Gilles Chanteperdrix <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:gilles.chanteperdrix@xenomai.org" target=3D"_blank">gilles.chan=
teperdrix@domain.hid</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div>Saravanan S wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; I am trying to install xenomai on a Dell Poweredge server (R710).The<b=
r>
&gt; platform details are given below:<br>
&gt;<br>
&gt; Two quad Intel(8 cores) Xeon E5506@domain.hid 6,RAM-16<br>
&gt; GB,uses SAS disks through a SAS Host Bus Adapter(HBA).<br>
&gt;<br>
&gt; Drivers for this HBA only available from fedora 10 onwards.<br>
&gt;<br>
&gt; So I patched xenomai =A02.4.10 with linux 2.6.29.4 with fedora 11 as<b=
r>
&gt; the host OS.I used fedora 11 config file.I made the following changes<=
br>
&gt; to the config file<br>
&gt;<br>
&gt; 1.In processor types and features: architecture-&gt;Core2/Newer Xeon,<=
br>
&gt; subarchitecture-&gt;Generic, thermal throttling disabled,HPET support<=
br>
&gt; enabled<br>
&gt;<br>
&gt; 2.Power management stopped.<br>
<br>
</div>Bad. You should enable ACPI, only CONFIG_ACPI_PROCESSOR should be dis=
abled.<br>
<div><br>
&gt;<br>
&gt; 3.Support for PCI hotplug disabled.<br>
&gt;<br>
&gt; 4.MSI,MSI-X disabled.<br>
<br>
</div>No reason to do this. If you enable these options and get problems,<b=
r>
please isolate the option which causes a problem and report.<br>
<div><br>
&gt;<br>
&gt; 5.In real time subsystem all options selected.<br>
<br>
</div>Please keep the default settings for a first run, verify that it work=
s,<br>
then enable the options you want (all of them if you want), if it does<br>
not work, then isolate the option which is the cause of the problem.<br>
<div><br>
&gt;<br>
&gt; 6.SMP support enabled<br>
&gt;<br>
&gt; 7.MTD support disabled<br>
&gt;<br>
&gt; 8.All other default options.<br>
&gt;<br>
&gt; After making and installing the modules ,when i selected the xenomai<b=
r>
&gt; kernel on rebooting it didnt boot at all.There was just a blinking<br>
&gt; cursor on the screen.<br>
<br>
</div>Did you rebuild your OS (which is it anyway ?) initramfs/initrd? If y=
ou<br>
do the same procedure without activating CONFIG_IPIPE and<br>
CONFIG_XENOMAI, do you get<br>
<div><br>
&gt;<br>
&gt; I referred to the following documents while installing<br>
&gt;<br>
&gt; <a href=3D"http://download.intel.com/design/intarch/papers/322386.pdf"=
 target=3D"_blank">http://download.intel.com/design/intarch/papers/322386.p=
df</a><br>
&gt;<br>
</div>&gt; <a href=3D"http://stud3.tuwien.ac.at/%7Ee0226686/xenomai/xenomai=
_implementation.pdf" target=3D"_blank">http://stud3.tuwien.ac.at/~e0226686/=
xenomai/xenomai_implementation.pdf</a>&lt;<a href=3D"http://stud3.tuwien.ac=
.at/%7Ee0226686/xenomai/xenomai_implementation.pdf" target=3D"_blank">http:=
//stud3.tuwien.ac.at/%7Ee0226686/xenomai/xenomai_implementation.pdf</a>&gt;=
<br>


&gt;<br>
&gt;<br>
&gt; <a href=3D"http://www.lara.ene.unb.br/%7Ephsantana/files/technotes/How=
To_Debian_Embedded.pdf" target=3D"_blank">http://www.lara.ene.unb.br/~phsan=
tana/files/technotes/HowTo_Debian_Embedded.pdf</a>&lt;<a href=3D"http://www=
.lara.ene.unb.br/%7Ephsantana/files/technotes/HowTo_Debian_Embedded.pdf" ta=
rget=3D"_blank">http://www.lara.ene.unb.br/%7Ephsantana/files/technotes/How=
To_Debian_Embedded.pdf</a>&gt;<br>


<br>
That is fine and even flattering to see that there are paper about<br>
xenomai all around the web and even on intel&#39;s site. However, the<br>
website containing authoritative documentation is <a href=3D"http://www.xen=
omai.org" target=3D"_blank">http://www.xenomai.org</a><br>
If something is missing there, please ask.<br>
<br>
I read the Intel doc for instance, it contains a lot of things which are<br=
>
a cut and paste of Xenomai documentation, with some added stuff, which<br>
unfortunately is quite erroneous:<br>
- Adeos is not a real-time kernel<br>
- there is no such thing as a list of linux kernels compatibles with a<br>
version of Xenomai, each version of Xenomai aims at being compatible<br>
with each versions of a Linux kernel for which a patch has been issued<br>
at the time of the release. For each architecture, there are several<br>
patches contained in the package, you are insured that linux kernel<br>
patched with these patches compile, and that the one with the highest<br>
linux version has been tested to validate xenomai.<br>
- the list of packages to install in order to be able to install xenomai<br=
>
is extravagant. The following packages are not needed:<br>
rpm -ivh libgomp-4.1.2-42.el5.i386.rpm (Disk 2)<br>
rpm -ivh elfutils-libs-0.125-3.el5.i386.rpm (Disk 2)<br>
rpm -ivh redhat-rpm-config-8.0.45-24.el5.noarch.rpm (Disk<br>
2)<br>
rpm -ivh ncurses-devel-5.5-24.20060715.i386.rpm (Disk 2)<br>
rpm -ivh elfutils-0.125-3.el5.i386.rpm (Disk 2)<br>
rpm -ivh libstdc++-devel-4.1.2-42.el5.i386.rpm (Disk 2)<br>
rpm -ivh doxygen-1.4.7-1.1.i386.rpm (optional, Disk 2)<br>
rpm -ivh unifdef-1.171-5.fc6.i386.rpm (Disk 3)<br>
rpm -ivh rpm-build-4.4.2-48.el5.i386.rpm (Disk 3)<br>
rpm -ivh emacs-common-21.4-20.el5.i386.rpm (required for<br>
emacs-nox, Disk 3)<br>
rpm -ivh emacs-nox-21.4-20.el5.i386.rpm (optional,<br>
Disk 4)<br>
- when building a linux 2.6 kernel, you do not need to run make clean<br>
before building the kernel, actually, it is a waste of time<br>
- the list of options to disable to run with xenomai is extravagant too:<br=
>
you should not disable power management, you should enable ACPI, and the<br=
>
MSI and MSI-X should work<br>
CardBus should work<br>
I suspect Toshiba and Dell laptop support should work<br>
PCI hotplug should work<br>
MTD should work (and actually works on embedded platforms with MTD devices)=
<br>
Fusion MPT should work<br>
I2O should work<br>
ISDN should work<br>
<br>
Anyway, if you have problem when enabling these options, writing a paper<br=
>
telling the rest of the world to disable them is the wrong approach, any<br=
>
such issue should be reported on this list.<br>
<br>
--<br></blockquote></div></div><div><br><br>Thanks for replying first of al=
l.I guess i was mislead by the intel document.I will try out what you have =
said and come back to you.<br><br><br>With regards,<br><br>S Saravanan=A0 <=
br>
</div>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br></blockquote><div><br>I tried out the install=
ation following the guidelines given by xenomai documents as per your advic=
e .The details are given below:<br><br><span style=3D"background-color: rgb=
(255, 255, 255); color: rgb(51, 102, 255);">Xenomai-2.4.10 <span style=3D"c=
olor: rgb(0, 0, 0);">patched on</span> linux 2.6.29.4,<span style=3D"color:=
 rgb(0, 0, 0);">host OS</span>-fedora 11</span><br style=3D"color: rgb(51, =
102, 255);">
<br>while patching=A0 xenomai gave arch as<span style=3D"color: rgb(255, 0,=
 0);"> x86</span>(Is this correct for my server???)<br><br>I used the follo=
wing options following options in the kernel config<br><br>1.Processor -<sp=
an style=3D"color: rgb(204, 0, 0);">Pentium Pro</span>(Strangely newer xeon=
 option=A0 doesnt work ..kernel doesnt boot...tried several times)<br>
<br>2.ACPI-Processor disabled<br><br>3.APM disabled<br><br>4.CPU frequency =
scaling disabled<br><br>5.Check for P4 thermal throttling interrupt disable=
d.(If enabled gives a error while making kernel)<br><br>5.rest all default =
options.<br>
<br>After installing i could boot inside xenomai kernel but when i ran xeno=
-test program ,got worst case latency of around <span style=3D"color: rgb(2=
55, 0, 0);">88 us</span> which is not good enough.<br><br>some other points=
:<br>
<br>1.Grepping dmesg showed no message &quot;SMI chipset found&quot;(SMI de=
tection was enabled), so my platform surely does not have SMI chipset(Is th=
is assumption correct????).<br><br>2.There are <span style=3D"color: rgb(20=
4, 0, 0);">4 UHCI USB</span> and <span style=3D"color: rgb(204, 0, 0);">2 E=
HCI USB</span> embedded controllers in the server.But anyway the UHCI and E=
HCI drivers were loaded.<br>
<br>I dont know how to proceed next.Would be very helpful if you could guid=
e me on where things could be going wrong.<br><br>Thanking you,<br><br>With=
 Regards,<br><br>S Saravanan<br></div></div><br>

--0016e64cc78c32c412047cfc2f63--

