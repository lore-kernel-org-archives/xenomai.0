MIME-Version: 1.0
In-Reply-To: <4E7C46C7.4050203@domain.hid>
References: <CAL8zT=g-Mo1VDk2X9zE1d=j-k2wVRFVeNVHEuX50p7Bee5rKaQ@mail.gmail.com>
	<4E7C46C7.4050203@domain.hid>
From: Jean-Michel Hautbois <jhautbois@domain.hid>
Date: Fri, 23 Sep 2011 11:21:47 +0200
Message-ID: <CAL8zT=i-c0Oib2giMNcqe8_ZBh-qBHn9zHy0xZUCN=ii6p2vPQ@mail.gmail.com>
Content-Type: multipart/alternative; boundary=20cf30025e5ad5b75904ad985768
Subject: Re: [Xenomai-core] P2020 support for ftrace with ipipe 2.12-01 and
 xeno 2.5.5.1
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai-core@domain.hid

--20cf30025e5ad5b75904ad985768
Content-Type: text/plain; charset=UTF-8

Yes, ipipe tracing works.
When it is the case, BTW, Here is the result of echoing a new tracer :

$>cat max
I-pipe worst-case tracing service on 2.6.35.11/ipipe-2.12-01
------------------------------
------------------------------
CPU: 0, Begin: 2593605556 cycles, Trace Points: 12 (-10/+5), Length: 268166
us
Calibrated minimum trace-point overhead: 0.023 us

 +----- Hard IRQs ('|': locked)
 |+---- <unused>
 ||+--- <unused>
 |||+-- Xenomai
 ||||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
 |||||                        +---------- Delay flag ('+': > 1 us, '!': > 10
us)
 |||||                        |        +- NMI noise ('N')
 |||||                        |        |
      Type    User Val.   Time    Delay  Function (Parent)
     #func                   0    0.039  ipipe_check_context+0x8
(tick_nohz_stop_sched_tick+0x31c)
 |   #begin   0x80000001     0    0.051  ipipe_check_context+0xf0
(tick_nohz_stop_sched_tick+0x31c)
 |   #end     0x80000001     0    0.039  ipipe_check_context+0xdc
(tick_nohz_stop_sched_tick+0x31c)
     #func                   0    0.039  __ipipe_unstall_root+0x8
(tick_nohz_stop_sched_tick+0x320)
 |   #begin   0x80000000     0    0.043  __ipipe_unstall_root+0xbc
(tick_nohz_stop_sched_tick+0x320)
 |   #func                   0    0.058  ipipe_check_context+0x8
(__ipipe_unstall_root+0x3c)
 |   +end     0x80000000     0    0.046  __ipipe_unstall_root+0xa8
(tick_nohz_stop_sched_tick+0x320)
     +func                   0    0.041  ipipe_suspend_domain+0x8
(cpu_idle+0xb0)
 |   +begin   0x80000001     0    0.060  ipipe_suspend_domain+0x1e0
(cpu_idle+0xb0)
 |   +end     0x80000001     0    0.043  ipipe_suspend_domain+0x220
(cpu_idle+0xb0)
>|   +begin   0x80000000     0! 2146.524  cpu_idle+0xe8 (rest_init+0x94)
:|   +func               268166    0.045  __ipipe_grab_timer+0x8
(__ipipe_ret_from_except+0x0)
:|   +begin   0x00000200 268166    0.046  __ipipe_grab_timer+0x84
(__ipipe_ret_from_except+0x0)
:|   +func               268166    0.060  __ipipe_dispatch_wired_nocheck+0x8
(__ipipe_grab_timer+0x138)
:|  # func               268166    0.054  xnintr_clock_handler+0x8
(__ipipe_dispatch_wired_nocheck+0x104)
:|  # func               268166    0.050  xntimer_tick_aperiodic+0x8
(xnintr_clock_handler+0xd0)
:|  # func               268166    0.060  xntimer_next_local_shot+0x8
(xntimer_tick_aperiodic+0x304)
:|  # func               268166    0.049  xnintr_host_tick+0x8
(xnintr_clock_handler+0x1f4)
:|  # func               268166    0.085  __ipipe_set_irq_pending+0x8
(xnintr_host_tick+0x94)
:|   +func               268166    0.065  __ipipe_walk_pipeline+0x8
(__ipipe_dispatch_wired_nocheck+0x148)
:|   +func               268166    0.061  __ipipe_sync_stage+0x8
(__ipipe_walk_pipeline+0x1a8)
<|   #end     0x80000000 268166    0.042  __ipipe_sync_stage+0x238
(__ipipe_walk_pipeline+0x1a8)
     #func               268166    0.042  irq_enter+0x8
(__ipipe_sync_stage+0x260)
     #func               268166    0.046  rcu_irq_enter+0x8 (irq_enter+0x38)
     #func               268167    0.043  idle_cpu+0x8 (irq_enter+0x44)
     #func               268167    0.039  ipipe_check_context+0x8
(irq_enter+0x84)
 |   #begin   0x80000001 268167    0.000  ipipe_check_context+0xf0
(irq_enter+0x84)


$>echo function_graph > current_tracer
[  275.698664] ------------[ cut here ]------------
[  275.755250] ------------[ cut here ]------------
[  275.810547] Kernel stack overflow in process dc6bf020, r1=dc838250
[  275.896276] Kernel panic - not syncing: kernel stack overflow
[  275.965200] Rebooting in 30 seconds..

2011/9/23 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> On 09/23/2011 09:58 AM, Jean-Michel Hautbois wrote:
> > Hi List,
> >
> > I am trying to use ftrace on a P2020 board, using the following :
> > - Linux 2.6.35-11
> > - Xenomai 2.5.5.1 (or 2.5.6, same problem)
> > - ipipe 2.12-01
> >
> > I launch it using :
> > $> mkdir /tmp/debug
> > $> mount -t debugfs nodev /tmp/debug
> > $> cd /tmp/debug/tracing
> > $> echo function_graph > current_tracer
> >
> > The last one fails (it hangs the CPU, I cannot do anything than hard
> reset).
> > Do you know what could cause that ?
> > As I can't have any trace, I don't really know how to go further, and
> before
> > using a BDI I would like to know if it is a known issue, as I could not
> find
> > anything related to this in the recent changes...
> >
> > Thanks in advance for your help,
> > Regards,
> > JM
>
> Does the I-pipe tracer work?
> See:
> http://www.xenomai.org/index.php/I-pipe:Tracer
>
>
> --
>                                            Gilles.
>

--20cf30025e5ad5b75904ad985768
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

WWVzLCBpcGlwZSB0cmFjaW5nIHdvcmtzLjxicj5XaGVuIGl0IGlzIHRoZSBjYXNlLCBCVFcsIEhl
cmUgaXMgdGhlIHJlc3VsdCBvZiBlY2hvaW5nIGEgbmV3IHRyYWNlciA6PGJyPjxicj4kJmd0O2Nh
dCBtYXg8YnI+SS1waXBlIHdvcnN0LWNhc2UgdHJhY2luZyBzZXJ2aWNlIG9uIDxhIGhyZWY9Imh0
dHA6Ly8yLjYuMzUuMTEvaXBpcGUtMi4xMi0wMSIgdGFyZ2V0PSJfYmxhbmsiPjIuNi4zNS4xMS9p
cGlwZS0yLjEyLTAxPC9hPjxicj4KCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTxkaXYg
aWQ9IjoyanEiPi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTxicj5DUFU6IDAsIEJlZ2lu
OiAyNTkzNjA1NTU2IGN5Y2xlcywgVHJhY2UgUG9pbnRzOiAxMiAoLTEwLys1KSwgTGVuZ3RoOiAy
NjgxNjYgdXM8YnI+CkNhbGlicmF0ZWQgbWluaW11bSB0cmFjZS1wb2ludCBvdmVyaGVhZDogMC4w
MjMgdXM8YnI+PGJyPsKgKy0tLS0tIEhhcmQgSVJRcyAoJiMzOTt8JiMzOTs6IGxvY2tlZCk8YnI+
wqB8Ky0tLS0gJmx0O3VudXNlZCZndDs8YnI+wqB8fCstLS0gJmx0O3VudXNlZCZndDs8YnI+wqB8
fHwrLS0gWGVub21haTxicj7CoHx8fHwrLSBMaW51eCAoJiMzOTsqJiMzOTs6IGRvbWFpbiBzdGFs
bGVkLCAmIzM5OysmIzM5OzogY3VycmVudCwgJiMzOTsjJiMzOTs6IGN1cnJlbnQrc3RhbGxlZCk8
YnI+CgoKwqB8fHx8fMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgKy0tLS0tLS0tLS0gRGVsYXkgZmxhZyAoJiMzOTsrJiMzOTs6ICZndDsgMSB1cywgJiMzOTsh
JiMzOTs6ICZndDsgMTAgdXMpPGJyPsKgfHx8fHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDCoCArLSBOTUkgbm9pc2UgKCYjMzk7TiYj
Mzk7KTxicj7CoHx8fHx8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8wqDCoMKgwqDCoMKgwqAgfDxicj7CoMKgwqDCoMKgIFR5cGXCoMKgwqAgVXNlciBWYWwu
wqDCoCBUaW1lwqDCoMKgIERlbGF5wqAgRnVuY3Rpb24gKFBhcmVudCk8YnI+CgoKwqDCoMKgwqAg
I2Z1bmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMMKgwqDCoCAwLjAzOcKg
IGlwaXBlX2NoZWNrX2NvbnRleHQrMHg4ICh0aWNrX25vaHpfc3RvcF9zY2hlZF90aWNrKzB4MzFj
KTxicj7CoHzCoMKgICNiZWdpbsKgwqAgMHg4MDAwMDAwMcKgwqDCoMKgIDDCoMKgwqAgMC4wNTHC
oCBpcGlwZV9jaGVja19jb250ZXh0KzB4ZjAgKHRpY2tfbm9oel9zdG9wX3NjaGVkX3RpY2srMHgz
MWMpPGJyPsKgfMKgwqAgI2VuZMKgwqDCoMKgIDB4ODAwMDAwMDHCoMKgwqDCoCAwwqDCoMKgIDAu
MDM5wqAgaXBpcGVfY2hlY2tfY29udGV4dCsweGRjICh0aWNrX25vaHpfc3RvcF9zY2hlZF90aWNr
KzB4MzFjKTxicj4KCgrCoMKgwqDCoCAjZnVuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAwwqDCoMKgIDAuMDM5wqAgX19pcGlwZV91bnN0YWxsX3Jvb3QrMHg4ICh0aWNrX25v
aHpfc3RvcF9zY2hlZF90aWNrKzB4MzIwKTxicj7CoHzCoMKgICNiZWdpbsKgwqAgMHg4MDAwMDAw
MMKgwqDCoMKgIDDCoMKgwqAgMC4wNDPCoCBfX2lwaXBlX3Vuc3RhbGxfcm9vdCsweGJjICh0aWNr
X25vaHpfc3RvcF9zY2hlZF90aWNrKzB4MzIwKTxicj7CoHzCoMKgICNmdW5jwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDDCoMKgwqAgMC4wNTjCoCBpcGlwZV9jaGVja19jb250
ZXh0KzB4OCAoX19pcGlwZV91bnN0YWxsX3Jvb3QrMHgzYyk8YnI+CgoKwqB8wqDCoCArZW5kwqDC
oMKgwqAgMHg4MDAwMDAwMMKgwqDCoMKgIDDCoMKgwqAgMC4wNDbCoCBfX2lwaXBlX3Vuc3RhbGxf
cm9vdCsweGE4ICh0aWNrX25vaHpfc3RvcF9zY2hlZF90aWNrKzB4MzIwKTxicj7CoMKgwqDCoCAr
ZnVuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAwwqDCoMKgIDAuMDQxwqAg
aXBpcGVfc3VzcGVuZF9kb21haW4rMHg4IChjcHVfaWRsZSsweGIwKTxicj7CoHzCoMKgICtiZWdp
bsKgwqAgMHg4MDAwMDAwMcKgwqDCoMKgIDDCoMKgwqAgMC4wNjDCoCBpcGlwZV9zdXNwZW5kX2Rv
bWFpbisweDFlMCAoY3B1X2lkbGUrMHhiMCk8YnI+CgoKwqB8wqDCoCArZW5kwqDCoMKgwqAgMHg4
MDAwMDAwMcKgwqDCoMKgIDDCoMKgwqAgMC4wNDPCoCBpcGlwZV9zdXNwZW5kX2RvbWFpbisweDIy
MCAoY3B1X2lkbGUrMHhiMCk8YnI+Jmd0O3zCoMKgICtiZWdpbsKgwqAgMHg4MDAwMDAwMMKgwqDC
oMKgIDAhIDIxNDYuNTI0wqAgY3B1X2lkbGUrMHhlOCAocmVzdF9pbml0KzB4OTQpPGJyPjp8wqDC
oCArZnVuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMjY4MTY2wqDCoMKgIDAuMDQ1wqAg
X19pcGlwZV9ncmFiX3RpbWVyKzB4OCAoX19pcGlwZV9yZXRfZnJvbV9leGNlcHQrMHgwKTxicj4K
Cgo6fMKgwqAgK2JlZ2luwqDCoCAweDAwMDAwMjAwIDI2ODE2NsKgwqDCoCAwLjA0NsKgIF9faXBp
cGVfZ3JhYl90aW1lcisweDg0IChfX2lwaXBlX3JldF9mcm9tX2V4Y2VwdCsweDApPGJyPjp8wqDC
oCArZnVuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMjY4MTY2wqDCoMKgIDAuMDYwwqAg
X19pcGlwZV9kaXNwYXRjaF93aXJlZF9ub2NoZWNrKzB4OCAoX19pcGlwZV9ncmFiX3RpbWVyKzB4
MTM4KTxicj46fMKgICMgZnVuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMjY4MTY2wqDC
oMKgIDAuMDU0wqAgeG5pbnRyX2Nsb2NrX2hhbmRsZXIrMHg4IChfX2lwaXBlX2Rpc3BhdGNoX3dp
cmVkX25vY2hlY2srMHgxMDQpPGJyPgoKCjp8wqAgIyBmdW5jwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAyNjgxNjbCoMKgwqAgMC4wNTDCoCB4bnRpbWVyX3RpY2tfYXBlcmlvZGljKzB4OCAo
eG5pbnRyX2Nsb2NrX2hhbmRsZXIrMHhkMCk8YnI+OnzCoCAjIGZ1bmPCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIDI2ODE2NsKgwqDCoCAwLjA2MMKgIHhudGltZXJfbmV4dF9sb2NhbF9zaG90
KzB4OCAoeG50aW1lcl90aWNrX2FwZXJpb2RpYysweDMwNCk8YnI+OnzCoCAjIGZ1bmPCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIDI2ODE2NsKgwqDCoCAwLjA0OcKgIHhuaW50cl9ob3N0X3Rp
Y2srMHg4ICh4bmludHJfY2xvY2tfaGFuZGxlcisweDFmNCk8YnI+CgoKOnzCoCAjIGZ1bmPCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDI2ODE2NsKgwqDCoCAwLjA4NcKgIF9faXBpcGVfc2V0
X2lycV9wZW5kaW5nKzB4OCAoeG5pbnRyX2hvc3RfdGljaysweDk0KTxicj46fMKgwqAgK2Z1bmPC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDI2ODE2NsKgwqDCoCAwLjA2NcKgIF9faXBpcGVf
d2Fsa19waXBlbGluZSsweDggKF9faXBpcGVfZGlzcGF0Y2hfd2lyZWRfbm9jaGVjaysweDE0OCk8
YnI+OnzCoMKgICtmdW5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAyNjgxNjbCoMKgwqAg
MC4wNjHCoCBfX2lwaXBlX3N5bmNfc3RhZ2UrMHg4IChfX2lwaXBlX3dhbGtfcGlwZWxpbmUrMHgx
YTgpPGJyPgoKCiZsdDt8wqDCoCAjZW5kwqDCoMKgwqAgMHg4MDAwMDAwMCAyNjgxNjbCoMKgwqAg
MC4wNDLCoCBfX2lwaXBlX3N5bmNfc3RhZ2UrMHgyMzggKF9faXBpcGVfd2Fsa19waXBlbGluZSsw
eDFhOCk8YnI+wqDCoMKgwqAgI2Z1bmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDI2ODE2
NsKgwqDCoCAwLjA0MsKgIGlycV9lbnRlcisweDggKF9faXBpcGVfc3luY19zdGFnZSsweDI2MCk8
YnI+wqDCoMKgwqAgI2Z1bmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDI2ODE2NsKgwqDC
oCAwLjA0NsKgIHJjdV9pcnFfZW50ZXIrMHg4IChpcnFfZW50ZXIrMHgzOCk8YnI+CgoKwqDCoMKg
wqAgI2Z1bmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDI2ODE2N8KgwqDCoCAwLjA0M8Kg
IGlkbGVfY3B1KzB4OCAoaXJxX2VudGVyKzB4NDQpPGJyPsKgwqDCoMKgICNmdW5jwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAyNjgxNjfCoMKgwqAgMC4wMznCoCBpcGlwZV9jaGVja19jb250
ZXh0KzB4OCAoaXJxX2VudGVyKzB4ODQpPGJyPsKgfMKgwqAgI2JlZ2luwqDCoCAweDgwMDAwMDAx
IDI2ODE2N8KgwqDCoCAwLjAwMMKgIGlwaXBlX2NoZWNrX2NvbnRleHQrMHhmMCAoaXJxX2VudGVy
KzB4ODQpPC9kaXY+Cgo8YnI+PGJyPiQmZ3Q7ZWNobyBmdW5jdGlvbl9ncmFwaCAmZ3Q7IGN1cnJl
bnRfdHJhY2VyPGJyPlvCoCAyNzUuNjk4NjY0XSAtLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0t
LS0tLS0tLS08YnI+W8KgIDI3NS43NTUyNTBdIC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0t
LS0tLS0tLTxicj5bwqAgMjc1LjgxMDU0N10gS2VybmVsIHN0YWNrIG92ZXJmbG93IGluIHByb2Nl
c3MgZGM2YmYwMjAsIHIxPWRjODM4MjUwPGJyPgoKW8KgIDI3NS44OTYyNzZdIEtlcm5lbCBwYW5p
YyAtIG5vdCBzeW5jaW5nOiBrZXJuZWwgc3RhY2sgb3ZlcmZsb3c8YnI+W8KgIDI3NS45NjUyMDBd
IFJlYm9vdGluZyBpbiAzMCBzZWNvbmRzLi48YnI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3Rl
Ij4yMDExLzkvMjMgR2lsbGVzIENoYW50ZXBlcmRyaXggPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBo
cmVmPSJtYWlsdG86Z2lsbGVzLmNoYW50ZXBlcmRyaXhAeGVub21haS5vcmciPmdpbGxlcy5jaGFu
dGVwZXJkcml4QHhlbm9tYWkub3JnPC9hPiZndDs8L3NwYW4+PGJyPgoKPGJsb2NrcXVvdGUgY2xh
c3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4
ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleDsiPjxkaXY+PGRpdj48L2Rpdj48ZGl2IGNsYXNz
PSJoNSI+T24gMDkvMjMvMjAxMSAwOTo1OCBBTSwgSmVhbi1NaWNoZWwgSGF1dGJvaXMgd3JvdGU6
PGJyPgomZ3Q7IEhpIExpc3QsPGJyPgomZ3Q7PGJyPgomZ3Q7IEkgYW0gdHJ5aW5nIHRvIHVzZSBm
dHJhY2Ugb24gYSBQMjAyMCBib2FyZCwgdXNpbmcgdGhlIGZvbGxvd2luZyA6PGJyPgomZ3Q7IC0g
TGludXggMi42LjM1LTExPGJyPgomZ3Q7IC0gWGVub21haSAyLjUuNS4xIChvciAyLjUuNiwgc2Ft
ZSBwcm9ibGVtKTxicj4KJmd0OyAtIGlwaXBlIDIuMTItMDE8YnI+CiZndDs8YnI+CiZndDsgSSBs
YXVuY2ggaXQgdXNpbmcgOjxicj4KJmd0OyAkJmd0OyBta2RpciAvdG1wL2RlYnVnPGJyPgomZ3Q7
ICQmZ3Q7IG1vdW50IC10IGRlYnVnZnMgbm9kZXYgL3RtcC9kZWJ1Zzxicj4KJmd0OyAkJmd0OyBj
ZCAvdG1wL2RlYnVnL3RyYWNpbmc8YnI+CiZndDsgJCZndDsgZWNobyBmdW5jdGlvbl9ncmFwaCAm
Z3Q7IGN1cnJlbnRfdHJhY2VyPGJyPgomZ3Q7PGJyPgomZ3Q7IFRoZSBsYXN0IG9uZSBmYWlscyAo
aXQgaGFuZ3MgdGhlIENQVSwgSSBjYW5ub3QgZG8gYW55dGhpbmcgdGhhbiBoYXJkIHJlc2V0KS48
YnI+CiZndDsgRG8geW91IGtub3cgd2hhdCBjb3VsZCBjYXVzZSB0aGF0ID88YnI+CiZndDsgQXMg
SSBjYW4mIzM5O3QgaGF2ZSBhbnkgdHJhY2UsIEkgZG9uJiMzOTt0IHJlYWxseSBrbm93IGhvdyB0
byBnbyBmdXJ0aGVyLCBhbmQgYmVmb3JlPGJyPgomZ3Q7IHVzaW5nIGEgQkRJIEkgd291bGQgbGlr
ZSB0byBrbm93IGlmIGl0IGlzIGEga25vd24gaXNzdWUsIGFzIEkgY291bGQgbm90IGZpbmQ8YnI+
CiZndDsgYW55dGhpbmcgcmVsYXRlZCB0byB0aGlzIGluIHRoZSByZWNlbnQgY2hhbmdlcy4uLjxi
cj4KJmd0Ozxicj4KJmd0OyBUaGFua3MgaW4gYWR2YW5jZSBmb3IgeW91ciBoZWxwLDxicj4KJmd0
OyBSZWdhcmRzLDxicj4KJmd0OyBKTTxicj4KPGJyPgo8L2Rpdj48L2Rpdj5Eb2VzIHRoZSBJLXBp
cGUgdHJhY2VyIHdvcms/PGJyPgpTZWU6PGJyPgo8YSBocmVmPSJodHRwOi8vd3d3Lnhlbm9tYWku
b3JnL2luZGV4LnBocC9JLXBpcGU6VHJhY2VyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cDovL3d3dy54
ZW5vbWFpLm9yZy9pbmRleC5waHAvSS1waXBlOlRyYWNlcjwvYT48YnI+Cjxmb250IGNvbG9yPSIj
ODg4ODg4Ij48YnI+Cjxicj4KLS08YnI+CiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoEdpbGxlcy48YnI+CjwvZm9udD48L2Js
b2NrcXVvdGU+PC9kaXY+PGJyPgo=
--20cf30025e5ad5b75904ad985768--

