Message-ID: <fd6a47a90601312330x2f80b7ak@domain.hid>
Date: Wed, 1 Feb 2006 08:30:25 +0100
From: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Subject: Re: [Xenomai-help] Dual Xeon 2.6.13 SMP config problem
In-Reply-To: <43E006C2.50503@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_663_9528542.1138779025425"
References: <200601251105.k0PB5uPK028509@domain.hid>
	<43D7CD2F.9030709@domain.hid> <43DE0955.7060608@domain.hid>
	<43E006C2.50503@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Nathaniel Villaume <villaume@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_663_9528542.1138779025425
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

>
> My distro is FC3 with linux-2.6.9. I'm trying to get the SMP version of
> 2.6.13 running with Xenomai.


Why not use 2.6.15 immediately ?


> Test #2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> I used the single CPU kernel config to build the adeos-patched 2.6.13
> kernel.  This boots and xeno latency runs fine. I had  a problem with
> `make devices` not making the devices, but I moved on to getting the SMP
> working.
> If I switch to SMP in the kernel config, the machine doesn't boot.
> Instead, it complains: "mount: error 6 mounting ext3".
> I checked that the ext3 is being compiled as a module.... I literally
> only change the SMP option.


Are there any other errors before that one ?

Jeroen.

------=_Part_663_9528542.1138779025425
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">My distro is FC3 with linux-2.6.=
9. I'm trying to get the SMP version of<br>2.6.13 running with Xenomai.</bl=
ockquote>

<div>&nbsp;</div>
<div>Why not use 2.6.15 immediately ?</div>
<div>&nbsp;</div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Test #2<br>=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<br>I used the single CPU kernel config to build the adeos-patched=
 2.6.13<br>kernel.&nbsp;&nbsp;This boots and xeno latency runs fine. I had&=
nbsp;&nbsp;a problem with
<br>`make devices` not making the devices, but I moved on to getting the SM=
P<br>working.<br>If I switch to SMP in the kernel config, the machine doesn=
't boot.<br>Instead, it complains: &quot;mount: error 6 mounting ext3&quot;=
.
<br>I checked that the ext3 is being compiled as a module.... I literally<b=
r>only change the SMP option.</blockquote>
<div>&nbsp;</div>
<div>Are there any other errors before that one ?</div>
<div>&nbsp;</div>
<div>Jeroen.</div></div>

------=_Part_663_9528542.1138779025425--

