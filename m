Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 May 2008 16:06:28 +0200
Message-ID: <A3B06EAFE0D9C14096681C935E0B300802110F22@domain.hid>
In-Reply-To: <4829613B.3000500@domain.hid>
References: <A3B06EAFE0D9C14096681C935E0B300802110A0C@zue-s-15.zue.zwick.de>
	<4829613B.3000500@domain.hid>
From: "Kaeppeler, Oliver" <Oliver.Kaeppeler@domain.hid>
Subject: Re: [Xenomai-help] gdb + multi-threaded application + Intel dual
	core	processor + Xenomai => frozen system
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

Hello Jan,

thanks for your answer. We had used Xenomai 2.4.3 in our tests. Now, I =
also tried the daily snapshot version, but the problem remains.

The problem should be reproducable by the sample program, we attached in =
our last message...

Regards,
Oliver.
=20

-----Urspr=FCngliche Nachricht-----
Von: Jan Kiszka [mailto:jan.kiszka@domain.hid
Gesendet: Dienstag, 13. Mai 2008 11:37
An: Kaeppeler, Oliver
Cc: xenomai@xenomai.org
Betreff: Re: [Xenomai-help] gdb + multi-threaded application + Intel =
dual core processor + Xenomai =3D> frozen system

Kaeppeler, Oliver wrote:
> Hello,
> =20
> we get an frozen system, if we start a multi-threaded posix-skin=20
> application within the GNU-Debugger (gdb) on an Intel dual core=20
> processor. Precisely, the system freezes when threads are being =
created.
> Often the problem occurs when the third or fourth thread is being=20
> created.
> =20
> Some further remarks:
> o We use OpenSUSE Linux 10.3 and Xenomai 2.4.3 over Linux Vanilla=20
> 2.6.24.5. Xenomai 2.4.0 over 2.6.23.9 shows simular behavier.
> o Toolchain SUSE 10.3 as is. =20
> o We run "init 3", so no x-server
> o We tested some gdb-Versions (6.3, 6.6, 6.8), but the result remains=20
> the same.
> o The system does NOT freeze, if the dual core feature is deactivated=20
> in the BIOS (so the processor works just with ONE core)!
> o Without gdb the program runs as expected.
> =20
> We attached a very small example program that creates 50 threads via=20
> pthread_create(). Each thread prints "Hello world", sleeps a few=20
> seconds and exits. We also attached the result of xeno-test=20
> (xeno-test.log.bz2) and /proc/config.gz.
> =20
> To start the application "test1" within the debugger, just type the
> following:
> # gdb test1
> (gdb) run
> =20
> Does anybody know, why the system freezes?

Yep. Known issue. Already fixed in latest SVN trunk and 2.4.x.

Jan

--
Siemens AG, Corporate Technology, CT SE 2 Corporate Competence Center =
Embedded Linux

