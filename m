Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 Jun 2007 08:23:29 +0200
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2AAA6EFD@ARVMAIL1.mra.roland-man.biz>
From: <Roderik_Wildenburg@domain.hid>
Subject: [Xenomai-help] Xenomai and Busybox
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

Does anyone use Busybox(www.busybox.net) on a xenomai-linux ?
Or does anyone experience one of these problems with busybox on xenomai
:
- yes > /dev/null stalls system completely (yes is a little program
returning 'y' continously; this does not happen using a normal bash
shell)
- "netstat -a" seems to delay realtime execution (periodic task produces
overruns). I have no idea how this could happen, as I thought xenomai
has highest priority and, as far as I have seen, netstat does not
anything else than reading /proc/net/netstat.

We experienced these problems on a PPC 2.4 xenomai-linux.

Any suggestions/ideas/explanations ?

Many thanks in advance
Roderik=20

MAN Roland Druckmaschinen AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle   =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592   =20
USt-Ident-Nr. DE 250200933

