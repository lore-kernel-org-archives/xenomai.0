Message-ID: <4720A719.7090100@domain.hid>
Date: Thu, 25 Oct 2007 10:24:25 -0400
From: "Steven A. Falco" <sfalco@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="------------030900050406080303080705"
Subject: [Xenomai-core] kernel BUG running cyclictest on powerpc 405
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------030900050406080303080705
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I have built a 2.6.23-rc7 kernel (from Denx git) with Xenomai 2.4-rc3.  
Architecture is powerpc, processor is a 405GP.

I had to make some additions to arch/powerpc/kernel/head_40x.S, and I 
can submit a patch if someone tells me where to post it.

However, while the kernel boots and runs, the xenomai user apps do not 
work correctly.  Specifically, when running cyclictest, I get the following:

    # ./cyclictest
    0.00 0.00 0.00 1/18 668

    T: 0 (  668) P:99 I:   ------------[ cut here ]------------     0
    Avg:       0 Max:-1000000
     1000 C:       5kernel BUG at
    /n/maytag/home/sfalco/linux/embedded/ppc3/linux/linux-2.6-denx/kernel/ipipe/core.c:314!
     Min:      24 AcOops: Exception in kernel mode, sig: 5 [#1]
    Netdec
    Modules linked in:
    NIP: c0045dd0 LR: c0015750 CTR: c00121fc
    REGS: c0dbde00 TRAP: 0700   Not tainted  (2.6.23-rc7)
    MSR: 00021030 <ME,IR,DR>  CR: 22000422  XER: 20000000
    TASK = c0fe7420[668] 'cyclictest' THREAD: c0dbc000
    GPR00: 00004900 c0dbdeb0 c0fe7420 00000000 003f0000 c00115dc
    00000000 00000000
    GPR08: 00000000 000048ff c0296090 00000001 00010000 1001c23c
    00ff9900 00000001
    GPR16: 7fbabcb0 10015090 10015068 00000000 0ff81940 00000000
    0000029a 0ff815d0
    GPR24: c02a2fcc 00000280 00000000 c030c200 0000001f 003f0000
    00000010 c028e3bc
    NIP [c0045dd0] __ipipe_restore_root+0x1c/0x50
    LR [c0015750] uic_mask_irq+0x84/0x98
    Call Trace:
    [c0dbdeb0] [c0054cdc] hisyscall_event+0x1fc/0x310 (unreliable)
    [c0dbded0] [c00439fc] __ipipe_ack_level_irq+0x50/0x78
    [c0dbdee0] [c0007b2c] __ipipe_ack_irq+0x28/0x3c
    [c0dbdef0] [c0007e68] __ipipe_handle_irq+0x12c/0x148
    [c0dbdf20] [c00080f8] __ipipe_grab_irq+0x3c/0xc0
    [c0dbdf40] [c000e338] __ipipe_ret_from_except+0x0/0xc
    Instruction dump:
    0.00 0.00 0.00 2/18 66Xenomai: POSIX: destroyed thread c0f803203d20c02c
    8          004a78 3120ffff 7d690110 <0f0b0000> 2f830000 3d60c029
    392b6050
    t:      39 Avg:      29 Max:      39
    T: 0 (  668) P:99 I:    1000 C:       8 Min:      24 Act:      24
    Avg:      29 Max:      39
    Trace/breakpoint trap

The bug is coming from ipipe/core.c:314, which is the BUG_ON here:

    void __ipipe_restore_root(unsigned long x)
    {
        BUG_ON(!ipipe_root_domain_p);

        if (x)
            __ipipe_stall_root();
        else
            __ipipe_unstall_root();
    }

How do I debug this?  I have done a little kernel hacking, but I am a 
noob when it comes to Xenomai...

    Steve


--------------030900050406080303080705
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<body bgcolor="#ffffff" text="#000000">
<tt>I have built a 2.6.23-rc7 kernel (from Denx git) with Xenomai
2.4-rc3.  Architecture is powerpc, processor is a 405GP.<br>
<br>
I had to make some additions to arch/powerpc/kernel/head_40x.S, and I
can submit a patch if someone tells me where to post it.<br>
<br>
However, while the kernel boots and runs, the xenomai user apps do not
work correctly.  Specifically, when running cyclictest, I get the
following:<br>
</tt>
<blockquote><tt># ./cyclictest</tt><br>
  <tt>0.00 0.00 0.00 1/18 668</tt><br>
  <br>
  <tt>T: 0 (  668) P:99 I:   ------------[ cut here ]------------     0
Avg:       0 Max:-1000000</tt><br>
  <tt> 1000 C:       5kernel BUG at
/n/maytag/home/sfalco/linux/embedded/ppc3/linux/linux-2.6-denx/kernel/ipipe/core.c:314!</tt><br>
  <tt> Min:      24 AcOops: Exception in kernel mode, sig: 5 [#1]</tt><br>
  <tt>Netdec</tt><br>
  <tt>Modules linked in:</tt><br>
  <tt>NIP: c0045dd0 LR: c0015750 CTR: c00121fc</tt><br>
  <tt>REGS: c0dbde00 TRAP: 0700   Not tainted  (2.6.23-rc7)</tt><br>
  <tt>MSR: 00021030 &lt;ME,IR,DR&gt;  CR: 22000422  XER: 20000000</tt><br>
  <tt>TASK = c0fe7420[668] 'cyclictest' THREAD: c0dbc000</tt><br>
  <tt>GPR00: 00004900 c0dbdeb0 c0fe7420 00000000 003f0000 c00115dc
00000000 00000000</tt><br>
  <tt>GPR08: 00000000 000048ff c0296090 00000001 00010000 1001c23c
00ff9900 00000001</tt><br>
  <tt>GPR16: 7fbabcb0 10015090 10015068 00000000 0ff81940 00000000
0000029a 0ff815d0</tt><br>
  <tt>GPR24: c02a2fcc 00000280 00000000 c030c200 0000001f 003f0000
00000010 c028e3bc</tt><br>
  <tt>NIP [c0045dd0] __ipipe_restore_root+0x1c/0x50</tt><br>
  <tt>LR [c0015750] uic_mask_irq+0x84/0x98</tt><br>
  <tt>Call Trace:</tt><br>
  <tt>[c0dbdeb0] [c0054cdc] hisyscall_event+0x1fc/0x310 (unreliable)</tt><br>
  <tt>[c0dbded0] [c00439fc] __ipipe_ack_level_irq+0x50/0x78</tt><br>
  <tt>[c0dbdee0] [c0007b2c] __ipipe_ack_irq+0x28/0x3c</tt><br>
  <tt>[c0dbdef0] [c0007e68] __ipipe_handle_irq+0x12c/0x148</tt><br>
  <tt>[c0dbdf20] [c00080f8] __ipipe_grab_irq+0x3c/0xc0</tt><br>
  <tt>[c0dbdf40] [c000e338] __ipipe_ret_from_except+0x0/0xc</tt><br>
  <tt>Instruction dump:</tt><br>
  <tt>0.00 0.00 0.00 2/18 66Xenomai: POSIX: destroyed thread
c0f803203d20c02c</tt><br>
  <tt>8          004a78 3120ffff 7d690110 &lt;0f0b0000&gt; 2f830000
3d60c029 392b6050</tt><br>
  <tt>t:      39 Avg:      29 Max:      39</tt><br>
  <tt>T: 0 (  668) P:99 I:    1000 C:       8 Min:      24 Act:      24
Avg:      29 Max:      39</tt><br>
  <tt>Trace/breakpoint trap</tt><br>
</blockquote>
<tt>The bug is coming from</tt><tt> ipipe/core.c:314</tt><tt>, which is
the BUG_ON here:<br>
</tt>
<blockquote><tt>void __ipipe_restore_root(unsigned long x)</tt><br>
  <tt>{</tt><br>
  <tt>    BUG_ON(!ipipe_root_domain_p);</tt><br>
  <br>
  <tt>    if (x)</tt><br>
  <tt>        __ipipe_stall_root();</tt><br>
  <tt>    else</tt><br>
  <tt>        __ipipe_unstall_root();</tt><br>
  <tt>}</tt><br>
</blockquote>
<tt>How do I debug this?  I have done a little kernel hacking, but I am
a noob when it comes to Xenomai...<br>
<br>
    Steve<br>
<br>
</tt>
</body>
</html>

--------------030900050406080303080705--

