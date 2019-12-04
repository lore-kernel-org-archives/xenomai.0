From: "Electronic Dept. - Vbm Group" <electronic@vbm-grp.com>
Subject: undefined reference to `rt_task_create
Message-ID: <441471f5-30ed-3b11-8b58-8e5bd7f805d1@vbm-grp.com>
Date: Wed, 4 Dec 2019 12:01:47 +0100
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Goodmorning,
I'm using a Beaglebone black and I'm doing the first tests with Xenomai.
I've created a kernel patched with Xenomai from here:
https://github.com/RobertCNelson/ti-linux-kernel-dev/tree/ti-linux-xenomai-=
4.4.y
and installed Xenomai libraries following:
https://forum.digikey.com/t/how-to-cross-compile-application-for-xenomai-wi=
th-beaglebone/4943/3


I've made a test file named cyclic_test.c and the following Makefile:

MAIN_SRC=3D cyclic_test
TARGET=A0=A0=A0 =3D cyclic_test

SKIN =A0=A0=A0 :=3D alchemy
CFLAGS =A0=A0=A0 :=3D $(shell /usr/xenomai/bin/xeno-config --skin=3D$(skin)=
 --cflags)
LDFLAGS :=3D $(shell /usr/xenomai/bin/xeno-config --skin=3D$(skin) --ldflag=
s)
CC =A0=A0=A0 :=3D $(shell /usr/xenomai/bin/xeno-config --cc)

$(TARGET): $(MAIN_SRC).c
 =A0=A0=A0 $(CC) -o $@ $< $(CFLAGS) $(LDFLAGS)

clean:
 =A0=A0=A0 @rm $(MAIN_SRC)


And I get the following response:

gcc -o cyclic_test cyclic_test.c -I/usr/xenomai/include/cobalt=20
-I/usr/xenomai/in
clude -march=3Darmv7-a -mfpu=3Dvfp3 -D_GNU_SOURCE -D_REENTRANT=20
-fasynchronous-unwind
-tables -D__COBALT__ -Wl,--no-as-needed=20
-Wl,@/usr/xenomai/lib/modechk.wrappers
/usr/xenomai/lib/xenomai/bootstrap.o -Wl,--wrap=3Dmain=20
-Wl,--dynamic-list=3D/usr/xen
omai/lib/dynlist.ld -L/usr/xenomai/lib -lcobalt -lmodechk -lpthread -lrt=20
-march=3D
armv7-a -mfpu=3Dvfp3
/tmp/ccNmb1Fm.o: In function `rt_timer_read':
cyclic_test.c:(.text+0xe): undefined reference to `clockobj_get_time'
cyclic_test.c:(.text+0x20): undefined reference to `alchemy_clock'
/tmp/ccNmb1Fm.o: In function `loop_task_proc':
cyclic_test.c:(.text+0x32): undefined reference to `rt_task_self'
cyclic_test.c:(.text+0x40): undefined reference to `rt_task_inquire'
cyclic_test.c:(.text+0x76): undefined reference to `rt_task_set_periodic'
cyclic_test.c:(.text+0xc4): undefined reference to `rt_task_wait_period'
/tmp/ccNmb1Fm.o: In function `main':
cyclic_test.c:(.text+0x11c): undefined reference to `rt_task_create'
cyclic_test.c:(.text+0x12e): undefined reference to `rt_task_start'
collect2: error: ld returned 1 exit status
Makefile:10: recipe for target 'cyclic_test' failed
make: *** [cyclic_test] Error 1

Can you advise me plase?
Thank you very much.

Best Regards
Davide Brunelli

*Electronic Vbm Group*
e-mail: electronic2@vbm-grp.com <mailto:electronic2@vbm-grp.com>

Vbm Group <http://service.vbm-grp.com/signature/logogrp.png>


Vbm Group Vbm Group Vbm Group


*Vbm Group is a trademark of VI.BE.MAC S.p.a.*

*Declaration according to Law No. 196 of 30 June 2003*
We hereby inform you that your data will be treated automatically,=20
according to the current security regulations for written=20
correspondence; your data will not be spread by Vi.Be.Mac. Spa. In any=20
way, as far as your data are concerned, you have the rights indicated in=20
art. No. 13 L. 675/1996 (such as access, cancellation, modification,=20
objection, etc.). Vi.Be.Mac. Spa. Is the holder of treatment of your=20
data. Vi.Be.Mac. is located in via Monte Pastello, 7/i (Vr) Italy. For=20
further information, please write to: privacy@vibemac.com According to=20
Art. No. 13 of law 196/2003, in any moment and free of any charge you=20
have the right to deny the use of your personal data to send you written=20
correspondence. You just have to advise about this by writing to:=20
privacy@vibemac.com


*Informativa ai sensi del d.lgs n. 196, 30.6.2003*
I suoi dati saranno trattati in forma automatizzata, nel rispetto delle=20
idonee misure di sicurezza, per l'invio di comunicazioni e non saranno=20
soggetti a diffusione all'esterno di Vi.Be.Mac. Spa. In relazione al=20
trattamento dei dati, potr=E0 esercitare i diritti (accesso,cancellazione, =

rettifica, opposizione, etc.) specificamente previsti dall'art. 13 L.=20
675/1996 e nelle modalit=E0 ivi contemplate. Titolare del trattamento dei=20
dati =E8 Vi.Be.Mac. Spa, con sede legale in San Giovanni Lupatoto (Vr) via =

Monte Pastello 7/i. Per informazioni scrivere a privacy@vibemac.com Ai=20
sensi dell'art. 13 del d.lgs. 196/2003, potr=E0 opporsi in ogni momento,=20
in via gratuita, al trattamento dei suoi dati al fine dell'invio di=20
analoghe comunicazioni a mezzo di posta elettronica, semplicemente=20
comunicandocelo all'indirizzo e-mail privacy@vibemac.com Qualsiasi=20
utilizzo non autorizzato del presente messaggio nonch=E8 dei suoi allegati =

=E8 vietato e potrebbe costituire reato. Se lei ha ricevuto erroneamente=20
il presente messaggio, Le saremmo grati se via e-mail ce ne comunicasse=20
la ricezione e provvedesse alla distruzione del messaggio stesso e dei=20
suoi eventuali allegati.

VI.BE.MAC s.p.a. - 37057 S. GIOVANNI LUPATOTO (VR) ITALY - Via Monte=20
Pastello, 7/i - Tel. +39 045 8778151/52 - Fax +39 045 8779024 - Cod.=20
Fisc./Partita IVA 01264050236- Cap. Soc. Euro 2.000.000,00 int. Vers. -=20
Reg. Imprese di VERONA N. 01264050236 - REA N. 170441
Societ=E0 soggetta a direzione e coordinamento di Jack Europe S.=E0.r.l.
