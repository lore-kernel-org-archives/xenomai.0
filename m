Date: Mon, 4 Dec 2006 17:39:48 +0300
From: Anthony Sharobaiko <anthony@domain.hid>
Subject: Re: [Xenomai-help] Xenomai install problems
Message-ID: <20061204143948.GA20411@domain.hid>
References: <20061204133717.GA20186@domain.hid> <4574268C.7000705@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4574268C.7000705@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Mon, Dec 04, 2006 at 02:45:48PM +0100, Jan Kiszka wrote:
> Is it a pure user-space crash, or do you also see some oops in the
> kernel logs?

Yes, sometimes (I still can not understand what affects this) it crashes with oops:
=== cut here ===
root@domain.hid# ./run 
*
*
* Type ^C to stop this application.
*
*
Bad mode in prefetch abort handler detected: mode UK13_32
Internal error: Oops - bad mode: 0 [#1]
Modules linked in:
CPU: 0
PC is at 0x228
LR is at 0x22b
pc : [<00000228>]    lr : [<0000022b>]    Not tainted
sp : c06f1fb8  ip : 4002afd4  fp : be9d3cb8
r10: 00000000  r9 : 00000000  r8 : 400331b4
r7 : 00000001  r6 : be9d3e34  r5 : be9d3e3c  r4 : 4001c8dc
r3 : 4001c8f0  r2 : be9d3cbc  r1 : 00000001  r0 : ffffffda
Flags: nzcv  IRQs on  FIQs on  Mode UK13_32  Segment user
Control: 397F  Table: A3F34000  DAC: 00000015
Process latency (pid: 1099, stack limit = 0xc06f01a0)
Stack: (0xc06f1fb8 to 0xc06f2000)
1fa0:                                                       ffffffda
00000001 
1fc0: be9d3cbc 4001c8f0 4001c8dc be9d3e3c be9d3e34 00000001 400331b4
00000000 
1fe0: 00000000 be9d3cb8 4002afd4 c06f1fb8 0000022b 00000228 0000001d
ffffffff 
Backtrace: invalid frame pointer 0xbe9d3cb8
Code: bad PC value.
 /usr/xenomai/bin/xeno-load: line 247:  1099 Segmentation fault
 $suflag $* $cmdargs
=== cut here ===

How can I provide more detailed log? ksymoops?

> If it's user-space, place attach gdb to find out where it
> crashes.

ok, I'll try to put gdbserver in there and look.


-- 
	WBR, Anthony Sharobaiko.


