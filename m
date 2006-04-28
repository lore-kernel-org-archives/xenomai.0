From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Date: Fri, 28 Apr 2006 17:36:27 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200604281736.28169.lbocseg@domain.hid>
Subject: [Xenomai-help] Have condition variables Priority Inheritance
	Protection (PIP)?
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

Hi,
Having a look at cond.c in the native skin, I didn't understand why it is n=
ot=20
passed the PIP flag to xnsynch_init(). I mean, why the code is not=20
xnsynch_init(&cond->synch_base,XNSYNCH_PIP);

instead of

xnsynch_init(&cond->synch_base,XNSYNCH_PRIO);

?

Could someone please point me the reason?

Thanks in advance,

Rodrigo.

	=09
_______________________________________________________=20
Abra sua conta no Yahoo! Mail: 1GB de espa=E7o, alertas de e-mail no celula=
r e anti-spam realmente eficaz.=20
http://br.info.mail.yahoo.com/


