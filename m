From: Josh Karch <JKarch@domain.hid>
Date: Mon, 14 Dec 2009 08:33:55 -0800
Message-ID: <843773D242212C4882D4EDFFBF665F7F0155A93ABB@FW-SBS.fw.local>
References: <843773D242212C4882D4EDFFBF665F7F0155A93A9D@FW-SBS.fw.local>,
	<4B1FE230.8070702@domain.hid>
	<843773D242212C4882D4EDFFBF665F7F0155A93AA7@domain.hid>,
	<4B1FEF97.9000509@domain.hid>
	<843773D242212C4882D4EDFFBF665F7F0155A93AAA@FW-SBS.fw.local>,
	<4B20C5DE.2040606@domain.hid>
	<843773D242212C4882D4EDFFBF665F7F0155A93AAD@FW-SBS.fw.local>,
	<4B22143B.5040901@domain.hid>
In-Reply-To: <4B22143B.5040901@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai scheduling while atomic bug--debugging
	parameters
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Jan,
I left my application running over the weekend with the new RT-Socket CAN a=
nd the system is still running stable today.  Thank you for pointing out th=
at bug-- you've made my December vacation!

Sincerely,

Joshua Karch
________________________________________
From: Jan Kiszka [jan.kiszka@domain.hid]
Sent: Friday, December 11, 2009 1:43 AM
To: Josh Karch
Cc: xenomai@xenomai.org
Subject: Re: Xenomai scheduling while atomic bug--debugging   parameters

Josh Karch wrote:
> Jan,
>
> Our program ran without interruption last night with no bug, except it ap=
pears one still exists possibly regarding either ethernet (Intel e100), ssh=
d, nfsd, or as a result of running top.  It seems excessive network request=
s and calls to top and dmesg can trigger it.
>
> Today I will recompile the kernel with all debugging options enabled,  ma=
ke the system run until the bug occurs, send you that .config file as well =
as the current .config that still crashes on occasion (though the xenomai a=
pplication runs rock solid in spite of the linux scheduling while atomic bu=
gs). since the logs may be big, is there an ftp I can send them to or shoul=
d I email those directly?
>

>From the "fulldebugging" trace you sent to Gilles and me:

> [  412.520716]  |  # func                    0 ipipe_trace_panic_freeze+0=
x4 (ipipe_check_context+0x41)
> [  412.520716]  |  # func                    0 ipipe_check_context+0x5 (a=
dd_preempt_count+0x10)
> [  412.520716]  |  # func                    0 delay_tsc+0x9 (__const_ude=
lay+0x1d)
> [  412.520716]  |  # func                   -1 __const_udelay+0x3 (sja100=
0_irqhandler_common+0x2bd [pcan])

The pcan driver invokes a Linux service that is not supposed to be used
from RT context (udelay). Better switch to the CAN driver in upstream
Xenomai (it also comes with a standard API for better portability across
CAN vendors).

> [  412.520716]  |  # func                   -9 xnarch_tsc_to_ns+0x5 (xnar=
ch_get_cpu_time+0xf)
> [  412.520716]  |  # func                   -9 xnarch_get_cpu_time+0x3 (s=
ja1000_irqhandler_common+0x102 [pcan])
> [  412.520716]  |  # func                  -10 xnintr_edge_shirq_handler+=
0x9 (__ipipe_dispatch_wired_nocheck+0x3e)
> [  412.520716]  |   +func                  -11 __ipipe_dispatch_wired_noc=
heck+0x6 (__ipipe_dispatch_wired+0x4f)
> [  412.520716]  |   +func                  -11 __ipipe_dispatch_wired+0x5=
 (__ipipe_handle_irq+0x93)
> [  412.520716]  |   +func                  -11 native_apic_mem_write+0x3 =
(ack_apic_level+0x141)
> [  412.520716]  |   +func                  -13 native_apic_mem_read+0x3 (=
ack_apic_level+0x3f)
> [  412.520716]  |   +func                  -13 ack_apic_level+0x6 (__ipip=
e_ack_fasteoi_irq+0xe)
> [  412.520716]  |   +func                  -13 __ipipe_ack_fasteoi_irq+0x=
3 (__ipipe_handle_irq+0x8a)
> [  412.520716]  |   +func                  -14 __ipipe_handle_irq+0x9 (co=
mmon_interrupt+0x36)
> [  412.520716]  |   +begin   0xffffffb6    -14 common_interrupt+0x2f ()

Besides that, there might be a bug in our bug detection infrastructure
with generates a confusing output instead of a proper warning about the
core issue. Will have a look.

Jan

--
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

