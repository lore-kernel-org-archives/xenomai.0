Message-ID: <f48df4840604051439g309cc53eoda87f81552c19a34@domain.hid>
Date: Wed, 5 Apr 2006 23:39:30 +0200
From: "Bruno Rouchouse" <brouchouse@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_7804_29425445.1144273170945"
Subject: [Xenomai-core] Problem compiling POSIX skin for mvm
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_7804_29425445.1144273170945
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi !

Just having a little problem compiling my posix skin for the simulator.
GFP_USER doesn't seem to be defined anywhere. Did I misconfigure something =
?
Does it have something to do with the one defined in
/usr/include/linux/gfp.h ?

Thanks.

--
Bruno Rouchouse

=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
bruno@domain.hid$ pwd
/home/bruno/sim-build/skins/posix
bruno@domain.hid$ make install
Making install in .
make[1]: Entering directory `/home/bruno/sim-build/skins/posix'
if ../../gcic/gcic -DHAVE_CONFIG_H -I. -I../../../xenomai/sim/skins/posix
-I../../include  -D_GNU_SOURCE -D__IN_XENO__
--gcic-backend=3D/home/bruno/install//libexec/gcic --skin-code
-I../../../xenomai/sim/../ksrc/skins -I../../../xenomai/sim/../include
-I../../../xenomai/sim/skins/posix/..   -g -MT shm.o -MD -MP -MF
".deps/shm.Tpo" -c -o shm.o ../../../xenomai/sim/../ksrc/skins/posix/shm.c;
\
then mv -f ".deps/shm.Tpo" ".deps/shm.Po"; else rm -f ".deps/shm.Tpo"; exit
1; fi
../../../xenomai/sim/../ksrc/skins/posix/shm.c: In function
`pse51_ftruncate':
../../../xenomai/sim/../ksrc/skins/posix/shm.c:556: `GFP_USER' undeclared
(first use in this function)
../../../xenomai/sim/../ksrc/skins/posix/shm.c:556: (Each undeclared
identifier is reported only once
../../../xenomai/sim/../ksrc/skins/posix/shm.c:556: for each function it
appears in.)
make[1]: *** [shm.o] Error 1
make[1]: Leaving directory `/home/bruno/sim-build/skins/posix'
make: *** [install-recursive] Error 1
bruno@domain.hid$ xeno-info
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux psodiem 2.6.14 #1 PREEMPT Sat Mar 18 02:04:03 CET 2006 i686 GNU/Linux

Gnu C                  3.3.5
Gnu make               3.80
util-linux             2.12p
mount                  2.12p
module-init-tools      3.1
e2fsprogs              1.35
jfsutils               1.1.6
xfsprogs               2.6.20
pcmcia-cs              3.2.5
PPP                    2.4.2
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.4
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
Modules Loaded         ipv6 speedstep_smi speedstep_lib cpufreq_userspace
cpufreq_powersave cpufreq_ondemand pcnet_cs 8390 pcmcia firmware_class vide=
o
thermal processor ibm_acpi fan container button battery ac af_packet usbhid
i2c_piix4 uhci_hcd usbcore snd_cs46xx gameport snd_rawmidi snd_seq_device
snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd
soundcore snd_page_alloc yenta_socket rsrc_nonstatic pcmcia_core pci_hotplu=
g
intel_agp agpgart irtty_sir sir_dev irda crc_ccitt rtc pcspkr tsdev md_mod
dm_mod psmouse mousedev lp unix
bruno@domain.hid$

------=_Part_7804_29425445.1144273170945
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi !<br>
<br>
Just having a little problem compiling my posix skin for the simulator.
GFP_USER doesn't seem to be defined anywhere. Did I misconfigure
something ? Does it have something to do with the one defined in
/usr/include/linux/gfp.h ?<br>
<br>
Thanks.<br>
<br>
--<br>
Bruno Rouchouse<br>
<br>
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D<br>
bruno@domain.hid$ pwd<br>
/home/bruno/sim-build/skins/posix<br>
bruno@domain.hid$ make install<br>
Making install in .<br>
make[1]: Entering directory `/home/bruno/sim-build/skins/posix'<br>
if ../../gcic/gcic -DHAVE_CONFIG_H -I.
-I../../../xenomai/sim/skins/posix -I../../include&nbsp; -D_GNU_SOURCE
-D__IN_XENO__ --gcic-backend=3D/home/bruno/install//libexec/gcic
--skin-code&nbsp; -I../../../xenomai/sim/../ksrc/skins
-I../../../xenomai/sim/../include
-I../../../xenomai/sim/skins/posix/..&nbsp;&nbsp; -g -MT shm.o -MD -MP
-MF &quot;.deps/shm.Tpo&quot; -c -o shm.o
../../../xenomai/sim/../ksrc/skins/posix/shm.c; \<br>
then mv -f &quot;.deps/shm.Tpo&quot; &quot;.deps/shm.Po&quot;; else rm -f &=
quot;.deps/shm.Tpo&quot;; exit 1; fi<br>
../../../xenomai/sim/../ksrc/skins/posix/shm.c: In function `pse51_ftruncat=
e':<br>
../../../xenomai/sim/../ksrc/skins/posix/shm.c:556: `GFP_USER' undeclared (=
first use in this function)<br>
../../../xenomai/sim/../ksrc/skins/posix/shm.c:556: (Each undeclared identi=
fier is reported only once<br>
../../../xenomai/sim/../ksrc/skins/posix/shm.c:556: for each function it ap=
pears in.)<br>
make[1]: *** [shm.o] Error 1<br>
make[1]: Leaving directory `/home/bruno/sim-build/skins/posix'<br>
make: *** [install-recursive] Error 1<br>
bruno@domain.hid$ xeno-info <br>
If some fields are empty or look unusual you may have an old version.<br>
Compare to the current minimal requirements in Documentation/Changes.<br>
&nbsp;<br>
Linux psodiem 2.6.14 #1 PREEMPT Sat Mar 18 02:04:03 CET 2006 i686 GNU/Linux=
<br>
&nbsp;<br>
Gnu C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.3.5<br>
Gnu make&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 3.80<br>
util-linux&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 2.12p<br>
mount&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.12p<br>
module-init-tools&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.1<br>
e2fsprogs&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 1.35<br>
jfsutils&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 1.1.6<br>
xfsprogs&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 2.6.20<br>
pcmcia-cs&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 3.2.5<br>
PPP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.4.2<br>
Linux C Library&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.3.2<br>
Dynamic linker (ldd)&nbsp;&nbsp; 2.3.2<br>
Procps&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 3.2.4<br>
Net-tools&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 1.60<br>
Console-tools&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.2.3<b=
r>
Sh-utils&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 5.2.1<br>
Modules Loaded&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ipv6
speedstep_smi speedstep_lib cpufreq_userspace cpufreq_powersave
cpufreq_ondemand pcnet_cs 8390 pcmcia firmware_class video thermal
processor ibm_acpi fan container button battery ac af_packet usbhid
i2c_piix4 uhci_hcd usbcore snd_cs46xx gameport snd_rawmidi
snd_seq_device snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss
snd_pcm snd_timer snd soundcore snd_page_alloc yenta_socket
rsrc_nonstatic pcmcia_core pci_hotplug intel_agp agpgart irtty_sir
sir_dev irda crc_ccitt rtc pcspkr tsdev md_mod dm_mod psmouse mousedev
lp unix<br>
bruno@domain.hid$ <br>

------=_Part_7804_29425445.1144273170945--

