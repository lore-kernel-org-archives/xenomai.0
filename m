From: Prasanna Kannan <prasanna.kannan@ipg-automotive.com>
Subject: Difference between Xenomai timer and Linux clock
Date: Fri, 27 May 2022 15:39:08 +0200 (CEST)
Message-ID: <014301d871cf$2449b990$6cdd2cb0$@ipg-automotive.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: de
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello Everybody,

I am comparing the Xenomai Timer(rt_timer_read()) and clock_gettime() with
CLOCK_REALTIME and found that the two drift at roughly 100 us/s
Here is the snippet from my code:

init():
clock_gettime(CLOCK_REALTIME, &ts_start);
rtime_start = rt_timer_read();

runtime():
clk_xenotime = (rt_timer_read() - rtime_start) * 1e-9;
clock_gettime(CLOCK_REALTIME, &ts);
clk_rttime = (ts.tv_sec - ts_start.tv_sec) + (ts.tv_nsec -
ts_start.tv_nsec) * 1e-9;
delta = clk_rttime - clk_xenotime

The observation is that the delta is around 100us/s
...
ClockGetTime:2.588435s, rt_timer_read:2.588167s, delta:0.000268s
ClockGetTime:3.588533s, rt_timer_read:3.588161s, delta:0.000372s
ClockGetTime:4.588671s, rt_timer_read:4.588196s, delta:0.000475s
...

The Linux clock is not corrected via NTP/PTP, thus I am wondering why they
are drifting in this way.

Some Information about my setup:
Xenomai/cobalt v3.1
Linux rtdonau 4.19.115-ipipe #54 SMP PREEMPT Wed Oct 13 12:16:56 CEST 2021
x86_64 GNU/Linux
Kernel parameters: intel_idle.max_cstate=0 vga=0x317 ip=dhcp root=/dev/nfs
nfsroot=10.0.0.1:/opt/xyz/xeno_rt,tcp,nfsvers=3 BOOT_IMAGE=xeno10.2 
I-pipe release #12 detected
Cobalt core 3.1 detected
Compiler: gcc version 7.5.0 (GCC) 
Build args: --prefix=/opt/xenomai-3.1 --enable-smp --enable-pshared
--enable-dlopen-libs

The hardware used is an Intel SBC based on Core i7-4700EQ CPU @ 2.40GHz

Thank you in Advance.

Best Regards
Prasanna


