Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 May 2008 11:55:34 +0200
Message-ID: <0C9896A4B6D338488AD6FFFE58BAEF100276DDDE@serveur3.lgm.com>
References: <A3B06EAFE0D9C14096681C935E0B300802110A0C@zue-s-15.zue.zwick.de>	<4829613B.3000500@domain.hid><0C9896A4B6D338488AD6FFFE58BAEF100276DBF6@domain.hid><48297566.1010607@domain.hid><0C9896A4B6D338488AD6FFFE58BAEF100276DC66@domain.hid>
	<4829AA19.8070405@domain.hid>
	<0C9896A4B6D338488AD6FFFE58BAEF100276DD0C@serveur3.lgm.com>
	<4829C8C9.4020300@domain.hid>
From: "DOURNES Guillaume" <Guillaume.DOURNES@lgm.fr>
Subject: Re: [Xenomai-help] Interrupt management under rtdm driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Since I add the watchdog option in my kernel configuration, The software =
doesn't block.
But I obtain an EPREM (-1) error on the second call of =
rtdm_event_timedwait, and in dmesg : Xenomai: assertion failed at =
kernel/xenomai/skins/rtdm/drvlib.c:919 (!xnpod_unblockable_p()).
I don't understand why I have this error, because the =
rtdm_event_timedwait is used as the 16550A rtserial rtdm driver. And I =
use this rtserial driver, and it works.
Note that this problem doesn't appears when I call rt_task_suspend just =
after my rtdm_event_timedwait, and I resume the task by a gets.

-----Message d'origine-----
De : Jan Kiszka [mailto:jan.kiszka@domain.hid
Envoy=E9 : mardi 13 mai 2008 18:59
=C0 : DOURNES Guillaume
Cc : xenomai@xenomai.org
Objet : Re: [Xenomai-help] Interrupt management under rtdm driver

DOURNES Guillaume wrote:
> Sorry my old archive contained svn files. I send again my cource code.
>=20
> I have some syslog message as kernel : Oops : 0000 [#1], or kernel : =
CPU : 0, or EIP : 0060 [<f8a88de7>] Tainted : PF  VLI, etc.

Well, if your system locks up while the test runs, it is not likely that =
any message is pushed to syslog anymore. At best you see something on =
the console (VGA or serial).

>=20
> I don't understand the watchdog catch. Can you explain a little more ?

See the help in the kernel configuration: If the the watchdog catches =
some spinning Xenomai thread, it will suspend it, allowing the rest of =
the system to run again. This will also generate a log message on the =
kernel console.

Jan

--
Siemens AG, Corporate Technology, CT SE 2 Corporate Competence Center =
Embedded Linux


