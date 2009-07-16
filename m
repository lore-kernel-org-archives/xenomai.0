Date: Thu, 16 Jul 2009 15:15:27 +0200
From: Petr Cervenka <grugh@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1247750127.306081.22356.nullmailer@domain.hid>
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] rt_task_shadow returns always -EFAULT
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>


Hello,
the xenomai native function rt_task_shadow(...) always returns -EFAULT fo=
r me. Only happens in xenomai-2.5-rc2.

Same behaviour was also in 2.5-rc1, see note in my older post:
https://mail.gna.org/public/xenomai-help/2009-05/msg00024.html

Example code, in the end of this post:
https://mail.gna.org/public/xenomai-help/2009-05/msg00038.html

My configuration:
Athlon 64 X2 4600+
Kubuntu 7.10
linux-2.6.29.5 (also tried 2.6.30.1)
xenomai-2.5.-rc2

Best regards

Petr Cervenka

