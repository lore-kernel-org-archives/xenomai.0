Message-ID: <15183185.1178867312688.JavaMail.ngmail@domain.hid>
Date: Fri, 11 May 2007 09:08:32 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Xenomai and futexes - Native API optimized
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: stephane.fillod@domain.hid, jan.kiszka@domain.hid, mathias_koehrer@domain.hid
Cc: xenomai@xenomai.org

Hi,

here are my latest results:
I included xeno_nucleus and xeno_native into the kernel. (see first oprofil=
e result).
(I also added debug information to the kernel which was of no additional he=
lp).
I detected that most of the time was spent in __ipipe_hard_cpuid.
I looked at that routine and broke that using 2 additional helper functions=
 that are use
to "monitor" the apic_read() resp. the GET_APIC_ID calls (see patch below).
The results of this experiment can be found at "second oprofile result" bel=
ow.
When I interpret the results correctly, then it looks as if the apic_read()=
 is actually
eating up the performance. As this call "leaves" the CPU internal "area" an=
d accesses the external=20
APIC this sounds sensible.
I think this is done here to detect the current CPU.
Is it possible to detect differently or to store that information somehow w=
ith a thread (TLS)
to avoid requesting it frequently?
=20
I hope that helps a little bit to identify this issue and (perhaps) to find=
 a faster solution.
Thanks for all feedback on this!

Regards

Mathias

------------ Begin of patch -----------------
--- ipipe.c.orig        2007-05-09 16:16:32.000000000 +0200
+++ ipipe.c     2007-05-11 08:47:41.000000000 +0200
@@ -72,13 +72,30 @@

 int (*__ipipe_logical_cpuid)(void) =3D &__ipipe_boot_cpuid;

+
+unsigned long __ipipe_hard_cpuid_apic_read(void)
+{
+    return apic_read(APIC_ID);
+}
+
+unsigned __ipipe_hard_cpuid_get_apic_id(unsigned long apic)
+{
+        return GET_APIC_ID(apic);
+}
+
+
 static notrace int __ipipe_hard_cpuid(void)
 {
        unsigned long flags;
        int cpu;
+        unsigned long apic;
+        unsigned apic_id;

        local_irq_save_hw_notrace(flags);
-       cpu =3D __ipipe_apicid_2_cpu[GET_APIC_ID(apic_read(APIC_ID))];
+       // cpu =3D __ipipe_apicid_2_cpu[GET_APIC_ID(apic_read(APIC_ID))];
+        apic =3D __ipipe_hard_cpuid_apic_read();
+        apic_id =3D __ipipe_hard_cpuid_get_apic_id(apic);
+        cpu =3D __ipipe_apicid_2_cpu[apic_id];
        local_irq_restore_hw_notrace(flags);
        return cpu;
 }
--------- End of patch=20

------------- First oprofile result: -----------------------------
Using default event: GLOBAL_POWER_EVENTS:100000:1:1:1
Daemon started.
Profiler running.
delta is 50404054895 per step: 5040
Stopping profiling.
CPU: P4 / Xeon, speed 3192.16 MHz (estimated)
Counted GLOBAL_POWER_EVENTS events (time during which processor is not stop=
ped) with a unit mask of 0x01 (ma
ndatory) count 100000
samples  %        image name               app name                 symbol =
name
6273     56.8928  vmlinux                  vmlinux                  __ipipe=
_hard_cpuid
900       8.1625  vmlinux                  vmlinux                  rt_sem_=
v
694       6.2942  vmlinux                  vmlinux                  xnregis=
try_fetch
321       2.9113  vmlinux                  vmlinux                  __ipipe=
_dispatch_event
293       2.6574  bash                     bash                     (no sym=
bols)
250       2.2674  vmlinux                  vmlinux                  hrtimer=
_run_queues
227       2.0588  libc-2.3.6.so            libc-2.3.6.so            (no sym=
bols)
140       1.2697  vmlinux                  vmlinux                  delay_t=
sc
123       1.1155  libnative.so.0.0.0       libnative.so.0.0.0       rt_sem_=
p
103       0.9342  vmlinux                  vmlinux                  __ipipe=
_stall_root
78        0.7074  vmlinux                  vmlinux                  __ipipe=
_test_and_stall_root
67        0.6077  vmlinux                  vmlinux                  apic_ti=
mer_interrupt
66        0.5986  vmlinux                  vmlinux                  sysente=
r_past_esp
60        0.5442  vmlinux                  vmlinux                  __ipipe=
_restore_pipeline_head
56        0.5079  vmlinux                  vmlinux                  do_wp_p=
age
56        0.5079  vmlinux                  vmlinux                  search_=
by_key
54        0.4898  oprofiled                oprofiled                (no sym=
bols)
41        0.3718  vmlinux                  vmlinux                  __ipipe=
_sync_stage
37        0.3356  ld-2.3.6.so              ld-2.3.6.so              do_look=
up_x
37        0.3356  vmlinux                  vmlinux                  __handl=
e_mm_fault
25        0.2267  vmlinux                  vmlinux                  __ipipe=
_handle_exception
25        0.2267  vmlinux                  vmlinux                  find_ge=
t_page
25        0.2267  vmlinux                  vmlinux                  get_pag=
e_from_freelist
25        0.2267  vmlinux                  vmlinux                  run_tim=
er_softirq
25        0.2267  vmlinux                  vmlinux                  schedul=
er_tick
24        0.2177  vmlinux                  vmlinux                  sysente=
r_exit
23        0.2086  vmlinux                  vmlinux                  __ipipe=
_syscall_root
23        0.2086  vmlinux                  vmlinux                  __ipipe=
_unstall_root
22        0.1995  libnative.so.0.0.0       libnative.so.0.0.0       rt_sem_=
v
21        0.1905  vmlinux                  vmlinux                  __ipipe=
_test_root
21        0.1905  vmlinux                  vmlinux                  ata_bmd=
ma_start
19        0.1723  ld-2.3.6.so              ld-2.3.6.so              strcmp
19        0.1723  vmlinux                  vmlinux                  ata_alt=
status
19        0.1723  vmlinux                  vmlinux                  ata_bmd=
ma_irq_clear
18        0.1633  oprofile                 oprofile                 (no sym=
bols)
18        0.1633  vmlinux                  vmlinux                  find_vm=
a
18        0.1633  vmlinux                  vmlinux                  flush_t=
lb_page
18        0.1633  vmlinux                  vmlinux                  release=
_pages
18        0.1633  vmlinux                  vmlinux                  unmap_v=
mas
17        0.1542  ld-2.3.6.so              ld-2.3.6.so              _dl_rel=
ocate_object
17        0.1542  vmlinux                  vmlinux                  __ipipe=
_unstall_iret_root
---------------------------------------------

------------- Second oprofile result: -----------------------------
Using default event: GLOBAL_POWER_EVENTS:100000:1:1:1
Daemon started.
Profiler running.
delta is 51846556098 per step: 5184
Stopping profiling.
CPU: P4 / Xeon, speed 3192.33 MHz (estimated)
Counted GLOBAL_POWER_EVENTS events (time during which processor is not stop=
ped) with a unit mask of 0x01 (ma
ndatory) count 100000
samples  %        image name               app name                 symbol =
name
4350     39.4307  vmlinux                  vmlinux                  __ipipe=
_hard_cpuid_apic_read
2336     21.1748  vmlinux                  vmlinux                  __ipipe=
_hard_cpuid
306       2.7737  bash                     bash                     (no sym=
bols)
287       2.6015  vmlinux                  vmlinux                  __ipipe=
_dispatch_event
276       2.5018  vmlinux                  vmlinux                  sysente=
r_past_esp
269       2.4384  vmlinux                  vmlinux                  hrtimer=
_run_queues
264       2.3930  vmlinux                  vmlinux                  __ipipe=
_syscall_root
245       2.2208  vmlinux                  vmlinux                  xnregis=
try_fetch
209       1.8945  libc-2.3.6.so            libc-2.3.6.so            (no sym=
bols)
173       1.5682  vmlinux                  vmlinux                  rt_sem_=
v
154       1.3959  vmlinux                  vmlinux                  __ipipe=
_restore_pipeline_head
128       1.1603  vmlinux                  vmlinux                  __copy_=
from_user_ll_nozero
102       0.9246  vmlinux                  vmlinux                  delay_t=
sc
100       0.9065  vmlinux                  vmlinux                  __ipipe=
_stall_root
100       0.9065  vmlinux                  vmlinux                  hisysca=
ll_event
90        0.8158  vmlinux                  vmlinux                  apic_ti=
mer_interrupt
89        0.8067  vmlinux                  vmlinux                  __ipipe=
_test_and_stall_root
80        0.7252  vmlinux                  vmlinux                  rt_sem_=
p
74        0.6708  vmlinux                  vmlinux                  sysente=
r_exit
58        0.5257  vmlinux                  vmlinux                  do_wp_p=
age
53        0.4804  oprofiled                oprofiled                (no sym=
bols)
53        0.4804  vmlinux                  vmlinux                  search_=
by_key
50        0.4532  vmlinux                  vmlinux                  __ipipe=
_sync_stage
40        0.3626  vmlinux                  vmlinux                  __rt_se=
m_v
39        0.3535  vmlinux                  vmlinux                  __rt_se=
m_p
31        0.2810  ld-2.3.6.so              ld-2.3.6.so              do_look=
up_x
30        0.2719  vmlinux                  vmlinux                  find_ge=
t_page
27        0.2447  vmlinux                  vmlinux                  ata_bmd=
ma_start
24        0.2175  vmlinux                  vmlinux                  __ipipe=
_unstall_root
24        0.2175  vmlinux                  vmlinux                  run_tim=
er_softirq
23        0.2085  vmlinux                  vmlinux                  unmap_v=
mas
22        0.1994  vmlinux                  vmlinux                  flush_t=
lb_page
21        0.1904  ld-2.3.6.so              ld-2.3.6.so              strcmp
21        0.1904  vmlinux                  vmlinux                  __handl=
e_mm_fault
19        0.1722  vmlinux                  vmlinux                  __ipipe=
_test_root
18        0.1632  vmlinux                  vmlinux                  do_page=
_fault
17        0.1541  oprofile                 oprofile                 (no sym=
bols)
17        0.1541  vmlinux                  vmlinux                  __ipipe=
_handle_exception
16        0.1450  vmlinux                  vmlinux                  __d_loo=
kup
15        0.1360  vmlinux                  vmlinux                  filemap=
_nopage
15        0.1360  vmlinux                  vmlinux                  get_pag=
e_from_freelist
15        0.1360  vmlinux                  vmlinux                  page_re=
move_rmap
15        0.1360  vmlinux                  vmlinux                  restore=
_nocheck_notrace
14        0.1269  vmlinux                  vmlinux                  _atomic=
_dec_and_lock
14        0.1269  vmlinux                  vmlinux                  copy_pa=
ge_range
14        0.1269  vmlinux                  vmlinux                  schedul=
er_tick
12        0.1088  ld-2.3.6.so              ld-2.3.6.so              _dl_rel=
ocate_object
12        0.1088  vmlinux                  vmlinux                  __find_=
get_block
12        0.1088  vmlinux                  vmlinux                  __ipipe=
_unstall_iret_root
--------------------------------------------------------------


> define CONFIG_XENO_OPT_DEBUG and CONFIG_DEBUG_KERNEL/CONFIG_DEBUG_INFO
> to have symbols and all. OProfile is only able to look up virtual
> address
> when debug symbols are present in file. You may have to pass the=20
> --vmlinux option to opcontrol. Compiling Xenomai like suggested by Jan
> will make your life easier, and will bring you an extra mini speedup
> if you're in that kind of business.
>=20
> --=20
> Stephane
>=20


--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  39,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2

