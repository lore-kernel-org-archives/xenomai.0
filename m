Content-Type: text/html; charset=euc-kr
From: "=?EUC-KR?B?yLK8rsGk?=" <to_infinity@domain.hid>
Date: Mon, 04 Aug 2003 23:10:51 +0900 (KST)
Message-Id: <20030804231051.HM.G00000000060kMp@domain.hid>
Errors-To: <to_infinity@domain.hid>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Adeos-main] sched.c ?
List-Id: <adeos-main.nongnu.org>
List-Unsubscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.gnu.org/pipermail/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

<style> p {margin-top:0px;margin-bottom:0px;} </style><table border=3D0 w=
idth=3D100% bgcolor=3D'' cellpadding=3D0 cellspacing=3D0 align=3Dcenter><=
tr><td valign=3Dtop style=3D'padding:8pt;'><font size=3D2><P>Hell all.</P=
>
<P>&nbsp;</P>
<P>I'm a newbie to Adeos.</P>
<P>I downloaded m3 version of Adeos and check a source tree.</P>
<P>I found that Adoes has files such as printk.c, sched.c and other files=
</P>
<P>similar to files contained in linux kernel.</P>
<P>And I think their contexts seem to be almost same with kernel's.</P>
<P>What are their purpose or functionality?</P>
<P>Please answer this question even it's some stupid.</P>
<P>Have a nice day please ;)</P>
<P>&nbsp;</P>
<P>Fredrick</P></font></td></tr></table>
<table border=3D0 cellpadding=3D0 cellspacing=3D1 align=3Dcenter>
<tr><td bgcolor=3D"#ffffff" align=3D"center" width=3D130>=20
<iframe src=3D'http://avatarfile.hanmail.net/bin/getavatar?EUSERID=3D8_ZF=
j2RUTCg0&LOOK=3D1' width=3D130 height=3D150 border=3D0 frameborder=3D0 sc=
rolling=3Dno></iframe></td>
<td align=3D"left" valign=3D"middle">

<table border=3D0 cellpadding=3D0 cellspacing=3D0>
<tr><td><img src=3D'http://image.hanmail.net/hm/av/box1_c1.gif'></td>
	<td background=3D'http://image.hanmail.net/hm/av/box1_upbg.gif'></td>
	<td><img src=3D'http://image.hanmail.net/hm/av/box1_c2.gif'></td>
</tr>
<tr><td background=3D'http://image.hanmail.net/hm/av/box1_lbg.gif' valign=
=3Dtop><img src=3D'http://image.hanmail.net/hm/av/box1_c11.gif'></td>
	<td background=3D'http://image.hanmail.net/hm/av/box1_bg.gif' style=3D'l=
ine-height:120%; padding:10px'><font color=3D#003D82>--------------------=
--------------------
<br>Seok-jeong Hwang ( Fredrick Hwang )
<br>Undegraduate '99 CSE Postech
<br>hwoarang@domain.hid
<br>to_infinity@domain.hid
<br>+82-16-824-9350(016-824-9350)
<br>+82-54-279-9318(054-279-9318)
<br>*Have a nice day!!*
<br>
<br></font></td>
	<td background=3D'http://image.hanmail.net/hm/av/box1_rbg.gif'></td>
</tr>
<tr><td><img src=3D'http://image.hanmail.net/hm/av/box1_c3.gif'></td>
	<td background=3D'http://image.hanmail.net/hm/av/box1_dwbg.gif'></td>
	<td><img src=3D'http://image.hanmail.net/hm/av/box1_c4.gif'></td>
</tr>
</table></td>=20
<td>&nbsp;&nbsp;&nbsp;</td>
</tr>
</table>

<br><br><table border=3D0 cellpadding=3D5 cellspacing=3D0 width=3D100%>
<tr><td background=3D'http://image.hanmail.net/hanmail/general/dotline_si=
m.gif' height=3D1></td></tr>
<tr>
<td><font color=3D"#312400" style=3D"font-size:9pt;">
"=BF=EC=B8=AE =C0=CE=C5=CD=B3=DD, Daum" <a href=3Dhttp://www.daum.net tar=
get=3D_top><font color=3D"#312400">http://www.daum.net</font></a>&nbsp;&n=
bsp;=A1=BA=C6=F2=BB=FD=BE=B2=B4=C2 =B9=AB=B7=E1 =C7=D1=B8=DE=C0=CF=B3=DD=A1=
=BB<br>
</font></td></tr></table><table bgcolor=3D#F8F8F8 border=3D0 cellpadding=3D=
3 cellspacing=3D0 width=3D100%  style=3D"border: #ECECEC solid 1px;">
<tr>
<td width=3D50 align=3Dright nowrap><a href=3D'http://hmm.daum.net/info/p=
reminfo_to_nopre.html' target=3D_blank><img src=3D'http://image.hanmail.n=
et/hanmail/top/adver/pri_footer.gif' width=3D40 height=3D40 border=3D0></=
a></td>
<td width=3D50% class=3Dbase style=3D"line-height:140%; font-size:9pt;">
<a href=3D'http://hmm.daum.net/info/preminfo_to_nopre.html' target=3D_bla=
nk><font color=3D#BD8000 style=3D"font-size:9pt;">
=BF=CD=BF=EC! =C7=C1=B8=AE=B9=CC=BE=F6 =B8=DE=C0=CF=BF=A1 =C0=CC=B7=B1 =B1=
=E2=B4=C9=C0=CC?</font></a><br>6=B0=A1=C1=F6 =BD=BA=C5=B2+=BF=EB=B7=AE=C8=
=AE=C0=E5+=A5=E1 =B3=AA=B8=B8=C0=C7 =B8=C2=C3=E3 =B8=DE=C0=CF!=20
</td>
<td width=3D3 nowrap><img src=3D'http://image.hanmail.net/hm/line_h.gif' =
width=3D3 height=3D40></td>
<td width=3D40><a href=3D'http://hmm.daum.net/footer_spam' target=3D_blan=
k><img src=3D'http://image.hanmail.net/hanmail/top/adver/footer_spam.gif'=
 width=3D40 height=3D40 border=3D0></a></td>
<td width=3D50% class=3Dbase style=3D"line-height:140%; font-size:9pt;">
<a href=3D'http://hmm.daum.net/footer_spam' target=3D_blank><font color=3D=
#BD8000 style=3D"font-size:9pt;">=C7=D1=B8=DE=C0=CF=B3=DD =BD=BA=C6=D4=C1=
=A6=B7=CE =BD=C3=BD=BA=C5=DB</font></a><br>=BD=BA=C6=D4 =BE=F8=B4=C2 =C6=ED=
=C1=F6=C7=D4! =C7=D1=B8=DE=C0=CF=B3=DD =C6=ED=C1=F6=C7=D4!</td>
</table>

<img src=3D"http://www17.hanmail.net:4280/@from=3Dto_infinity&rcpt=3Dadeo=
s%2Dmain%40nongnu%2Eorg&msgid=3D%3C20030804231051%2EHM%2EG00000000060kMp%=
40www17%2Ehanmail%2Enet%3E">


