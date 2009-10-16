MIME-Version: 1.0
In-Reply-To: <72cf3fb0910160345i494f81dr2c2d7ca4a1f5e66@domain.hid>
References: <96eea0c80910151813v635d518dr6abd72986e2f07bd@domain.hid>
	<72cf3fb0910160345i494f81dr2c2d7ca4a1f5e66@domain.hid>
Date: Fri, 16 Oct 2009 10:16:29 -0700
Message-ID: <96eea0c80910161016j1a1c1b8et4b2783b8cd5fa712@domain.hid>
From: Peter Pastor <peter.pastor@domain.hid>
Content-Type: multipart/alternative; boundary=0016e64698e489c6ec0476108e3d
Subject: Re: [Xenomai-help] national instruments card and comedi-rtdm-dev
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Alexis Berlemont <berlemont.hauw@domain.hid>
Cc: xenomai@xenomai.org

--0016e64698e489c6ec0476108e3d
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hey Alexis,

Thanks a lot for your quick response.

>> Is rt_comedi_test an application you developed ?
Yes, it is my little test application, which is kept simple (open, read,
close).

>> I think you should follow the common comedi way:
>> 1) Check you have the suitable driver loaded:
xenomai:/proc/xenomai/rtdm> cat /proc/comedi/drivers
--  Comedi drivers --

| idx | driver name
|  00 | ni_pcimio

>> 2) Check the comedi RTDM devices available:
xenomai:/proc/xenomai/rtdm> cat /proc/xenomai/rtdm/named_devices
Hash    Name                Driver        /proc
A1    comedi0                            rtdm_comedi        comedi0
A2    comedi1                            rtdm_comedi        comedi1
A3    comedi2                            rtdm_comedi        comedi2
A4    comedi3                            rtdm_comedi        comedi3
A5    comedi4                            rtdm_comedi        comedi4
A6    comedi5                            rtdm_comedi        comedi5
A7    comedi6                            rtdm_comedi        comedi6
A8    comedi7                            rtdm_comedi        comedi7
A9    comedi8                            rtdm_comedi        comedi8
AA    comedi9                            rtdm_comedi        comedi9

>> 3)  You have to attach the driver to the rtdm device you want to use
>> with comedi_config (a tool available in Xenomai).
>> #comedi_config comedi0 comedi_pcimio
>>    That command will assign comedi_pcimio driver to comedi0
root@domain.hid# ./comedi_config comedi0 comedi_pcimio
comedi_config: comedi_snd_attach failed ret=3D-22
root@domain.hid# ./comedi_config comedi0 ni_pcimio
comedi_config: comedi_snd_attach failed ret=3D-5

>> 4) Eventually, you can test the acquistion is working with some test too=
l
of ours :cmd_read
>> # /usr/local/bin/cmd_read -v
I don't find this test tool. How do I install it ?


>> SVN is not our version control system anymore. You should use our git
repository.
>> If you want the last fix I made, take my comedi branch.
>> Have a look at:
>> http://git.xenomai.org/?p=3Dxenomai-abe.git;a=3Dshortlog;h=3Drefs/heads/=
comedi<http://git.xenomai.org/?p=3Dxenomai-abe.git;a=3Dshortlog;h=3Drefs/he=
ads/comedi>

I actually started to download using git, but it was unbelievable slow :(
(11Kbit/s). Is there a difference between HEAD and ABE that does matter to
me ?

Apparently, I don't have comedi_pcimio. How do I build it and where can I
find it ? It seems not to be in xenomai 2.5-rc3. I will downlaod
xenomai-abe.git and see what I get.

>> the driver name is comedi_pcimio instead of ni_pcimio. So you should typ=
e
comedi_config comedi0 comedi_pcimio.
So, the comedi_pcimio is the driver I'll need ? Is the no National
Instrument specific driver ?? (ni_pcimio) ??

Thanks again,
 peter



On Fri, Oct 16, 2009 at 3:45 AM, Alexis Berlemont <berlemont.hauw@domain.hid>w=
rote:

> Hi,
>
> On Fri, Oct 16, 2009 at 3:13 AM, Peter Pastor <peter.pastor@domain.hid>
> wrote:
> > Hey,
> >
> > I am trying to get a national instrument data acquisition pci card
> working
> > under linux 2.6.30.5 xenomai 2.5-rc3 using comedi. I successfully
> installed
> > the regular comedi drivers and I got data from the card, however, I als=
o
> got
> > mode switches. Therefore, I moved to the latest xenomai release which
> > includes the comedi interface. The installation worked out and I got a
> > xeno_comedi.ko module that I can load and a
> /usr/xenomai/lib/libcomedi.so.0.
> > However, my program returns with...
> >
> > xenomai:~/xenomai_test> ./rt_comedi_test
> > ./rt_comedi_test: /usr/xenomai/lib/libcomedi.so.0: no version informati=
on
> > available (required by ./rt_comedi_test)
> > Xenomai: incompatible ABI revision level
> > (needed=3D1, current=3D2).
>
> Is rt_comedi_test an application you developed ?
>
> > I figured, that I need a national instrument driver (ni_pcimio) to get
> the
> > /dev/comedi0 up and running since there is no kernel module associated
> with
> > the NI card...
>
> I think you should follow the common comedi way:
> 1) Check you have the suitable driver loaded:
> # cat /proc/comedi/drivers
> --  Comedi drivers --
>
> | idx | driver name
> |  00 | comedi_pcimio
> |  01 | 8255
> |  02 | comedi_loop
> |  03 | comedi_fake
>
> 2) Check the comedi RTDM devices available:
> # cat /proc/xenomai/rtdm/named_devices
> Hash    Name                            Driver          /proc
> A1      comedi0                         rtdm_comedi     comedi0
> A2      comedi1                         rtdm_comedi     comedi1
> A3      comedi2                         rtdm_comedi     comedi2
> A4      comedi3                         rtdm_comedi     comedi3
> A5      comedi4                         rtdm_comedi     comedi4
> A6      comedi5                         rtdm_comedi     comedi5
> A7      comedi6                         rtdm_comedi     comedi6
> A8      comedi7                         rtdm_comedi     comedi7
> A9      comedi8                         rtdm_comedi     comedi8
> AA      comedi9                         rtdm_comedi     comedi9
> D6      rttest0                         xeno_timerbench rttest0
> D7      rttest1                         xeno_switchtest rttest1
>
>
> 3)  You have to attach the driver to the rtdm device you want to use
> with comedi_config (a tool available in Xenomai).
> #comedi_config comedi0 comedi_pcimio
>     That command will assign comedi_pcimio driver to comedi0
>
> 4) Eventually, you can test the acquistion is working with some test
> tool of ours :cmd_read
> # /usr/local/bin/cmd_read -v
> cmd_read: device comedi0 opened (fd=3D0)
> cmd_read: basic descriptor retrieved
>         subdevices count =3D 14
>         read subdevice index =3D 0
>         write subdevice index =3D 1
> cmd_read: complex descriptor retrieved
> cmd_read: channel 0
>         ranges count =3D 4
>         range's size =3D 16 (bits)
> cmd_read: channel 1
>         ranges count =3D 4
>         range's size =3D 16 (bits)
> cmd_read: channel 2
>         ranges count =3D 4
>         range's size =3D 16 (bits)
> cmd_read: channel 3
>         ranges count =3D 4
>         range's size =3D 16 (bits)
> cmd_read: scan size =3D 8
> cmd_read: size to read =3D 800
> cmd_read: command successfully sent
> 0x0 0x0 0x69 0x1 0x5f 0x33 0x33 0x58
> 0xb3 0x3a 0xec 0x28 0x2a 0x2d 0x9e 0x3a
> 0x73 0x3b 0x2f 0x35 0x78 0x32 0x7d 0x35
> 0x8b 0x37 0xad 0x36 0x25 0x35 0x8f 0x35
> 0xe 0x36 0x49 0x36 0xcd 0x35 0xef 0x35
> 0xc5 0x35 0x1 0x36 0xdb 0x35 0xe 0x36
> 0xc3 0x35 0xea 0x35 0xd1 0x35 0xe 0x36
> 0xc6 0x35 0xe4 0x35 0xc7 0x35 0x9 0x36
> 0xc3 0x35 0xe0 0x35 0xc1 0x35 0x1 0x36
> 0xc0 0x35 0xd9 0x35 0xbb 0x35 0xfb 0x35
> 0xb9 0x35 0xd5 0x35 0xb5 0x35 0xf3 0x35
> 0xb2 0x35 0xce 0x35 0xae 0x35 0xee 0x35
>
> Here is my output with a NI 6221.
>
> > xenomai:~/xenomai_test> lspci -v
> >
> > ...
> >
> > 06:00.0 Class ff00: National Instruments Device 717f
> >     Flags: bus master, medium devsel, latency 64, IRQ 11
> >     Memory at f7dfe000 (32-bit, non-prefetchable) [size=3D4K]
> >     Memory at f7dff000 (32-bit, non-prefetchable) [size=3D4K]
> >
> > ...
> >
> > I "svn co http://svn.gna.org/svn/xenomai/branches/comedi-rtdm-dev" sinc=
e
> it
> > seems to contain the NI drivers... however, I got a compiler error that=
 I
> > think relates to the fact that the system I am using has 4GB of ram
> > (highmem). I am using revision: 4727.
>
>
>

>
> > root@domain.hid# make
> > make  all-recursive
> > make[1]: Entering directory `/usr/src/comedi-rtdm-dev'
> > Making all in comedi_kcore
> > make[2]: Entering directory `/usr/src/comedi-rtdm-dev/comedi_kcore'
> > make[3]: Entering directory `/usr/src/comedi-rtdm-dev'
> > make[3]: Leaving directory `/usr/src/comedi-rtdm-dev'
> > make[3]: Entering directory `/usr/src/linux-2.6.30.5'
> >   CC [M]  /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_os_facilities.o
> >   CC [M]  /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_command.o
> >   CC [M]  /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_instruction.o
> >   CC [M]  /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_driver.o
> >   CC [M]  /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_subdevice.o
> >   CC [M]  /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_buffer.o
> > /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_buffer.c: In function
> > =91comedi_free_buffer=92:
> > /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_buffer.c:52: error: implic=
it
> > declaration of function =91__va_to_kva=92
> > make[4]: *** [/usr/src/comedi-rtdm-dev/comedi_kcore/comedi_buffer.o]
> Error 1
> > make[3]: *** [_module_/usr/src/comedi-rtdm-dev/comedi_kcore] Error 2
> > make[3]: Leaving directory `/usr/src/linux-2.6.30.5'
> > make[2]: *** [comedi.ko] Error 2
> > make[2]: Leaving directory `/usr/src/comedi-rtdm-dev/comedi_kcore'
> > make[1]: *** [all-recursive] Error 1
> > make[1]: Leaving directory `/usr/src/comedi-rtdm-dev'
> > make: *** [all] Error 2
> >
> > I would be really happy if someone could give me some hints/advice on h=
ow
> to
> > get things working. What do I need to do ??
> >
> > Thanks a lot,
> >  peter
> >
>
> Alexis.
>

--0016e64698e489c6ec0476108e3d
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hey Alexis,<br><br>Thanks a lot for your quick response.<br><br>&gt;&gt; Is=
 rt_comedi_test an application you developed ?<br>
Yes, it is my little test application, which is kept simple (open, read, cl=
ose).<br><br>&gt;&gt; I think you should follow the common comedi way:<br>
&gt;&gt; 1) Check you have the suitable driver loaded:<br>xenomai:/proc/xen=
omai/rtdm&gt; cat /proc/comedi/drivers <br>--=A0 Comedi drivers --<br><br>|=
 idx | driver name<br>|=A0 00 | ni_pcimio<br><br>&gt;&gt; 2) Check the come=
di RTDM devices available:<br>
xenomai:/proc/xenomai/rtdm&gt; cat /proc/xenomai/rtdm/named_devices <br>Has=
h=A0=A0=A0 Name=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 Driver=A0=A0=A0 =A0=
=A0=A0 /proc<br>A1=A0=A0=A0 comedi0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0 rtdm_comedi=A0=A0=A0 =A0=A0=A0 com=
edi0<br>A2=A0=A0=A0 comedi1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0 rtdm_comedi=A0=A0=A0 =A0=A0=A0 comedi1<br>
A3=A0=A0=A0 comedi2=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =A0=A0=A0 rtdm_comedi=A0=A0=A0 =A0=A0=A0 comedi2<br>A4=A0=
=A0=A0 comedi3=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 =A0=A0=A0 rtdm_comedi=A0=A0=A0 =A0=A0=A0 comedi3<br>A5=A0=A0=A0 c=
omedi4=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 =A0=A0=A0 rtdm_comedi=A0=A0=A0 =A0=A0=A0 comedi4<br>A6=A0=A0=A0 comedi5=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=
=A0 rtdm_comedi=A0=A0=A0 =A0=A0=A0 comedi5<br>
A7=A0=A0=A0 comedi6=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =A0=A0=A0 rtdm_comedi=A0=A0=A0 =A0=A0=A0 comedi6<br>A8=A0=
=A0=A0 comedi7=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 =A0=A0=A0 rtdm_comedi=A0=A0=A0 =A0=A0=A0 comedi7<br>A9=A0=A0=A0 c=
omedi8=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 =A0=A0=A0 rtdm_comedi=A0=A0=A0 =A0=A0=A0 comedi8<br>AA=A0=A0=A0 comedi9=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=
=A0 rtdm_comedi=A0=A0=A0 =A0=A0=A0 comedi9<br>
<br>&gt;&gt; 3) =A0You have to attach the driver to the rtdm device you wan=
t to use<br>
&gt;&gt; with comedi_config (a tool available in Xenomai).<br>
&gt;&gt; #comedi_config comedi0 comedi_pcimio<br>
 &gt;&gt;=A0 =A0 That command will assign comedi_pcimio driver to comedi0<b=
r>root@domain.hid# ./comedi_config comedi0 comedi_pcimio<br>=
comedi_config: comedi_snd_attach failed ret=3D-22<br>root@domain.hid=
mai/sbin# ./comedi_config comedi0 ni_pcimio<br>
comedi_config: comedi_snd_attach failed ret=3D-5<br><br>&gt;&gt; 4) Eventua=
lly, you can test the acquistion is working with some test tool of ours :cm=
d_read<br>
&gt;&gt; # /usr/local/bin/cmd_read -v<br>I don&#39;t find this test tool. H=
ow do I install it ?<br><br><br>
&gt;&gt; SVN is not our version control system anymore. You should use our =
git repository.<br>
&gt;&gt; If you want the last fix I made, take my comedi branch.<br>
&gt;&gt; Have a look at:<br>
<a href=3D"http://git.xenomai.org/?p=3Dxenomai-abe.git;a=3Dshortlog;h=3Dref=
s/heads/comedi" target=3D"_blank">&gt;&gt; http://git.xenomai.org/?p=3Dxeno=
mai-abe.git;a=3Dshortlog;h=3Drefs/heads/comedi</a><br><br>I actually starte=
d to download using git, but it was unbelievable slow :( (11Kbit/s). Is the=
re a difference between HEAD and ABE that does matter to me ?<br>
<br>Apparently, I don&#39;t have comedi_pcimio. How do I build it and where=
 can I find it ? It seems not to be in xenomai 2.5-rc3. I will downlaod xen=
omai-abe.git and see what I get.<br><br>&gt;&gt; the driver name is comedi_=
pcimio instead of ni_pcimio. So you should type comedi_config comedi0 comed=
i_pcimio.<br>
So, the comedi_pcimio is the driver I&#39;ll need ? Is the no National Inst=
rument specific driver ?? (ni_pcimio) ??<br><br>Thanks again,<br>=A0peter<b=
r><br><br><br><div class=3D"gmail_quote">On Fri, Oct 16, 2009 at 3:45 AM, A=
lexis Berlemont <span dir=3D"ltr">&lt;<a href=3D"mailto:berlemont.hauw@domain.hid=
.fr" target=3D"_blank">berlemont.hauw@domain.hid</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi,<br>
<div><br>
On Fri, Oct 16, 2009 at 3:13 AM, Peter Pastor &lt;<a href=3D"mailto:peter.p=
astor@domain.hid" target=3D"_blank">peter.pastor@domain.hid</a>&gt; wrote:<br=
>
&gt; Hey,<br>
&gt;<br>
&gt; I am trying to get a national instrument data acquisition pci card wor=
king<br>
&gt; under linux 2.6.30.5 xenomai 2.5-rc3 using comedi. I successfully inst=
alled<br>
&gt; the regular comedi drivers and I got data from the card, however, I al=
so got<br>
&gt; mode switches. Therefore, I moved to the latest xenomai release which<=
br>
&gt; includes the comedi interface. The installation worked out and I got a=
<br>
&gt; xeno_comedi.ko module that I can load and a /usr/xenomai/lib/libcomedi=
.so.0.<br>
&gt; However, my program returns with...<br>
&gt;<br>
&gt; xenomai:~/xenomai_test&gt; ./rt_comedi_test<br>
&gt; ./rt_comedi_test: /usr/xenomai/lib/libcomedi.so.0: no version informat=
ion<br>
&gt; available (required by ./rt_comedi_test)<br>
&gt; Xenomai: incompatible ABI revision level<br>
&gt; (needed=3D1, current=3D2).<br>
<br>
</div>Is rt_comedi_test an application you developed ?<br>
<div><br>
&gt; I figured, that I need a national instrument driver (ni_pcimio) to get=
 the<br>
&gt; /dev/comedi0 up and running since there is no kernel module associated=
 with<br>
&gt; the NI card...<br>
<br>
</div>I think you should follow the common comedi way:<br>
1) Check you have the suitable driver loaded:<br>
# cat /proc/comedi/drivers<br>
-- =A0Comedi drivers --<br>
<br>
| idx | driver name<br>
| =A000 | comedi_pcimio<br>
| =A001 | 8255<br>
| =A002 | comedi_loop<br>
| =A003 | comedi_fake<br>
<br>
2) Check the comedi RTDM devices available:<br>
# cat /proc/xenomai/rtdm/named_devices<br>
Hash =A0 =A0Name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Dri=
ver =A0 =A0 =A0 =A0 =A0/proc<br>
A1 =A0 =A0 =A0comedi0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtdm_=
comedi =A0 =A0 comedi0<br>
A2 =A0 =A0 =A0comedi1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtdm_=
comedi =A0 =A0 comedi1<br>
A3 =A0 =A0 =A0comedi2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtdm_=
comedi =A0 =A0 comedi2<br>
A4 =A0 =A0 =A0comedi3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtdm_=
comedi =A0 =A0 comedi3<br>
A5 =A0 =A0 =A0comedi4 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtdm_=
comedi =A0 =A0 comedi4<br>
A6 =A0 =A0 =A0comedi5 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtdm_=
comedi =A0 =A0 comedi5<br>
A7 =A0 =A0 =A0comedi6 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtdm_=
comedi =A0 =A0 comedi6<br>
A8 =A0 =A0 =A0comedi7 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtdm_=
comedi =A0 =A0 comedi7<br>
A9 =A0 =A0 =A0comedi8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtdm_=
comedi =A0 =A0 comedi8<br>
AA =A0 =A0 =A0comedi9 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtdm_=
comedi =A0 =A0 comedi9<br>
D6 =A0 =A0 =A0rttest0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xeno_=
timerbench rttest0<br>
D7 =A0 =A0 =A0rttest1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xeno_=
switchtest rttest1<br>
<br>
<br>
3) =A0You have to attach the driver to the rtdm device you want to use<br>
with comedi_config (a tool available in Xenomai).<br>
#comedi_config comedi0 comedi_pcimio<br>
 =A0 =A0 That command will assign comedi_pcimio driver to comedi0<br>
<br>
4) Eventually, you can test the acquistion is working with some test<br>
tool of ours :cmd_read<br>
# /usr/local/bin/cmd_read -v<br>
cmd_read: device comedi0 opened (fd=3D0)<br>
cmd_read: basic descriptor retrieved<br>
 =A0 =A0 =A0 =A0 subdevices count =3D 14<br>
 =A0 =A0 =A0 =A0 read subdevice index =3D 0<br>
 =A0 =A0 =A0 =A0 write subdevice index =3D 1<br>
cmd_read: complex descriptor retrieved<br>
cmd_read: channel 0<br>
 =A0 =A0 =A0 =A0 ranges count =3D 4<br>
 =A0 =A0 =A0 =A0 range&#39;s size =3D 16 (bits)<br>
cmd_read: channel 1<br>
 =A0 =A0 =A0 =A0 ranges count =3D 4<br>
 =A0 =A0 =A0 =A0 range&#39;s size =3D 16 (bits)<br>
cmd_read: channel 2<br>
 =A0 =A0 =A0 =A0 ranges count =3D 4<br>
 =A0 =A0 =A0 =A0 range&#39;s size =3D 16 (bits)<br>
cmd_read: channel 3<br>
 =A0 =A0 =A0 =A0 ranges count =3D 4<br>
 =A0 =A0 =A0 =A0 range&#39;s size =3D 16 (bits)<br>
cmd_read: scan size =3D 8<br>
cmd_read: size to read =3D 800<br>
cmd_read: command successfully sent<br>
0x0 0x0 0x69 0x1 0x5f 0x33 0x33 0x58<br>
0xb3 0x3a 0xec 0x28 0x2a 0x2d 0x9e 0x3a<br>
0x73 0x3b 0x2f 0x35 0x78 0x32 0x7d 0x35<br>
0x8b 0x37 0xad 0x36 0x25 0x35 0x8f 0x35<br>
0xe 0x36 0x49 0x36 0xcd 0x35 0xef 0x35<br>
0xc5 0x35 0x1 0x36 0xdb 0x35 0xe 0x36<br>
0xc3 0x35 0xea 0x35 0xd1 0x35 0xe 0x36<br>
0xc6 0x35 0xe4 0x35 0xc7 0x35 0x9 0x36<br>
0xc3 0x35 0xe0 0x35 0xc1 0x35 0x1 0x36<br>
0xc0 0x35 0xd9 0x35 0xbb 0x35 0xfb 0x35<br>
0xb9 0x35 0xd5 0x35 0xb5 0x35 0xf3 0x35<br>
0xb2 0x35 0xce 0x35 0xae 0x35 0xee 0x35<br>
<br>
Here is my output with a NI 6221.<br>
<div><br>
&gt; xenomai:~/xenomai_test&gt; lspci -v<br>
&gt;<br>
&gt; ...<br>
&gt;<br>
&gt; 06:00.0 Class ff00: National Instruments Device 717f<br>
&gt; =A0=A0=A0 Flags: bus master, medium devsel, latency 64, IRQ 11<br>
&gt; =A0=A0=A0 Memory at f7dfe000 (32-bit, non-prefetchable) [size=3D4K]<br=
>
&gt; =A0=A0=A0 Memory at f7dff000 (32-bit, non-prefetchable) [size=3D4K]<br=
>
&gt;<br>
&gt; ...<br>
&gt;<br>
&gt; I &quot;svn co <a href=3D"http://svn.gna.org/svn/xenomai/branches/come=
di-rtdm-dev" target=3D"_blank">http://svn.gna.org/svn/xenomai/branches/come=
di-rtdm-dev</a>&quot; since it<br>
&gt; seems to contain the NI drivers... however, I got a compiler error tha=
t I<br>
&gt; think relates to the fact that the system I am using has 4GB of ram<br=
>
&gt; (highmem). I am using revision: 4727.<br>
<br></div><div><div></div><div><br></div></div></blockquote><div>=A0</div><=
blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 2=
04, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div>
<br>
&gt; root@domain.hid# make<br>
&gt; make=A0 all-recursive<br>
&gt; make[1]: Entering directory `/usr/src/comedi-rtdm-dev&#39;<br>
&gt; Making all in comedi_kcore<br>
&gt; make[2]: Entering directory `/usr/src/comedi-rtdm-dev/comedi_kcore&#39=
;<br>
&gt; make[3]: Entering directory `/usr/src/comedi-rtdm-dev&#39;<br>
&gt; make[3]: Leaving directory `/usr/src/comedi-rtdm-dev&#39;<br>
&gt; make[3]: Entering directory `/usr/src/linux-2.6.30.5&#39;<br>
&gt; =A0 CC [M]=A0 /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_os_faciliti=
es.o<br>
&gt; =A0 CC [M]=A0 /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_command.o<b=
r>
&gt; =A0 CC [M]=A0 /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_instruction=
.o<br>
&gt; =A0 CC [M]=A0 /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_driver.o<br=
>
&gt; =A0 CC [M]=A0 /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_subdevice.o=
<br>
&gt; =A0 CC [M]=A0 /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_buffer.o<br=
>
&gt; /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_buffer.c: In function<br>
&gt; =91comedi_free_buffer=92:<br>
&gt; /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_buffer.c:52: error: impli=
cit<br>
&gt; declaration of function =91__va_to_kva=92<br>
&gt; make[4]: *** [/usr/src/comedi-rtdm-dev/comedi_kcore/comedi_buffer.o] E=
rror 1<br>
&gt; make[3]: *** [_module_/usr/src/comedi-rtdm-dev/comedi_kcore] Error 2<b=
r>
&gt; make[3]: Leaving directory `/usr/src/linux-2.6.30.5&#39;<br>
&gt; make[2]: *** [comedi.ko] Error 2<br>
&gt; make[2]: Leaving directory `/usr/src/comedi-rtdm-dev/comedi_kcore&#39;=
<br>
&gt; make[1]: *** [all-recursive] Error 1<br>
&gt; make[1]: Leaving directory `/usr/src/comedi-rtdm-dev&#39;<br>
&gt; make: *** [all] Error 2<br>
&gt;<br>
&gt; I would be really happy if someone could give me some hints/advice on =
how to<br>
&gt; get things working. What do I need to do ??<br>
&gt;<br>
&gt; Thanks a lot,<br>
&gt; =A0peter<br>
&gt;<br>
<br>
</div></div><font color=3D"#888888">Alexis.<br>
</font></blockquote></div><br>

--0016e64698e489c6ec0476108e3d--

