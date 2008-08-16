From: Paul <paul_c@domain.hid>
Date: Sat, 16 Aug 2008 23:15:31 +0100
References: <486E6E1D.2020209@domain.hid> <4871C676.90301@domain.hid>
	<48A2BFD1.40400@domain.hid>
In-Reply-To: <48A2BFD1.40400@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_DG1pIbn4FehBUDV"
Message-Id: <200808162315.31868.paul_c@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] can: avoid naming conflict in 2.6.26
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>

--Boundary-00=_DG1pIbn4FehBUDV
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 13 August 2008, Jan Kiszka wrote:
> Wolfgang Grandegger wrote:
> > Hi Jan,
> >
> > Jan Kiszka wrote:
> >> Due to a global definition of 'clock' in latest 2.6.26, we now have a
> >> problem with two rtcan drivers. Below is a fix that breaks those
> >> drivers' user interface by rename the conflicting variable which
> >> unfortunately also renames the module parameter name.
> >>
> >> An alternative approach would be to add a kernel version dependent fix
> >> to the drivers. That would be required as compat_module_param_array
> >> cannot be extended to use a different parameter name than the related
> >> variable is called. Maybe someone sees a third, better solution, I do
> >> not.
> >
> > Nor do I. But I would prefer prefixing the module parameters with
> > "can_". Who knows what comes next.
>
> The issue is still open. Wolfgang, will you take care?
>
> Jan

Just bringing the issue back to the top (had to fix locally before compiling 
2.6.26.2).

 Attached, a patch in line with Wolfgang's recommendation - Also includes a 
trivial spelling correction.


Regards, Paul.


--Boundary-00=_DG1pIbn4FehBUDV
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="can_clock.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="can_clock.diff"

Index: scripts/xeno-test.in
===================================================================
--- scripts/xeno-test.in	(revision 4100)
+++ scripts/xeno-test.in	(working copy)
@@ -439,7 +439,7 @@ exit 0
 #will eventually finish, and should be restarted to keep the load up.
 #Figure out why killall didnt work properly.
 #
-#2. Much more testing.  Heres a weak start. You migth be better off
+#2. Much more testing.  Heres a weak start. You might be better off
 #using and improving test/test-xeno-test.rb.
 #
 ##!/bin/bash
Index: ksrc/drivers/can/sja1000/rtcan_isa.c
===================================================================
--- ksrc/drivers/can/sja1000/rtcan_isa.c	(revision 4100)
+++ ksrc/drivers/can/sja1000/rtcan_isa.c	(working copy)
@@ -47,19 +47,19 @@ MODULE_LICENSE("GPL");
 
 static u16 io[RTCAN_ISA_MAX_DEV];
 static int irq[RTCAN_ISA_MAX_DEV];
-static u32 clock[RTCAN_ISA_MAX_DEV];
+static u32 can_clock[RTCAN_ISA_MAX_DEV];
 static u8 ocr[RTCAN_ISA_MAX_DEV];
 static u8 cdr[RTCAN_ISA_MAX_DEV];
 
 compat_module_param_array(io, ushort, RTCAN_ISA_MAX_DEV, 0444);
 compat_module_param_array(irq, int, RTCAN_ISA_MAX_DEV, 0444);
-compat_module_param_array(clock, uint, RTCAN_ISA_MAX_DEV, 0444);
+compat_module_param_array(can_clock, uint, RTCAN_ISA_MAX_DEV, 0444);
 compat_module_param_array(ocr, byte, RTCAN_ISA_MAX_DEV, 0444);
 compat_module_param_array(cdr, byte, RTCAN_ISA_MAX_DEV, 0444);
 
 MODULE_PARM_DESC(io, "The io-port address");
 MODULE_PARM_DESC(irq, "The interrupt number");
-MODULE_PARM_DESC(clock, "External clock frequency (default 16 MHz)");
+MODULE_PARM_DESC(can_clock, "External clock frequency (default 16 MHz)");
 MODULE_PARM_DESC(ocr, "Value of output control register (default 0x1a)");
 MODULE_PARM_DESC(cdr, "Value of clock divider register (default 0xc8");
 
@@ -116,8 +116,8 @@ int __init rtcan_isa_init_one(int idx)
 	}
 
 	/* Clock frequency in Hz */
-	if (clock[idx])
-		dev->can_sys_clock = clock[idx] / 2;
+	if (can_clock[idx])
+		dev->can_sys_clock = can_clock[idx] / 2;
 	else
 		dev->can_sys_clock = 8000000; /* 16/2 MHz */
 
Index: ksrc/drivers/can/sja1000/rtcan_mem.c
===================================================================
--- ksrc/drivers/can/sja1000/rtcan_mem.c	(revision 4100)
+++ ksrc/drivers/can/sja1000/rtcan_mem.c	(working copy)
@@ -55,19 +55,19 @@ MODULE_LICENSE("GPL");
 
 static u32 mem[RTCAN_MEM_MAX_DEV];
 static int irq[RTCAN_MEM_MAX_DEV];
-static u32 clock[RTCAN_MEM_MAX_DEV];
+static u32 can_clock[RTCAN_MEM_MAX_DEV];
 static u8 ocr[RTCAN_MEM_MAX_DEV];
 static u8 cdr[RTCAN_MEM_MAX_DEV];
 
 compat_module_param_array(mem, uint, RTCAN_MEM_MAX_DEV, 0444);
 compat_module_param_array(irq, int, RTCAN_MEM_MAX_DEV, 0444);
-compat_module_param_array(clock, uint, RTCAN_MEM_MAX_DEV, 0444);
+compat_module_param_array(can_clock, uint, RTCAN_MEM_MAX_DEV, 0444);
 compat_module_param_array(ocr, byte, RTCAN_MEM_MAX_DEV, 0444);
 compat_module_param_array(cdr, byte, RTCAN_MEM_MAX_DEV, 0444);
 
 MODULE_PARM_DESC(mem, "The io-memory address");
 MODULE_PARM_DESC(irq, "The interrupt number");
-MODULE_PARM_DESC(clock, "External clock frequency (default 16 MHz)");
+MODULE_PARM_DESC(can_clock, "External clock frequency (default 16 MHz)");
 MODULE_PARM_DESC(ocr, "Value of output control register (default 0x1a)");
 MODULE_PARM_DESC(cdr, "Value of clock divider register (default 0xc8");
 
@@ -125,8 +125,8 @@ int __init rtcan_mem_init_one(int idx)
 	}
 
 	/* Clock frequency in Hz */
-	if (clock[idx])
-		dev->can_sys_clock = clock[idx] / 2;
+	if (can_clock[idx])
+		dev->can_sys_clock = can_clock[idx] / 2;
 	else
 		dev->can_sys_clock = 8000000; /* 16/2 MHz */
 

--Boundary-00=_DG1pIbn4FehBUDV--

