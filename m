Message-ID: <004801c9a69a$4a63aaf0$0109220a@domain.hid>
From: "Henry Bausley" <hbausley@domain.hid>
References: <004301c9a683$c6b00200$0109220a@domain.hid>
Date: Mon, 16 Mar 2009 17:49:55 -0700
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0045_01C9A65F.9E0261F0"
Subject: Re: [Xenomai-help] ENXIO error with large shared memory
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

This is a multi-part message in MIME format.

------=_NextPart_000_0045_01C9A65F.9E0261F0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

ftruncate returns 0
  ----- Original Message -----=20
  From: Henry Bausley=20
  To: xenomai@xenomai.org
  Sent: Monday, March 16, 2009 3:08 PM
  Subject: [Xenomai-help] ENXIO error with large shared memory


  I am trying to map a large shared memory buffer and cannot seem to map 32=
M.
  I get the error code ENXIO back from the posix skin mmap.

  The code works for
    ftruncate(prgshmfd, 16777216);
    pPrgShm =3D mmap(NULL, 16777216, PROT_READ | PROT_WRITE, MAP_SHARED, pr=
gshmfd, 0);
  but fails if I have
    ftruncate(prgshmfd, 16777216*2);
    pPrgShm =3D mmap(NULL, 16777216*2, PROT_READ | PROT_WRITE, MAP_SHARED, =
prgshmfd, 0);


  The condition failing is mmap in xenomai/skins/posix/shm.c.=20

   if (!shm->addr || off + len > shm->size)=20
          {
     err =3D ENXIO;
     up(&shm->maplock);
     goto err_free_map;
   }


  For  16M
  len =3D 0x1000000 and shm->size =3D 0x1000000

  For 32M
  len =3D 0x2000000 and shm->size =3D 0x1FFF000

  Is there something I didn't configure correctly that is limiting my size?


  I am currently using 2.4.6 Xenomai, I-pipe 2.2-07 with kernel 2.6.26-denx=
 on a 1Ghz PowerPC 460EX with 2G RAM


---------------------------------------------------------------------------=
---


  _______________________________________________
  Xenomai-help mailing list
  Xenomai-help@domain.hid
  https://mail.gna.org/listinfo/xenomai-help

**********************************************************=0D
Outbound scan for Spam or Virus by Barracuda at Delta Tau=0D
**********************************************************

------=_NextPart_000_0045_01C9A65F.9E0261F0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.6000.16809" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>ftruncate returns 0</FONT></DIV>
<BLOCKQUOTE=20
style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LE=
FT: #000000 2px solid; MARGIN-RIGHT: 0px">
  <DIV style=3D"FONT: 10pt arial">----- Original Message ----- </DIV>
  <DIV=20
  style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: black"><B>Fro=
m:</B>=20
  <A title=3Dhbausley@domain.hid href=3D"mailto:hbausley@domain.hid">He=
nry=20
  Bausley</A> </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>To:</B> <A title=3Dxenomai@xenomai.org=
g=20
  href=3D"mailto:xenomai@xenomai.org">xenomai@xenomai.org</A> </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Sent:</B> Monday, March 16, 2009 3:08=
=20
PM</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Subject:</B> [Xenomai-help] ENXIO erro=
r with=20
  large shared memory</DIV>
  <DIV><BR></DIV>
  <DIV><FONT face=3DArial size=3D2>I am trying to map a large shared memory=
 buffer=20
  and cannot seem to map 32M.<BR>I get the error code ENXIO back from the p=
osix=20
  skin mmap.</FONT></DIV>
  <DIV>&nbsp;</DIV>
  <DIV><FONT face=3DArial size=3D2>The code works for<BR>&nbsp; ftruncate(p=
rgshmfd,=20
  16777216);<BR>&nbsp; pPrgShm =3D mmap(NULL, 16777216, PROT_READ | PROT_WR=
ITE,=20
  MAP_SHARED, prgshmfd, 0);<BR>but fails if I have<BR>&nbsp; ftruncate(prgs=
hmfd,=20
  16777216*2);<BR>&nbsp; pPrgShm =3D mmap(NULL, 16777216*2, PROT_READ |=20
  PROT_WRITE, MAP_SHARED, prgshmfd, 0);</FONT></DIV>
  <DIV>&nbsp;</DIV><FONT face=3DArial size=3D2>
  <DIV><BR>The condition failing is mmap in xenomai/skins/posix/shm.c. </DI=
V>
  <DIV>&nbsp;</DIV>
  <DIV>&nbsp;if (!shm-&gt;addr || off + len &gt; shm-&gt;size)=20
  <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<BR>&nbsp;&nbsp; err =3D=
=20
  ENXIO;<BR>&nbsp;&nbsp; up(&amp;shm-&gt;maplock);<BR>&nbsp;&nbsp; goto=20
  err_free_map;<BR>&nbsp;}</DIV>
  <DIV>&nbsp;</DIV>
  <DIV><BR>For&nbsp; 16M<BR>len =3D 0x1000000 and shm-&gt;size =3D 0x100000=
0</DIV>
  <DIV>&nbsp;</DIV>
  <DIV>For 32M<BR>len =3D 0x2000000 and shm-&gt;size =3D 0x1FFF000</DIV>
  <DIV>&nbsp;</DIV>
  <DIV>Is there something I didn't configure correctly that is limiting my=
=20
  size?</DIV>
  <DIV>&nbsp;</DIV>
  <DIV>&nbsp;</DIV>
  <DIV>I am currently using 2.4.6 Xenomai, I-pipe 2.2-07 with kernel 2.6.26=
-denx=20
  on a 1Ghz PowerPC 460EX with 2G RAM</FONT></DIV>
  <P>
  <HR>

  <P></P>_______________________________________________<BR>Xenomai-help ma=
iling=20
  list<BR>Xenomai-help@domain.hid<BR>https://mail.gna.org/listinfo/xenomai-hel=
p<BR></BLOCKQUOTE>
</BODY></HTML>

------=_NextPart_000_0045_01C9A65F.9E0261F0--



