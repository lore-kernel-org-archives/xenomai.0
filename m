From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <000001cbc4b0$03297d50$097c77f0$@de>
References: <mailman.9723.1296855625.10284.xenomai@xenomai.org>
	<000001cbc4b0$03297d50$097c77f0$@de>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 04 Feb 2011 23:32:24 +0100
Message-ID: <1296858744.2087.44.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [    1.954665] Xenomai: native skin init failed,
 code -19
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Franz Engel <franz_lambert_engel@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2011-02-04 at 22:10 +0100, Franz Engel wrote:
> Here is my full boot log:

[snip]

> [    0.030589] tseg: 0000000000
> [    0.030596] CPU: Physical Processor ID: 0
> [    0.030626] CPU: Processor Core ID: 0
> [    0.030657] mce: CPU supports 6 MCE banks
> [    0.030692] using C1E aware idle routine

This means that you are not running the patched kernel. There is no way
the c1e_idle routine which outputs the above message could run with it
applied.

[snip]

> [    0.030000] CPU: L2 Cache: 512K (64 bytes/line)
> [    0.030000] CPU 1/0x1 -> Node 0
> [    0.030000] CPU: Physical Processor ID: 0
> [    0.030000] CPU: Processor Core ID: 1
> [    0.430096] CPU1: AMD Phenom(tm) II X6 1055T Processor stepping 00
> [    0.430357] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
> [    0.440015] System has AMD C1E enabled

This means you BIOS did not disable C1E properly. The CPU still
advertises this mode. 

In fact, once C1E is properly disabled by the BIOS, you should not need
the patch at all.

Please check your BIOS setup and kernel install. You don't seem to be
running what you think you do actually.

-- 
Philippe.



