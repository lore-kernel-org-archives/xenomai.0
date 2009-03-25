Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9AD81.4408B49E"
Date: Wed, 25 Mar 2009 15:35:57 -0400
Message-ID: <73A4F0FC6A6416469CCECF0E83917EA301582940@domain.hid>
References: <73A4F0FC6A6416469CCECF0E83917EA30158293E@exfp1.Railpowertech.local>
	<1238005150.6815.82.camel@domain.hid>
From: "Bennett, Adam" <ABennett@domain.hid>
Subject: Re: [Xenomai-help] cant' handle reloc type 0xe in librtdm.so.1
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9AD81.4408B49E
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



>=20From:=20Philippe=20Gerum=20[mailto:rpm@xenomai.org]
>=20Sent:=20Wed=203/25/2009=202:19=20PM
>=20To:=20Bennett,=20Adam
>=20Cc:=20xenomai@xenomai.org
>=20Subject:=20Re:=20[Xenomai-help]=20cant'=20handle=20reloc=20type=200xe=20=
in=20librtdm.so.1
>=20
>=20On=20Wed,=202009-03-25=20at=2014:14=20-0400,=20Bennett,=20Adam=20wrote=
:
>>=20Hello,
>>=20
>>=20I=20am=20upgrading=20from=20svn=20branch=202.4.x=20to=20trunk=20and=20=
an=20now=20getting=20the
>>=20following=20error:
>>=20
>>=20symbol=20'xeno_current':=20=20can't=20handle=20reloc=20type=200xe=20i=
n=20lib
>>=20'/usr/local/xenomai/lib/librtdm.so.1'
>>=20
>
>=20try=20--without-__thread=20when=20building=20the=20userland=20libs.

Thanks,=20that=20worked.

>
>>=20Has=20anyone=20encountered=20this?
>>=20
>>=20I=20am=20using=20uclibc=200.9.30.1.
>>=20
>>=20Adam
>>=20
>=20_______________________________________________
>=20Xenomai-help=20mailing=20list
>=20Xenomai-help@domain.hid
>=20https://mail.gna.org/listinfo/xenomai-help
>=20--=20
>=20Philippe.

Adam

This=20e-mail=20communication=20(and=20any=20attachment/s)=20may=20contain=
=20confidential=20or=20privileged=20information=20and=20is=20intended=20on=
ly=20for=20the=20individual(s)=20or=20entity=20named=20above=20and=20to=20=
others=20who=20have=20been=20specifically=20authorized=20to=20receive=20it=
.=20If=20you=20are=20not=20the=20intended=20recipient,=20please=20do=20not=
=20read,=20copy,=20use=20or=20disclose=20the=20contents=20of=20this=20comm=
unication=20to=20others.=20Please=20notify=20the=20sender=20that=20you=20h=
ave=20received=20this=20e-mail=20in=20error=20by=20reply=20e-mail,=20and=20=
delete=20the=20e-mail=20subsequently.=20
Thank=20you.=20
__________________________________________________________________________=
_______________________________________=20

Ce=20message=20(ainsi=20que=20le(s)=20fichier/s),=20transmis=20par=20courr=
iel,=20peut=20contenir=20des=20renseignements=20confidentiels=20ou=20prot=E9=
g=E9s=20et=20est=20destin=E9=20=E0=20l=92usage=20exclusif=20du=20destinata=
ire=20ci-dessus.=20Toute=20autre=20personne=20est=20par=20les=20pr=E9sente=
s=20avis=E9e=20qu=92il=20est=20strictement=20interdit=20de=20le=20diffuser=
,=20le=20distribuer=20ou=20le=20reproduire.=20Si=20vous=20l=92avez=20re=E7=
u=20par=20inadvertance,=20veuillez=20nous=20en=20aviser=20et=20d=E9truire=20=
ce=20message.=20
Merci.
------_=_NextPart_001_01C9AD81.4408B49E
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE=20HTML=20PUBLIC=20"-//W3C//DTD=20HTML=203.2//EN">
<HTML>
<HEAD>
<META=20HTTP-EQUIV=3D"Content-Type"=20CONTENT=3D"text/html;=20charset=3Dis=
o-8859-1">
<META=20NAME=3D"Generator"=20CONTENT=3D"MS=20Exchange=20Server=20version=20=
6.5.7653.38">
<TITLE>RE:=20[Xenomai-help]=20cant'=20handle=20reloc=20type=200xe=20in=20l=
ibrtdm.so.1</TITLE>
</HEAD>
<BODY>
<!--=20Converted=20from=20text/plain=20format=20-->
<BR>
<BR>

<P><FONT=20SIZE=3D2>&gt;=20From:=20Philippe=20Gerum=20[<A=20HREF=3D"mailto=
:rpm@xenomai.org">mailto:rpm@xenomai.org</A>]<BR>
&gt;=20Sent:=20Wed=203/25/2009=202:19=20PM<BR>
&gt;=20To:=20Bennett,=20Adam<BR>
&gt;=20Cc:=20xenomai@xenomai.org<BR>
&gt;=20Subject:=20Re:=20[Xenomai-help]=20cant'=20handle=20reloc=20type=200=
xe=20in=20librtdm.so.1<BR>
&gt;<BR>
&gt;=20On=20Wed,=202009-03-25=20at=2014:14=20-0400,=20Bennett,=20Adam=20wr=
ote:<BR>
&gt;&gt;=20Hello,<BR>
&gt;&gt;<BR>
&gt;&gt;=20I=20am=20upgrading=20from=20svn=20branch=202.4.x=20to=20trunk=20=
and=20an=20now=20getting=20the<BR>
&gt;&gt;=20following=20error:<BR>
&gt;&gt;<BR>
&gt;&gt;=20symbol=20'xeno_current':&nbsp;=20can't=20handle=20reloc=20type=20=
0xe=20in=20lib<BR>
&gt;&gt;=20'/usr/local/xenomai/lib/librtdm.so.1'<BR>
&gt;&gt;<BR>
&gt;<BR>
&gt;=20try=20--without-__thread=20when=20building=20the=20userland=20libs.=
<BR>
<BR>
Thanks,=20that=20worked.<BR>
<BR>
&gt;<BR>
&gt;&gt;=20Has=20anyone=20encountered=20this?<BR>
&gt;&gt;<BR>
&gt;&gt;=20I=20am=20using=20uclibc=200.9.30.1.<BR>
&gt;&gt;<BR>
&gt;&gt;=20Adam<BR>
&gt;&gt;<BR>
&gt;=20_______________________________________________<BR>
&gt;=20Xenomai-help=20mailing=20list<BR>
&gt;=20Xenomai-help@domain.hid<BR>
&gt;=20<A=20HREF=3D"https://mail.gna.org/listinfo/xenomai-help">https://ma=
il.gna.org/listinfo/xenomai-help</A><BR>
&gt;=20--<BR>
&gt;=20Philippe.<BR>
<BR>
Adam</FONT>
</P>


<BR>
This=20e-mail=20communication=20(and=20any=20attachment/s)=20may=20contain=
=20confidential=20or=20privileged=20information=20and=20is=20intended=20on=
ly=20for=20the=20individual(s)=20or=20entity=20named=20above=20and=20to=20=
others=20who=20have=20been=20specifically=20authorized=20to=20receive=20it=
.=20If=20you=20are=20not=20the=20intended=20recipient,=20please=20do=20not=
=20read,=20copy,=20use=20or=20disclose=20the=20contents=20of=20this=20comm=
unication=20to=20others.=20Please=20notify=20the=20sender=20that=20you=20h=
ave=20received=20this=20e-mail=20in=20error=20by=20reply=20e-mail,=20and=20=
delete=20the=20e-mail=20subsequently.=20<BR>
Thank=20you.=20<BR>
__________________________________________________________________________=
_______________________________________=20<BR>
<BR>
Ce=20message=20(ainsi=20que=20le(s)=20fichier/s),=20transmis=20par=20courr=
iel,=20peut=20contenir=20des=20renseignements=20confidentiels=20ou=20prot=E9=
g=E9s=20et=20est=20destin=E9=20=E0=20l=92usage=20exclusif=20du=20destinata=
ire=20ci-dessus.=20Toute=20autre=20personne=20est=20par=20les=20pr=E9sente=
s=20avis=E9e=20qu=92il=20est=20strictement=20interdit=20de=20le=20diffuser=
,=20le=20distribuer=20ou=20le=20reproduire.=20Si=20vous=20l=92avez=20re=E7=
u=20par=20inadvertance,=20veuillez=20nous=20en=20aviser=20et=20d=E9truire=20=
ce=20message.=20<BR>
Merci.<BR>
</BODY>
</HTML>
------_=_NextPart_001_01C9AD81.4408B49E--

