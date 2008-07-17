Message-ID: <3451.132.206.72.194.1216322618.squirrel@domain.hid>
Date: Thu, 17 Jul 2008 15:23:38 -0400 (EDT)
From: vleves@domain.hid
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Freeze on system()/fork() call (xenomai 2.4.4)
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

Hello,

A few months ago I reported that my installation of xenomai 2.4.2 would
freeze when calling fork() or system() under certain conditions:

https://mail.gna.org/public/xenomai-help/2008-04/msg00002.html

Gilles Chanteperdrix gave me a patch that seemed to resolve the issue. I
now tried to upgrade to Xenomai 2.4.4 and it seems to suffer from the sam=
e
problem. Is this issue expected to be resolved in the near future or
should I look for a permanent work-around in my programs?

Thank you,

Vincent Levesque
vleves@domain.hid

