MIME-Version: 1.0
In-Reply-To: <CAHifFDNw2K4oeJALuT9QY2FGURy1ME1tAK2S8dFmyiHwx9QkpQ@mail.gmail.com>
References: <CAHifFDNw2K4oeJALuT9QY2FGURy1ME1tAK2S8dFmyiHwx9QkpQ@mail.gmail.com>
Date: Mon, 5 Sep 2011 00:42:38 +0400
Message-ID: <CAHifFDM5POqB_2V4n97DXzE5LhZBSNNdOfkB8RrS8E0Go8VT2w@domain.hid>
From: Said Syakin <dias.be.ok@domain.hid>
Content-Type: multipart/alternative; boundary=000e0cd5d0409b385904ac23a2f5
Subject: [Xenomai-help] xenomai and iMX28 freescale processor
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--000e0cd5d0409b385904ac23a2f5
Content-Type: text/plain; charset=ISO-8859-1

Dear all,


 I want to know if xenomai has any support for iMX28 freescale processor? If
not - what should I do to add it?

I try to compile the xenomai-patched kernel 2.6.35.3 with xenomai-2.5.6 and
adeos-ipipe-2.6.35.9-arm-1.18-03.patch from the xenomai git repository.
During building uImage I got errors:

In file included from

/home/dias/work/kernels/linux-2.6.35.3-imx287/kernel/xenomai/arch/generic/hal.c:47:

/home/dias/work/kernels/linux-2.6.35.3-imx287/arch/arm/include/asm/xenomai/hal.h:77:

error: #error "Unsupported ARM machine"


 Best regards.

--000e0cd5d0409b385904ac23a2f5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote"><p style=3D"margin-top:0px;margin-bottom:0px;mar=
gin-left:0px;margin-right:0px;text-indent:0px">Dear all,</p><p style=3D"mar=
gin-top:0px;margin-bottom:0px;margin-left:0px;margin-right:0px;text-indent:=
0px">

<br></p>
<p style=3D"margin-top:0px;margin-bottom:0px;margin-left:0px;margin-right:0=
px;text-indent:0px"></p>
<p style=3D"margin-top:0px;margin-bottom:0px;margin-left:0px;margin-right:0=
px;text-indent:0px">I want to know if xenomai has any support for iMX28 fre=
escale processor? If not - what should I do to add it?</p>

<p style=3D"margin-top:0px;margin-bottom:0px;margin-left:0px;margin-right:0=
px;text-indent:0px"></p>
<p style=3D"margin-top:0px;margin-bottom:0px;margin-left:0px;margin-right:0=
px;text-indent:0px">I try to compile the xenomai-patched kernel 2.6.35.3 wi=
th xenomai-2.5.6 and adeos-ipipe-2.6.35.9-arm-1.18-03.patch from the xenoma=
i git repository. During  building uImage I got errors:</p>


<p style=3D"margin-top:0px;margin-bottom:0px;margin-left:0px;margin-right:0=
px;text-indent:0px"></p>
<p style=3D"margin-top:0px;margin-bottom:0px;margin-left:0px;margin-right:0=
px;text-indent:0px">In file included from</p>
<p style=3D"margin-top:0px;margin-bottom:0px;margin-left:0px;margin-right:0=
px;text-indent:0px">/home/dias/work/kernels/linux-2.6.35.3-imx287/kernel/xe=
nomai/arch/generic/hal.c:47:</p>

<p style=3D"margin-top:0px;margin-bottom:0px;margin-left:0px;margin-right:0=
px;text-indent:0px">/home/dias/work/kernels/linux-2.6.35.3-imx287/arch/arm/=
include/asm/xenomai/hal.h:77:</p>

<p style=3D"margin-top:0px;margin-bottom:0px;margin-left:0px;margin-right:0=
px;text-indent:0px">error: #error &quot;Unsupported ARM machine&quot;</p><p=
 style=3D"margin-top:0px;margin-bottom:0px;margin-left:0px;margin-right:0px=
;text-indent:0px">

<br></p>
<p style=3D"margin-top:0px;margin-bottom:0px;margin-left:0px;margin-right:0=
px;text-indent:0px"></p>
<p style=3D"margin-top:0px;margin-bottom:0px;margin-left:0px;margin-right:0=
px;text-indent:0px">Best regards.</p>
</div><br>

--000e0cd5d0409b385904ac23a2f5--

