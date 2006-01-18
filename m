Message-ID: <fd6a47a90601181417x79837d34h@domain.hid>
Date: Wed, 18 Jan 2006 23:17:09 +0100
From: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Subject: Re: [Xenomai-core] Scheduling while atomic
In-Reply-To: <fd6a47a90601181334y14b06d6an@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_6203_32217840.1137622629396"
References: <fd6a47a90601181204g4c86f778x@domain.hid>
	<43CEA323.7000701@domain.hid> <43CEAF25.6010705@domain.hid>
	<43CEB291.4020609@domain.hid>
	<fd6a47a90601181334y14b06d6an@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Hannes Mayer <h.mayer@domain.hid>, xenomai@xenomai.org

------=_Part_6203_32217840.1137622629396
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

When testing, also check the dmesg logs please. When nucleus debugging is
off, you get only a kernel warning 'scheduling while atomic'.

- Could you replace MAXLONG on line 119 with TM_INFINITE and rerun the sem
test (to avoid printf'ing) You can terminate with Ctrl+C.

> - Could you try to run with tmax somewhat lower (to increase the load):
> e.g. ./sem 5.0e6 or so. Be careful not to starve Linux. I think 1.0e5 wil=
l
> be too low.
>
> Crashes with me happen within the first 10 secs with 1.0e7
>
> Thanks,
>
> Jeroen.
>
>

------=_Part_6203_32217840.1137622629396
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>When testing, also check the dmesg logs please. When nucleus debugging=
 is off, you get only a kernel warning 'scheduling while atomic'.</div>
<div><br>- Could you replace MAXLONG on line 119 with TM_INFINITE and rerun=
 the sem test (to avoid printf'ing) You can terminate with Ctrl+C.</div>
<div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>- Could you try to run with tmax somewhat lower (to increase the load)=
: e.g. ./sem 5.0e6 or so. Be careful not&nbsp;to starve Linux. I think 1.0e=
5 will be too low.<br>&nbsp;</div>
<div>Crashes with me happen within the first 10 secs with 1.0e7</div>
<div>&nbsp;</div>
<div>Thanks,</div><span class=3D"sg">
<div>&nbsp;</div>
<div>Jeroen.</div>
<div>&nbsp;</div></span></blockquote></div>

------=_Part_6203_32217840.1137622629396--

