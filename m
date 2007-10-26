Message-ID: <47223AB7.3080601@domain.hid>
Date: Fri, 26 Oct 2007 15:06:31 -0400
From: "Steven A. Falco" <sfalco@domain.hid>
MIME-Version: 1.0
References: <47220255.4040309@domain.hid> <472220AD.6080402@domain.hid>
	<472229DF.4060700@domain.hid> <47222C0E.50203@domain.hid>
In-Reply-To: <47222C0E.50203@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------070504090805060203080401"
Subject: Re: [Xenomai-core] clocktest and cyclictest work but irqloop crashes
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------070504090805060203080401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

My apologies - I didn't realize I had to change that configuration.  
I'll look into it.

The 405GP UART is a 16550 clone but the registers are at ef600300 in 
memory space, and the IRQ is 0.  This information is captured in the 
board-specific .dts file - it looks like the .dts info is made available 
in /sysfs.

That said, I think there is more going on here.  Without Xenomai, I am 
able to ping the loopback address.  With Xenomai, I get a crash, also 
involving a "kernel access of bad area".  Note: in both cases I am able 
to mount my root filesystem over NFS, so the kernel is able to use the 
network, but user-land (or at least ping) is not.  Here is what the ping 
crash looks like:

# ping 127.0.0.1
PING 127.0.0.1 (127.0.0.1): 56 data bytes
Unable to handle kernel paging request for data at address 0x00000008
Faulting instruction address: 0xc01b4968
Oops: Kernel access of bad area, sig: 11 [#1]
Netdec
Modules linked in:
NIP: c01b4968 LR: c01b4fc8 CTR: c0172e88
REGS: c0e479e0 TRAP: 0300   Not tainted  (2.6.23)
MSR: 00029030 <EE,ME,IR,DR>  CR: 42000422  XER: 00000000
DEAR: 00000008, ESR: 00000000
TASK = c06cb420[660] 'ping' THREAD: c0e46000
GPR00: 00000000 c0e47a90 c06cb420 00000008 00000001 7f000001 7f000001 
00000002
GPR08: c0f21e00 c02a1680 00000000 c02a0000 c0f21e10 100d25f0 00ff9900 
00000001
GPR16: 000000a0 c06dbf68 c0230000 c0290000 c0e47b78 fffee72a c02e7d88 
00000000
GPR24: c02e7da8 00000040 c02a1680 c02e9208 00000001 c06c0040 c034fbe0 
c0f21e10
NIP [c01b4968] __raw_v4_lookup+0x10/0x84
LR [c01b4fc8] raw_v4_input+0xb0/0x15c
Call Trace:
[c0e47a90] [c01b4f94] raw_v4_input+0x7c/0x15c (unreliable)
[c0e47ab0] [c01949b0] ip_local_deliver+0xb0/0x188
[c0e47ad0] [c0194cc4] ip_rcv+0x23c/0x4a4
[c0e47b00] [c017b774] netif_receive_skb+0x220/0x2dc
[c0e47b30] [c017deb4] process_backlog+0xb0/0x190
[c0e47b70] [c017e03c] net_rx_action+0xa8/0x19c
[c0e47bb0] [c0023294] __do_softirq+0x80/0xfc
[c0e47be0] [c0004e8c] do_softirq+0x74/0x78
[c0e47bf0] [c0023050] local_bh_enable+0x70/0x98
[c0e47c00] [c017e768] dev_queue_xmit+0x9c/0x2c8
[c0e47c20] [c0184e68] neigh_resolve_output+0xe4/0x258
[c0e47c50] [c0199310] ip_output+0x2c4/0x328
[c0e47c70] [c01987f8] ip_push_pending_frames+0x280/0x40c
[c0e47c90] [c01b5928] raw_sendmsg+0x684/0x71c
[c0e47d10] [c01be83c] inet_sendmsg+0x50/0x78
[c0e47d30] [c016f3cc] sock_sendmsg+0xac/0xf4
[c0e47e20] [c016f75c] sys_sendto+0xcc/0x108
[c0e47f00] [c01700c4] sys_socketcall+0x138/0x1d8
[c0e47f40] [c000d98c] ret_from_syscall+0x0/0x3c
Instruction dump:
7d2b0194 913f0000 915f0004 80010014 83e1000c 7c0803a6 38210010 4e800020
2c030000 4da20020 34630008 41820070 <81230000> 2f090000 419a0008 7c004a2c
Kernel panic - not syncing: Fatal exception in interrupt
Rebooting in 1 seconds..<0>System Halted, OK to turn off power


    Steve

Jan Kiszka wrote:
> Steven A. Falco wrote:
>   
>> Hmmm.  IRQ4 is "PCI ExternalCommand Write"?  But I'm not using PCI. 
>> Here is the output:
>>
>> # ./irqloop
>> NULL ->unmask handler, IRQ 4, chip <NULL>
>> Test mode:    user-space task
>> Port type:    serial
>> Port address: 0x3f8
>> Port IRQ:     4
>>     
>
> Well, irqloop is preconfigured for boring x86 PCs, not thrilling PowerPC
> platforms :). It assumes there is a 16550-based UART at the given
> address using the given IRQ, but I would bet this doesn't apply to your
> board. Please check doc/txt/irqbench.txt on the requirements.
>
> What interface do you plan to use for the IRQ latency test? Maybe it is
> possible to extend the benchmark driver.
>
> Jan
>
>   

--------------070504090805060203080401
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<tt>My apologies - I didn't realize I had to change that
configuration.&nbsp; I'll look into it.<br>
<br>
The 405GP UART is a 16550 clone but the registers are at ef600300 in
memory space, and the IRQ is 0.&nbsp; This information is captured in the
board-specific .dts file - it looks like the .dts info is made
available in /sysfs.<br>
<br>
That said, I think there is more going on here.&nbsp; Without Xenomai, I am
able to ping the loopback address.&nbsp; With Xenomai, I get a crash, also
involving a "kernel access of bad area".&nbsp; Note: in both cases I am able
to mount my root filesystem over NFS, so the kernel is able to use the
network, but user-land (or at least ping) is not.&nbsp; Here is what the
ping crash looks like:<br>
<br>
# ping 127.0.0.1<br>
PING 127.0.0.1 (127.0.0.1): 56 data bytes<br>
Unable to handle kernel paging request for data at address 0x00000008<br>
Faulting instruction address: 0xc01b4968<br>
Oops: Kernel access of bad area, sig: 11 [#1]<br>
Netdec<br>
Modules linked in:<br>
NIP: c01b4968 LR: c01b4fc8 CTR: c0172e88<br>
REGS: c0e479e0 TRAP: 0300&nbsp;&nbsp; Not tainted&nbsp; (2.6.23)<br>
MSR: 00029030 &lt;EE,ME,IR,DR&gt;&nbsp; CR: 42000422&nbsp; XER: 00000000<br>
DEAR: 00000008, ESR: 00000000<br>
TASK = c06cb420[660] 'ping' THREAD: c0e46000<br>
GPR00: 00000000 c0e47a90 c06cb420 00000008 00000001 7f000001 7f000001
00000002<br>
GPR08: c0f21e00 c02a1680 00000000 c02a0000 c0f21e10 100d25f0 00ff9900
00000001<br>
GPR16: 000000a0 c06dbf68 c0230000 c0290000 c0e47b78 fffee72a c02e7d88
00000000<br>
GPR24: c02e7da8 00000040 c02a1680 c02e9208 00000001 c06c0040 c034fbe0
c0f21e10<br>
NIP [c01b4968] __raw_v4_lookup+0x10/0x84<br>
LR [c01b4fc8] raw_v4_input+0xb0/0x15c<br>
Call Trace:<br>
[c0e47a90] [c01b4f94] raw_v4_input+0x7c/0x15c (unreliable)<br>
[c0e47ab0] [c01949b0] ip_local_deliver+0xb0/0x188<br>
[c0e47ad0] [c0194cc4] ip_rcv+0x23c/0x4a4<br>
[c0e47b00] [c017b774] netif_receive_skb+0x220/0x2dc<br>
[c0e47b30] [c017deb4] process_backlog+0xb0/0x190<br>
[c0e47b70] [c017e03c] net_rx_action+0xa8/0x19c<br>
[c0e47bb0] [c0023294] __do_softirq+0x80/0xfc<br>
[c0e47be0] [c0004e8c] do_softirq+0x74/0x78<br>
[c0e47bf0] [c0023050] local_bh_enable+0x70/0x98<br>
[c0e47c00] [c017e768] dev_queue_xmit+0x9c/0x2c8<br>
[c0e47c20] [c0184e68] neigh_resolve_output+0xe4/0x258<br>
[c0e47c50] [c0199310] ip_output+0x2c4/0x328<br>
[c0e47c70] [c01987f8] ip_push_pending_frames+0x280/0x40c<br>
[c0e47c90] [c01b5928] raw_sendmsg+0x684/0x71c<br>
[c0e47d10] [c01be83c] inet_sendmsg+0x50/0x78<br>
[c0e47d30] [c016f3cc] sock_sendmsg+0xac/0xf4<br>
[c0e47e20] [c016f75c] sys_sendto+0xcc/0x108<br>
[c0e47f00] [c01700c4] sys_socketcall+0x138/0x1d8<br>
[c0e47f40] [c000d98c] ret_from_syscall+0x0/0x3c<br>
Instruction dump:<br>
7d2b0194 913f0000 915f0004 80010014 83e1000c 7c0803a6 38210010 4e800020<br>
2c030000 4da20020 34630008 41820070 &lt;81230000&gt; 2f090000 419a0008
7c004a2c<br>
Kernel panic - not syncing: Fatal exception in interrupt<br>
Rebooting in 1 seconds..&lt;0&gt;System Halted, OK to turn off power<br>
<br>
<br>
&nbsp;&nbsp;&nbsp; Steve<br>
<br>
</tt>Jan Kiszka wrote:
<blockquote cite="mid:47222C0E.50203@domain.hid" type="cite">
  <pre wrap="">Steven A. Falco wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Hmmm.  IRQ4 is "PCI ExternalCommand Write"?  But I'm not using PCI. 
Here is the output:

# ./irqloop
NULL -&gt;unmask handler, IRQ 4, chip &lt;NULL&gt;
Test mode:    user-space task
Port type:    serial
Port address: 0x3f8
Port IRQ:     4
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Well, irqloop is preconfigured for boring x86 PCs, not thrilling PowerPC
platforms :). It assumes there is a 16550-based UART at the given
address using the given IRQ, but I would bet this doesn't apply to your
board. Please check doc/txt/irqbench.txt on the requirements.

What interface do you plan to use for the IRQ latency test? Maybe it is
possible to extend the benchmark driver.

Jan

  </pre>
</blockquote>
</body>
</html>

--------------070504090805060203080401--

