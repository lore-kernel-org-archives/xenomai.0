MIME-Version: 1.0
In-Reply-To: <4C061EC8.3010507@domain.hid>
References: <AANLkTikm9draDOStz8YfJCxtWb14pvMMfXjpMItjE8mu@domain.hid>
	<4C061EC8.3010507@domain.hid>
Date: Thu, 3 Jun 2010 10:31:23 +0200
Message-ID: <AANLkTilKrKpEiddPFMkRwZmxdF1sl8HBOtTUeLE09qlI@mail.gmail.com>
From: Divi Oillo <divi.oillo@domain.hid>
Content-Type: multipart/alternative; boundary=0016e6dbde301b269404881c0849
Subject: Re: [Xenomai-help] Dating problem with the trivial-periodic example
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--0016e6dbde301b269404881c0849
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I have modified my .config file and it looks good!
I have avoided this following kernel settings:

   - CONFIG_CPU_FREQ (CPU Frequency Scaling)
   - CONFIG_INPUT_PCSPKR (PC Speaker Support)
   - CONFIG_ACPI_PROCESSOR (Processor)
   - CONFIG_APM (Advanced Power Management and ACPI options)

And enabled:

   - CONFIG_XENO_HW_SMI_ALL (Globally disable SMI)

See this link : http://www.xenomai.org/index.php/FAQs

Regards.

Divi.

2010/6/2 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> Divi Oillo wrote:
> >
> > Hi all,
> >
> > I'm trying to install Xenomai-2.5.3 with Linux 2.6.31.12 on my PC
> > (Pentium M Dell Latitude 810).
> > First, I have disabled ACPI Processor.
> > When I run the test examples/native/trivial-periodic.c. => OK
> > When I stress with : "stress --cpu 1 --io 4 --vm 2 --vm-bytes 128M
> > --timeout 10s" => I have 1.25s between each rt_task_wait_period(NULL);
> >
> > Then , I have enabled ACPI Processor (Here is my .config).
> > Kernel arg : idle=poll
> > When I run the test examples/native/trivial-periodic.c. => I'm not sure
> > but it seems that each time fans run the time between each wait is 1.25s.
> >
> > What could I be doing wrong here? please help.
>
> Normally, when enabling ACPI Processor, you should get a message in
> Kconfig telling you that this option should not be enabled with Xenomai.
> So, do not enable it.
>
> --
>                                             Gilles.
>

--0016e6dbde301b269404881c0849
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I have modified my .config file and it looks good!<br>I have avo=
ided this following kernel settings:<br><ul><li>CONFIG_CPU_FREQ (CPU Freque=
ncy Scaling)<br></li><li>CONFIG_INPUT_PCSPKR (PC Speaker Support)<br></li>
<li>CONFIG_ACPI_PROCESSOR (Processor)</li><li>CONFIG_APM (Advanced Power Ma=
nagement and ACPI options)</li></ul>And enabled:<br><ul><li>CONFIG_XENO_HW_=
SMI_ALL (Globally disable SMI)</li></ul>See this link : <a href=3D"http://w=
ww.xenomai.org/index.php/FAQs">http://www.xenomai.org/index.php/FAQs</a><br=
>
<br>Regards.<br><br>Divi.<br><br><div class=3D"gmail_quote">2010/6/2 Gilles=
 Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix=
@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span><br><blockquot=
e class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1p=
x solid rgb(204, 204, 204); padding-left: 1ex;">
<div><div></div><div class=3D"h5">Divi Oillo wrote:<br>
&gt;<br>
&gt; Hi all,<br>
&gt;<br>
&gt; I&#39;m trying to install Xenomai-2.5.3 with Linux 2.6.31.12 on my PC<=
br>
&gt; (Pentium M Dell Latitude 810).<br>
&gt; First, I have disabled ACPI Processor.<br>
&gt; When I run the test examples/native/trivial-periodic.c. =3D&gt; OK<br>
&gt; When I stress with : &quot;stress --cpu 1 --io 4 --vm 2 --vm-bytes 128=
M<br>
&gt; --timeout 10s&quot; =3D&gt; I have 1.25s between each rt_task_wait_per=
iod(NULL);<br>
&gt;<br>
&gt; Then , I have enabled ACPI Processor (Here is my .config).<br>
&gt; Kernel arg : idle=3Dpoll<br>
&gt; When I run the test examples/native/trivial-periodic.c. =3D&gt; I&#39;=
m not sure<br>
&gt; but it seems that each time fans run the time between each wait is 1.2=
5s.<br>
&gt;<br>
&gt; What could I be doing wrong here? please help.<br>
<br>
</div></div>Normally, when enabling ACPI Processor, you should get a messag=
e in<br>
Kconfig telling you that this option should not be enabled with Xenomai.<br=
>
So, do not enable it.<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br>

--0016e6dbde301b269404881c0849--

