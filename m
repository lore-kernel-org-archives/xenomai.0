MIME-Version: 1.0
In-Reply-To: <E2CAE7F7B064EA49B5CE7EE9A4BB167D14FD2A1992@domain.hid>
References: <76E258664B189C4CBEF125491CA11ECC9458403922@domain.hid>
	<76E258664B189C4CBEF125491CA11ECC9458403925@domain.hid>
	<1281597159.1730.71.camel@domain.hid>
	<E2CAE7F7B064EA49B5CE7EE9A4BB167D14FD14F757@domain.hid>
	<4C642F04.4020008@domain.hid>
	<E2CAE7F7B064EA49B5CE7EE9A4BB167D14FD065786@domain.hid>
	<4C651A5D.9030101@domain.hid>
	<E2CAE7F7B064EA49B5CE7EE9A4BB167D14FD065788@domain.hid>
	<E2CAE7F7B064EA49B5CE7EE9A4BB167D14FD065789@domain.hid>
	<4C695C36.1030308@domain.hid>
	<E2CAE7F7B064EA49B5CE7EE9A4BB167D14FD2A1992@domain.hid>
Date: Tue, 17 Aug 2010 09:39:22 +0530
Message-ID: <AANLkTingp952EJiZk38P_hywNyKB9333mr1Cs4ctpQcc@domain.hid>
From: Prakash A S <asprakash83@domain.hid>
Content-Type: multipart/alternative; boundary=001636c5b15b3125cf048dfd1d0a
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

--001636c5b15b3125cf048dfd1d0a
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Aug 16, 2010 at 9:38 PM, Hemal C.Bavishi <
Hemal.Bavishi@domain.hid> wrote:

> Dear Stefan,
>
> The behavior was quite peculiar and it has nothing to do with the "building
> debian packages howto". However, it would be good if you specify these steps
> into howto under building debian packages for smooth installation for new
> comers:)
>
> Nevertheless, I resolved this issue by explicitly calling the
> update-initramfs -c -k with the image name. I was bit surprised with the
> behavior but it worked for me.
>
> However, I am still facing the problem of hang up issue at boot(blank
> screen which other users also has reported) some time (it generally boots
> after every 3/4 starts). I don't know what's an issue but I observed this
> behavior in 4 different system. Do you have any solution for this issue? Do
> I have to build xenomai with the newer kernel version 2.6.32.34? Would that
> solve current issue?
>

Try to pass (without quote) "noapic nolapic" in kernel boot option and
please update the scenario.

-Prakash

--001636c5b15b3125cf048dfd1d0a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Mon, Aug 16, 2010 at 9:38 PM, Hemal C=
.Bavishi <span dir=3D"ltr">&lt;<a href=3D"mailto:Hemal.Bavishi@domain.hid.=
com">Hemal.Bavishi@domain.hid</a>&gt;</span> wrote:<br><blockquote cla=
ss=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); marg=
in: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Dear Stefan,<br>
<br>
The behavior was quite peculiar and it has nothing to do with the &quot;bui=
lding debian packages howto&quot;. However, it would be good if you specify=
 these steps into howto under building debian packages for smooth installat=
ion for new comers:)<br>

<br>
Nevertheless, I resolved this issue by explicitly calling the update-initra=
mfs -c -k with the image name. I was bit surprised with the behavior but it=
 worked for me.<br>
<br>
However, I am still facing the problem of hang up issue at boot(blank scree=
n which other users also has reported) some time (it generally boots after =
every 3/4 starts). I don&#39;t know what&#39;s an issue but I observed this=
 behavior in 4 different system. Do you have any solution for this issue? D=
o I have to build xenomai with the newer kernel version 2.6.32.34? Would th=
at solve current issue?<br>
</blockquote><div><br></div></div>Try to pass (without quote) &quot;noapic =
nolapic&quot; in kernel boot option and please update the scenario.<br><br>=
-Prakash<br>

--001636c5b15b3125cf048dfd1d0a--

