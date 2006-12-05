Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 5 Dec 2006 10:46:54 +0100
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A6C6377@domain.hid>
From: <Roderik_Wildenburg@domain.hid>
Subject: [Xenomai-help] vxworks- and posix-skin simultaneously
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

Can anybody tell me about the actual state of using vxworks-skin and =
posix-skin simultaneously ? Is it possible, compiling one application =
with vxWorks-skin and an other one with the posix-skin and to =
use/execute these two applications simultaneously on one system ?

In an earlier posting I have read, that all skins (or at least the =
native and the posix one) should be compiled as modules, so they do not =
overide the timer mode. Is this still true ? And if yes, dosn=B4t need =
the posix skin an aperiodic timer, but the timer is set to periodic mode =
by the vxworks skin ? So, can an vxworks application and an posix =
applications run together ??

Thank you for help and best regards=20
Roderik

