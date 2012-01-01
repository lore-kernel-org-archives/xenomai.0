Message-ID: <BLU166-W43669C15D140AD73775927C4900@domain.hid>
Content-Type: multipart/alternative;
	boundary="_ebc79049-76c9-430e-b1e2-8d3e932c82e8_"
From: Jan-Erik Lange <jan0385@domain.hid>
Date: Sun, 1 Jan 2012 13:56:54 +0100
In-Reply-To: <4EFF2B04.1000209@domain.hid>
References: <BLU166-W39C682E7E76684CC152F0C4930@domain.hid>,
	<4EFF2B04.1000209@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] user and kernel space
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--_ebc79049-76c9-430e-b1e2-8d3e932c82e8_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



=20

> Date: Sat=2C 31 Dec 2011 16:32:20 +0100
> From: gilles.chanteperdrix@xenomai.org
> To: jan0385@domain.hid
> CC: xenomai@xenomai.org
> Subject: Re: [Xenomai-core] user and kernel space
>=20
> On 12/31/2011 12:18 PM=2C Jan-Erik Lange wrote:
> >=20
> > Hello=2C
> >=20
> > I have a question concerning user space and kernel space. I'm dealing
> > with the native API and I read=2C that this API provides the same
> > funtkions for both kernel and user space.
> >=20
> > When looking at the sourcecode of buffer.h for example=2C there I find
> > a section called public interface. When looking at the function
> > rt_buffer_create()=3B for example=2C how does the Implementation von th=
is
> > function in userspace differs to the implementation for this function
> > kernel space? Or is it the same implementation for user and kernel
> > space.
>=20
> For most services such as buffer services=2C user functions emit system
> calls which implementation in kernel-space use the corresponding kernel
> service.
>=20
> There are some exceptions such as mutexes implementation where we try
> hard to avoid system calls and so provide both a user-space
> implementation and a kernel-space implementation.
=20
=20
Ok=2C but the names of the API function are the same for user and kernel sp=
ace. How is it realized to take the implementation A for kernel space and t=
he implementation B for userspace? Is this realzied in the linking process?

>=20
> Another exception is the __xn_rdtsc() function=2C which relies on most
> platforms on the same mechanism in user and kernel-space to access the
> machine high resolution counter=2C and so has an identical implementation=
.
>=20
>=20
=20
> --=20
> Gilles.
 		 	   		  =

--_ebc79049-76c9-430e-b1e2-8d3e932c82e8_
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
<DIV id=3DSkyDrivePlaceholder></DIV>
<DIV>&gt=3B Date: Sat=2C 31 Dec 2011 16:32:20 +0100<BR>&gt=3B From: gilles.=
chanteperdrix@domain.hid<BR>&gt=3B To: jan0385@domain.hid<BR>&gt=3B CC: xe=
nomai-core@domain.hid<BR>&gt=3B Subject: Re: [Xenomai-core] user and kernel sp=
ace<BR>&gt=3B <BR>&gt=3B On 12/31/2011 12:18 PM=2C Jan-Erik Lange wrote:<BR=
>&gt=3B &gt=3B <BR>&gt=3B &gt=3B Hello=2C<BR>&gt=3B &gt=3B <BR>&gt=3B &gt=
=3B I have a question concerning user space and kernel space. I'm dealing<B=
R>&gt=3B &gt=3B with the native API and I read=2C that this API provides th=
e same<BR>&gt=3B &gt=3B funtkions for both kernel and user space.<BR>&gt=3B=
 &gt=3B <BR>&gt=3B &gt=3B When looking at the sourcecode of buffer.h for ex=
ample=2C there I find<BR>&gt=3B &gt=3B a section called public interface. W=
hen looking at the function<BR>&gt=3B &gt=3B rt_buffer_create()=3B for exam=
ple=2C how does the Implementation von this<BR>&gt=3B &gt=3B function in us=
erspace differs to the implementation for this function<BR>&gt=3B &gt=3B ke=
rnel space? Or is it the same implementation for user and kernel<BR>&gt=3B =
&gt=3B space.<BR>&gt=3B <BR>&gt=3B For most services such as buffer service=
s=2C user functions emit system<BR>&gt=3B calls which implementation in ker=
nel-space use the corresponding kernel<BR>&gt=3B service.<BR>&gt=3B <BR>&gt=
=3B There are some exceptions such as mutexes implementation where we try<B=
R>&gt=3B hard to avoid system calls and so provide both a user-space<BR>&gt=
=3B implementation and a kernel-space implementation.</DIV>
<DIV>&nbsp=3B</DIV>
<DIV>&nbsp=3B</DIV>
<DIV>Ok=2C but the names of the&nbsp=3BAPI function are the same for user a=
nd kernel space. How is it realized to take the implementation A for kernel=
 space and the implementation B for userspace? Is this realzied in the link=
ing process?</DIV>
<DIV><BR>&gt=3B <BR>&gt=3B Another exception is the __xn_rdtsc() function=
=2C which relies on most<BR>&gt=3B platforms on the same mechanism in user =
and kernel-space to access the<BR>&gt=3B machine high resolution counter=2C=
 and so has an identical implementation.<BR>&gt=3B <BR>&gt=3B </DIV>
<DIV>&nbsp=3B</DIV>
<DIV>&gt=3B -- <BR>&gt=3B Gilles.<BR></DIV> 		 	   		  </div></body>
</html>=

--_ebc79049-76c9-430e-b1e2-8d3e932c82e8_--

