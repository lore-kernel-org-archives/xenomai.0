Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Jun 2006 15:50:35 +0200
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A3BC849@domain.hid>
From: <Roderik_Wildenburg@domain.hid>
Subject: [Xenomai-help] static linking of posix demo
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

when I try to link the posix demo satch.c statically by inserting a
"-static" option to the LDFLAGS ( %_rt: LDFLAGS=3D -static $(LDFLAGS_RT) =
)
I get a lot of Errors about undefined references :
e.g.:
undefined reference to `__wrap_timer_settime'
relocation truncated to fit: R_PPC_REL24 __wrap_timer_settime=20

Does anybody know what I have done wrong, or is static linking not
supposed to be used.

Thank you for your help
Roderik

