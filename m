From: Steven Seeger <steven.seeger@flightsystems.net>
Subject: Re: [PATCH] powerpc: ipipe: Do full exit checks after
 __ipipe_call_mayday
Date: Fri, 20 Dec 2019 17:19:10 -0500
Message-ID: <3547025.FgZ9TNa1CN@omoikane>
In-Reply-To: <d93a6092-b340-b74b-ff3d-51ac5c438c25@siemens.com>
References: <d93a6092-b340-b74b-ff3d-51ac5c438c25@siemens.com>
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

Tried running with your patch, Jan. I made sure the files I sent you I had 
worked on were the same I had sent you. I wound up with a crash in 
do_user_signal during the smokey gdb test.

# LD_LIBRARY_PATH=/usr/xenomai/lib /usr/xenomai/bin/smokey --run=gdb
[   10.650031] Unable to handle kernel paging request for instruction fetch
[   10.656762] Faulting instruction address: 0xc0010b00
[   10.661736] Oops: Kernel access of bad area, sig: 11 [#1]
[   10.667124] BE PREEMPT Aitech SP0S100
[   10.670780] Modules linked in: unix
[   10.674268] CPU: 0 PID: 982 Comm: smokey Not tainted 4.19.55-aitech #96
[   10.680871] I-pipe domain: Linux
[   10.684089] NIP:  c0010b00 LR: c0010ad8 CTR: c00a8f1c
[   10.689131] REGS: ee8cbe90 TRAP: 0400   Not tainted  (4.19.55-aitech)
[   10.695559] MSR:  00009220 <EE,ME,DE,IR>  CR: 24000284  XER: 20000000
[   10.701998] 
[   10.701998] GPR00: 00000000 ee8cbf40 ef156bc0 00000000 c0007890 ef156bc0 
00000000 5d084753 
[   10.701998] GPR08: c055b068 00000001 c0599a60 00021000 22000282 1004870c 
00000000 00000000 
[   10.701998] GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 
00000000 10040000 
[   10.701998] GPR24: 00000000 b7ffc000 1001e480 1001e4b0 10041198 100425d0 
00000002 bffff9d0 
[   10.736886] NIP [c0010b00] do_user_signal+0x20/0x34
[   10.741755] LR [c0010ad8] recheck+0x48/0x50
[   10.745927] Call Trace:
[   10.748362] Instruction dump:
[   10.751322] 7d400124 48089e21 2c830000 4186ffa0 614a8000 7d400124 806100b0 
70600001 
[   10.759066] 41820010 bda10044 5463003c 906100b0 <38610010> 7d244b78 
4bff7add b9a10044 
[   10.766985] ---[ end trace d102d53b0f8d6db9 ]---
[   10.771591] 






