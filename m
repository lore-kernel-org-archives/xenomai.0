content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C87535.2BACFF92"
Date: Fri, 22 Feb 2008 10:27:40 +0100
Message-ID: <4272986BE32B50458F5E186DBBF3392B07C20A@globen.stockholm.syntronic.se>
From: =?Windows-1252?Q?Kristoffer_R=F6nnblom?= <krro@domain.hid>
Subject: [Adeos-main] AT91SAM9260: Necessary patches
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C87535.2BACFF92
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi, just wondering if the new ADEOS-patch
adeos-ipipe-2.6.20-arm-1.8-03.patch is applied on the same way as the
old patch, according to Gregory, in april 24 2007:

"Hi,
this is the last version of patch support for  AT91SAM926x, it now
support  AT91SAM9260 and  AT91SAM9261
To use it:
- take a vanilla linux
- apply the I-pipe patch
- apply the AT91 patch, then solve the three rejects by hand
- finally apply this patch

(as we also use NFS root on AT91SAM9260-EK, we needed to had support
for Ethernet MAC B, see
http://www.spinics.net/lists/arm/msg12707.html and
http://www.spinics.net/lists/arm/msg12961.html )

As there is no support for AT91SAM9263  in at91 patch in 2.6.19
kernel, we prefer wait for 2.6.20 (or higher) ipipe version for
integrate this chip.

Gregory CLEMENT"

Or is the new patch improved so that the AT91-patch is unecessary,
aswell as the support for ethernet MAC B?

/Kristoffer Roennblom

------_=_NextPart_001_01C87535.2BACFF92
Content-Type: text/html;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DWindows-1252">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.0.4417.0">
<TITLE>AT91SAM9260: Necessary patches</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hi, just wondering if the new ADEOS-patch =
adeos-ipipe-2.6.20-arm-1.8-03.patch is applied on the same way as the =
old patch, according to Gregory, in april 24 2007:<BR>
<BR>
&quot;Hi,<BR>
this is the last version of patch support for&nbsp; AT91SAM926x, it =
now<BR>
support&nbsp; AT91SAM9260 and&nbsp; AT91SAM9261<BR>
To use it:<BR>
- take a vanilla linux<BR>
- apply the I-pipe patch<BR>
- apply the AT91 patch, then solve the three rejects by hand<BR>
- finally apply this patch<BR>
<BR>
(as we also use NFS root on AT91SAM9260-EK, we needed to had support<BR>
for Ethernet MAC B, see<BR>
<A =
HREF=3D"http://www.spinics.net/lists/arm/msg12707.html">http://www.spinic=
s.net/lists/arm/msg12707.html</A> and<BR>
<A =
HREF=3D"http://www.spinics.net/lists/arm/msg12961.html">http://www.spinic=
s.net/lists/arm/msg12961.html</A> )<BR>
<BR>
As there is no support for AT91SAM9263&nbsp; in at91 patch in 2.6.19<BR>
kernel, we prefer wait for 2.6.20 (or higher) ipipe version for<BR>
integrate this chip.<BR>
<BR>
Gregory CLEMENT&quot;<BR>
<BR>
Or is the new patch improved so that the AT91-patch is unecessary, =
aswell as the support for ethernet MAC B?<BR>
<BR>
/Kristoffer Roennblom</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C87535.2BACFF92--

