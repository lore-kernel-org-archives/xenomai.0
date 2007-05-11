Message-ID: <22454399.1178869062098.JavaMail.ngmail@domain.hid>
Date: Fri, 11 May 2007 09:37:42 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <15183185.1178867312688.JavaMail.ngmail@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <15183185.1178867312688.JavaMail.ngmail@domain.hid>
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

Hi!

As written in my mail before, I measured that the time is lost in __ipipe_h=
ard_cpuid.
This function will only be called with a SMP setup.
I have now disabled SMP in my kernel (but enabled APIC and  IO APIC) to do =
the same experiment.
And the result with a UP system is dramatically better!!!!
It is now less than 1microsecond per loop (compared against about 5 microse=
conds in SMP).
See below the oprofile output for UP.

Regards

Mathias
--------------------------------------------- oprofile output for UP ------=
----------
Using default event: GLOBAL_POWER_EVENTS:100000:1:1:1
Daemon started.
Profiler running.
delta is 9190565309 per step: 919
Stopping profiling.
CPU: P4 / Xeon, speed 3192.2 MHz (estimated)
Counted GLOBAL_POWER_EVENTS events (time during which processor is not stop=
ped) with a unit mask of 0x01 (ma
ndatory) count 100000
samples  %        image name               app name                 symbol =
name
1669     18.5115  vmlinux                  vmlinux                  __ipipe=
_dispatch_event
985      10.9250  vmlinux                  vmlinux                  sysente=
r_past_esp
711       7.8860  vmlinux                  vmlinux                  xnregis=
try_fetch
550       6.1003  libc-2.3.6.so            libc-2.3.6.so            (no sym=
bols)
479       5.3128  vmlinux                  vmlinux                  __copy_=
from_user_ll_nozero
474       5.2573  vmlinux                  vmlinux                  __ipipe=
_restore_pipeline_head
471       5.2240  vmlinux                  vmlinux                  rt_sem_=
p
451       5.0022  vmlinux                  vmlinux                  search_=
by_key
294       3.2609  bash                     bash                     (no sym=
bols)
240       2.6619  vmlinux                  vmlinux                  hisysca=
ll_event
237       2.6287  vmlinux                  vmlinux                  rt_sem_=
v
236       2.6176  libnative.so.0.0.0       libnative.so.0.0.0       rt_sem_=
p
156       1.7303  libnative.so.0.0.0       libnative.so.0.0.0       rt_sem_=
v
145       1.6083  performance              performance              mytaska
61        0.6766  vmlinux                  vmlinux                  do_wp_p=
age
60        0.6655  vmlinux                  vmlinux                  acpi_pm=
_read
56        0.6211  vmlinux                  vmlinux                  __find_=
get_block
53        0.5878  vmlinux                  vmlinux                  memset
52        0.5768  oprofiled                oprofiled                (no sym=
bols)
43        0.4769  ld-2.3.6.so              ld-2.3.6.so              do_look=
up_x
34        0.3771  syslogd                  syslogd                  (no sym=
bols)
34        0.3771  vmlinux                  vmlinux                  release=
_console_sem
33        0.3660  vmlinux                  vmlinux                  __ipipe=
_unstall_root
33        0.3660  vmlinux                  vmlinux                  memcpy
31        0.3438  vmlinux                  vmlinux                  do_jour=
nal_end
30        0.3327  klogd                    klogd                    (no sym=
bols)
30        0.3327  vmlinux                  vmlinux                  unmap_v=
mas
29        0.3217  oprofile                 oprofile                 (no sym=
bols)
27        0.2995  vmlinux                  vmlinux                  __copy_=
from_user_ll
27        0.2995  vmlinux                  vmlinux                  do_con_=
write
27        0.2995  vmlinux                  vmlinux                  ll_rw_b=
lock
25        0.2773  vmlinux                  vmlinux                  do_sysl=
og
21        0.2329  ld-2.3.6.so              ld-2.3.6.so              strcmp
21        0.2329  vmlinux                  vmlinux                  get_pag=
e_from_freelist
21        0.2329  vmlinux                  vmlinux                  sysente=
r_exit
21        0.2329  vmlinux                  vmlinux                  write_c=
han
19        0.2107  vmlinux                  vmlinux                  __handl=
e_mm_fault
19        0.2107  vmlinux                  vmlinux                  __ipipe=
_unstall_iret_root
19        0.2107  vmlinux                  vmlinux                  generic=
_file_buffered_write
18        0.1996  vmlinux                  vmlinux                  bit_wai=
tqueue
18        0.1996  vmlinux                  vmlinux                  reiserf=
s_update_sd_size
17        0.1886  vmlinux                  vmlinux                  journal=
_mark_dirty
17        0.1886  vmlinux                  vmlinux                  reiserf=
s_prepare_for_journal
17        0.1886  vmlinux                  vmlinux                  vsnprin=
tf
16        0.1775  vmlinux                  vmlinux                  unlock_=
buffer
15        0.1664  vmlinux                  vmlinux                  memmove
15        0.1664  vmlinux                  vmlinux                  number
14        0.1553  vmlinux                  vmlinux                  __link_=
path_walk
14        0.1553  vmlinux                  vmlinux                  conv_un=
i_to_pc
14        0.1553  vmlinux                  vmlinux                  kmem_ca=
che_alloc
14        0.1553  vmlinux                  vmlinux                  radix_t=
ree_lookup
13        0.1442  ld-2.3.6.so              ld-2.3.6.so              _dl_rel=
ocate_object
13        0.1442  vmlinux                  vmlinux                  get_num=
_ver
12        0.1331  vmlinux                  vmlinux                  __d_loo=
kup
12        0.1331  vmlinux                  vmlinux                  __ipipe=
_handle_exception
11        0.1220  vmlinux                  vmlinux                  __block=
_prepare_write
l--------------------------------------

=20


--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  39,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2

