Date: Wed, 18 Apr 2012 10:24:23 +0800
From: hustgongchen <hustgongchen@domain.hid>
Mime-Version: 1.0
Message-ID: <201204181024206179330@domain.hid>
Content-Type: multipart/alternative;
	boundary="----=_001_NextPart417268186576_=----"
Subject: [Xenomai-help] Can't use interrupt after adeos patch
Reply-To: hustgongchen <hustgongchen@domain.hid>
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

This is a multi-part message in MIME format.

------=_001_NextPart417268186576_=----
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: base64

SGkgZXZlcnlvbmU6DQogICAgSSB1c2UgbGludXgga2VybmVsIDIuNi4zMyBhbmQgeGVub21haSAy
LjUuMyB0byBidWlsZCBteSBydC1lbWJlZGRlZCBzeXN0ZW0gYmFzZWQgb24gUzNjMjQ0MCwNCmJ1
dCBpIGZvdW5kIEkgY2FuJ3QgdXNlIGludGVycnVwdCBhZnRlciBwdXQgdGhlIGFkZW9zIHBhdGNo
IHRvIGxpbnV4IGtlcm5lbC5UaGUgc3lzdGVtIGNyYXNoZXMgb25jZQ0KIEkgaW5zZXJ0IGEgVVNC
IGRldmljZSB0byBpdCBvciByZWNlaXZlIGEgZXRoZXJuZXQgcGFja2V0KHRoZSBuZXQgY2FyZCBp
IHVzZSBpcyBDUzg5MDApLg0KICAgIEJlY2F1c2UgZXZlbiBpIGRpZG4ndCBidWlsZCB4ZW5vbWFp
IGludG8ga2VybmVsICwgdGhlIHN5c3RlbSBzdGlsbCBjcmFzaGVkIG9uY2UgcmVjZWl2ZWQgYSAN
CmhhcmR3YXJlIGludGVycnVwdCBzbyBpIGd1ZXNzIHRoZSBwcm9ibGVtIGlzIGFib3V0IGFkZW9z
IHBhdGNoLklzIHRoZXJlIGFueSBidWcgd2l0aCANCmFkZW9zLWlwaXBlLTIuNi4zMy1hcm0tMS4x
Ni0wMS5wYXRjaD8NCiAgICBUaGFuayB5b3UgdmVyeSBtdWNoICENCiAgICAgZ29uZ2NoZW4NCg0K
DQoNCg0KaHVzdGdvbmdjaGVu

------=_001_NextPart417268186576_=----
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Dgb2312" http-equiv=3DContent-Type>
<STYLE>
BLOCKQUOTE {
	MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px; MARGIN-LEFT: 2em
}
OL {
	MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px
}
UL {
	MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px
}
P {
	MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px
}
DIV.FoxDiv20120418102346325503 {
	LINE-HEIGHT: 1.5; MARGIN: 10px; FONT-FAMILY: =CE=A2=C8=ED=D1=C5=BA=DA; CO=
LOR: #000000; FONT-SIZE: 10.5pt
}
BODY {
	LINE-HEIGHT: 1.5; FONT-FAMILY: =CE=A2=C8=ED=D1=C5=BA=DA; COLOR: #000080; =
FONT-SIZE: 10.5pt
}
</STYLE>

<META name=3DGENERATOR content=3D"MSHTML 8.00.7601.17699">
<STYLE>BLOCKQUOTE {
	MARGIN-TOP: 0px
}
OL {
	MARGIN-TOP: 0px
}
UL {
	MARGIN-TOP: 0px
}
</STYLE>
</HEAD>
<BODY style=3D"MARGIN: 10px">
<DIV>
<DIV class=3DFoxDiv20120418102346325503>
<STYLE>BLOCKQUOTE {
	MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px; MARGIN-LEFT: 2em
}
OL {
	MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px
}
UL {
	MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px
}
P {
	MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px
}
</STYLE>

<META name=3DGENERATOR content=3D"MSHTML 8.00.7601.17699">
<DIV>
<DIV>Hi&nbsp;everyone:</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;I&nbsp;use&nbsp;linux&nbsp;kernel&nbsp;2.6.33=
&nbsp;and&nbsp;xenomai&nbsp;2.5.3&nbsp;to&nbsp;build&nbsp;my&nbsp;rt-embed=
ded&nbsp;system&nbsp;based&nbsp;on&nbsp;S3c2440,</DIV>
<DIV>but&nbsp;i&nbsp;found&nbsp;I&nbsp;can't&nbsp;use&nbsp;interrupt&nbsp;=
after&nbsp;put&nbsp;the&nbsp;adeos&nbsp;patch&nbsp;to&nbsp;linux&nbsp;kern=
el.The&nbsp;system&nbsp;crashes&nbsp;once</DIV>
<DIV>&nbsp;I&nbsp;insert&nbsp;a&nbsp;USB&nbsp;device&nbsp;to&nbsp;it&nbsp;=
or&nbsp;receive&nbsp;a&nbsp;ethernet&nbsp;packet(the&nbsp;net&nbsp;card&nb=
sp;i&nbsp;use&nbsp;is&nbsp;CS8900).</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;Because&nbsp;even&nbsp;i&nbsp;didn't&nbsp;bui=
ld&nbsp;xenomai&nbsp;into&nbsp;kernel&nbsp;,&nbsp;the&nbsp;system&nbsp;sti=
ll&nbsp;crashed&nbsp;once&nbsp;received&nbsp;a&nbsp;</DIV>
<DIV>hardware&nbsp;interrupt&nbsp;so&nbsp;i&nbsp;guess&nbsp;the&nbsp;probl=
em&nbsp;is&nbsp;about&nbsp;adeos&nbsp;patch.Is&nbsp;there&nbsp;any&nbsp;bu=
g&nbsp;with&nbsp;</DIV>
<DIV>adeos-ipipe-2.6.33-arm-1.16-01.patch?</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;Thank&nbsp;you&nbsp;very&nbsp;much&nbsp;!</DI=
V>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;gongchen</DIV></DIV>
<DIV>&nbsp;</DIV>
<HR style=3D"WIDTH: 210px; HEIGHT: 1px" align=3Dleft color=3D#b5c4df SIZE=
=3D1>

<DIV><SPAN>hustgongchen</SPAN></DIV></DIV></DIV></BODY></HTML>

------=_001_NextPart417268186576_=------


