Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Dec 2007 15:19:20 +0100
Message-ID: <4B2EEE69E41E524EB7FCDC62A15D68D8018CFEBF@ARVMAIL1.mra.roland-man.biz>
From: <Thomas.Debes@domain.hid>
Subject: [Xenomai-help] Uniqueness of registry objects
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

I am using the native skin together with mutexes and message queues. If
I use the same name for both objects (mutex=3D"test" , =
queuename=3D"test") I
can not register the second one because it fails with error -17 (file
exists) in rt_queue_create. I assume that the registry service doesn't
make a difference between the various RT object types. Can you confirm
this behaviour? If it is by design would it be better to differ between
the various RT object types (mutex, queue, pipe etc.)?

Thanks
Thomas=20

MAN Roland Druckmaschinen AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle   =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592   =20
USt-Ident-Nr. DE 250200933

