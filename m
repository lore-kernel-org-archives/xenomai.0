Message-ID: <30635766.1178804493587.JavaMail.ngmail@domain.hid>
Date: Thu, 10 May 2007 15:41:33 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <25556725.1178802170156.JavaMail.ngmail@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <25556725.1178802170156.JavaMail.ngmail@domain.hid>
	<4642E54B.3060600@domain.hid>
	<1178727256.11688.35.camel@domain.hid>	<22908039.1178707932628.JavaMail.ngmail@domain.hid>
	<12120203.1178785866207.JavaMail.ngmail@domain.hid>
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
To: jan.kiszka@domain.hid, mathias_koehrer@domain.hid
Cc: xenomai@xenomai.org

Hi Jan,

here is the (truncated) output of opreport -l (which seems to be more usefu=
l...).

Regards

Mathias
------------------
Profiler running.
delta is 2030247695 per step: 5075
Stopping profiling.
CPU: P4 / Xeon, speed 3192.18 MHz (estimated)
Counted GLOBAL_POWER_EVENTS events (time during which processor is not stop=
ped) with a unit mask of 0x01 (mandatory) count 100000
samples  %        image name               app name                 symbol =
name
27423    64.2074  vmlinux                  vmlinux                  __ipipe=
_hard_cpuid
2309      5.4062  xeno_nucleus             xeno_nucleus             (no sym=
bols)
1489      3.4863  bash                     bash                     (no sym=
bols)
1226      2.8705  vmlinux                  vmlinux                  sysente=
r_past_esp
1209      2.8307  xeno_native              xeno_native              (no sym=
bols)
1091      2.5544  libc-2.3.6.so            libc-2.3.6.so            (no sym=
bols)
792       1.8544  vmlinux                  vmlinux                  __ipipe=
_syscall_root
700       1.6390  vmlinux                  vmlinux                  __ipipe=
_dispatch_event
581       1.3603  vmlinux                  vmlinux                  page_fa=
ult
316       0.7399  vmlinux                  vmlinux                  __ipipe=
_stall_root
264       0.6181  vmlinux                  vmlinux                  do_wp_p=
age
232       0.5432  oprofiled                oprofiled                (no sym=
bols)
227       0.5315  vmlinux                  vmlinux                  __ipipe=
_test_and_stall_root
177       0.4144  ld-2.3.6.so              ld-2.3.6.so              do_look=
up_x
157       0.3676  vmlinux                  vmlinux                  find_ge=
t_page
156       0.3653  vmlinux                  vmlinux                  __copy_=
from_user_ll_nozero
156       0.3653  vmlinux                  vmlinux                  __handl=
e_mm_fault
128       0.2997  performance              performance              mytaska
122       0.2856  ld-2.3.6.so              ld-2.3.6.so              strcmp
106       0.2482  vmlinux                  vmlinux                  unmap_v=
mas
105       0.2458  vmlinux                  vmlinux                  __ipipe=
_handle_exception
97        0.2271  vmlinux                  vmlinux                  get_pag=
e_from_freelist
92        0.2154  vmlinux                  vmlinux                  search_=
by_key
86        0.2014  vmlinux                  vmlinux                  page_re=
move_rmap
85        0.1990  vmlinux                  vmlinux                  flush_t=
lb_page
82        0.1920  vmlinux                  vmlinux                  timer_i=
nterrupt
78        0.1826  vmlinux                  vmlinux                  filemap=
_nopage
77        0.1803  vmlinux                  vmlinux                  __ipipe=
_unstall_root
75        0.1756  vmlinux                  vmlinux                  release=
_pages
73        0.1709  oprofile                 oprofile                 (no sym=
bols)
66        0.1545  vmlinux                  vmlinux                  __ipipe=
_restore_pipeline_head
64        0.1498  vmlinux                  vmlinux                  mwait_i=
dle_with_hints
62        0.1452  ld-2.3.6.so              ld-2.3.6.so              _dl_rel=
ocate_object
60        0.1405  vmlinux                  vmlinux                  copy_pa=
ge_range
60        0.1405  vmlinux                  vmlinux                  find_vm=
a
56        0.1311  vmlinux                  vmlinux                  hrtimer=
_run_queues
52        0.1218  vmlinux                  vmlinux                  __ipipe=
_test_root
52        0.1218  vmlinux                  vmlinux                  up_read
50        0.1171  vmlinux                  vmlinux                  __ipipe=
_unstall_iret_root
49        0.1147  vmlinux                  vmlinux                  do_page=
_fault
47        0.1100  e1000                    e1000                    (no sym=
bols)
47        0.1100  vmlinux                  vmlinux                  down_re=
ad_trylock
46        0.1077  vmlinux                  vmlinux                  error_c=
ode
40        0.0937  vmlinux                  vmlinux                  __ipipe=
_sync_stage
---------------------------
=20


>=20
> >=20
> > Mind to run oprofile on this setup to see where costs primarily come
> from?
> >=20


--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  39,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2

