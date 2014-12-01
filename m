From: =?iso-8859-1?Q?Terje_Fr=F8ysa?= <Terje.Froysa@sintef.no>
Date: Mon, 1 Dec 2014 05:54:36 +0000
Message-ID: <314E5ECDAA86314791309FA670550F89C9C4FD8A@SINTEFEXMBX05.sintef.no>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] WARNING: at arch/arm/kernel/ipipe.c:157
 ipipe_set_irq_affinity+0x47/0x70()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Dear Forum,

Occasionally I get the warning listed below on my Beaglebone Black console.
I am running Debian 3.8.13-bone67 with Xenomai 2.6.4

I am running four RTDM modules handling interrupts from GPIO pins.

As far as I have found, this kind of warnings can be associated with inappr=
opriate calls from user space.
But I cannot find such calls in my code.
The irq is requested by a RTDM kernel module when issuing a device open cal=
l from user space.

Please advice
Best regards
Terje Froysa


[ 398.167710] RTDM BARO INT (GPIO 60) - open
[  398.167730] RTDM BARO pin 60 - irq number 188
[  398.167738] RTDM BARO 60 - request GPIO
[  398.167757] RTDM BARO 60 - request IRQ 188
[  398.167768] ------------[ cut here ]------------
[  398.172673] WARNING: at arch/arm/kernel/ipipe.c:157 ipipe_set_irq_affini=
ty+0x47/0x70()
[  398.180951] Modules linked in: g_multi libcomposite imu_rtdm(O) baro_rtd=
m(O) gyro_rtdm(O) rtgps_1pps(O) omap_rng
[  398.191733] [<c00117ed>] (unwind_backtrace+0x1/0x9c) from [<c003022b>] (=
warn_slowpath_common+0x33/0x48)
[  398.201606] [<c003022b>] (warn_slowpath_common+0x33/0x48) from [<c003025=
1>] (warn_slowpath_null+0x11/0x14)
[  398.211701] [<c0030251>] (warn_slowpath_null+0x11/0x14) from [<c001470f>=
] (ipipe_set_irq_affinity+0x47/0x70)
[  398.222010] [<c001470f>] (ipipe_set_irq_affinity+0x47/0x70) from [<c0099=
1b5>] (xnintr_attach+0x21/0x1f0)
[  398.231936] [<c00991b5>] (xnintr_attach+0x21/0x1f0) from [<c00eea8d>] (r=
tdm_irq_request+0x25/0x44)
[  398.241324] [<c00eea8d>] (rtdm_irq_request+0x25/0x44) from [<bf80c153>] =
(baro_irq_open+0x6a/0xfc [baro_rtdm])
[  398.251704] [<bf80c153>] (baro_irq_open+0x6a/0xfc [baro_rtdm]) from [<c0=
0eb531>] (__rt_dev_open+0x61/0xa4)
[  398.261832] [<c00eb531>] (__rt_dev_open+0x61/0xa4) from [<c00eeca9>] (sy=
s_rtdm_open+0x3d/0x48)
[  398.270853] [<c00eeca9>] (sys_rtdm_open+0x3d/0x48) from [<c00a9649>] (lo=
syscall_event+0x81/0x1e0)
[  398.280142] [<c00a9649>] (losyscall_event+0x81/0x1e0) from [<c007d169>] =
(ipipe_syscall_hook+0x2d/0x34)
[  398.289892] [<c007d169>] (ipipe_syscall_hook+0x2d/0x34) from [<c007bfc7>=
] (__ipipe_notify_syscall+0x5b/0xb8)
[  398.300180] [<c007bfc7>] (__ipipe_notify_syscall+0x5b/0xb8) from [<c0014=
87d>] (__ipipe_syscall_root+0x3d/0x98)
[  398.310646] [<c001487d>] (__ipipe_syscall_root+0x3d/0x98) from [<c000cbc=
d>] (local_restart+0x9/0x54)
[  398.320194] ---[ end trace f174ab8361e31708 ]---

Smail: Terje Fr=F8ysa, SINTEF ICT (Information and Communication Technology=
), N-7465 Trondheim, Norway.
Email: terje.froysa@sintef.no<blocked::mailto:terje.froysa@sintef.no> <mail=
to:terje.froysa@sintef.no<blocked::mailto:terje.froysa@sintef.no>>
Phone: +47 930 03603,
Company: Independent R&D, see <http://www.sintef.no/<blocked::http://www.si=
ntef.no/>

