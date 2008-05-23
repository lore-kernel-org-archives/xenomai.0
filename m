From: "kerhoas.vincent" <kerhoas.vincent@domain.hid>
Message-ID: <30723461.6495621211553763904.JavaMail.www@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_570026_30976839.1211553763903"
Date: Fri, 23 May 2008 16:42:43 +0200 (CEST)
Subject: [Xenomai-help] I2C Bus and intel PXA255 (or other board)
Reply-To: "kerhoas.vincent" <kerhoas.vincent@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_570026_30976839.1211553763903
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


Hi

I'm working on a ep9302 board and I'm trying to install xenomai on it. For =
the moment there isn't a dedicated patch, so I've got to do it by hand. I c=
ontinue doing it but I'm thinking about another solution.

My purpose is creating real time robotic labs ; I was considering (and I'm =
still considering) a qwerk solution (from charmed lab), but in the worst ca=
se I'm now considering korebot solution (from k-team). This robot use Intel=
 PXA255 board, which seems to be ok for xenomai, but this board need I2C to=
 communicate with other board.

So I'm wondering If there is I2C driver to rewrite for xenomai or there is =
just special functions to use after patching the kernel ?

Regards

Vincent


 Cr=C3=A9ez votre adresse =C3=A9lectronique pr=C3=A9nom.nom@domain.hid
 1 Go d'espace de stockage, anti-spam et anti-virus int=C3=A9gr=C3=A9s.

------=_Part_570026_30976839.1211553763903
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p style=3D"margin:0;padding:0;" align=3D"left"><br /></p><p style=3D"margi=
n: 0pt; padding: 0pt" align=3D"left">Hi<br /><br />I'm working on a ep9302 =
board and I'm trying to install xenomai on it. For the moment there isn't a=
 dedicated patch, so I've got to do it by hand. I continue doing it but I'm=
 thinking about another solution.<br /><br />My purpose is creating real ti=
me robotic labs ; I was considering (and I'm still considering) a qwerk sol=
ution (from charmed lab), but in the worst case I'm now considering korebot=
 solution (from k-team). This robot use Intel PXA255 board, which seems to =
be ok for xenomai, but this board need I2C to communicate with other board.=
<br /><br />So I'm wondering If there is I2C driver to rewrite for xenomai =
or there is just special functions to use after patching the kernel ?<br />=
<br />Regards<br /><br />Vincent</p><BR><BR><i>Cr=C3=A9ez votre adresse =C3=
=A9lectronique <a target=3D_blank href=3Dhttp://www.laposte.net>pr=C3=A9nom=
.nom@domain.hid</a> <BR> 1 Go d'espace de stockage, anti-spam et anti-viru=
s int=C3=A9gr=C3=A9s.</i><BR>
------=_Part_570026_30976839.1211553763903--



