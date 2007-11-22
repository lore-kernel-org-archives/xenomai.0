Date: Thu, 22 Nov 2007 14:45:03 +0100
Message-Id: <1806365692@domain.hid>
MIME-Version: 1.0
From: Andreas Vogt <A_C_V@web.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] boot hang up with lapic
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


Hello
I hope somebody can help me.
I have Xenomai 2.3.1 and Linux 2.6.20.13 and i tried it with other Version=
s and adeos-ipipe-2.6.20-i386-1.10-10.patch.
Everytime I have in the boot options nolapic then the Linux works but the =
Error

>Xenomai: Local APIC absent or disabled!
>Disable APIC support or pass "lapic=3D1" as bootparam.
>Xenomai: system init failed, code -19.
>Xenomai: starting POSIX services.
>Xenomai: POSIX skin init failed, code -19.
>Xenomai: RTDM skin init failed, code -19.

happen.
And if i write lapic in the boot options the system doesn't boot.
Andreas

=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
Jetzt neu! Sch=FCtzen Sie Ihren PC mit McAfee und WEB.DE. 3 Monate
kostenlos testen. http://www.pc-sicherheit.web.de/startseite/=3Fmc=3D022220


