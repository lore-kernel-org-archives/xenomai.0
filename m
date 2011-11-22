Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Nov 2011 16:13:19 +0100
Message-ID: <A55C63E538AA1E458EE4D75BD99595630694EE2E@ZIVCORREO.ziv.es>
In-Reply-To: <4ECB74C1.3030508@domain.hid>
From: "Enric Bel Prim" <e.bel@domain.hid>
Subject: Re: [Xenomai-help] pthread creation with native api
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

On 11/22/2011 09:51 AM, Enric Bel Prim wrote:
>> Hi,
>> I have some questions regarding pthread and NATIVE API...
>>=20
>> I use xenomai 2.4.8 with native API and RTDM services in a linux=20
>> 2.6.28 lite5200 embedded platform.
>> My application creates several realtime tasks (rt_task) using native=20
>> api, inside a linux environment with other applications.  All worked=20
>> fine, till I need to create, from any of this rt_task, some=20
>> nonrealtime tasks to do a long and not priority jobs (parse huge xml=20
>> files, compress / uncompress them...).
>> To do that, I use pthread_create(), to create a non realtime task
with=20
>> the "default attributes".
>> I expected that this pthread would share the remaining CPU time with
the
>> other linux applications.  =20
>> But it seems that this new pthread created has higher priority than=20
>> any of the other non-RT linux apps.  The feeling is that the CPU is=20
>> shared only between the realtime tasks and this pthread: for
instance,=20
>> one of the other non-RT apps controls the watchdog, and it resets the

>> system some seconds after the pthread is created.
>> If I call pthread_getschedparam inside the pthread I get thread prio
=3D=20
>> 0, and SCHED_OTHER.

>Up to here, it makes sense if you are passing flags to compile for the
posix skin.

I agree. The point is that I have not activated the POSIX API, as you
can see...

# Adeos-ipipe
LINUX_CONFIG+=3DCONFIG_IPIPE=3Dy

# Xenomai
LINUX_CONFIG+=3DCONFIG_XENOMAI=3Dy

# Nucleus=20
LINUX_CONFIG+=3DCONFIG_XENO_OPT_NUCLEUS=3Dy

LINUX_CONFIG+=3DCONFIG_XENO_OPT_PIPE=3Dy
LINUX_CONFIG+=3DCONFIG_XENO_OPT_REGISTRY=3Dy

# Pervasive real-time support in user-space
LINUX_CONFIG+=3DCONFIG_XENO_OPT_PERVASIVE=3Dy

# Interrupt shield support
LINUX_CONFIG+=3DCONFIG_XENO_OPT_ISHIELD=3Di

# Priority shield support=20
LINUX_CONFIG+=3DCONFIG_XENO_OPT_PRIOCPL=3Di

# Optimize as pipeline head
LINUX_CONFIG+=3DCONFIG_XENO_OPT_PIPELINE_HEAD=3Dy

# Number of pipe devices
LINUX_CONFIG+=3DCONFIG_XENO_OPT_PIPE_NRDEV=3D32

# Number of registry slots
LINUX_CONFIG+=3DCONFIG_XENO_OPT_REGISTRY_NRSLOTS=3D512

# Size of the system head (Kb)
LINUX_CONFIG+=3DCONFIG_XENO_OPT_SYS_HEAPSZ=3D128

# Size of the private stack pool (Kb)
LINUX_CONFIG+=3DCONFIG_XENO_OPT_SYS_STACKPOOLSZ=3D64

# Statistics collection
LINUX_CONFIG+=3DCONFIG_XENO_OPT_STATS=3Dy

# Debug support
LINUX_CONFIG+=3DCONFIG_XENO_OPT_DEBUG=3Di=20

# Shared interrupts
LINUX_CONFIG+=3DCONFIG_XENO_OPT_SHIRQ=3Dy=20

# Enable periodic timing
LINUX_CONFIG+=3DCONFIG_XENO_OPT_TIMING_PERIODIC=3Di

# Scheduling latency (ns)
LINUX_CONFIG+=3DCONFIG_XENO_OPT_TIMING_SCHEDLAT=3D0

# O(1) scheduler
LINUX_CONFIG+=3DCONFIG_XENO_OPT_SCALABLE_SCHED=3Di

# Timer indexing method
LINUX_CONFIG+=3DCONFIG_XENO_OPT_TIMER_LIST=3Dy
LINUX_CONFIG+=3DCONFIG_XENO_OPT_TIMER_HEAP=3Di
LINUX_CONFIG+=3DCONFIG_XENO_OPT_TIMER_WHEEL=3Di=20

# Enable NMI watchdog=20
LINUX_CONFIG+=3DCONFIG_XENO_HW_NMI_DEBUG_LATENCY=3Di

# Native API
LINUX_CONFIG+=3DCONFIG_XENO_SKIN_NATIVE=3Dy
LINUX_CONFIG+=3DCONFIG_XENO_OPT_NATIVE_PIPE=3Dy
LINUX_CONFIG+=3DCONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=3D1024
LINUX_CONFIG+=3DCONFIG_XENO_OPT_NATIVE_SEM=3Dy
LINUX_CONFIG+=3DCONFIG_XENO_OPT_NATIVE_EVENT=3Dy
LINUX_CONFIG+=3DCONFIG_XENO_OPT_NATIVE_MUTEX=3Dy
LINUX_CONFIG+=3DCONFIG_XENO_OPT_NATIVE_COND=3Dy
LINUX_CONFIG+=3DCONFIG_XENO_OPT_NATIVE_QUEUE=3Dy
LINUX_CONFIG+=3DCONFIG_XENO_OPT_NATIVE_HEAP=3Dy
LINUX_CONFIG+=3DCONFIG_XENO_OPT_NATIVE_ALARM=3Dy
LINUX_CONFIG+=3DCONFIG_XENO_OPT_NATIVE_MPS=3Dy
LINUX_CONFIG+=3DCONFIG_XENO_OPT_NATIVE_INTR=3Di=20
LINUX_CONFIG+=3DCONFIG_XENO_OPT_NATIVE_PERIOD=3D0
LINUX_CONFIG+=3DCONFIG_XENO_OPT_NATIVE_REGISTRY=3Dy

# POSIX API
LINUX_CONFIG+=3DCONFIG_XENO_SKIN_POSIX=3Di=20

# pSOS+ emulator
LINUX_CONFIG+=3DCONFIG_XENO_SKIN_PSOS=3Di=20

# uITRON API
LINUX_CONFIG+=3DCONFIG_XENO_SKIN_UITRON=3Di=20

# VRTX emulator
LINUX_CONFIG+=3DCONFIG_XENO_SKIN_VRTX=3Di=20

# VxWorks emulator
LINUX_CONFIG+=3DCONFIG_XENO_SKIN_VXWORKS=3Di=20

# RTAI emulator
LINUX_CONFIG+=3DCONFIG_XENO_SKIN_RTAI=3Di=20

# Real-Time Driver Model (RTDM)
LINUX_CONFIG+=3DCONFIG_XENO_SKIN_RTDM=3Dy
LINUX_CONFIG+=3DCONFIG_XENO_OPT_RTDM_FILDES=3D128
LINUX_CONFIG+=3DCONFIG_XENO_OPT_RTDM_SELECT=3Di=20
LINUX_CONFIG+=3DCONFIG_XENO_OPT_RTDM_PERIOD=3D0

# Serial drivers
LINUX_CONFIG+=3DCONFIG_XENO_DRIVERS_16550A=3Di=20
LINUX_CONFIG+=3DCONFIG_XENO_DRIVERS_16550A_PIO=3Di=20
LINUX_CONFIG+=3DCONFIG_XENO_DRIVERS_16550A_MMIO=3Di=20
LINUX_CONFIG+=3DCONFIG_XENO_DRIVERS_16550A_ANY=3Di=20

# CAN drivers
LINUX_CONFIG+=3DCONFIG_XENO_DRIVERS_CAN=3Di=20
LINUX_CONFIG+=3DCONFIG_XENO_DRIVERS_CAN_DEBUG=3Di=20
LINUX_CONFIG+=3DCONFIG_XENO_DRIVERS_CAN_LOOPBACK=3Di=20
LINUX_CONFIG+=3DCONFIG_XENO_DRIVERS_CAN_RXBUF_SIZE=3Di=20
LINUX_CONFIG+=3DCONFIG_XENO_DRIVERS_CAN_MAX_DEVICES=3Di=20
LINUX_CONFIG+=3DCONFIG_XENO_DRIVERS_CAN_MAX_RECEIVERS=3Di=20
LINUX_CONFIG+=3DCONFIG_XENO_DRIVERS_CAN_BUS_ERR=3Di=20
LINUX_CONFIG+=3DCONFIG_XENO_DRIVERS_CAN_VIRT=3Di=20

# Testing drivers
LINUX_CONFIG+=3DCONFIG_XENO_KLATENCY_MODULE=3Di
LINUX_CONFIG+=3DCONFIG_XENO_DRIVERS_TIMERBENCH=3Di
LINUX_CONFIG+=3DCONFIG_XENO_DRIVERS_KLATENCY=3Di
LINUX_CONFIG+=3DCONFIG_XENO_DRIVERS_IRQBENCH=3Di=20
LINUX_CONFIG+=3DCONFIG_XENO_DRIVERS_SWITCHTEST=3Di

# Enable FPU support=20
LINUX_CONFIG+=3DCONFIG_XENO_HW_FPU=3Dy

# SMI workaround
LINUX_CONFIG+=3DCONFIG_XENO_HW_SMI_DETECT_DISABLE=3Di
LINUX_CONFIG+=3DCONFIG_XENO_HW_SMI_WORKAROUND=3Di



>> I tried using __real_pthread_create as well, and had the same result.

>This does not make sense.

If POSIX api is not active, __real_pthread_create behaves identically as
pthread_create, I suppose.

>>=20
>> Is correct to use pthread_create to create a new non-RT task from a=20
>> rt_task?
>> Which are the attributes/priority of that pthread? Does it inherit=20
>> some of the RT parent "privileges"?

>When compiling for the posix skin, threads created with pthread_create
are the same kind of tasks as the ones created with rt_task_create. The
SCHED_OTHER/0 priority is simply the lowest priority for these tasks. If
you do not want that, you should not pass the flags to compile for the
posix skin.

I agree. I don't activate posix skin.

>However, even when using the posix skin compilation flags, this should
not happen when using __real_pthread_create. Could you try xenomai
2.4.10 and see if it has the same behaviour?

>Could you post an example program?

>--=20
>					    Gilles.


I tried with version 2.4.10 and I got the same result.  I agree with you
that this should not occur without posix skin compilation flags. I
workaround the problem reducing the pthread priority calling nice() at
the start of pthread code.  But I'd like to know the reason of that
behaviour.

Thanks for your help,
Enric.=20
=20
----------------------------------------- PLEASE NOTE =
-------------------------------------------
This message, along with any attachments, may be confidential or legally =
privileged.=20
It is intended only for the named person(s), who is/are the only =
authorized recipients.
If this message has reached you in error, kindly destroy it without =
review and notify the sender immediately.
Thank you for your help.
ZIV uses virus scanning software but excludes any liability for viruses =
contained in any attachment.
=20
------------------------------------ ROGAMOS LEA ESTE TEXTO =
-------------------------------
Este mensaje y sus anexos pueden contener informaci=F3n confidencial y/o =
con derecho legal.=20
Est=E1 dirigido =FAnicamente a la/s persona/s o entidad/es rese=F1adas =
como =FAnico destinatario autorizado.
Si este mensaje le hubiera llegado por error, por favor elim=EDnelo sin =
revisarlo ni reenviarlo y notif=EDquelo inmediatamente al remitente. =
Gracias por su colaboraci=F3n. =20
ZIV utiliza software antivirus, pero no se hace responsable de los virus =
contenidos en los ficheros anexos.

