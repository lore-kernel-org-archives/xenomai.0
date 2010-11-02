MIME-Version: 1.0
In-Reply-To: <4CD00450.6020100@domain.hid>
References: <AANLkTinN+KBK2B77opSCwDvb9bneObxL1+FTmmwpQGup@domain.hid>
	<4CC20AD2.4060501@domain.hid>
	<AANLkTi=W0w277PctkebaC=BcTLNZeW3KMzPzp=X1isB=@mail.gmail.com>
	<4CC665AC.5030802@domain.hid>
	<AANLkTi=5YF3QnvK9iGpBs8enuA+=MHz7gKjE1p_3whM+@mail.gmail.com>
	<4CD00450.6020100@domain.hid>
Date: Tue, 2 Nov 2010 08:24:39 -0700
Message-ID: <AANLkTikFiNw5HcDJsnbVsER9xjvPWAm5dBbZM9uiRh6x@domain.hid>
From: Peter Pastor <peter.pastor@domain.hid>
Content-Type: multipart/alternative; boundary=20cf300fb2cdf5a83d049413852a
Subject: Re: [Xenomai-help] Slow hard drive access in xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

--20cf300fb2cdf5a83d049413852a
Content-Type: text/plain; charset=ISO-8859-1

Hey Gilles,

I do understand the intention of why I should disable either of the two (usb
controller and SATA drives), however, what I meant is, I need both
"permanently". If I disable all the usb ports, then I only have access over
ethernet (ssh), since the keyboard is attached to the computer through usb
(there are no other options). Also, to the best of my knowledge, disabling
means disabling them in the BIOS, correct? If so, I do not see how I could
enable the usb controller again... Are there other ways to do that. If not,
please let me know how to do it. The other option, disabling the SATA drives
does not make sense either, since I need them to boot the kernel, do I ?

Anyway, I added the kernel parameter "irqpooll" as suggested by the error
msg in the kernel log... and since then I haven't seen the problem occurring
again. The documentation says that I will loose some performance and I am
wondering how much that is. However, I am willing to debug this further and
to remove the irqpoll option again.

Thanks a lot.
 peter

On Tue, Nov 2, 2010 at 5:30 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Peter Pastor wrote:
> > I would like to switch of either of the two devices that are attached to
> IRQ
> > 16, the problem however is, I need both.
>
> The idea was to disable each one in turn to see which one is faulty. Not
> disable them permanently.
>
>
> --
>                                                                 Gilles.
>

--20cf300fb2cdf5a83d049413852a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hey Gilles,<br><br>I do understand the intention of why I should disable ei=
ther of the two (usb controller and SATA drives), however, what I meant is,=
 I need both &quot;permanently&quot;. If I disable all the usb ports, then =
I only have access over ethernet (ssh), since the keyboard is attached to t=
he computer through usb (there are no other options). Also, to the best of =
my knowledge, disabling means disabling them in the BIOS, correct? If so, I=
 do not see how I could enable the usb controller again... Are there other =
ways to do that. If not, please let me know how to do it. The other option,=
 disabling the SATA drives does not make sense either, since I need them to=
 boot the kernel, do I ?<br>
<br>Anyway, I added the kernel parameter &quot;irqpooll&quot; as suggested =
by the error msg in the kernel log... and since then I haven&#39;t seen the=
 problem occurring again. The documentation says that I will loose some per=
formance and I am wondering how much that is. However, I am willing to debu=
g this further and to remove the irqpoll option again.<br>
<br>Thanks a lot.<br>=A0peter<br><br><div class=3D"gmail_quote">On Tue, Nov=
 2, 2010 at 5:30 AM, Gilles Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"=
mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</=
a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><div class=3D"im"=
>Peter Pastor wrote:<br>
&gt; I would like to switch of either of the two devices that are attached =
to IRQ<br>
&gt; 16, the problem however is, I need both.<br>
<br>
</div>The idea was to disable each one in turn to see which one is faulty. =
Not<br>
disable them permanently.<br>
<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0Gilles.<br>
</font></blockquote></div><br>

--20cf300fb2cdf5a83d049413852a--

