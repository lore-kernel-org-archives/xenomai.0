MIME-Version: 1.0
In-Reply-To: <CAPRPZsAmv9eRQOj-ocKMwjKzEuzbQU+XKr6iAPwvPM9QRXZACQ@mail.gmail.com>
References: <CAPRPZsCOSWYjHqGv0L+9ip+wkegMiV3GJBsGWtRjV2W=BsdOQw@domain.hid>
	<4E63CCFD.4090800@domain.hid>
	<CAPRPZsAmv9eRQOj-ocKMwjKzEuzbQU+XKr6iAPwvPM9QRXZACQ@mail.gmail.com>
Date: Sun, 4 Sep 2011 21:37:45 +0200
Message-ID: <CAPRPZsDxcF+xiX2wEAxbTdRSCuy7H8_KHdGJ7hFNXFDrvfmHBw@domain.hid>
From: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec51dd1cb8874e304ac22ba6b
Subject: Re: [Xenomai-help] Build issue Linux kernel 2.6.38.8 - Xenomai 2.5.6
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

--bcaec51dd1cb8874e304ac22ba6b
Content-Type: text/plain; charset=ISO-8859-1

>
>
>
> You need to compile with -fno-omit-frame-pointer, that is precisely the
> contrary of -fomit-frame-pointer
>
>
Indeed I had to, thank you very much. So for sake of completeness:

Variant 4 (works):
- ./configure --enable-x86-sep --enable-smp CFLAGS="-m32 -O2
-fno-omit-frame-pointer" LDFLAGS="-m32"

Still not fully understanding what I'm doing here, but going to look up the
effects pf 'omit-frame-pointer'.

Thanks again,


> --
>                                                                Gilles.
>

--bcaec51dd1cb8874e304ac22ba6b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">
<div class=3D"gmail_quote">
<div class=3D"im">
<blockquote style=3D"BORDER-LEFT: #ccc 1px solid; MARGIN: 0px 0px 0px 0.8ex=
; PADDING-LEFT: 1ex" class=3D"gmail_quote">
<div><br>=A0</div>You need to compile with -fno-omit-frame-pointer, that is=
 precisely the<br>contrary of -fomit-frame-pointer<br><br></blockquote>
<div>=A0</div></div>
<div>Indeed I had to, thank you=A0very much. So for sake of completeness:</=
div>
<div>=A0</div>
<div>Variant 4 (works):</div>
<div>- ./configure --enable-x86-sep --enable-smp CFLAGS=3D&quot;-m32 -O2 -f=
no-omit-frame-pointer&quot; LDFLAGS=3D&quot;-m32&quot;</div>
<div>=A0</div>
<div>Still not fully understanding what I&#39;m doing here, but going to lo=
ok up the effects pf &#39;omit-frame-pointer&#39;.</div>
<div>=A0</div>
<div>Thanks again,</div>
<div>=A0</div>
<blockquote style=3D"BORDER-LEFT: #ccc 1px solid; MARGIN: 0px 0px 0px 0.8ex=
; PADDING-LEFT: 1ex" class=3D"gmail_quote">--<br><font color=3D"#888888">=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br></font></blo=
ckquote>
</div><br></div><br>

--bcaec51dd1cb8874e304ac22ba6b--

