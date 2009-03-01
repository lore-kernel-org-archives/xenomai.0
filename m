From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Sun, 1 Mar 2009 18:30:07 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200903011830.08793.niklaus.giger@domain.hid>
Subject: [Xenomai-core] zombie thread would not die
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi

I successfully ported our basic IO library to Xenomai with the vxWorks
skin running on our PPC405GPr based HCU4 (which was accepted into Linux 
2.6.28). I just added support for one external interrrupt (occurring every 
millisecond) and two CAN interrupts (not yet currently activated).

Now my program starts up, recognizes the HW but stops sometimes after 5 
seconds, sometimes after 30 seconds. Always with a zombie message. Can anyboy 
tell me, where the error is or what I have to check?

I am using  svn://svn.gna.org/svn/xenomai/trunk (Revision 4662).
uname -a gives
Linux hcu4 2.6.28.5-dirty #12 Sun Mar 1 13:45:44 CET 2009 ppc ppc ppc 
GNU/Linux
cat /proc/ipipe/version
2.4-04
cat /proc/interrupts
           CPU0
 16:        220   UIC   Level     serial
 17:       7971   UIC   Level     MAL TX EOB
 18:      12537   UIC   Level     MAL RX EOB
 19:          0   UIC   Level     CAN1
 20:          0   UIC   Level     CAN2
 21:          0   UIC   Level     MAL SERR
 22:          0   UIC   Level     MAL TX DE
 23:          0   UIC   Level     MAL RX DE
 24:          0   UIC   Level     EMAC
 25:          0   UIC   Level     CPLD
BAD:          0


 Xenomai: fatal: zombie thread iTsk_25 (c18e3e20) would not die...
 CPU  PID    PRI      TIMEOUT  STAT      NAME
>  0  0      231      0        00200080  ROOT
   0  1032   211(45)  1        00100184  root
   0  1034   231(25)  0        00100380  tUtilLog
   0  1036   246(10)  0        00100182  tBBprio
   0  1039   216(40)  0        00100182  BSysThreadPool0
   0  1040   216(40)  0        00100182  BSysThreadPool1
   0  1041   216(40)  0        00100182  BSysThreadPool2
   0  1042   216(40)  0        00100182  BSysThreadPool3
   0  1043   216(40)  0        00100182  BSysThreadPool4
   0  1044   216(40)  0        00100182  BSysThreadPool5
   0  1045   216(40)  0        00100182  BSysThreadPool6
   0  1046   216(40)  0        00100182  BSysThreadPool7
   0  1047   216(40)  0        00100182  BSysThreadPool8
   0  1048   216(40)  0        00100182  BSysThreadPool9
   0  1049   254(2)   2        00100186  tBBmsec
Master time base: clock=273984265688

Call Trace:
[c1a8de50] [c0006c7c] show_stack+0x44/0x16c (unreliable)
[c1a8de90] [c00584d8] __xnpod_schedule+0x444/0x634
[c1a8dee0] [c00546b8] xnintr_clock_handler+0x1c4/0x1d8
[c1a8df10] [c004f844] __ipipe_dispatch_wired_nocheck+0x80/0xf4
[c1a8df30] [c0008a74] __ipipe_grab_timer+0x78/0xd4
[c1a8df40] [c0010244] __ipipe_ret_from_except+0x0/0xc

Best regards

-- 
Niklaus Giger


