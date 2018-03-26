Date: Mon, 26 Mar 2018 19:29:54 +0300 (EEST)
From: =?windows-1251?B?2OXi9+Xt6u4g0uDw4PEgw/Do4+7w/OXi6Pc=?=
 <shevchenko.taras@triolcorp.com.ua>
Message-ID: <1257363232.7918002.1522081794591.JavaMail.zimbra@triolcorp.com.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] errors in log when startup 4.9.51
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hi=20
I found errors in log when startup 4.9.51 with Xenomai could it be a proble=
m with sd reader ?=20




[ 0.366633] platform wdat_wdt: failed to claim resource 4=20
[ 0.366647] ACPI: watchdog: Failed to create platform device=20

[ 1.447252] i2c_designware 808622C1:00: failure requesting irq 32: -38=20

Xenomai registerd=20

[ 12.960998] [Xenomai] scheduling class idle registered.=20
[ 12.961001] [Xenomai] scheduling class rt registered.=20
[ 12.961052] [Xenomai] SMI-enabled chipset found, but SMI workaround disabl=
ed=20
(see xenomai.smi parameter). You might encounter=20
high latencies!=20
[ 12.961171] I-pipe: head domain Xenomai registered.=20
[ 12.962015] [Xenomai] Cobalt v3.0.5 (Sisyphus's Boulder)=20

PS I saw patch today but have not try it yet=20

=D1 =F3=E2=E0=E6=E5=ED=E8=E5=EC =E8 =ED=E0=E4=E5=E6=E4=EE=E9 =ED=E0 =F1=EE=
=F2=F0=F3=E4=ED=E8=F7=E5=F1=F2=E2=EE,=20
=D8=E5=E2=F7=E5=ED=EA=EE =D2.=C3.=20
