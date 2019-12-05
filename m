Subject: Re: undefined reference to `rt_task_create
References: <d3c4d944-807a-a2d4-7ec1-2d1639f36f78@vbm-grp.com>
From: "Electronic Dept. - Vbm Group" <electronic@vbm-grp.com>
Message-ID: <48de04a3-9f2c-d3e6-8a80-568a497015c1@vbm-grp.com>
Date: Thu, 5 Dec 2019 08:35:42 +0100
MIME-Version: 1.0
In-Reply-To: <d3c4d944-807a-a2d4-7ec1-2d1639f36f78@vbm-grp.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello Jan,

thank you for your answer.

My Xenomai version is:

Xenomai/cobalt v3.0.9 -- #5b99a61 (2019-11-04 19:44:03 +0100)

My kernel version is:

Linux arm 4.4.113-ti-xenomai-r149.1 #1 SMP Mon Oct 21 11:55:55 CEST 2019=20
armv7l GNU/Linux

If it can be useful the result of xeno-test is:

Started child 676: /bin/bash /usr/xenomai/bin/xeno-test-run-wrapper=20
./xeno-test
++ echo 0
++ testdir=3D/usr/xenomai/bin
++ /usr/xenomai/bin/smokey --run
arith OK
bufp skipped (no kernel support)
cpu_affinity OK
iddp skipped (no kernel support)
leaks OK
net_packet_dgram skipped (no kernel support)
net_packet_raw skipped (no kernel support)
net_udp skipped (no kernel support)
posix_clock OK
posix_cond OK
posix_fork OK
mutex_trylock not supported
posix_mutex OK
posix_select OK
rtdm skipped (no kernel support)
sched_quota skipped (no kernel support)
sched_tp skipped (no kernel support)
setsched OK
sigdebug skipped (no kernel support)
timerfd OK
tsc OK
vdso_access OK
xddp skipped (no kernel support)
++ /usr/xenomai/bin/clocktest -D -T 30 -C CLOCK_HOST_REALTIME
hostrt data area is live
sequence counter : 197044
wall_time_sec=A0=A0=A0 : 1575475032
wall_time_nsec=A0=A0 : 492643503
wall_to_monotonic_sec=A0=A0=A0 : -1575471617
wall_to_monotonic_nsec=A0=A0 : 197320093
cycle_last=A0=A0=A0=A0=A0=A0 : 81979795008
mask=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : 0xffffffffffffffff
mult=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : 699025481
shift=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : 24

=3D=3D Testing built-in CLOCK_HOST_REALTIME (32)
CPU=A0=A0=A0=A0=A0 ToD offset [us] ToD drift [us/s]=A0=A0=A0=A0=A0 warps ma=
x delta [us]
--- -------------------- ---------------- ---------- --------------
 =A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 3.3=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 0.054=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 0.0
++ /usr/xenomai/bin/switchtest -T 30
=3D=3D Testing FPU check routines...
d0: 1 !=3D 2
d1: 1 !=3D 2
d2: 1 !=3D 2
d3: 1 !=3D 2
d4: 1 !=3D 2
d5: 1 !=3D 2
d6: 1 !=3D 2
d7: 1 !=3D 2
d8: 1 !=3D 2
d9: 1 !=3D 2
d10: 1 !=3D 2
d11: 1 !=3D 2
d12: 1 !=3D 2
d13: 1 !=3D 2
d14: 1 !=3D 2
d15: 1 !=3D 2
=3D=3D FPU check routines: OK.
=3D=3D Threads: sleeper_ufps0-0 rtk0-1 rtk0-2 rtk_fp0-3 rtk_fp0-4=20
rtk_fp_ufpp0-5 rtk_fp_ufpp0-6 rtup0-7 rtup0-8 rtup_ufpp0-9 rtup_ufpp0-10=20
rtus0-11 rtus0-12 rtus_ufps0-13 rtus_ufps0-14 rtuo0-15 rtuo0-16=20
rtuo_ufpp0-17 rtuo_ufpp0-18 rtuo_ufps0-19 rtuo_ufps0-20=20
rtuo_ufpp_ufps0-21 rtuo_ufpp_ufps0-22
RTT|=A0 00:00:01
RTH|---------cpu|ctx switches|-------total
RTD|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0=A0 15937|=A0=A0=A0=A0=
=A0=A0 15937
RTD|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0=A0 15732|=A0=A0=A0=A0=
=A0=A0 31669
RTD|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0=A0 15736|=A0=A0=A0=A0=
=A0=A0 47405
RTD|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0=A0 15797|=A0=A0=A0=A0=
=A0=A0 63202
RTD|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0=A0 15801|=A0=A0=A0=A0=
=A0=A0 79003
RTD|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0=A0 15667|=A0=A0=A0=A0=
=A0=A0 94670
RTD|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0=A0 15730|=A0=A0=A0=A0=
=A0 110400
RTD|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0=A0 15661|=A0=A0=A0=A0=
=A0 126061
RTD|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0=A0 15801|=A0=A0=A0=A0=
=A0 141862
RTD|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0=A0 15801|=A0=A0=A0=A0=
=A0 157663
RTD|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0=A0 15801|=A0=A0=A0=A0=
=A0 173464
RTD|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0=A0 15801|=A0=A0=A0=A0=
=A0 189265
RTD|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0=A0 15736|=A0=A0=A0=A0=
=A0 205001
RTD|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0=A0 15801|=A0=A0=A0=A0=
=A0 220802
RTD|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0=A0 15866|=A0=A0=A0=A0=
=A0 236668
RTD|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0=A0 15732|=A0=A0=A0=A0=
=A0 252400
RTD|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0=A0 15736|=A0=A0=A0=A0=
=A0 268136
RTD|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0=A0 15866|=A0=A0=A0=A0=
=A0 284002
RTD|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0=A0 15732|=A0=A0=A0=A0=
=A0 299734
RTD|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0=A0 15663|=A0=A0=A0=A0=
=A0 315397
RTD|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0=A0 15732|=A0=A0=A0=A0=
=A0 331129
RTT|=A0 00:00:22
RTH|---------cpu|ctx switches|-------total
RTD|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0=A0 15801|=A0=A0=A0=A0=
=A0 346930
RTD|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0=A0 15734|=A0=A0=A0=A0=
=A0 362664
RTD|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0=A0 15734|=A0=A0=A0=A0=
=A0 378398
RTD|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0=A0 15799|=A0=A0=A0=A0=
=A0 394197
RTD|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0=A0 15799|=A0=A0=A0=A0=
=A0 409996
RTD|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0=A0 15801|=A0=A0=A0=A0=
=A0 425797
RTD|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0=A0 15734|=A0=A0=A0=A0=
=A0 441531
RTD|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0=A0 15799|=A0=A0=A0=A0=
=A0 457330
RTD|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0=A0 14490|=A0=A0=A0=A0=
=A0 471820
++ start_load
++ echo start_load
++ false
++ check_alive /usr/xenomai/bin/latency
++ echo check_alive /usr/xenomai/bin/latency
++ wait_load
++ read rc
Started child 744: dohell 900
Started child 745: /usr/xenomai/bin/latency
=3D=3D Sampling period: 1000 us
=3D=3D Test mode: periodic user-mode task
=3D=3D All results in microseconds
warming up...
RTT|=A0 00:00:01=A0 (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat=20
best|--lat worst
RTD|=A0=A0=A0=A0 14.416|=A0=A0=A0=A0 29.666|=A0=A0=A0=A0 55.416|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 14.416|=A0=A0=A0=A0 55.416
RTD|=A0=A0=A0=A0 14.374|=A0=A0=A0=A0 29.543|=A0=A0=A0=A0 53.583|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 14.374|=A0=A0=A0=A0 55.416
RTD|=A0=A0=A0=A0 14.374|=A0=A0=A0=A0 28.730|=A0=A0=A0=A0 54.582|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 14.374|=A0=A0=A0=A0 55.416
RTD|=A0=A0=A0=A0 14.374|=A0=A0=A0=A0 28.170|=A0=A0=A0=A0 56.249|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 14.374|=A0=A0=A0=A0 56.249
RTD|=A0=A0=A0=A0 14.374|=A0=A0=A0=A0 28.609|=A0=A0=A0=A0 54.374|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 14.374|=A0=A0=A0=A0 56.249
RTD|=A0=A0=A0=A0 14.332|=A0=A0=A0=A0 27.711|=A0=A0=A0=A0 55.874|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 14.332|=A0=A0=A0=A0 56.249
RTD|=A0=A0=A0=A0 14.331|=A0=A0=A0=A0 28.196|=A0=A0=A0=A0 57.956|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 14.331|=A0=A0=A0=A0 57.956
RTD|=A0=A0=A0=A0 14.373|=A0=A0=A0=A0 27.163|=A0=A0=A0=A0 54.915|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 14.331|=A0=A0=A0=A0 57.956
RTD|=A0=A0=A0=A0 14.331|=A0=A0=A0=A0 28.497|=A0=A0=A0=A0 61.623|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 14.331|=A0=A0=A0=A0 61.623
RTD|=A0=A0=A0=A0 11.414|=A0=A0=A0=A0 28.633|=A0=A0=A0=A0 56.914|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 11.414|=A0=A0=A0=A0 61.623
RTD|=A0=A0=A0=A0 14.414|=A0=A0=A0=A0 27.801|=A0=A0=A0=A0 60.914|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 11.414|=A0=A0=A0=A0 61.623
RTD|=A0=A0=A0=A0 14.372|=A0=A0=A0=A0 27.482|=A0=A0=A0=A0 57.289|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 11.414|=A0=A0=A0=A0 61.623
RTD|=A0=A0=A0=A0 14.372|=A0=A0=A0=A0 28.480|=A0=A0=A0=A0 56.038|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 11.414|=A0=A0=A0=A0 61.623
RTD|=A0=A0=A0=A0 14.371|=A0=A0=A0=A0 28.990|=A0=A0=A0=A0 56.413|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 11.414|=A0=A0=A0=A0 61.623
RTD|=A0=A0=A0=A0 14.371|=A0=A0=A0=A0 28.460|=A0=A0=A0=A0 54.371|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 11.414|=A0=A0=A0=A0 61.623
RTD|=A0=A0=A0=A0 14.371|=A0=A0=A0=A0 27.868|=A0=A0=A0=A0 54.704|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 11.414|=A0=A0=A0=A0 61.623
RTD|=A0=A0=A0=A0 14.412|=A0=A0=A0=A0 27.557|=A0=A0=A0=A0 53.746|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 11.414|=A0=A0=A0=A0 61.623
RTD|=A0=A0=A0=A0 14.287|=A0=A0=A0=A0 27.530|=A0=A0=A0=A0 53.287|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 11.414|=A0=A0=A0=A0 61.623
RTD|=A0=A0=A0=A0 14.370|=A0=A0=A0=A0 26.841|=A0=A0=A0=A0 55.829|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 11.414|=A0=A0=A0=A0 61.623
RTD|=A0=A0=A0=A0 14.412|=A0=A0=A0=A0 26.846|=A0=A0=A0=A0 52.912|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 11.414|=A0=A0=A0=A0 61.623
RTD|=A0=A0=A0=A0 14.411|=A0=A0=A0=A0 26.671|=A0=A0=A0=A0 53.953|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 11.414|=A0=A0=A0=A0 61.623
RTT|=A0 00:00:22=A0 (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat=20
best|--lat worst
RTD|=A0=A0=A0=A0 14.411|=A0=A0=A0=A0 26.720|=A0=A0=A0=A0 54.245|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 11.414|=A0=A0=A0=A0 61.623
RTD|=A0=A0=A0=A0 14.369|=A0=A0=A0=A0 26.391|=A0=A0=A0=A0 57.869|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 11.414|=A0=A0=A0=A0 61.623
RTD|=A0=A0=A0=A0 14.411|=A0=A0=A0=A0 26.184|=A0=A0=A0=A0 55.536|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 11.414|=A0=A0=A0=A0 61.623
RTD|=A0=A0=A0=A0 14.411|=A0=A0=A0=A0 26.052|=A0=A0=A0=A0 54.286|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 11.414|=A0=A0=A0=A0 61.623
RTD|=A0=A0=A0=A0 14.410|=A0=A0=A0=A0 26.045|=A0=A0=A0=A0 54.369|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 11.414|=A0=A0=A0=A0 61.623
RTD|=A0=A0=A0=A0 13.577|=A0=A0=A0=A0 26.106|=A0=A0=A0=A0 56.410|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 11.414|=A0=A0=A0=A0 61.623
RTD|=A0=A0=A0=A0=A0 9.243|=A0=A0=A0=A0 25.842|=A0=A0=A0=A0 54.452|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 9.243|=A0=A0=A0=A0 61.623
RTD|=A0=A0=A0=A0 14.285|=A0=A0=A0=A0 26.535|=A0=A0=A0=A0 54.701|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 9.243|=A0=A0=A0=A0 61.623
RTD|=A0=A0=A0=A0 14.326|=A0=A0=A0=A0 26.546|=A0=A0=A0=A0 54.409|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 9.243|=A0=A0=A0=A0 61.623
RTD|=A0=A0=A0=A0 14.368|=A0=A0=A0=A0 26.472|=A0=A0=A0=A0 52.284|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 9.243|=A0=A0=A0=A0 61.623
RTD|=A0=A0=A0=A0 14.409|=A0=A0=A0=A0 26.455|=A0=A0=A0=A0 53.867|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 9.243|=A0=A0=A0=A0 61.623
RTD|=A0=A0=A0=A0 14.409|=A0=A0=A0=A0 26.570|=A0=A0=A0=A0 54.784|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 9.243|=A0=A0=A0=A0 61.623
RTD|=A0=A0=A0=A0 14.325|=A0=A0=A0=A0 26.518|=A0=A0=A0=A0 54.367|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 9.243|=A0=A0=A0=A0 61.623
RTD|=A0=A0=A0=A0 14.325|=A0=A0=A0=A0 26.566|=A0=A0=A0=A0 52.492|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 9.243|=A0=A0=A0=A0 61.623
RTD|=A0=A0=A0=A0 14.241|=A0=A0=A0=A0 26.803|=A0=A0=A0=A0 53.616|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 9.243|=A0=A0=A0=A0 61.623
RTD|=A0=A0=A0=A0 14.408|=A0=A0=A0=A0 26.506|=A0=A0=A0=A0 53.783|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 9.243|=A0=A0=A0=A0 61.623
RTD|=A0=A0=A0=A0 14.324|=A0=A0=A0=A0 26.520|=A0=A0=A0=A0 54.407|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 9.243|=A0=A0=A0=A0 61.623
RTD|=A0=A0=A0=A0 14.282|=A0=A0=A0=A0 26.762|=A0=A0=A0=A0 52.616|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 9.243|=A0=A0=A0=A0 61.623
RTD|=A0=A0=A0=A0 14.365|=A0=A0=A0=A0 26.757|=A0=A0=A0=A0 53.657|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 9.243|=A0=A0=A0=A0 61.623
RTD|=A0=A0=A0=A0 14.323|=A0=A0=A0=A0 26.326|=A0=A0=A0=A0 53.657|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 9.243|=A0=A0=A0=A0 61.623
RTD|=A0=A0=A0=A0 14.406|=A0=A0=A0=A0 26.473|=A0=A0=A0=A0 55.907|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0| 9.243|=A0=A0=A0=A0 61.623

Thank you for your help.

Best Regards
Davide Brunelli

*Electronic Vbm Group*
e-mail: electronic2@vbm-grp.com <mailto:electronic2@vbm-grp.com>

Vbm Group <http://service.vbm-grp.com/signature/logogrp.png>


Vbm Group Vbm Group Vbm Group


*Vbm Group is a trademark of VI.BE.MAC S.p.a.*

*Declaration according to Law No. 196 of 30 June 2003*
We hereby inform you that your data will be treated automatically,=20
according to the current security regulations for written=20
correspondence; your data will not be spread by Vi.Be.Mac. Spa. In any=20
way, as far as your data are concerned, you have the rights indicated in=20
art. No. 13 L. 675/1996 (such as access, cancellation, modification,=20
objection, etc.). Vi.Be.Mac. Spa. Is the holder of treatment of your=20
data. Vi.Be.Mac. is located in via Monte Pastello, 7/i (Vr) Italy. For=20
further information, please write to: privacy@vibemac.com According to=20
Art. No. 13 of law 196/2003, in any moment and free of any charge you=20
have the right to deny the use of your personal data to send you written=20
correspondence. You just have to advise about this by writing to:=20
privacy@vibemac.com


*Informativa ai sensi del d.lgs n. 196, 30.6.2003*
I suoi dati saranno trattati in forma automatizzata, nel rispetto delle=20
idonee misure di sicurezza, per l'invio di comunicazioni e non saranno=20
soggetti a diffusione all'esterno di Vi.Be.Mac. Spa. In relazione al=20
trattamento dei dati, potr=E0 esercitare i diritti (accesso,cancellazione, =

rettifica, opposizione, etc.) specificamente previsti dall'art. 13 L.=20
675/1996 e nelle modalit=E0 ivi contemplate. Titolare del trattamento dei=20
dati =E8 Vi.Be.Mac. Spa, con sede legale in San Giovanni Lupatoto (Vr) via =

Monte Pastello 7/i. Per informazioni scrivere a privacy@vibemac.com Ai=20
sensi dell'art. 13 del d.lgs. 196/2003, potr=E0 opporsi in ogni momento,=20
in via gratuita, al trattamento dei suoi dati al fine dell'invio di=20
analoghe comunicazioni a mezzo di posta elettronica, semplicemente=20
comunicandocelo all'indirizzo e-mail privacy@vibemac.com Qualsiasi=20
utilizzo non autorizzato del presente messaggio nonch=E8 dei suoi allegati =

=E8 vietato e potrebbe costituire reato. Se lei ha ricevuto erroneamente=20
il presente messaggio, Le saremmo grati se via e-mail ce ne comunicasse=20
la ricezione e provvedesse alla distruzione del messaggio stesso e dei=20
suoi eventuali allegati.

VI.BE.MAC s.p.a. - 37057 S. GIOVANNI LUPATOTO (VR) ITALY - Via Monte=20
Pastello, 7/i - Tel. +39 045 8778151/52 - Fax +39 045 8779024 - Cod.=20
Fisc./Partita IVA 01264050236- Cap. Soc. Euro 2.000.000,00 int. Vers. -=20
Reg. Imprese di VERONA N. 01264050236 - REA N. 170441
Societ=E0 soggetta a direzione e coordinamento di Jack Europe S.=E0.r.l.
Il 04/12/2019 12:10, Jan Kiszka ha scritto:
> On 04.12.19 12:01, Electronic Dept. - Vbm Group via Xenomai wrote:
>> Goodmorning,
>> I'm using a Beaglebone black and I'm doing the first tests with Xenomai.
>> I've created a kernel patched with Xenomai from here:
>> https://github.com/RobertCNelson/ti-linux-kernel-dev/tree/ti-linux-xenom=
ai-4.4.y
>>
>> and installed Xenomai libraries following:
>> https://forum.digikey.com/t/how-to-cross-compile-application-for-xenomai=
-with-beaglebone/4943/3
>>
>>
>>
>> I've made a test file named cyclic_test.c and the following Makefile:
>>
>> MAIN_SRC=3D cyclic_test
>> TARGET=A0=A0=A0 =3D cyclic_test
>>
>> SKIN =A0=A0=A0 :=3D alchemy
>> CFLAGS =A0=A0=A0 :=3D $(shell /usr/xenomai/bin/xeno-config --skin=3D$(sk=
in) --cflags)
>> LDFLAGS :=3D $(shell /usr/xenomai/bin/xeno-config --skin=3D$(skin) --ldf=
lags)
>> CC =A0=A0=A0 :=3D $(shell /usr/xenomai/bin/xeno-config --cc)
>>
>> $(TARGET): $(MAIN_SRC).c
>>  =A0=A0=A0 $(CC) -o $@ $< $(CFLAGS) $(LDFLAGS)
>>
>> clean:
>>  =A0=A0=A0 @rm $(MAIN_SRC)
>>
>>
>> And I get the following response:
>>
>> gcc -o cyclic_test cyclic_test.c -I/usr/xenomai/include/cobalt
>> -I/usr/xenomai/in
>> clude -march=3Darmv7-a -mfpu=3Dvfp3 -D_GNU_SOURCE -D_REENTRANT
>> -fasynchronous-unwind
>> -tables -D__COBALT__ -Wl,--no-as-needed
>> -Wl,@/usr/xenomai/lib/modechk.wrappers
>> /usr/xenomai/lib/xenomai/bootstrap.o -Wl,--wrap=3Dmain
>> -Wl,--dynamic-list=3D/usr/xen
>> omai/lib/dynlist.ld -L/usr/xenomai/lib -lcobalt -lmodechk -lpthread -lrt
>> -march=3D
>> armv7-a -mfpu=3Dvfp3
>> /tmp/ccNmb1Fm.o: In function `rt_timer_read':
>> cyclic_test.c:(.text+0xe): undefined reference to `clockobj_get_time'
>> cyclic_test.c:(.text+0x20): undefined reference to `alchemy_clock'
>> /tmp/ccNmb1Fm.o: In function `loop_task_proc':
>> cyclic_test.c:(.text+0x32): undefined reference to `rt_task_self'
>> cyclic_test.c:(.text+0x40): undefined reference to `rt_task_inquire'
>> cyclic_test.c:(.text+0x76): undefined reference to `rt_task_set_periodic'
>> cyclic_test.c:(.text+0xc4): undefined reference to `rt_task_wait_period'
>> /tmp/ccNmb1Fm.o: In function `main':
>> cyclic_test.c:(.text+0x11c): undefined reference to `rt_task_create'
>> cyclic_test.c:(.text+0x12e): undefined reference to `rt_task_start'
>> collect2: error: ld returned 1 exit status
>> Makefile:10: recipe for target 'cyclic_test' failed
>> make: *** [cyclic_test] Error 1
>>
>> Can you advise me plase?
>> Thank you very much.
> You are missing "-lalchemy" in your linker flags. Normally, xeno-config
> --skin=3Dalchemy --ldflags returns this, at least for me here with both
> latest stable and the 3.1-rc. What version are you using?
>
> Jan
>
