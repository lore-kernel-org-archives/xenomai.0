Message-ID: <BLU166-W26172D3A52D00FCD9AA3C8C49F0@domain.hid>
Content-Type: multipart/alternative;
	boundary="_4cbe8604-7456-4678-a5b5-e6c3eb269809_"
From: Jan-Erik Lange <jan0385@domain.hid>
Date: Thu, 12 Jan 2012 14:36:21 +0100
In-Reply-To: <BLU166-W11229BDE02887632739145C49E0@domain.hid>
References: <BLU166-W4379BD842C749BADC78DE7C49E0@domain.hid>,
	<4F0DDCFD.3070902@domain.hid>,
	<BLU166-W11229BDE02887632739145C49E0@domain.hid>
MIME-Version: 1.0
Subject: [Xenomai-core] FW:  Question about context switching
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--_4cbe8604-7456-4678-a5b5-e6c3eb269809_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



=20



> Date: Wed=2C 11 Jan 2012 20:03:25 +0100
> From: gilles.chanteperdrix@xenomai.org
> To: jan0385@domain.hid
> CC: xenomai@xenomai.org
> Subject: Re: [Xenomai-core] Question about context switching
>=20
> On 01/11/2012 07:12 PM=2C Jan-Erik Lange wrote:
> >=20
> > Hello=2C
> >=20
> > I have a question about the context switching:
> >=20
> > Unless that there a rtdm_copy_to_user() available in the rtdm API.
> > Would cause the function copy_to_user() in an xenomai kernel based rt
> > task a switch into the secondary domain? Because copy_to_user() not
> > actually a syscall right?
>=20
> Absolutely no function in kernel-space causes an automatic switch to
> secondary mode. As Philippe answered to the very first mail you posted
> to this list=2C the only events which cause a switch to secondary mode ar=
e:
>=20
> - invoking a regular linux syscall
> - receiving a linux signal (e.g. kill(2) and GDB)
> - causing a CPU trap (e.g. invalid memory access)=2C hitting a breakpoint
> (e.g. GDB)
>=20
> All these events only happen for threads in user-space.

Sorry I'm new in Xenomai.

But is it generaly possible that the xenomai kernel-space task can interact=
 with a common Linux task over this way? I mean is it possible to get data =
with the standard copy_to_user()-function from the Xenomai kernel-space int=
o the Linux user space? Aren't the adress spaces strictly seperated and you=
 have to need the rt-pipe service to interact between the xenomai kernel sp=
ace and the linux userspace?

>=20
> --=20
> Gilles.
 		 	   		  =

--_4cbe8604-7456-4678-a5b5-e6c3eb269809_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Tahoma
}
--></style></head>
<body class=3D'hmmessage'><div dir=3D'ltr'>
<BR>&nbsp=3B<BR>
<DIV>
<DIV dir=3Dltr>
<DIV>
<DIV id=3DecxSkyDrivePlaceholder></DIV>&gt=3B Date: Wed=2C 11 Jan 2012 20:0=
3:25 +0100<BR>&gt=3B From: gilles.chanteperdrix@xenomai.org<BR>&gt=3B To: j=
an0385@domain.hid<BR>&gt=3B CC: xenomai@xenomai.org<BR>&gt=3B Subject: Re:=
 [Xenomai-core] Question about context switching<BR>&gt=3B <BR>&gt=3B On 01=
/11/2012 07:12 PM=2C Jan-Erik Lange wrote:<BR>&gt=3B &gt=3B <BR>&gt=3B &gt=
=3B Hello=2C<BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B I have a question about the=
 context switching:<BR>&gt=3B &gt=3B <BR>&gt=3B &gt=3B Unless that there a =
rtdm_copy_to_user() available in the rtdm API.<BR>&gt=3B &gt=3B Would cause=
 the function copy_to_user() in an xenomai kernel based rt<BR>&gt=3B &gt=3B=
 task a switch into the secondary domain? Because copy_to_user() not<BR>&gt=
=3B &gt=3B actually a syscall right?<BR>&gt=3B <BR>&gt=3B Absolutely no fun=
ction in kernel-space causes an automatic switch to<BR>&gt=3B secondary mod=
e. As Philippe answered to the very first mail you posted<BR>&gt=3B to this=
 list=2C the only events which cause a switch to secondary mode are:<BR>&gt=
=3B <BR>&gt=3B - invoking a regular linux syscall<BR>&gt=3B - receiving a l=
inux signal (e.g. kill(2) and GDB)<BR>&gt=3B - causing a CPU trap (e.g. inv=
alid memory access)=2C hitting a breakpoint<BR>&gt=3B (e.g. GDB)<BR>&gt=3B =
<BR>&gt=3B All these events only happen for threads in user-space.<BR><BR>S=
orry I'm new in Xenomai.<BR><BR>But is it generaly possible that the xenoma=
i kernel-space task can interact with a common Linux task over this way? I =
mean is it possible to get data with the standard copy_to_user()-function f=
rom the Xenomai kernel-space into the Linux user space? Aren't the adress s=
paces strictly seperated and you have to need the rt-pipe service to intera=
ct between the xenomai kernel space and the linux userspace?<BR><BR>&gt=3B =
<BR>&gt=3B -- <BR>&gt=3B Gilles.<BR></DIV></DIV></DIV> 		 	   		  </div></b=
ody>
</html>=

--_4cbe8604-7456-4678-a5b5-e6c3eb269809_--

