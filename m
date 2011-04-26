Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 Apr 2011 11:48:22 +0200
Message-ID: <1183078C0D064042B3AD2D03E3859EF174E31A@AREXCH02.mra.roland-man.biz>
From: <dietmar.schindler@domain.hid>
Subject: [Xenomai-help] message pipe message boundaries
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

The documentation of rt_pipe_write() says: "rt_pipe_write() always
preserves message boundaries, which means that all data sent through a
single call of this service will be gathered in a single read(2)
operation from the special device." Is this supposed to mean also that
data sent through two calls of this service will be gathered in two
read(2) operations, or would it be conforming that data sent through two
calls of this service will be gathered in a single read(2) operation?

--------------------------------------------------------
manroland AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle  =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
USt-Ident-Nr. DE 250200933

