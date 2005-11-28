Message-ID: <ae7121c60511280922l2c885116m419ffc17d2b61b04@domain.hid>
Date: Mon, 28 Nov 2005 18:22:23 +0100
From: Panagiotis Issaris <panagiotis@domain.hid>
Subject: Re: [Xenomai-core] Latest snapshot (182) not compiling (kernel)
In-Reply-To: <438B3990.4020809@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_10167_4900733.1133198543037"
References: <438743FC.6070007@domain.hid>
	<ae7121c60511280857l26c080b7g299c6cae93a8afed@domain.hid>
	<ae7121c60511280858g7d25f4d9y28de0688053ad51d@domain.hid>
	<438B3990.4020809@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

------=_Part_10167_4900733.1133198543037
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Jan,

On 11/28/05, Jan Kiszka <kiszka@domain.hid> wrote:
>
> ...
> > reference to `__raw_read_unlock'
> > kernel/built-in.o: In function `schedule_event':
> > /usr/local/src/linux-2.6.14/kernel/xenomai/nucleus/shadow.c:152:
> undefined
> > reference to `__raw_read_lock'
> > /usr/local/src/linux-2.6.14/kernel/xenomai/nucleus/shadow.c:158:
> undefined
> > reference to `__raw_read_unlock'
> > make[1]: *** [.tmp_vmlinux1] Error 1
> > make: *** [_all] Error 2
> >
>
> Kernel config...?


Sorry :)

#
# Real-time sub-system
#
CONFIG_XENOMAI=3Dy
CONFIG_XENO_OPT_NUCLEUS=3Dy
CONFIG_XENO_OPT_PERVASIVE=3Dy
CONFIG_XENO_OPT_PIPE=3Dy
CONFIG_XENO_OPT_PIPE_NRDEV=3D32
CONFIG_XENO_OPT_SYS_HEAPSZ=3D128
CONFIG_XENO_OPT_ISHIELD=3Dy
CONFIG_XENO_OPT_STATS=3Dy
# CONFIG_XENO_OPT_DEBUG is not set
# CONFIG_XENO_OPT_WATCHDOG is not set

#
# Scalability
#
# CONFIG_XENO_OPT_SCALABLE_SCHED is not set

#
# Machine
#
CONFIG_XENO_HW_FPU=3Dy
CONFIG_XENO_HW_PERIODIC_TIMER=3Dy
CONFIG_XENO_HW_TIMER_LATENCY=3D0
CONFIG_XENO_HW_SCHED_LATENCY=3D0

#
# NMI watchdog
#
# CONFIG_XENO_HW_NMI_DEBUG_LATENCY is not set

#
# SMI workaround
#
# CONFIG_XENO_HW_SMI_DETECT_DISABLE is not set
CONFIG_XENO_HW_SMI_DETECT=3Dy
# CONFIG_XENO_HW_SMI_WORKAROUND is not set

#
# Interfaces
#
CONFIG_XENO_SKIN_NATIVE=3Dy
CONFIG_XENO_OPT_NATIVE_REGISTRY=3Dy
CONFIG_XENO_OPT_NATIVE_REGISTRY_NRSLOTS=3D512
CONFIG_XENO_OPT_NATIVE_PIPE=3Dy
CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=3D4096
CONFIG_XENO_OPT_NATIVE_SEM=3Dy
CONFIG_XENO_OPT_NATIVE_EVENT=3Dy
CONFIG_XENO_OPT_NATIVE_MUTEX=3Dy
CONFIG_XENO_OPT_NATIVE_COND=3Dy
CONFIG_XENO_OPT_NATIVE_QUEUE=3Dy
CONFIG_XENO_OPT_NATIVE_HEAP=3Dy
CONFIG_XENO_OPT_NATIVE_ALARM=3Dy
CONFIG_XENO_OPT_NATIVE_MPS=3Dy
CONFIG_XENO_OPT_NATIVE_INTR=3Dy
CONFIG_XENO_SKIN_POSIX=3Dy
# CONFIG_XENO_SKIN_PSOS is not set
# CONFIG_XENO_SKIN_UITRON is not set
# CONFIG_XENO_SKIN_VRTX is not set
# CONFIG_XENO_SKIN_VXWORKS is not set
# CONFIG_XENO_SKIN_RTAI is not set
CONFIG_XENO_SKIN_RTDM=3Dy
# CONFIG_XENO_SKIN_UVM is not set

#
# Drivers
#
# CONFIG_XENO_DRIVERS_16550A is not set




Do you happen to have the IRQ shield switched on? May it's a regression
> related to this per-default-off feature.
>
Indeed! I disabled the IRQ shield and the linking error is gone! Thanks! :)


With friendly regards,
Takis

------=_Part_10167_4900733.1133198543037
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Jan,<br><br><div><span class=3D"gmail_quote">On 11/28/05, <b class=3D"gm=
ail_sendername">Jan Kiszka</b> &lt;<a href=3D"mailto:kiszka@domain.hid=
r.de">kiszka@domain.hid</a>&gt; wrote:</span><blockquote class=3D"=
gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0p=
t 0pt 0pt 0.8ex; padding-left: 1ex;">
 ...<br>&gt; reference to `__raw_read_unlock'<br>&gt; kernel/built-in.o: In=
 function `schedule_event':<br>&gt; /usr/local/src/linux-2.6.14/kernel/xeno=
mai/nucleus/shadow.c:152: undefined<br>&gt; reference to `__raw_read_lock'
<br>&gt; /usr/local/src/linux-2.6.14/kernel/xenomai/nucleus/shadow.c:158: u=
ndefined<br>&gt; reference to `__raw_read_unlock'<br>&gt; make[1]: *** [.tm=
p_vmlinux1] Error 1<br>&gt; make: *** [_all] Error 2<br>&gt;<br><br>Kernel =
config...?
</blockquote><div><br>Sorry :) <br><br>#<br># Real-time sub-system<br>#<br>=
CONFIG_XENOMAI=3Dy<br>CONFIG_XENO_OPT_NUCLEUS=3Dy<br>CONFIG_XENO_OPT_PERVAS=
IVE=3Dy<br>CONFIG_XENO_OPT_PIPE=3Dy<br>CONFIG_XENO_OPT_PIPE_NRDEV=3D32<br>C=
ONFIG_XENO_OPT_SYS_HEAPSZ=3D128
<br>CONFIG_XENO_OPT_ISHIELD=3Dy<br>CONFIG_XENO_OPT_STATS=3Dy<br># CONFIG_XE=
NO_OPT_DEBUG is not set<br># CONFIG_XENO_OPT_WATCHDOG is not set<br><br>#<b=
r># Scalability<br>#<br># CONFIG_XENO_OPT_SCALABLE_SCHED is not set<br><br>
#<br># Machine<br>#<br>CONFIG_XENO_HW_FPU=3Dy<br>CONFIG_XENO_HW_PERIODIC_TI=
MER=3Dy<br>CONFIG_XENO_HW_TIMER_LATENCY=3D0<br>CONFIG_XENO_HW_SCHED_LATENCY=
=3D0<br><br>#<br># NMI watchdog<br>#<br># CONFIG_XENO_HW_NMI_DEBUG_LATENCY =
is not set
<br><br>#<br># SMI workaround<br>#<br># CONFIG_XENO_HW_SMI_DETECT_DISABLE i=
s not set<br>CONFIG_XENO_HW_SMI_DETECT=3Dy<br># CONFIG_XENO_HW_SMI_WORKAROU=
ND is not set<br><br>#<br># Interfaces<br>#<br>CONFIG_XENO_SKIN_NATIVE=3Dy<=
br>
CONFIG_XENO_OPT_NATIVE_REGISTRY=3Dy<br>CONFIG_XENO_OPT_NATIVE_REGISTRY_NRSL=
OTS=3D512<br>CONFIG_XENO_OPT_NATIVE_PIPE=3Dy<br>CONFIG_XENO_OPT_NATIVE_PIPE=
_BUFSZ=3D4096<br>CONFIG_XENO_OPT_NATIVE_SEM=3Dy<br>CONFIG_XENO_OPT_NATIVE_E=
VENT=3Dy
<br>CONFIG_XENO_OPT_NATIVE_MUTEX=3Dy<br>CONFIG_XENO_OPT_NATIVE_COND=3Dy<br>=
CONFIG_XENO_OPT_NATIVE_QUEUE=3Dy<br>CONFIG_XENO_OPT_NATIVE_HEAP=3Dy<br>CONF=
IG_XENO_OPT_NATIVE_ALARM=3Dy<br>CONFIG_XENO_OPT_NATIVE_MPS=3Dy<br>CONFIG_XE=
NO_OPT_NATIVE_INTR=3Dy
<br>CONFIG_XENO_SKIN_POSIX=3Dy<br># CONFIG_XENO_SKIN_PSOS is not set<br># C=
ONFIG_XENO_SKIN_UITRON is not set<br># CONFIG_XENO_SKIN_VRTX is not set<br>=
# CONFIG_XENO_SKIN_VXWORKS is not set<br># CONFIG_XENO_SKIN_RTAI is not set
<br>CONFIG_XENO_SKIN_RTDM=3Dy<br># CONFIG_XENO_SKIN_UVM is not set<br><br>#=
<br># Drivers<br>#<br># CONFIG_XENO_DRIVERS_16550A is not set<br><br><br>&n=
bsp;</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px s=
olid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Do you happen to have the IRQ shield switched on? May it's a regression<br>=
related to this per-default-off feature.<br></blockquote></div>Indeed! I di=
sabled the IRQ shield and the linking error is gone! Thanks! :)<br><br>
<br>With friendly regards,<br>Takis<br>

------=_Part_10167_4900733.1133198543037--

