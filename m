MIME-Version: 1.0
In-Reply-To: <72cf3fb0910161406g313db0ffm61c6bd09a65e025c@domain.hid>
References: <96eea0c80910151813v635d518dr6abd72986e2f07bd@domain.hid>
	<72cf3fb0910160345i494f81dr2c2d7ca4a1f5e66@domain.hid>
	<96eea0c80910161016j1a1c1b8et4b2783b8cd5fa712@domain.hid>
	<72cf3fb0910161406g313db0ffm61c6bd09a65e025c@domain.hid>
Date: Fri, 16 Oct 2009 15:06:21 -0700
Message-ID: <96eea0c80910161506v6292310et2d5fdf617355d97e@domain.hid>
From: Peter Pastor <peter.pastor@domain.hid>
Content-Type: multipart/alternative; boundary=0016e6470aac30bf480476149ba8
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

--0016e6470aac30bf480476149ba8
Content-Type: text/plain; charset=ISO-8859-1

Hey Alexis,

Thanks for your response !!

>> Yes take the abe repository, please. I will make a pull request soon.
I downloaded the git xenomai-abe repository and installed linux-2.6.29.1
(since there was no patch for 2.6.30.5).

The installation worked out, however, it seems that the comedi_pcimio driver
is not included.
Am I missing something during configuring the kernel ??

>From what I understand now is that I need xeno_comedi.ko which is the
interface to xenomai and RTDM and I need comedi_pcimio.ko which actually
talks to the hardware and does real-time capable I/O. Is this correct ??

Thanks a lot, I am really glad that I am getting somewhere !!

 peter



On Fri, Oct 16, 2009 at 2:06 PM, Alexis Berlemont <berlemont.hauw@domain.hid>wrote:

> Hi,
>
> On Fri, Oct 16, 2009 at 7:16 PM, Peter Pastor <peter.pastor@domain.hid>
> wrote:
> > Hey Alexis,
> >
> > Thanks a lot for your quick response.
> >
> >>> Is rt_comedi_test an application you developed ?
> > Yes, it is my little test application, which is kept simple (open, read,
> > close).
> >
> >>> I think you should follow the common comedi way:
> >>> 1) Check you have the suitable driver loaded:
> > xenomai:/proc/xenomai/rtdm> cat /proc/comedi/drivers
> > --  Comedi drivers --
> >
> > | idx | driver name
> > |  00 | ni_pcimio
> >
> >>> 2) Check the comedi RTDM devices available:
> > xenomai:/proc/xenomai/rtdm> cat /proc/xenomai/rtdm/named_devices
> > Hash    Name                Driver        /proc
> > A1    comedi0                            rtdm_comedi        comedi0
> > A2    comedi1                            rtdm_comedi        comedi1
> > A3    comedi2                            rtdm_comedi        comedi2
> > A4    comedi3                            rtdm_comedi        comedi3
> > A5    comedi4                            rtdm_comedi        comedi4
> > A6    comedi5                            rtdm_comedi        comedi5
> > A7    comedi6                            rtdm_comedi        comedi6
> > A8    comedi7                            rtdm_comedi        comedi7
> > A9    comedi8                            rtdm_comedi        comedi8
> > AA    comedi9                            rtdm_comedi        comedi9
> >
> >>> 3)  You have to attach the driver to the rtdm device you want to use
> >>> with comedi_config (a tool available in Xenomai).
> >>> #comedi_config comedi0 comedi_pcimio
> >>>    That command will assign comedi_pcimio driver to comedi0
> > root@domain.hid# ./comedi_config comedi0 comedi_pcimio
> > comedi_config: comedi_snd_attach failed ret=-22
> > root@domain.hid# ./comedi_config comedi0 ni_pcimio
> > comedi_config: comedi_snd_attach failed ret=-5
> >
> >>> 4) Eventually, you can test the acquistion is working with some test
> tool
> >>> of ours :cmd_read
> >>> # /usr/local/bin/cmd_read -v
> > I don't find this test tool. How do I install it ?
> >
> >
> >>> SVN is not our version control system anymore. You should use our git
> >>> repository.
> >>> If you want the last fix I made, take my comedi branch.
> >>> Have a look at:
> >>>
> http://git.xenomai.org/?p=xenomai-abe.git;a=shortlog;h=refs/heads/comedi
> >
> > I actually started to download using git, but it was unbelievable slow :(
> > (11Kbit/s). Is there a difference between HEAD and ABE that does matter
> to
> > me ?
>
> Yes take the abe repository, please. I will make a pull request soon.
>
> Concerning the bitrate, I did not manage to reproduce your low bandwidth:
> Receiving objects:   6% (3661/57181), 780.00 KiB | 94 KiB/s
>
> > Apparently, I don't have comedi_pcimio. How do I build it and where can I
> > find it ? It seems not to be in xenomai 2.5-rc3.
>
> You are right, the driver was not available in 2.5-rc3.
>
> I will downlaod
> > xenomai-abe.git and see what I get.
> >
> >>> the driver name is comedi_pcimio instead of ni_pcimio. So you should
> type
> >>> comedi_config comedi0 comedi_pcimio.
> > So, the comedi_pcimio is the driver I'll need ?
>
> If, with the original Comedi framework, you used ni_pcimio, then
> comedi_pcimio is what you need  with Comedi/RTDM.
>
>  Is the no National
> > Instrument specific driver ?? (ni_pcimio) ??
>
> Sorry I don't understand the question. "no National Instrument" ?
>
> The "pcimio" driver supports a host of NI PCI boards:
>  * Devices: [National Instruments] PCI-MIO-16XE-50 (ni_pcimio),
>  * PCI-MIO-16XE-10, PXI-6030E, PCI-MIO-16E-1, PCI-MIO-16E-4, PCI-6014,
>  * PCI-6040E,PXI-6040E, PCI-6030E, PCI-6031E, PCI-6032E, PCI-6033E,
>  * PCI-6071E, PCI-6023E, PCI-6024E, PCI-6025E, PXI-6025E, PCI-6034E,
>  * PCI-6035E, PCI-6052E, PCI-6110, PCI-6111, PCI-6220, PCI-6221,
>  * PCI-6224, PCI-6225, PCI-6229, PCI-6250, PCI-6251, PCIe-6251,
>  * PCI-6254, PCI-6259, PCIe-6259, PCI-6280, PCI-6281, PXI-6281,
>  * PCI-6284, PCI-6289, PCI-6711, PXI-6711, PCI-6713, PXI-6713,
>  * PXI-6071E, PCI-6070E, PXI-6070E, PXI-6052E, PCI-6036E, PCI-6731,
>  * PCI-6733, PXI-6733, PCI-6143, PXI-6143
>
> Alexis.
>

--0016e6470aac30bf480476149ba8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hey Alexis,<br><br>Thanks for your response !!<br><br>&gt;&gt; Yes take the=
 abe repository, please. I will make a pull request soon.<br>I downloaded t=
he git xenomai-abe repository and installed linux-2.6.29.1 (since there was=
 no patch for 2.6.30.5).<br>
<br>The installation worked out, however, it seems that the comedi_pcimio d=
river is not included.<br>Am I missing something during configuring the ker=
nel ??<br><br>From what I understand now is that I need xeno_comedi.ko whic=
h is the interface to xenomai and RTDM and I need comedi_pcimio.ko which ac=
tually talks to the hardware and does real-time capable I/O. Is this correc=
t ??<br>
<br>Thanks a lot, I am really glad that I am getting somewhere !!<br><br>=
=A0peter<br><br><br><br><div class=3D"gmail_quote">On Fri, Oct 16, 2009 at =
2:06 PM, Alexis Berlemont <span dir=3D"ltr">&lt;<a href=3D"mailto:berlemont=
.hauw@domain.hid">berlemont.hauw@domain.hid</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi,<br>
<div><div></div><div class=3D"h5"><br>
On Fri, Oct 16, 2009 at 7:16 PM, Peter Pastor &lt;<a href=3D"mailto:peter.p=
astor@domain.hid">peter.pastor@domain.hid</a>&gt; wrote:<br>
&gt; Hey Alexis,<br>
&gt;<br>
&gt; Thanks a lot for your quick response.<br>
&gt;<br>
&gt;&gt;&gt; Is rt_comedi_test an application you developed ?<br>
&gt; Yes, it is my little test application, which is kept simple (open, rea=
d,<br>
&gt; close).<br>
&gt;<br>
&gt;&gt;&gt; I think you should follow the common comedi way:<br>
&gt;&gt;&gt; 1) Check you have the suitable driver loaded:<br>
&gt; xenomai:/proc/xenomai/rtdm&gt; cat /proc/comedi/drivers<br>
&gt; --=A0 Comedi drivers --<br>
&gt;<br>
&gt; | idx | driver name<br>
&gt; |=A0 00 | ni_pcimio<br>
&gt;<br>
&gt;&gt;&gt; 2) Check the comedi RTDM devices available:<br>
&gt; xenomai:/proc/xenomai/rtdm&gt; cat /proc/xenomai/rtdm/named_devices<br=
>
&gt; Hash=A0=A0=A0 Name=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 Driver=A0=A0=
=A0 =A0=A0=A0 /proc<br>
&gt; A1=A0=A0=A0 comedi0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 =A0=A0=A0 rtdm_comedi=A0=A0=A0 =A0=A0=A0 comedi0<br>
&gt; A2=A0=A0=A0 comedi1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 =A0=A0=A0 rtdm_comedi=A0=A0=A0 =A0=A0=A0 comedi1<br>
&gt; A3=A0=A0=A0 comedi2=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 =A0=A0=A0 rtdm_comedi=A0=A0=A0 =A0=A0=A0 comedi2<br>
&gt; A4=A0=A0=A0 comedi3=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 =A0=A0=A0 rtdm_comedi=A0=A0=A0 =A0=A0=A0 comedi3<br>
&gt; A5=A0=A0=A0 comedi4=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 =A0=A0=A0 rtdm_comedi=A0=A0=A0 =A0=A0=A0 comedi4<br>
&gt; A6=A0=A0=A0 comedi5=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 =A0=A0=A0 rtdm_comedi=A0=A0=A0 =A0=A0=A0 comedi5<br>
&gt; A7=A0=A0=A0 comedi6=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 =A0=A0=A0 rtdm_comedi=A0=A0=A0 =A0=A0=A0 comedi6<br>
&gt; A8=A0=A0=A0 comedi7=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 =A0=A0=A0 rtdm_comedi=A0=A0=A0 =A0=A0=A0 comedi7<br>
&gt; A9=A0=A0=A0 comedi8=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 =A0=A0=A0 rtdm_comedi=A0=A0=A0 =A0=A0=A0 comedi8<br>
&gt; AA=A0=A0=A0 comedi9=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 =A0=A0=A0 rtdm_comedi=A0=A0=A0 =A0=A0=A0 comedi9<br>
&gt;<br>
&gt;&gt;&gt; 3) =A0You have to attach the driver to the rtdm device you wan=
t to use<br>
&gt;&gt;&gt; with comedi_config (a tool available in Xenomai).<br>
&gt;&gt;&gt; #comedi_config comedi0 comedi_pcimio<br>
&gt;&gt;&gt;=A0 =A0 That command will assign comedi_pcimio driver to comedi=
0<br>
&gt; root@domain.hid# ./comedi_config comedi0 comedi_pcimio<=
br>
&gt; comedi_config: comedi_snd_attach failed ret=3D-22<br>
&gt; root@domain.hid# ./comedi_config comedi0 ni_pcimio<br>
&gt; comedi_config: comedi_snd_attach failed ret=3D-5<br>
&gt;<br>
&gt;&gt;&gt; 4) Eventually, you can test the acquistion is working with som=
e test tool<br>
&gt;&gt;&gt; of ours :cmd_read<br>
&gt;&gt;&gt; # /usr/local/bin/cmd_read -v<br>
&gt; I don&#39;t find this test tool. How do I install it ?<br>
&gt;<br>
&gt;<br>
&gt;&gt;&gt; SVN is not our version control system anymore. You should use =
our git<br>
&gt;&gt;&gt; repository.<br>
&gt;&gt;&gt; If you want the last fix I made, take my comedi branch.<br>
&gt;&gt;&gt; Have a look at:<br>
&gt;&gt;&gt; <a href=3D"http://git.xenomai.org/?p=3Dxenomai-abe.git;a=3Dsho=
rtlog;h=3Drefs/heads/comedi" target=3D"_blank">http://git.xenomai.org/?p=3D=
xenomai-abe.git;a=3Dshortlog;h=3Drefs/heads/comedi</a><br>
&gt;<br>
&gt; I actually started to download using git, but it was unbelievable slow=
 :(<br>
&gt; (11Kbit/s). Is there a difference between HEAD and ABE that does matte=
r to<br>
&gt; me ?<br>
<br>
</div></div>Yes take the abe repository, please. I will make a pull request=
 soon.<br>
<br>
Concerning the bitrate, I did not manage to reproduce your low bandwidth:<b=
r>
Receiving objects: =A0 6% (3661/57181), 780.00 KiB | 94 KiB/s<br>
<div class=3D"im"><br>
&gt; Apparently, I don&#39;t have comedi_pcimio. How do I build it and wher=
e can I<br>
&gt; find it ? It seems not to be in xenomai 2.5-rc3.<br>
<br>
</div>You are right, the driver was not available in 2.5-rc3.<br>
<div class=3D"im"><br>
I will downlaod<br>
&gt; xenomai-abe.git and see what I get.<br>
&gt;<br>
&gt;&gt;&gt; the driver name is comedi_pcimio instead of ni_pcimio. So you =
should type<br>
&gt;&gt;&gt; comedi_config comedi0 comedi_pcimio.<br>
&gt; So, the comedi_pcimio is the driver I&#39;ll need ?<br>
<br>
</div>If, with the original Comedi framework, you used ni_pcimio, then<br>
comedi_pcimio is what you need =A0with Comedi/RTDM.<br>
<div class=3D"im"><br>
=A0Is the no National<br>
&gt; Instrument specific driver ?? (ni_pcimio) ??<br>
<br>
</div>Sorry I don&#39;t understand the question. &quot;no National Instrume=
nt&quot; ?<br>
<br>
The &quot;pcimio&quot; driver supports a host of NI PCI boards:<br>
=A0* Devices: [National Instruments] PCI-MIO-16XE-50 (ni_pcimio),<br>
=A0* PCI-MIO-16XE-10, PXI-6030E, PCI-MIO-16E-1, PCI-MIO-16E-4, PCI-6014,<br=
>
=A0* PCI-6040E,PXI-6040E, PCI-6030E, PCI-6031E, PCI-6032E, PCI-6033E,<br>
=A0* PCI-6071E, PCI-6023E, PCI-6024E, PCI-6025E, PXI-6025E, PCI-6034E,<br>
=A0* PCI-6035E, PCI-6052E, PCI-6110, PCI-6111, PCI-6220, PCI-6221,<br>
=A0* PCI-6224, PCI-6225, PCI-6229, PCI-6250, PCI-6251, PCIe-6251,<br>
=A0* PCI-6254, PCI-6259, PCIe-6259, PCI-6280, PCI-6281, PXI-6281,<br>
=A0* PCI-6284, PCI-6289, PCI-6711, PXI-6711, PCI-6713, PXI-6713,<br>
=A0* PXI-6071E, PCI-6070E, PXI-6070E, PXI-6052E, PCI-6036E, PCI-6731,<br>
=A0* PCI-6733, PXI-6733, PCI-6143, PXI-6143<br>
<font color=3D"#888888"><br>
Alexis.<br>
</font></blockquote></div><br>

--0016e6470aac30bf480476149ba8--

