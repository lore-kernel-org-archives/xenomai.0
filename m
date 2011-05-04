Message-ID: <12fbb161f5b.sdiani@domain.hid>
Date: Wed, 4 May 2011 14:57:59 +0200 (CEST)
From: "sdiani@domain.hid" <sdiani@domain.hid>
Mime-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_91599_9730385.1304513879905"
Subject: [Adeos-main] Adeos for PowerPc 2.6.29.4-64 bit
Reply-To: "sdiani@domain.hid" <sdiani@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

------=_Part_91599_9730385.1304513879905
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Hi everyone,
i'm trying to compile the 2.6.29.4 64-bit Denx kernel for PowerPC ( PPC 970 , G5 Desktop ).
I have applied the patch  adeos-ipipe-2.6.29.4-powerpc-DENX-2.7-04.patch  and after reboot i get this error:

                        NIP [000001C968] .power4_idle+0x54/0x58 
                        LR = (null)
                            ....
                        Exceptionn: 901 at power4_idle+0x54/0x58
                                    LR = .cpu_idle +0x11c/0x1d4It regards the idle_power4.S file and the only changes in it, are about the CONFIG_SOFTDISABLE.
Can Anyone help me to solve it ?

Thank you in advance

Sergio
------=_Part_91599_9730385.1304513879905
Content-Type: text/html;charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<BR>Hi everyone,<BR>i'm trying to compile the 2.6.29.4 64-bit Denx kernel f=
or PowerPC (&nbsp;PPC 970 , G5 Desktop ).<BR>I have applied the patch&nbsp;=
&nbsp;<A href=3D"http://download.gna.org/adeos/patches/v2.6/powerpc/older/a=
deos-ipipe-2.6.29.4-powerpc-DENX-2.7-04.patch">adeos-ipipe-2.6.29.4-powerpc=
-DENX-2.7-04.patch</A>&nbsp; and after reboot i get this error:<BR><BR><SPA=
N style=3D"LINE-HEIGHT: 115%; FONT-FAMILY: 'Times New Roman','serif'; FONT-=
SIZE: 12pt; mso-fareast-font-family: 'Times New Roman'; mso-ansi-language: =
IT; mso-fareast-language: IT; mso-bidi-language: AR-SA">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</SPAN><SPAN style=3D"LIN=
E-HEIGHT: 115%; FONT-FAMILY: 'Times New Roman','serif'; FONT-SIZE: 12pt; ms=
o-fareast-font-family: 'Times New Roman'; mso-ansi-language: EN-US; mso-far=
east-language: IT; mso-bidi-language: AR-SA" lang=3DEN-US>NIP [000001C968] =
.power4_idle+0x54/0x58&nbsp;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;LR =3D (null)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;....<BR>&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</SPAN><SPAN=
 style=3D"LINE-HEIGHT: 115%; FONT-FAMILY: 'Times New Roman','serif'; FONT-S=
IZE: 12pt; mso-fareast-font-family: 'Times New Roman'; mso-ansi-language: I=
T; mso-fareast-language: IT; mso-bidi-language: AR-SA">Exceptionn: 901 at p=
ower4_idle+0x54/0x58<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;LR =3D .cpu_idle +0x11c/0x1d4<BR style=3D"mso-special-charac=
ter: line-break"><BR style=3D"mso-special-character: line-break">It regards=
 the idle_power4.S file and the only changes in it,&nbsp;are about the CONF=
IG_SOFTDISABLE.<BR>Can Anyone help me to solve it ?<BR><BR>Thank you in adv=
ance<BR><BR>Sergio</SPAN>
------=_Part_91599_9730385.1304513879905--


