From: Prasanna Kannan <prasanna.kannan@ipg-automotive.com>
References: <014301d871cf$2449b990$6cdd2cb0$@ipg-automotive.com>
 <MN2PR11MB4285318D2C2F0AEDABADDBBAF2DD9@MN2PR11MB4285.namprd11.prod.outlook.com>
In-Reply-To: <MN2PR11MB4285318D2C2F0AEDABADDBBAF2DD9@MN2PR11MB4285.namprd11.prod.outlook.com>
Subject: AW: Difference between Xenomai timer and Linux clock
Date: Mon, 30 May 2022 09:33:26 +0200 (CEST)
Message-ID: <006101d873f7$8cf5e070$a6e1a150$@ipg-automotive.com>
MIME-Version: 1.0
Content-Language: de
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>, xenomai@xenomai.org

> -----Urspr=FCngliche Nachricht-----
> Von: Chen, Hongzhan [mailto:hongzhan.chen@intel.com]
> Gesendet: Montag, 30. Mai 2022 02:56
> An: Prasanna Kannan <prasanna.kannan@ipg-automotive.com>;
> xenomai@xenomai.org
> Betreff: RE: Difference between Xenomai timer and Linux clock
>
>
>
> >-----Original Message-----
> >From: Xenomai <xenomai-bounces@xenomai.org> On Behalf Of Prasanna
> >Kannan via Xenomai
> >Sent: Friday, May 27, 2022 9:39 PM
> >To: xenomai@xenomai.org
> >Subject: Difference between Xenomai timer and Linux clock
> >
> >Hello Everybody,
> >
> >I am comparing the Xenomai Timer(rt_timer_read()) and clock_gettime()
> >with CLOCK_REALTIME and found that the two drift at roughly 100 us/s
> >Here is the snippet from my code:
> >
> >init():
> >clock_gettime(CLOCK_REALTIME, &ts_start); rtime_start =3D
> >rt_timer_read();
> >
> >runtime():
> >clk_xenotime =3D (rt_timer_read() - rtime_start) * 1e-9;
> >clock_gettime(CLOCK_REALTIME, &ts); clk_rttime =3D (ts.tv_sec -
> >ts_start.tv_sec) + (ts.tv_nsec -
> >ts_start.tv_nsec) * 1e-9;
> >delta =3D clk_rttime - clk_xenotime
> >
> >The observation is that the delta is around 100us/s ...
> >ClockGetTime:2.588435s, rt_timer_read:2.588167s, delta:0.000268s
> >ClockGetTime:3.588533s, rt_timer_read:3.588161s, delta:0.000372s
> >ClockGetTime:4.588671s, rt_timer_read:4.588196s, delta:0.000475s ...
> >
> >The Linux clock is not corrected via NTP/PTP, thus I am wondering why
> >they are drifting in this way.
> >
> >Some Information about my setup:
> >Xenomai/cobalt v3.1
> >Linux rtdonau 4.19.115-ipipe #54 SMP PREEMPT Wed Oct 13 12:16:56 CEST
> >2021
> >x86_64 GNU/Linux
> >Kernel parameters: intel_idle.max_cstate=3D0 vga=3D0x317 ip=3Ddhcp
> >root=3D/dev/nfs
> >nfsroot=3D10.0.0.1:/opt/xyz/xeno_rt,tcp,nfsvers=3D3 BOOT_IMAGE=3Dxeno10.2
> >I-pipe release #12 detected Cobalt core 3.1 detected
> >Compiler: gcc version 7.5.0 (GCC)
> >Build args: --prefix=3D/opt/xenomai-3.1 --enable-smp --enable-pshared
> >--enable-dlopen-libs
> >
> >The hardware used is an Intel SBC based on Core i7-4700EQ CPU @ 2.40GHz
>
> One of what we found is that there is delayed work which would refine
tsc
> clock after Xenomai init and that cause Clock difference which may
result in
> such drift.  The patchset "[Cobalt Xenoami3.1 PATCH 0/2] notify Xenomai
> udpated clockfreq."
> I sent in community at 5/27 try to fix what we found.  Could you send
your
> complete linux dmsg to check if our issues is the same?
>
Yes, I can confirm this as I see similar messages in my linux dmesg:
[    0.000000] tsc: Detected 2394.479 MHz processor
[    1.714630] tsc: Refined TSC clocksource calibration: 2394.455 MHz

[rtdonau-~] !) cat /sys/module/xenomai/parameters/clockfreq
2394479000
Attached my complete  dmesg.

> Regards
>
> Hongzhan Chen
> >
> >Thank you in Advance.
> >
> >Best Regards
> >Prasanna
> >
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: dmesg_rtdonau.txt
URL: <http://xenomai.org/pipermail/xenomai/attachments/20220530/e5d2e114/at=
tachment.txt>
