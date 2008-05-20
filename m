Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 May 2008 09:19:39 +0200
Message-ID: <4B2EEE69E41E524EB7FCDC62A15D68D8018D0038@domain.hid>
From: <Thomas.Debes@domain.hid>
Subject: [Xenomai-help] How to interrupt blocked thread in Linux domain from
	Xenomai
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

what is best way to interrupt a blocked RT-Thread waiting on a Linux
ressource in secondary mode (e.g. socket) from another NRT-Thread? I can
successfully detect the blocked state via rt_task_inquire and testing if
XNRELAX is being set. Is kill(pid, SIGINT) the right way to interrupt
the blocking system call or are there better ways to do it?

Thanks for you help!=20

MAN Roland Druckmaschinen AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle   =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592   =20
USt-Ident-Nr. DE 250200933

