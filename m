From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <alpine.DEB.1.10.1103011145430.14165@domain.hid>
References: <alpine.DEB.1.10.1102281209570.12109@domain.hid>
	<4D6B9032.5060907@domain.hid>
	<alpine.DEB.1.10.1102281325340.12109@domain.hid>
	<4D6B92C8.3070505@domain.hid>
	<alpine.DEB.1.10.1102281342180.12109@domain.hid>
	<4D6B97E5.5030901@domain.hid>
	<alpine.DEB.1.10.1102281353490.12109@domain.hid>
	<4D6BA899.90600@domain.hid>
	<alpine.DEB.1.10.1102281944470.12808@domain.hid>
	<alpine.DEB.1.10.1103011145430.14165@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 06 Mar 2011 05:17:52 +0100
Message-ID: <1299385072.2200.2.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] More blackfin kernel oops under heavy load
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Kolja Waschk <xenoka09@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2011-03-01 at 11:50 +0100, Kolja Waschk wrote:
> Hi,
> 
> >> http://www.ixo.de/tmp/till20110228.tgz
> 
> After verifying that no one yet checked, I updated the code in the archive to even better reflect the "real" situation. The main thread emits a number on stdout every second endlessly, waiting for SIGINT. To trigger the fault, it is necessary to contact the net server (with wget as I described) in a fast loop and after some time (about 2 seconds in my setup) the kernel fault occurs.
> 
> Parameters to tune the load on the system are the frame size (MODT_BUFLEN in modt.h) and a nop loop in till.c rtdm_loop() (line 84). The BF537 here is running with 133 MHz bus clock, 533 MHz system clock.
> 

100% reproducible here as well. Does this fix help?

diff --git a/arch/blackfin/mach-common/entry.S b/arch/blackfin/mach-common/entry.S
index a5847f5..a7650ce 100644
--- a/arch/blackfin/mach-common/entry.S
+++ b/arch/blackfin/mach-common/entry.S
@@ -892,8 +892,17 @@ ENDPROC(_ret_from_exception)
 #ifdef CONFIG_IPIPE
 
 _resume_kernel_from_int:
+	r1 = LO(~0x8000) (Z);
+	r1 = r0 & r1;
+	r0 = 1;
+	r0 = r1 - r0;
+	r2 = r1 & r0;
+	cc = r2 == 0;
+	/* Sync the root stage only from the outer interrupt level. */
+	if !cc jump .Lnosync;
 	r0.l = ___ipipe_sync_root;
 	r0.h = ___ipipe_sync_root;
+	[--sp] = reti;
 	[--sp] = rets;
 	[--sp] = ( r7:4, p5:3 );
 	SP += -12;
@@ -901,6 +910,8 @@ _resume_kernel_from_int:
 	SP += 12;
 	( r7:4, p5:3 ) = [sp++];
 	rets = [sp++];
+	reti = [sp++];
+.Lnosync:
 	rts
 #else
 #define _resume_kernel_from_int	 2f

-- 
Philippe.



