From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Sat, 28 Oct 2006 00:31:57 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200610280031.57642.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Buildbot failure for sim since r1758
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi

I get the following error on my buildbot:
(see http://ngiger.dyndns.org/buildbot/sim_q/builds/133/step-make_sim/1)

make[1]: Entering directory `/var/buildbot/slave/sim_q/build/sim/adapter'
if=20
g++ -DHAVE_CONFIG_H -I. -I. -I../include -D__XENO_SIM__ -fno-exceptions -I.=
/.. -I./../../include    -O2 -MT=20
adapter.o -MD -MP -MF ".deps/adapter.Tpo" -c -o adapter.o adapter.cc; \
        then mv -f ".deps/adapter.Tpo" ".deps/adapter.Po"; else=20
rm -f ".deps/adapter.Tpo"; exit 1; fi
In Datei, eingef=FCgt von ./../../include/nucleus/pod.h:34,
                    von adapter.cc:23:
=2E/../../include/nucleus/thread.h:108:26: Fehler: nucleus/stat.h: Datei od=
er=20
Verzeichnis nicht gefunden
=2E/../../include/nucleus/thread.h:164: Fehler: =BBxnstat_counter_t=AB beze=
ichnet=20
keinen Typ
=2E/../../include/nucleus/thread.h:165: Fehler: =BBxnstat_counter_t=AB beze=
ichnet=20
keinen Typ
=2E/../../include/nucleus/thread.h:166: Fehler: =BBxnstat_counter_t=AB beze=
ichnet=20
keinen Typ
=2E/../../include/nucleus/thread.h:167: Fehler: =BBxnstat_runtime_t=AB beze=
ichnet=20
keinen Typ
=2E/../../include/nucleus/intr.h:65: Fehler: =BBxnstat_counter_t=AB bezeich=
net=20
keinen Typ
=2E/../../include/nucleus/intr.h:66: Fehler: =BBxnstat_runtime_t=AB bezeich=
net=20
keinen Typ
=2E/../../include/nucleus/intr.h:67: Fehler: =BBRTHAL_NR_CPUS=AB wurde in d=
iesem=20
G=FCltigkeitsbereich nicht definiert
make[1]: *** [adapter.o] Fehler 1
make[1]: Leaving directory `/var/buildbot/slave/sim_q/build/sim/adapter'
make: *** [all-recursive] Fehler 1
program finished with exit code 2

Starting with a virgen check out didn't cure the problem see:
http://ngiger.dyndns.org/buildbot/sim_q/builds/139/step-make_sim/1

Best regards=20

=2D-=20
Niklaus Giger

