MIME-Version: 1.0
Date: Fri, 28 Feb 2014 15:12:00 +0100
Message-ID: <CACKc53LDHUFyLAy5-=wW7Zy+rmB1gthujCORsY1w4zyzip1bmQ@mail.gmail.com>
From: Wojciech Domski <wojciech.domski@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Sensoray 626 analogy driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I have prepared Analogy driver for Sensoray 626. I kindly ask you for
review.

You can find patch in the attachment and below.

Best regards,
Wojciech Domski

>From 3c8991a6686486edaa5faf1dd8cf972e40a6499d Mon Sep 17 00:00:00 2001
From: Wojciech Domski <wojciech.domski@gmail.com>
Date: Fri, 28 Feb 2014 14:58:38 +0100
Subject: [PATCH] Added new Sensoray driver for model 626

---
 ksrc/drivers/analogy/sensoray/Config.in |    1 +
 ksrc/drivers/analogy/sensoray/Kconfig   |    5 +
 ksrc/drivers/analogy/sensoray/Makefile  |   14 +-
 ksrc/drivers/analogy/sensoray/s626.c    | 2843
+++++++++++++++++++++++++++++++
 ksrc/drivers/analogy/sensoray/s626.h    | 1136 ++++++++++++
 5 files changed, 3998 insertions(+), 1 deletion(-)
 create mode 100755 ksrc/drivers/analogy/sensoray/s626.c
 create mode 100755 ksrc/drivers/analogy/sensoray/s626.h

diff --git a/ksrc/drivers/analogy/sensoray/Config.in
b/ksrc/drivers/analogy/sensoray/Config.in
index 00e956c..03e3eda 100644
--- a/ksrc/drivers/analogy/sensoray/Config.in
+++ b/ksrc/drivers/analogy/sensoray/Config.in
@@ -1,2 +1,3 @@

 dep_tristate 'Sensoray Model 526 driver' CONFIG_XENO_DRIVERS_ANALOGY_S526
$CONFIG_XENO_DRIVERS_ANALOGY
+dep_tristate 'Sensoray Model 626 driver' CONFIG_XENO_DRIVERS_ANALOGY_S626
$CONFIG_XENO_DRIVERS_ANALOGY
diff --git a/ksrc/drivers/analogy/sensoray/Kconfig
b/ksrc/drivers/analogy/sensoray/Kconfig
index ce5aa51..ae626f4 100644
--- a/ksrc/drivers/analogy/sensoray/Kconfig
+++ b/ksrc/drivers/analogy/sensoray/Kconfig
@@ -3,3 +3,8 @@ config XENO_DRIVERS_ANALOGY_S526
     depends on XENO_DRIVERS_ANALOGY
     tristate "Sensoray Model 526 driver"
     default n
+
+config XENO_DRIVERS_ANALOGY_S626
+    depends on XENO_DRIVERS_ANALOGY
+    tristate "Sensoray Model 626 driver"
+    default n
diff --git a/ksrc/drivers/analogy/sensoray/Makefile
b/ksrc/drivers/analogy/sensoray/Makefile
index e5e97c9..c90001a 100644
--- a/ksrc/drivers/analogy/sensoray/Makefile
+++ b/ksrc/drivers/analogy/sensoray/Makefile
@@ -6,8 +6,12 @@ EXTRA_CFLAGS +=3D -D__IN_XENOMAI__ -Iinclude/xenomai

 obj-$(CONFIG_XENO_DRIVERS_ANALOGY_S526) +=3D analogy_s526.o

+obj-$(CONFIG_XENO_DRIVERS_ANALOGY_S626) +=3D analogy_s626.o
+
 analogy_s526-y :=3D s526.o

+analogy_s626-y :=3D s626.o
+
 else

 # Makefile flag for Linux v2.4
@@ -16,9 +20,13 @@ O_TARGET :=3D built-in.o

 obj-$(CONFIG_XENO_DRIVERS_ANALOGY_S526) +=3D analogy_s526.o

+obj-$(CONFIG_XENO_DRIVERS_ANALOGY_S626) +=3D analogy_s626.o
+
 analogy_s526-objs :=3D s526.o

-export-objs :=3D $(analogy_s526-objs)
+analogy_s626-objs :=3D s626.o
+
+export-objs :=3D $(analogy_s526-objs) $(analogy_s626-objs)

 EXTRA_CFLAGS +=3D -D__IN_XENOMAI__ -I$(TOPDIR)/include/xenomai
-I$(TOPDIR)/include/xenomai/compat

@@ -27,4 +35,8 @@ include $(TOPDIR)/Rules.make
 analogy_s526.o: $(analogy_s526-objs)
     $(LD) -r -o $@ $(analogy_s526-objs)

+analogy_s626.o: $(analogy_s626-objs)
+    $(LD) -r -o $@ $(analogy_s626-objs)
+
+
 endif
diff --git a/ksrc/drivers/analogy/sensoray/s626.c
b/ksrc/drivers/analogy/sensoray/s626.c
new file mode 100755
index 0000000..6b9011a
--- /dev/null
+++ b/ksrc/drivers/analogy/sensoray/s626.c
@@ -0,0 +1,2843 @@
+/**
+ * @file
+ * Analogy driver for Sensoray Model 626 board
+ *
+ * Copyright (C) 2014 Wojciech Domski <wojciech.domski@gmail.com>
+ * Copyright (C) 2014 Mariusz Janiak  <mariusz.janiak@pwr.wroc.pl>
+ *
+ * Derived from comedi:
+ * Copyright (C) 2000 David A. Schleef <ds@schleef.org>
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; either version 2 of the License,
+ * or (at your option) any later version.
+ *
+ * This code is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with Xenomai; if not, write to the Free Software Foundation,
+ * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+/*
+ * Original code comes from comedi linux-next staging driver
+ * Board documentation: http://www.sensoray.com/products/626.htm
+ * Everything should work as in comedi.
+ */
+
+#include <linux/module.h>
+#include <linux/ioport.h>
+#include <asm/byteorder.h>
+#include <analogy/analogy_driver.h>
+#include <linux/pci.h>
+
+#include <analogy/driver.h>
+#include <analogy/device.h>
+
+#include "s626.h"
+
+static LIST_HEAD(s626_list);
+
+/*  TrimDac LogicalChan-to-PhysicalChan mapping table. */
+static uint8_t trimchan[] =3D { 10, 9, 8, 3, 2, 7, 6, 1, 0, 5, 4 };
+
+/*  TrimDac LogicalChan-to-EepromAdrs mapping table. */
+static uint8_t trimadrs[] =3D { 0x40, 0x41, 0x42, 0x50, 0x51, 0x52, 0x53,
0x60,
+    0x61, 0x62, 0x63 };
+
+/*
+ * For devices with vendor:device id =3D=3D 0x1131:0x7146 you must specify
+ * also subvendor:subdevice ids, because otherwise it will conflict with
+ * Philips SAA7146 media/dvb based cards.
+ */
+static struct pci_device_id s626_pci_table[] =3D { { 0x1131, 0x7146, 0x600=
0,
+    0x0626, 0, 0, 0 }, { 0x1131, 0x7146, 0x6000, 626, 0, 0, 0 }, { 0, } };
+
+MODULE_DEVICE_TABLE(pci, s626_pci_table);
+
+static struct pci_driver drv_pci_s626 =3D { .name =3D "S626", .id_table =
=3D
+    s626_pci_table, .probe =3D s626_pci_probe, .remove =3D s626_pci_remove=
, };
+
+static struct s626_subd_dio_private s626_subd_dio_private_A =3D { .RDDIn =
=3D
+    LP_RDDINA, .WRDOut =3D LP_WRDOUTA, .RDEdgSel =3D LP_RDEDGSELA, .WREdgS=
el =3D
+    LP_WREDGSELA, .RDCapSel =3D LP_RDCAPSELA, .WRCapSel =3D LP_WRCAPSELA,
+    .RDCapFlg =3D LP_RDCAPFLGA, .RDIntSel =3D LP_RDINTSELA,
+    .WRIntSel =3D LP_WRINTSELA, .io_bits =3D 0, .state =3D 0, };
+
+static struct s626_subd_dio_private s626_subd_dio_private_B =3D { .RDDIn =
=3D
+    LP_RDDINB, .WRDOut =3D LP_WRDOUTB, .RDEdgSel =3D LP_RDEDGSELB, .WREdgS=
el =3D
+    LP_WREDGSELB, .RDCapSel =3D LP_RDCAPSELB, .WRCapSel =3D LP_WRCAPSELB,
+    .RDCapFlg =3D LP_RDCAPFLGB, .RDIntSel =3D LP_RDINTSELB,
+    .WRIntSel =3D LP_WRINTSELB, .io_bits =3D 0, .state =3D 0, };
+
+static struct s626_subd_dio_private s626_subd_dio_private_C =3D { .RDDIn =
=3D
+    LP_RDDINC, .WRDOut =3D LP_WRDOUTC, .RDEdgSel =3D LP_RDEDGSELC, .WREdgS=
el =3D
+    LP_WREDGSELC, .RDCapSel =3D LP_RDCAPSELC, .WRCapSel =3D LP_WRCAPSELC,
+    .RDCapFlg =3D LP_RDCAPFLGC, .RDIntSel =3D LP_RDINTSELC,
+    .WRIntSel =3D LP_WRINTSELC, .io_bits =3D 0, .state =3D 0, };
+
+/* ******  PRIVATE COUNTER FUNCTIONS ****** */
+
+/*  Reset a counter's index and overflow event capture flags. */
+
+static void ResetCapFlags_A(struct s626_struct * s626ptr, struct
enc_private *k) {
+  DEBIreplace(s626ptr, k->MyCRB, (uint16_t) (~CRBMSK_INTCTRL),
+      CRBMSK_INTRESETCMD | CRBMSK_INTRESET_A);
+}
+
+static void ResetCapFlags_B(struct s626_struct * s626ptr, struct
enc_private *k) {
+  DEBIreplace(s626ptr, k->MyCRB, (uint16_t) (~CRBMSK_INTCTRL),
+      CRBMSK_INTRESETCMD | CRBMSK_INTRESET_B);
+}
+
+/*  Return counter setup in a format (COUNTER_SETUP) that is consistent */
+/*  for both A and B counters. */
+
+static uint16_t GetMode_A(struct s626_struct * s626ptr, struct enc_private
*k) {
+  register uint16_t cra;
+  register uint16_t crb;
+  register uint16_t setup;
+
+  /*  Fetch CRA and CRB register images. */
+  cra =3D DEBIread(s626ptr, k->MyCRA);
+  crb =3D DEBIread(s626ptr, k->MyCRB);
+
+  /*  Populate the standardized counter setup bit fields.  Note: */
+  /*  IndexSrc is restricted to ENC_X or IndxPol. */
+  setup =3D ((cra & STDMSK_LOADSRC) /*  LoadSrc  =3D LoadSrcA. */
+  | ((crb << (STDBIT_LATCHSRC - CRBBIT_LATCHSRC)) & STDMSK_LATCHSRC) /*
LatchSrc =3D LatchSrcA. */
+  | ((cra << (STDBIT_INTSRC - CRABIT_INTSRC_A)) & STDMSK_INTSRC) /*
IntSrc   =3D IntSrcA. */
+  | ((cra << (STDBIT_INDXSRC - (CRABIT_INDXSRC_A + 1))) & STDMSK_INDXSRC)
/*  IndxSrc  =3D IndxSrcA<1>. */
+  | ((cra >> (CRABIT_INDXPOL_A - STDBIT_INDXPOL)) & STDMSK_INDXPOL) /*
IndxPol  =3D IndxPolA. */
+  | ((crb >> (CRBBIT_CLKENAB_A - STDBIT_CLKENAB)) & STDMSK_CLKENAB)); /*
ClkEnab  =3D ClkEnabA. */
+
+  /*  Adjust mode-dependent parameters. */
+  if (cra & (2 << CRABIT_CLKSRC_A)) /*  If Timer mode (ClkSrcA<1> =3D=3D 1=
): */
+    setup |=3D ((CLKSRC_TIMER << STDBIT_CLKSRC) /*    Indicate Timer mode.=
 */
+    | ((cra << (STDBIT_CLKPOL - CRABIT_CLKSRC_A)) & STDMSK_CLKPOL) /*
Set ClkPol to indicate count direction (ClkSrcA<0>). */
+    | (MULT_X1 << STDBIT_CLKMULT)); /*    ClkMult must be 1x in Timer
mode. */
+
+  else
+    /*  If Counter mode (ClkSrcA<1> =3D=3D 0): */
+    setup |=3D ((CLKSRC_COUNTER << STDBIT_CLKSRC) /*    Indicate Counter
mode. */
+    | ((cra >> (CRABIT_CLKPOL_A - STDBIT_CLKPOL)) & STDMSK_CLKPOL) /*
Pass through ClkPol. */
+        | (((cra & CRAMSK_CLKMULT_A) =3D=3D (MULT_X0 << CRABIT_CLKMULT_A))=
 ?
/*    Force ClkMult to 1x if not legal, else pass through. */
+        (MULT_X1 << STDBIT_CLKMULT) : ((cra
+            >> (CRABIT_CLKMULT_A - STDBIT_CLKMULT)) & STDMSK_CLKMULT)));
+
+  /*  Return adjusted counter setup. */
+  return setup;
+}
+
+static uint16_t GetMode_B(struct s626_struct * s626ptr, struct enc_private
*k) {
+  register uint16_t cra;
+  register uint16_t crb;
+  register uint16_t setup;
+
+  /*  Fetch CRA and CRB register images. */
+  cra =3D DEBIread(s626ptr, k->MyCRA);
+  crb =3D DEBIread(s626ptr, k->MyCRB);
+
+  /*  Populate the standardized counter setup bit fields.  Note: */
+  /*  IndexSrc is restricted to ENC_X or IndxPol. */
+  setup =3D (((crb << (STDBIT_INTSRC - CRBBIT_INTSRC_B)) & STDMSK_INTSRC)
/*  IntSrc   =3D IntSrcB. */
+  | ((crb << (STDBIT_LATCHSRC - CRBBIT_LATCHSRC)) & STDMSK_LATCHSRC) /*
LatchSrc =3D LatchSrcB. */
+  | ((crb << (STDBIT_LOADSRC - CRBBIT_LOADSRC_B)) & STDMSK_LOADSRC) /*
LoadSrc  =3D LoadSrcB. */
+  | ((crb << (STDBIT_INDXPOL - CRBBIT_INDXPOL_B)) & STDMSK_INDXPOL) /*
IndxPol  =3D IndxPolB. */
+  | ((crb >> (CRBBIT_CLKENAB_B - STDBIT_CLKENAB)) & STDMSK_CLKENAB) /*
ClkEnab  =3D ClkEnabB. */
+  | ((cra >> ((CRABIT_INDXSRC_B + 1) - STDBIT_INDXSRC)) &
STDMSK_INDXSRC)); /*  IndxSrc  =3D IndxSrcB<1>. */
+
+  /*  Adjust mode-dependent parameters. */
+  if ((crb & CRBMSK_CLKMULT_B) =3D=3D (MULT_X0 << CRBBIT_CLKMULT_B)) /*  If
Extender mode (ClkMultB =3D=3D MULT_X0): */
+    setup |=3D ((CLKSRC_EXTENDER << STDBIT_CLKSRC) /*    Indicate Extender
mode. */
+    | (MULT_X1 << STDBIT_CLKMULT) /*    Indicate multiplier is 1x. */
+    | ((cra >> (CRABIT_CLKSRC_B - STDBIT_CLKPOL)) & STDMSK_CLKPOL)); /*
Set ClkPol equal to Timer count direction (ClkSrcB<0>). */
+
+  else if (cra & (2 << CRABIT_CLKSRC_B)) /*  If Timer mode (ClkSrcB<1> =3D=
=3D
1): */
+    setup |=3D ((CLKSRC_TIMER << STDBIT_CLKSRC) /*    Indicate Timer mode.=
 */
+    | (MULT_X1 << STDBIT_CLKMULT) /*    Indicate multiplier is 1x. */
+    | ((cra >> (CRABIT_CLKSRC_B - STDBIT_CLKPOL)) & STDMSK_CLKPOL)); /*
Set ClkPol equal to Timer count direction (ClkSrcB<0>). */
+
+  else
+    /*  If Counter mode (ClkSrcB<1> =3D=3D 0): */
+    setup |=3D ((CLKSRC_COUNTER << STDBIT_CLKSRC) /*    Indicate Timer mod=
e.
*/
+    | ((crb >> (CRBBIT_CLKMULT_B - STDBIT_CLKMULT)) & STDMSK_CLKMULT)
/*    Clock multiplier is passed through. */
+    | ((crb << (STDBIT_CLKPOL - CRBBIT_CLKPOL_B)) & STDMSK_CLKPOL)); /*
Clock polarity is passed through. */
+
+  /*  Return adjusted counter setup. */
+  return setup;
+}
+
+/*
+ * Set the operating mode for the specified counter.  The setup
+ * parameter is treated as a COUNTER_SETUP data type.  The following
+ * parameters are programmable (all other parms are ignored): ClkMult,
+ * ClkPol, ClkEnab, IndexSrc, IndexPol, LoadSrc.
+ */
+
+static void SetMode_A(struct s626_struct * s626ptr, struct enc_private *k,
+    uint16_t Setup, uint16_t DisableIntSrc) {
+  struct s626_priv *devpriv =3D s626ptr->private;
+  register uint16_t cra;
+  register uint16_t crb;
+  register uint16_t setup =3D Setup; /*  Cache the Standard Setup. */
+
+  /*  Initialize CRA and CRB images. */
+  cra =3D ((setup & CRAMSK_LOADSRC_A) /*  Preload trigger is passed throug=
h.
*/
+  | ((setup & STDMSK_INDXSRC) >> (STDBIT_INDXSRC - (CRABIT_INDXSRC_A +
1)))); /*  IndexSrc is restricted to ENC_X or IndxPol. */
+
+  crb =3D (CRBMSK_INTRESETCMD | CRBMSK_INTRESET_A /*  Reset any pending
CounterA event captures. */
+  | ((setup & STDMSK_CLKENAB) << (CRBBIT_CLKENAB_A - STDBIT_CLKENAB)));
/*  Clock enable is passed through. */
+
+  /*  Force IntSrc to Disabled if DisableIntSrc is asserted. */
+  if (!DisableIntSrc)
+    cra |=3D ((setup & STDMSK_INTSRC) >> (STDBIT_INTSRC - CRABIT_INTSRC_A)=
);
+
+  /*  Populate all mode-dependent attributes of CRA & CRB images. */
+  switch ((setup & STDMSK_CLKSRC) >> STDBIT_CLKSRC) {
+  case CLKSRC_EXTENDER: /*  Extender Mode: Force to Timer mode */
+    /*  (Extender valid only for B counters). */
+
+  case CLKSRC_TIMER: /*  Timer Mode: */
+    cra |=3D ((2 << CRABIT_CLKSRC_A) /*    ClkSrcA<1> selects system clock=
 */
+    | ((setup & STDMSK_CLKPOL) >> (STDBIT_CLKPOL - CRABIT_CLKSRC_A))
/*      with count direction (ClkSrcA<0>) obtained from ClkPol. */
+    | (1 << CRABIT_CLKPOL_A) /*    ClkPolA behaves as always-on clock
enable. */
+    | (MULT_X1 << CRABIT_CLKMULT_A)); /*    ClkMult must be 1x. */
+    break;
+
+  default: /*  Counter Mode: */
+    cra |=3D (CLKSRC_COUNTER /*    Select ENC_C and ENC_D as clock/directi=
on
inputs. */
+    | ((setup & STDMSK_CLKPOL) << (CRABIT_CLKPOL_A - STDBIT_CLKPOL)) /*
Clock polarity is passed through. */
+        | (((setup & STDMSK_CLKMULT) =3D=3D (MULT_X0 << STDBIT_CLKMULT)) ?
/*    Force multiplier to x1 if not legal, otherwise pass through. */
+        (MULT_X1 << CRABIT_CLKMULT_A) : ((setup & STDMSK_CLKMULT)
+            << (CRABIT_CLKMULT_A - STDBIT_CLKMULT))));
+    break;
+  }
+
+  /*  Force positive index polarity if IndxSrc is software-driven only, */
+  /*  otherwise pass it through. */
+  if (~setup & STDMSK_INDXSRC)
+    cra |=3D ((setup & STDMSK_INDXPOL) << (CRABIT_INDXPOL_A -
STDBIT_INDXPOL));
+
+  /*  If IntSrc has been forced to Disabled, update the MISC2 interrupt */
+  /*  enable mask to indicate the counter interrupt is disabled. */
+  if (DisableIntSrc)
+    devpriv->CounterIntEnabs &=3D ~k->MyEventBits[3];
+
+  /*  While retaining CounterB and LatchSrc configurations, program the */
+  /*  new counter operating mode. */
+  DEBIreplace(s626ptr, k->MyCRA, CRAMSK_INDXSRC_B | CRAMSK_CLKSRC_B, cra);
+  DEBIreplace(s626ptr, k->MyCRB,
+      (uint16_t) (~(CRBMSK_INTCTRL | CRBMSK_CLKENAB_A)), crb);
+}
+
+static void SetMode_B(struct s626_struct * s626ptr, struct enc_private *k,
+    uint16_t Setup, uint16_t DisableIntSrc) {
+  struct s626_priv *devpriv =3D s626ptr->private;
+  register uint16_t cra;
+  register uint16_t crb;
+  register uint16_t setup =3D Setup; /*  Cache the Standard Setup. */
+
+  /*  Initialize CRA and CRB images. */
+  cra =3D ((setup & STDMSK_INDXSRC) << ((CRABIT_INDXSRC_B + 1) -
STDBIT_INDXSRC)); /*  IndexSrc field is restricted to ENC_X or IndxPol. */
+
+  crb =3D (CRBMSK_INTRESETCMD | CRBMSK_INTRESET_B /*  Reset event captures
and disable interrupts. */
+  | ((setup & STDMSK_CLKENAB) << (CRBBIT_CLKENAB_B - STDBIT_CLKENAB)) /*
Clock enable is passed through. */
+  | ((setup & STDMSK_LOADSRC) >> (STDBIT_LOADSRC - CRBBIT_LOADSRC_B)));
/*  Preload trigger source is passed through. */
+
+  /*  Force IntSrc to Disabled if DisableIntSrc is asserted. */
+  if (!DisableIntSrc)
+    crb |=3D ((setup & STDMSK_INTSRC) >> (STDBIT_INTSRC - CRBBIT_INTSRC_B)=
);
+
+  /*  Populate all mode-dependent attributes of CRA & CRB images. */
+  switch ((setup & STDMSK_CLKSRC) >> STDBIT_CLKSRC) {
+  case CLKSRC_TIMER: /*  Timer Mode: */
+    cra |=3D ((2 << CRABIT_CLKSRC_B) /*    ClkSrcB<1> selects system clock=
 */
+    | ((setup & STDMSK_CLKPOL) << (CRABIT_CLKSRC_B - STDBIT_CLKPOL)));
/*      with direction (ClkSrcB<0>) obtained from ClkPol. */
+    crb |=3D ((1 << CRBBIT_CLKPOL_B) /*    ClkPolB behaves as always-on
clock enable. */
+    | (MULT_X1 << CRBBIT_CLKMULT_B)); /*    ClkMultB must be 1x. */
+    break;
+
+  case CLKSRC_EXTENDER: /*  Extender Mode: */
+    cra |=3D ((2 << CRABIT_CLKSRC_B) /*    ClkSrcB source is OverflowA (sa=
me
as "timer") */
+    | ((setup & STDMSK_CLKPOL) << (CRABIT_CLKSRC_B - STDBIT_CLKPOL)));
/*      with direction obtained from ClkPol. */
+    crb |=3D ((1 << CRBBIT_CLKPOL_B) /*    ClkPolB controls IndexB -- alwa=
ys
set to active. */
+    | (MULT_X0 << CRBBIT_CLKMULT_B)); /*    ClkMultB selects OverflowA as
the clock source. */
+    break;
+
+  default: /*  Counter Mode: */
+    cra |=3D (CLKSRC_COUNTER << CRABIT_CLKSRC_B); /*    Select ENC_C and
ENC_D as clock/direction inputs. */
+    crb |=3D (((setup & STDMSK_CLKPOL) >> (STDBIT_CLKPOL - CRBBIT_CLKPOL_B=
))
/*    ClkPol is passed through. */
+        | (((setup & STDMSK_CLKMULT) =3D=3D (MULT_X0 << STDBIT_CLKMULT)) ?
/*    Force ClkMult to x1 if not legal, otherwise pass through. */
+        (MULT_X1 << CRBBIT_CLKMULT_B) : ((setup & STDMSK_CLKMULT)
+            << (CRBBIT_CLKMULT_B - STDBIT_CLKMULT))));
+    break;
+  }
+
+  /*  Force positive index polarity if IndxSrc is software-driven only, */
+  /*  otherwise pass it through. */
+  if (~setup & STDMSK_INDXSRC)
+    crb |=3D ((setup & STDMSK_INDXPOL) >> (STDBIT_INDXPOL -
CRBBIT_INDXPOL_B));
+
+  /*  If IntSrc has been forced to Disabled, update the MISC2 interrupt */
+  /*  enable mask to indicate the counter interrupt is disabled. */
+  if (DisableIntSrc)
+    devpriv->CounterIntEnabs &=3D ~k->MyEventBits[3];
+
+  /*  While retaining CounterA and LatchSrc configurations, program the */
+  /*  new counter operating mode. */
+  DEBIreplace(s626ptr, k->MyCRA,
+      (uint16_t) (~(CRAMSK_INDXSRC_B | CRAMSK_CLKSRC_B)), cra);
+  DEBIreplace(s626ptr, k->MyCRB, CRBMSK_CLKENAB_A | CRBMSK_LATCHSRC, crb);
+}
+
+/*  Return/set a counter's enable.  enab: 0=3Dalways enabled, 1=3Denabled =
by
index. */
+
+static void SetEnable_A(struct s626_struct * s626ptr, struct enc_private
*k,
+    uint16_t enab) {
+  DEBIreplace(s626ptr, k->MyCRB,
+      (uint16_t) (~(CRBMSK_INTCTRL | CRBMSK_CLKENAB_A)),
+      (uint16_t) (enab << CRBBIT_CLKENAB_A));
+}
+
+static void SetEnable_B(struct s626_struct * s626ptr, struct enc_private
*k,
+    uint16_t enab) {
+  DEBIreplace(s626ptr, k->MyCRB,
+      (uint16_t) (~(CRBMSK_INTCTRL | CRBMSK_CLKENAB_B)),
+      (uint16_t) (enab << CRBBIT_CLKENAB_B));
+}
+
+static uint16_t GetEnable_A(struct s626_struct * s626ptr, struct
enc_private *k) {
+  return (DEBIread(s626ptr, k->MyCRB) >> CRBBIT_CLKENAB_A) & 1;
+}
+
+static uint16_t GetEnable_B(struct s626_struct * s626ptr, struct
enc_private *k) {
+  return (DEBIread(s626ptr, k->MyCRB) >> CRBBIT_CLKENAB_B) & 1;
+}
+
+/*
+ * static uint16_t GetLatchSource(struct comedi_device *dev, struct
enc_private *k )
+ * {
+ *  return ( DEBIread(s626ptr, dev, k->MyCRB) >> CRBBIT_LATCHSRC ) & 3;
+ * }
+ */
+
+/*
+ * Return/set the event that will trigger transfer of the preload
+ * register into the counter.  0=3DThisCntr_Index, 1=3DThisCntr_Overflow,
+ * 2=3DOverflowA (B counters only), 3=3Ddisabled.
+ */
+
+static void SetLoadTrig_A(struct s626_struct * s626ptr, struct enc_private
*k,
+    uint16_t Trig) {
+  DEBIreplace(s626ptr, k->MyCRA, (uint16_t) (~CRAMSK_LOADSRC_A),
+      (uint16_t) (Trig << CRABIT_LOADSRC_A));
+}
+
+static void SetLoadTrig_B(struct s626_struct * s626ptr, struct enc_private
*k,
+    uint16_t Trig) {
+  DEBIreplace(s626ptr, k->MyCRB,
+      (uint16_t) (~(CRBMSK_LOADSRC_B | CRBMSK_INTCTRL)),
+      (uint16_t) (Trig << CRBBIT_LOADSRC_B));
+}
+
+static uint16_t GetLoadTrig_A(struct s626_struct * s626ptr,
+    struct enc_private *k) {
+  return (DEBIread(s626ptr, k->MyCRA) >> CRABIT_LOADSRC_A) & 3;
+}
+
+static uint16_t GetLoadTrig_B(struct s626_struct * s626ptr,
+    struct enc_private *k) {
+  return (DEBIread(s626ptr, k->MyCRB) >> CRBBIT_LOADSRC_B) & 3;
+}
+
+/* Return/set counter interrupt source and clear any captured
+ * index/overflow events.  IntSource: 0=3DDisabled, 1=3DOverflowOnly,
+ * 2=3DIndexOnly, 3=3DIndexAndOverflow.
+ */
+
+static void SetIntSrc_A(struct s626_struct * s626ptr, struct enc_private
*k,
+    uint16_t IntSource) {
+  struct s626_priv *devpriv =3D s626ptr->private;
+
+  /*  Reset any pending counter overflow or index captures. */
+  DEBIreplace(s626ptr, k->MyCRB, (uint16_t) (~CRBMSK_INTCTRL),
+      CRBMSK_INTRESETCMD | CRBMSK_INTRESET_A);
+
+  /*  Program counter interrupt source. */
+  DEBIreplace(s626ptr, k->MyCRA, ~CRAMSK_INTSRC_A,
+      (uint16_t) (IntSource << CRABIT_INTSRC_A));
+
+  /*  Update MISC2 interrupt enable mask. */
+  devpriv->CounterIntEnabs =3D (devpriv->CounterIntEnabs &
~k->MyEventBits[3])
+      | k->MyEventBits[IntSource];
+}
+
+static void SetIntSrc_B(struct s626_struct * s626ptr, struct enc_private
*k,
+    uint16_t IntSource) {
+  struct s626_priv *devpriv =3D s626ptr->private;
+  uint16_t crb;
+
+  /*  Cache writeable CRB register image. */
+  crb =3D DEBIread(s626ptr, k->MyCRB) & ~CRBMSK_INTCTRL;
+
+  /*  Reset any pending counter overflow or index captures. */
+  DEBIwrite(s626ptr, k->MyCRB,
+      (uint16_t) (crb | CRBMSK_INTRESETCMD | CRBMSK_INTRESET_B));
+
+  /*  Program counter interrupt source. */
+  DEBIwrite(s626ptr, k->MyCRB,
+      (uint16_t) ((crb & ~CRBMSK_INTSRC_B) | (IntSource <<
CRBBIT_INTSRC_B)));
+
+  /*  Update MISC2 interrupt enable mask. */
+  devpriv->CounterIntEnabs =3D (devpriv->CounterIntEnabs &
~k->MyEventBits[3])
+      | k->MyEventBits[IntSource];
+}
+
+static uint16_t GetIntSrc_A(struct s626_struct * s626ptr, struct
enc_private *k) {
+  return (DEBIread(s626ptr, k->MyCRA) >> CRABIT_INTSRC_A) & 3;
+}
+
+static uint16_t GetIntSrc_B(struct s626_struct * s626ptr, struct
enc_private *k) {
+  return (DEBIread(s626ptr, k->MyCRB) >> CRBBIT_INTSRC_B) & 3;
+}
+
+/*  Generate an index pulse. */
+
+static void PulseIndex_A(struct s626_struct * s626ptr, struct enc_private
*k) {
+  register uint16_t cra;
+
+  cra =3D DEBIread(s626ptr, k->MyCRA); /*  Pulse index. */
+  DEBIwrite(s626ptr, k->MyCRA, (uint16_t) (cra ^ CRAMSK_INDXPOL_A));
+  DEBIwrite(s626ptr, k->MyCRA, cra);
+}
+
+static void PulseIndex_B(struct s626_struct * s626ptr, struct enc_private
*k) {
+  register uint16_t crb;
+
+  crb =3D DEBIread(s626ptr, k->MyCRB) & ~CRBMSK_INTCTRL; /*  Pulse index. =
*/
+  DEBIwrite(s626ptr, k->MyCRB, (uint16_t) (crb ^ CRBMSK_INDXPOL_B));
+  DEBIwrite(s626ptr, k->MyCRB, crb);
+}
+
+static struct enc_private enc_private_data_init[] =3D { {
+    .GetEnable =3D GetEnable_A, .GetIntSrc =3D GetIntSrc_A, .GetLoadTrig =
=3D
+        GetLoadTrig_A, .GetMode =3D GetMode_A, .PulseIndex =3D PulseIndex_=
A,
+    .SetEnable =3D SetEnable_A, .SetIntSrc =3D SetIntSrc_A, .SetLoadTrig =
=3D
+        SetLoadTrig_A, .SetMode =3D SetMode_A, .ResetCapFlags =3D
ResetCapFlags_A,
+    .MyCRA =3D LP_CR0A, .MyCRB =3D LP_CR0B, .MyLatchLsw =3D LP_CNTR0ALSW,
+    .MyEventBits =3D EVBITS(0), }, { .GetEnable =3D GetEnable_A, .GetIntSr=
c =3D
+    GetIntSrc_A, .GetLoadTrig =3D GetLoadTrig_A, .GetMode =3D GetMode_A,
+    .PulseIndex =3D PulseIndex_A, .SetEnable =3D SetEnable_A, .SetIntSrc =
=3D
+        SetIntSrc_A, .SetLoadTrig =3D SetLoadTrig_A, .SetMode =3D SetMode_=
A,
+    .ResetCapFlags =3D ResetCapFlags_A, .MyCRA =3D LP_CR1A, .MyCRB =3D LP_=
CR1B,
+    .MyLatchLsw =3D LP_CNTR1ALSW, .MyEventBits =3D EVBITS(1), }, { .GetEna=
ble =3D
+    GetEnable_A, .GetIntSrc =3D GetIntSrc_A, .GetLoadTrig =3D GetLoadTrig_=
A,
+    .GetMode =3D GetMode_A, .PulseIndex =3D PulseIndex_A, .SetEnable =3D
SetEnable_A,
+    .SetIntSrc =3D SetIntSrc_A, .SetLoadTrig =3D SetLoadTrig_A,
+    .SetMode =3D SetMode_A, .ResetCapFlags =3D ResetCapFlags_A, .MyCRA =3D
LP_CR2A,
+    .MyCRB =3D LP_CR2B, .MyLatchLsw =3D LP_CNTR2ALSW, .MyEventBits =3D
EVBITS(2), }, {
+    .GetEnable =3D GetEnable_B, .GetIntSrc =3D GetIntSrc_B, .GetLoadTrig =
=3D
+        GetLoadTrig_B, .GetMode =3D GetMode_B, .PulseIndex =3D PulseIndex_=
B,
+    .SetEnable =3D SetEnable_B, .SetIntSrc =3D SetIntSrc_B, .SetLoadTrig =
=3D
+        SetLoadTrig_B, .SetMode =3D SetMode_B, .ResetCapFlags =3D
ResetCapFlags_B,
+    .MyCRA =3D LP_CR0A, .MyCRB =3D LP_CR0B, .MyLatchLsw =3D LP_CNTR0BLSW,
+    .MyEventBits =3D EVBITS(3), }, { .GetEnable =3D GetEnable_B, .GetIntSr=
c =3D
+    GetIntSrc_B, .GetLoadTrig =3D GetLoadTrig_B, .GetMode =3D GetMode_B,
+    .PulseIndex =3D PulseIndex_B, .SetEnable =3D SetEnable_B, .SetIntSrc =
=3D
+        SetIntSrc_B, .SetLoadTrig =3D SetLoadTrig_B, .SetMode =3D SetMode_=
B,
+    .ResetCapFlags =3D ResetCapFlags_B, .MyCRA =3D LP_CR1A, .MyCRB =3D LP_=
CR1B,
+    .MyLatchLsw =3D LP_CNTR1BLSW, .MyEventBits =3D EVBITS(4), }, { .GetEna=
ble =3D
+    GetEnable_B, .GetIntSrc =3D GetIntSrc_B, .GetLoadTrig =3D GetLoadTrig_=
B,
+    .GetMode =3D GetMode_B, .PulseIndex =3D PulseIndex_B, .SetEnable =3D
SetEnable_B,
+    .SetIntSrc =3D SetIntSrc_B, .SetLoadTrig =3D SetLoadTrig_B,
+    .SetMode =3D SetMode_B, .ResetCapFlags =3D ResetCapFlags_B, .MyCRA =3D
LP_CR2A,
+    .MyCRB =3D LP_CR2B, .MyLatchLsw =3D LP_CNTR2BLSW, .MyEventBits =3D
EVBITS(5), }, };
+
+static void CloseDMAB(struct s626_struct * s626ptr, struct bufferDMA *pdma,
+    size_t bsize) {
+  struct pci_dev *pcidev =3D s626ptr->pcidev;
+  void *vbptr;
+  dma_addr_t vpptr;
+
+  if (pdma =3D=3D NULL)
+    return;
+  /* find the matching allocation from the board struct */
+
+  vbptr =3D pdma->LogicalBase;
+  vpptr =3D pdma->PhysicalBase;
+  if (vbptr) {
+    pci_free_consistent(pcidev, bsize, vbptr, vpptr);
+    pdma->LogicalBase =3D NULL;
+    pdma->PhysicalBase =3D 0;
+  }
+}
+
+/*  Initialize the DEBI interface for all transfers. */
+
+static uint16_t DEBIread(struct s626_struct * s626ptr, uint16_t addr) {
+  struct s626_priv *devpriv =3D s626ptr->private;
+  uint16_t retval;
+
+  /*  Set up DEBI control register value in shadow RAM. */
+  WR7146(P_DEBICMD, DEBI_CMD_RDWORD | addr);
+
+  /*  Execute the DEBI transfer. */
+  DEBItransfer(s626ptr);
+
+  /*  Fetch target register value. */
+  retval =3D (uint16_t) RR7146(P_DEBIAD);
+
+  /*  Return register value. */
+  return retval;
+}
+
+/*  Write a value to a gate array register. */
+static void DEBIwrite(struct s626_struct * s626ptr, uint16_t addr,
+    uint16_t wdata) {
+  struct s626_priv *devpriv =3D s626ptr->private;
+
+  /*  Set up DEBI control register value in shadow RAM. */
+  WR7146(P_DEBICMD, DEBI_CMD_WRWORD | addr);
+  WR7146(P_DEBIAD, wdata);
+
+  /*  Execute the DEBI transfer. */
+  DEBItransfer(s626ptr);
+}
+
+/*  Execute a DEBI transfer.  This must be called from within a */
+/*  critical section. */
+static void DEBItransfer(struct s626_struct * s626ptr) {
+  struct s626_priv *devpriv =3D s626ptr->private;
+
+  /*  Initiate upload of shadow RAM to DEBI control register. */
+  MC_ENABLE(P_MC2, MC2_UPLD_DEBI);
+
+  /*  Wait for completion of upload from shadow RAM to DEBI control */
+  /*  register. */
+  while (!MC_TEST(P_MC2, MC2_UPLD_DEBI))
+    ;
+
+  /*  Wait until DEBI transfer is done. */
+  while (RR7146(P_PSR) & PSR_DEBI_S)
+    ;
+}
+
+static void DEBIreplace(struct s626_struct * s626ptr, uint16_t addr,
+    uint16_t mask, uint16_t wdata) {
+  struct s626_priv *devpriv =3D s626ptr->private;
+
+  /*  Copy target gate array register into P_DEBIAD register. */
+  WR7146(P_DEBICMD, DEBI_CMD_RDWORD | addr);
+  /* Set up DEBI control reg value in shadow RAM. */
+  DEBItransfer(s626ptr); /*  Execute the DEBI Read transfer. */
+
+  /*  Write back the modified image. */
+  WR7146(P_DEBICMD, DEBI_CMD_WRWORD | addr);
+  /* Set up DEBI control reg value in shadow  RAM. */
+
+  WR7146(P_DEBIAD, wdata | ((uint16_t) RR7146(P_DEBIAD) & mask));
+  /* Modify the register image. */
+  DEBItransfer(s626ptr); /*  Execute the DEBI Write transfer. */
+}
+
+/* **************  EEPROM ACCESS FUNCTIONS  ************** */
+
+static uint32_t I2Chandshake(struct s626_struct * s626ptr, uint32_t val) {
+  struct s626_priv *devpriv =3D s626ptr->private;
+
+  /*  Write I2C command to I2C Transfer Control shadow register. */
+  WR7146(P_I2CCTRL, val);
+
+  /*  Upload I2C shadow registers into working registers and wait for */
+  /*  upload confirmation. */
+
+  MC_ENABLE(P_MC2, MC2_UPLD_IIC);
+  while (!MC_TEST(P_MC2, MC2_UPLD_IIC))
+    ;
+
+  /*  Wait until I2C bus transfer is finished or an error occurs. */
+  while ((RR7146(P_I2CCTRL) & (I2C_BUSY | I2C_ERR)) =3D=3D I2C_BUSY)
+    ;
+
+  /*  Return non-zero if I2C error occurred. */
+  return RR7146(P_I2CCTRL) & I2C_ERR;
+
+}
+
+/*  Read uint8_t from EEPROM. */
+static uint8_t I2Cread(struct s626_struct * s626ptr, uint8_t addr) {
+  struct s626_priv *devpriv =3D s626ptr->private;
+  uint8_t rtnval;
+
+  /*  Send EEPROM target address. */
+  if (I2Chandshake(s626ptr, I2C_B2(I2C_ATTRSTART, I2CW)
+  /* Byte2 =3D I2C command: write to I2C EEPROM  device. */
+  | I2C_B1(I2C_ATTRSTOP, addr)
+  /* Byte1 =3D EEPROM internal target address. */
+  | I2C_B0(I2C_ATTRNOP, 0))) { /*  Byte0 =3D Not sent. */
+    /*  Abort function and declare error if handshake failed. */
+    return 0;
+  }
+  /*  Execute EEPROM read. */
+  if (I2Chandshake(s626ptr, I2C_B2(I2C_ATTRSTART, I2CR)
+
+  /*  Byte2 =3D I2C */
+  /*  command: read */
+  /*  from I2C EEPROM */
+  /*  device. */
+  | I2C_B1(I2C_ATTRSTOP, 0)
+
+  /*  Byte1 receives */
+  /*  uint8_t from */
+  /*  EEPROM. */
+  | I2C_B0(I2C_ATTRNOP, 0))) { /*  Byte0 =3D Not  sent. */
+
+    /*  Abort function and declare error if handshake failed. */
+    return 0;
+  }
+  /*  Return copy of EEPROM value. */
+  rtnval =3D (uint8_t) (RR7146(P_I2CCTRL) >> 16);
+  return rtnval;
+}
+
+static void WriteMISC2(struct s626_struct * s626ptr, uint16_t NewImage) {
+  DEBIwrite(s626ptr, LP_MISC1, MISC1_WENABLE); /*  enab writes to */
+  /*  MISC2 register. */
+  DEBIwrite(s626ptr, LP_WRMISC2, NewImage); /*  Write new image to MISC2.
*/
+  DEBIwrite(s626ptr, LP_MISC1, MISC1_WDISABLE); /*  Disable writes to
MISC2. */
+}
+
+/*  Write value into counter preload register. */
+static void Preload(struct s626_struct * s626ptr, struct enc_private *k,
+    uint32_t value) {
+  DEBIwrite(s626ptr, (uint16_t) (k->MyLatchLsw), (uint16_t) value);
+  DEBIwrite(s626ptr, (uint16_t) (k->MyLatchLsw + 2), (uint16_t) (value >>
16));
+}
+
+/* Private helper function: Transmit serial data to DAC via Audio
+ * channel 2.  Assumes: (1) TSL2 slot records initialized, and (2)
+ * Dacpol contains valid target image.
+ */
+static void SendDAC(struct s626_struct * s626ptr, uint32_t val) {
+  struct s626_priv *devpriv =3D s626ptr->private;
+
+  /* START THE SERIAL CLOCK RUNNING ------------- */
+
+  /* Assert DAC polarity control and enable gating of DAC serial clock
+   * and audio bit stream signals.  At this point in time we must be
+   * assured of being in time slot 0.  If we are not in slot 0, the
+   * serial clock and audio stream signals will be disabled; this is
+   * because the following DEBIwrite statement (which enables signals
+   * to be passed through the gate array) would execute before the
+   * trailing edge of WS1/WS3 (which turns off the signals), thus
+   * causing the signals to be inactive during the DAC write.
+   */
+  DEBIwrite(s626ptr, LP_DACPOL, devpriv->Dacpol);
+
+  /* TRANSFER OUTPUT DWORD VALUE INTO A2'S OUTPUT FIFO ---------------- */
+
+  /* Copy DAC setpoint value to DAC's output DMA buffer. */
+
+  /* WR7146( (uint32_t)devpriv->pDacWBuf, val ); */
+  *devpriv->pDacWBuf =3D val;
+
+  /* enab the output DMA transfer.  This will cause the DMAC to copy
+   * the DAC's data value to A2's output FIFO.  The DMA transfer will
+   * then immediately terminate because the protection address is
+   * reached upon transfer of the first DWORD value.
+   */
+  MC_ENABLE(P_MC1, MC1_A2OUT);
+
+  /*  While the DMA transfer is executing ... */
+
+  /* Reset Audio2 output FIFO's underflow flag (along with any other
+   * FIFO underflow/overflow flags).  When set, this flag will
+   * indicate that we have emerged from slot 0.
+   */
+  WR7146(P_ISR, ISR_AFOU);
+
+  /* Wait for the DMA transfer to finish so that there will be data
+   * available in the FIFO when time slot 1 tries to transfer a DWORD
+   * from the FIFO to the output buffer register.  We test for DMA
+   * Done by polling the DMAC enable flag; this flag is automatically
+   * cleared when the transfer has finished.
+   */
+  while ((RR7146(P_MC1) & MC1_A2OUT) !=3D 0)
+    ;
+
+  /* START THE OUTPUT STREAM TO THE TARGET DAC -------------------- */
+
+  /* FIFO data is now available, so we enable execution of time slots
+   * 1 and higher by clearing the EOS flag in slot 0.  Note that SD3
+   * will be shifted in and stored in FB_BUFFER2 for end-of-slot-list
+   * detection.
+   */
+  SETVECT(0, XSD2 | RSD3 | SIB_A2);
+
+  /* Wait for slot 1 to execute to ensure that the Packet will be
+   * transmitted.  This is detected by polling the Audio2 output FIFO
+   * underflow flag, which will be set when slot 1 execution has
+   * finished transferring the DAC's data DWORD from the output FIFO
+   * to the output buffer register.
+   */
+  while ((RR7146(P_SSR) & SSR_AF2_OUT) =3D=3D 0)
+    ;
+
+  /* Set up to trap execution at slot 0 when the TSL sequencer cycles
+   * back to slot 0 after executing the EOS in slot 5.  Also,
+   * simultaneously shift out and in the 0x00 that is ALWAYS the value
+   * stored in the last byte to be shifted out of the FIFO's DWORD
+   * buffer register.
+   */
+  SETVECT(0, XSD2 | XFIFO_2 | RSD2 | SIB_A2 | EOS);
+
+  /* WAIT FOR THE TRANSACTION TO FINISH ----------------------- */
+
+  /* Wait for the TSL to finish executing all time slots before
+   * exiting this function.  We must do this so that the next DAC
+   * write doesn't start, thereby enabling clock/chip select signals:
+   *
+   * 1. Before the TSL sequence cycles back to slot 0, which disables
+   *    the clock/cs signal gating and traps slot // list execution.
+   *    we have not yet finished slot 5 then the clock/cs signals are
+   *    still gated and we have not finished transmitting the stream.
+   *
+   * 2. While slots 2-5 are executing due to a late slot 0 trap.  In
+   *    this case, the slot sequence is currently repeating, but with
+   *    clock/cs signals disabled.  We must wait for slot 0 to trap
+   *    execution before setting up the next DAC setpoint DMA transfer
+   *    and enabling the clock/cs signals.  To detect the end of slot 5,
+   *    we test for the FB_BUFFER2 MSB contents to be equal to 0xFF.  If
+   *    the TSL has not yet finished executing slot 5 ...
+   */
+  if ((RR7146(P_FB_BUFFER2) & 0xFF000000) !=3D 0) {
+    /* The trap was set on time and we are still executing somewhere
+     * in slots 2-5, so we now wait for slot 0 to execute and trap
+     * TSL execution.  This is detected when FB_BUFFER2 MSB changes
+     * from 0xFF to 0x00, which slot 0 causes to happen by shifting
+     * out/in on SD2 the 0x00 that is always referenced by slot 5.
+     */
+    while ((RR7146(P_FB_BUFFER2) & 0xFF000000) !=3D 0)
+      ;
+  }
+  /* Either (1) we were too late setting the slot 0 trap; the TSL
+   * sequencer restarted slot 0 before we could set the EOS trap flag,
+   * or (2) we were not late and execution is now trapped at slot 0.
+   * In either case, we must now change slot 0 so that it will store
+   * value 0xFF (instead of 0x00) to FB_BUFFER2 next time it executes.
+   * In order to do this, we reprogram slot 0 so that it will shift in
+   * SD3, which is driven only by a pull-up resistor.
+   */
+  SETVECT(0, RSD3 | SIB_A2 | EOS);
+
+  /* Wait for slot 0 to execute, at which time the TSL is setup for
+   * the next DAC write.  This is detected when FB_BUFFER2 MSB changes
+   * from 0x00 to 0xFF.
+   */
+  while ((RR7146(P_FB_BUFFER2) & 0xFF000000) =3D=3D 0)
+    ;
+}
+
+/*  Private helper function: Write setpoint to an application DAC channel.
*/
+static void SetDAC(struct s626_struct * s626ptr, uint16_t chan, short
dacdata) {
+  struct s626_priv *devpriv =3D s626ptr->private;
+  register uint16_t signmask;
+  register uint32_t WSImage;
+
+  /*  Adjust DAC data polarity and set up Polarity Control Register */
+  /*  image. */
+  signmask =3D 1 << chan;
+  if (dacdata < 0) {
+    dacdata =3D -dacdata;
+    devpriv->Dacpol |=3D signmask;
+  } else
+    devpriv->Dacpol &=3D ~signmask;
+
+  /*  Limit DAC setpoint value to valid range. */
+  if ((uint16_t) dacdata > 0x1FFF)
+    dacdata =3D 0x1FFF;
+
+  /* Set up TSL2 records (aka "vectors") for DAC update.  Vectors V2
+   * and V3 transmit the setpoint to the target DAC.  V4 and V5 send
+   * data to a non-existent TrimDac channel just to keep the clock
+   * running after sending data to the target DAC.  This is necessary
+   * to eliminate the clock glitch that would otherwise occur at the
+   * end of the target DAC's serial data stream.  When the sequence
+   * restarts at V0 (after executing V5), the gate array automatically
+   * disables gating for the DAC clock and all DAC chip selects.
+   */
+
+  WSImage =3D (chan & 2) ? WS1 : WS2;
+  /* Choose DAC chip select to be asserted. */
+  SETVECT(2, XSD2 | XFIFO_1 | WSImage);
+  /* Slot 2: Transmit high data byte to target DAC. */
+  SETVECT(3, XSD2 | XFIFO_0 | WSImage);
+  /* Slot 3: Transmit low data byte to target DAC. */
+  SETVECT(4, XSD2 | XFIFO_3 | WS3);
+  /* Slot 4: Transmit to non-existent TrimDac channel to keep clock */
+  SETVECT(5, XSD2 | XFIFO_2 | WS3 | EOS);
+  /* Slot 5: running after writing target DAC's low data byte. */
+
+  /*  Construct and transmit target DAC's serial packet:
+   * ( A10D DDDD ),( DDDD DDDD ),( 0x0F ),( 0x00 ) where A is chan<0>,
+   * and D<12:0> is the DAC setpoint.  Append a WORD value (that writes
+   * to a  non-existent TrimDac channel) that serves to keep the clock
+   * running after the packet has been sent to the target DAC.
+   */
+  SendDAC(s626ptr, 0x0F000000
+  /* Continue clock after target DAC data (write to non-existent trimdac).
*/
+  | 0x00004000
+  /* Address the two main dual-DAC devices (TSL's chip select enables
+   * target device). */
+  | ((uint32_t) (chan & 1) << 15)
+  /*  Address the DAC channel within the  device. */
+  | (uint32_t) dacdata); /*  Include DAC setpoint data. */
+
+}
+
+static void WriteTrimDAC(struct s626_struct * s626ptr, uint8_t LogicalChan,
+    uint8_t DacData) {
+
+  struct s626_priv *devpriv =3D s626ptr->private;
+  uint32_t chan;
+
+  /*  Save the new setpoint in case the application needs to read it back
later. */
+  devpriv->TrimSetpoint[LogicalChan] =3D (uint8_t) DacData;
+
+  /*  Map logical channel number to physical channel number. */
+  chan =3D (uint32_t) trimchan[LogicalChan];
+
+  /* Set up TSL2 records for TrimDac write operation.  All slots shift
+   * 0xFF in from pulled-up SD3 so that the end of the slot sequence
+   * can be detected.
+   */
+
+  SETVECT(2, XSD2 | XFIFO_1 | WS3);
+  /* Slot 2: Send high uint8_t to target TrimDac. */
+  SETVECT(3, XSD2 | XFIFO_0 | WS3);
+  /* Slot 3: Send low uint8_t to target TrimDac. */
+  SETVECT(4, XSD2 | XFIFO_3 | WS1);
+  /* Slot 4: Send NOP high uint8_t to DAC0 to keep clock running. */
+  SETVECT(5, XSD2 | XFIFO_2 | WS1 | EOS);
+  /* Slot 5: Send NOP low  uint8_t to DAC0. */
+
+  /* Construct and transmit target DAC's serial packet:
+   * ( 0000 AAAA ), ( DDDD DDDD ),( 0x00 ),( 0x00 ) where A<3:0> is the
+   * DAC channel's address, and D<7:0> is the DAC setpoint.  Append a
+   * WORD value (that writes a channel 0 NOP command to a non-existent
+   * main DAC channel) that serves to keep the clock running after the
+   * packet has been sent to the target DAC.
+   */
+
+  /*  Address the DAC channel within the trimdac device. */
+  SendDAC(s626ptr, ((uint32_t) chan << 8) | (uint32_t) DacData); /*
Include DAC setpoint data. */
+}
+
+static void LoadTrimDACs(struct s626_struct * s626ptr) {
+  register uint8_t i;
+
+  /*  Copy TrimDac setpoint values from EEPROM to TrimDacs. */
+  for (i =3D 0; i < ARRAY_SIZE(trimchan); i++)
+    WriteTrimDAC(s626ptr, i, I2Cread(s626ptr, trimadrs[i]));
+}
+
+/* ******  COUNTER FUNCTIONS  ******* */
+/* All counter functions address a specific counter by means of the
+ * "Counter" argument, which is a logical counter number.  The Counter
+ * argument may have any of the following legal values: 0=3D0A, 1=3D1A,
+ * 2=3D2A, 3=3D0B, 4=3D1B, 5=3D2B.
+ */
+
+/*  Read a counter's output latch. */
+static uint32_t ReadLatch(struct s626_struct * s626ptr, struct enc_private
*k) {
+  register uint32_t value;
+
+  /*  Latch counts and fetch LSW of latched counts value. */
+  value =3D (uint32_t) DEBIread(s626ptr, k->MyLatchLsw);
+
+  /*  Fetch MSW of latched counts and combine with LSW. */
+  value |=3D ((uint32_t) DEBIread(s626ptr, k->MyLatchLsw + 2) << 16);
+
+  /*  Return latched counts. */
+  return value;
+}
+
+/* Return/set a counter pair's latch trigger source.  0: On read
+ * access, 1: A index latches A, 2: B index latches B, 3: A overflow
+ * latches B.
+ */
+static void SetLatchSource(struct s626_struct * s626ptr, struct
enc_private *k,
+    uint16_t value) {
+  DEBIreplace(s626ptr, k->MyCRB,
+      (uint16_t) (~(CRBMSK_INTCTRL | CRBMSK_LATCHSRC)),
+      (uint16_t) (value << CRBBIT_LATCHSRC));
+}
+
+static void s626_timer_load(struct s626_struct * s626ptr, struct
enc_private *k,
+    int tick) {
+  uint16_t Setup =3D (LOADSRC_INDX << BF_LOADSRC) | /*  Preload upon */
+  /*  index. */
+  (INDXSRC_SOFT << BF_INDXSRC) | /*  Disable hardware index. */
+  (CLKSRC_TIMER << BF_CLKSRC) | /*  Operating mode is Timer. */
+  (CLKPOL_POS << BF_CLKPOL) | /*  Active high clock. */
+  (CNTDIR_DOWN << BF_CLKPOL) | /*  Count direction is Down. */
+  (CLKMULT_1X << BF_CLKMULT) | /*  Clock multiplier is 1x. */
+  (CLKENAB_INDEX << BF_CLKENAB);
+  uint16_t valueSrclatch =3D LATCHSRC_A_INDXA;
+  /*   uint16_t enab=3DCLKENAB_ALWAYS; */
+
+  k->SetMode(s626ptr, k, Setup, FALSE);
+
+  /*  Set the preload register */
+  Preload(s626ptr, k, tick);
+
+  /*  Software index pulse forces the preload register to load */
+  /*  into the counter */
+  k->SetLoadTrig(s626ptr, k, 0);
+  k->PulseIndex(s626ptr, k);
+
+  /* set reload on counter overflow */
+  k->SetLoadTrig(s626ptr, k, 1);
+
+  /* set interrupt on overflow */
+  k->SetIntSrc(s626ptr, k, INTSRC_OVER);
+
+  SetLatchSource(s626ptr, k, valueSrclatch);
+  /*   k->SetEnable(dev,k,(uint16_t)(enab !=3D 0)); */
+}
+
+int s626_irq_handler(unsigned int irq, void *d) {
+  a4l_dev_t *dev =3D NULL;
+  struct s626_priv *devpriv =3D NULL;
+  a4l_subd_t *s;
+  a4l_cmd_t *cmd;
+  struct enc_private *k;
+  unsigned long flags;
+  int32_t *readaddr;
+  uint32_t irqtype, irqstatus;
+  int i =3D 0;
+  short tempdata;
+  uint8_t group;
+  uint16_t irqbit;
+
+  struct list_head *ptr;
+  struct s626_struct * s626ptr =3D NULL;
+
+  list_for_each( ptr, &s626_list) {
+    s626ptr =3D list_entry(ptr, struct s626_struct, list);
+    if (a4l_get_irq(s626ptr->dev) =3D=3D irq) {
+      dev =3D s626ptr->dev;
+      devpriv =3D s626ptr->private;
+      break;
+    }
+  }
+
+  if (dev =3D=3D NULL) {
+    __a4l_err( "Inside %s, error, no device\n", __PRETTY_FUNCTION__);
+    return -ENODEV;
+  }
+
+  //if (dev->attached =3D=3D 0)
+  //return IRQ_NONE;
+  //  lock to avoid race with comedi_poll
+  a4l_lock_irqsave(&dev->lock, flags);
+
+  // save interrupt enable register state
+  irqstatus =3D readl(devpriv->base_addr + P_IER);
+
+  // read interrupt type
+  irqtype =3D readl(devpriv->base_addr + P_ISR);
+
+  // disable master interrupt
+  writel(0, devpriv->base_addr + P_IER);
+
+  // clear interrupt
+  writel(irqtype, devpriv->base_addr + P_ISR);
+
+  switch (irqtype) {
+  case IRQ_RPS1: // end_of_scan occurs
+    //  manage ai subdevice
+    s =3D a4l_get_subd(dev, SUBD_AI);
+    cmd =3D a4l_get_cmd(s);
+
+    // Init ptr to DMA buffer that holds new ADC data.  We skip the
+    // first uint16_t in the buffer because it contains junk data from
+    // the final ADC of the previous poll list scan.
+
+    readaddr =3D (int32_t *) devpriv->ANABuf.LogicalBase + 1;
+
+    //  get the data and hand it over to comedi
+    for (i =3D 0; i < (cmd->nb_chan); i++) {
+      //  Convert ADC data to 16-bit integer values and copy to application
+      //  buffer.
+      tempdata =3D s626_ai_reg_to_uint((int) *readaddr);
+      readaddr++;
+
+      // put data into read buffer
+      //  comedi_buf_put(s->async, tempdata);
+      /*
+       if (cfc_write_to_buffer(s, tempdata) =3D=3D 0)
+       printk
+       ("s626_irq_handler: cfc_write_to_buffer error!\n");
+       */
+    }
+
+    // end of scan occurs
+    //s->async->events |=3D COMEDI_CB_EOS;
+
+    if (!(devpriv->ai_continous))
+      devpriv->ai_sample_count--;
+    if (devpriv->ai_sample_count <=3D 0) {
+      devpriv->ai_cmd_running =3D 0;
+
+      //  Stop RPS program.
+      MC_DISABLE(P_MC1, MC1_ERPS1);
+
+      // send end of acquisition
+      //s->async->events |=3D COMEDI_CB_EOA;
+
+      // disable master interrupt
+      irqstatus =3D 0;
+    }
+
+    if (devpriv->ai_cmd_running && cmd->scan_begin_src =3D=3D TRIG_EXT)
+      s626_dio_set_irq(s626ptr, cmd->scan_begin_arg);
+    //  tell comedi that data is there
+    //comedi_event(dev, s);
+    break;
+  case IRQ_GPIO3: // check dio and conter interrupt
+    //  manage ai subdevice
+    s =3D a4l_get_subd(dev, SUBD_AI);
+    cmd =3D a4l_get_cmd(s);
+
+    // s626_dio_clear_irq(dev);
+
+    for (group =3D 0; group < S626_DIO_BANKS; group++) {
+      irqbit =3D 0;
+      // read interrupt type
+      irqbit =3D DEBIread(s626ptr,
+          ((struct s626_subd_dio_private *) (&(a4l_get_subd(s626ptr->dev,
+              group + 2)->priv)))->RDCapFlg);
+
+      // check if interrupt is generated from dio channels
+      if (irqbit) {
+        s626_dio_reset_irq(s626ptr, group, irqbit);
+        if (devpriv->ai_cmd_running) {
+          // check if interrupt is an ai acquisition start trigger
+          if ((irqbit >> (cmd->start_arg - (16 * group)))
+              =3D=3D 1&& cmd->start_src =3D=3D TRIG_EXT) {
+          //  Start executing the RPS program.
+MC_ENABLE          (P_MC1, MC1_ERPS1);
+
+          if (cmd->scan_begin_src =3D=3D
+              TRIG_EXT) {
+            s626_dio_set_irq(s626ptr,cmd->scan_begin_arg);
+          }
+        }
+        if ((irqbit >> (cmd->scan_begin_arg -
+                    (16 * group)))
+            =3D=3D 1
+            && cmd->scan_begin_src =3D=3D
+            TRIG_EXT) {
+          //  Trigger ADC scan loop start by setting RPS Signal 0.
+          MC_ENABLE(P_MC2, MC2_ADC_RPS);
+
+          if (cmd->convert_src =3D=3D
+              TRIG_EXT) {
+            devpriv->ai_convert_count
+            =3D cmd->nb_chan;
+
+            s626_dio_set_irq(s626ptr, cmd->convert_arg);
+          }
+
+          if (cmd->convert_src =3D=3D
+              TRIG_TIMER) {
+            k =3D &encpriv[5];
+            devpriv->ai_convert_count
+            =3D cmd->nb_chan;
+            k->SetEnable(s626ptr,k,
+                CLKENAB_ALWAYS);
+          }
+        }
+        if ((irqbit >> (cmd->convert_arg -
+                    (16 * group)))
+            =3D=3D 1
+            && cmd->convert_src =3D=3D TRIG_EXT) {
+          //  Trigger ADC scan loop start by setting RPS Signal 0.
+          MC_ENABLE(P_MC2, MC2_ADC_RPS);
+
+          devpriv->ai_convert_count--;
+
+          if (devpriv->ai_convert_count >
+              0) {
+            s626_dio_set_irq(s626ptr,cmd->convert_arg);
+          }
+        }
+      }
+        break;
+      }
+    }
+
+    // read interrupt type
+    irqbit =3D DEBIread(s626ptr, LP_RDMISC2);
+
+    // check interrupt on counters
+    if (irqbit & IRQ_COINT1A) {
+      k =3D &encpriv[0];
+
+      // clear interrupt capture flag
+      k->ResetCapFlags(s626ptr, k);
+    }
+    if (irqbit & IRQ_COINT2A) {
+      k =3D &encpriv[1];
+
+      // clear interrupt capture flag
+      k->ResetCapFlags(s626ptr, k);
+    }
+    if (irqbit & IRQ_COINT3A) {
+      k =3D &encpriv[2];
+
+      // clear interrupt capture flag
+      k->ResetCapFlags(s626ptr, k);
+    }
+    if (irqbit & IRQ_COINT1B) {
+      k =3D &encpriv[3];
+
+      // clear interrupt capture flag
+      k->ResetCapFlags(s626ptr, k);
+    }
+    if (irqbit & IRQ_COINT2B) {
+      k =3D &encpriv[4];
+
+      // clear interrupt capture flag
+      k->ResetCapFlags(s626ptr, k);
+
+      if (devpriv->ai_convert_count > 0) {
+        devpriv->ai_convert_count--;
+        if (devpriv->ai_convert_count =3D=3D 0)
+          k->SetEnable(s626ptr, k, CLKENAB_INDEX);
+
+        if (cmd->convert_src =3D=3D TRIG_TIMER) {
+          //  Trigger ADC scan loop start by setting RPS Signal 0.
+          MC_ENABLE(P_MC2, MC2_ADC_RPS);
+        }
+      }
+    }
+    if (irqbit & IRQ_COINT3B) {
+      k =3D &encpriv[5];
+
+      // clear interrupt capture flag
+      k->ResetCapFlags(s626ptr, k);
+
+      if (cmd->scan_begin_src =3D=3D TRIG_TIMER) {
+        //  Trigger ADC scan loop start by setting RPS Signal 0.
+        MC_ENABLE(P_MC2, MC2_ADC_RPS);
+      }
+
+      if (cmd->convert_src =3D=3D TRIG_TIMER) {
+        k =3D &encpriv[4];
+        devpriv->ai_convert_count =3D cmd->nb_chan;
+        k->SetEnable(s626ptr, k, CLKENAB_ALWAYS);
+      }
+    }
+    break;
+  }
+
+  // enable interrupt
+  writel(irqstatus, devpriv->base_addr + P_IER);
+
+  a4l_unlock_irqrestore(&dev->lock, flags);
+
+  return IRQ_HANDLED;
+}
+
+/* This function doesn't require a particular form, this is just what
+ * happens to be used in some of the drivers.  It should convert ns
+ * nanoseconds to a counter value suitable for programming the device.
+ * Also, it should adjust ns so that it cooresponds to the actual time
+ * that the device will use. */
+static int s626_ns_to_timer(int *nanosec, int round_mode) {
+  int divider, base;
+
+  base =3D 500; /* 2MHz internal clock */
+
+  switch (round_mode) {
+  case TRIG_ROUND_NEAREST:
+  default:
+    divider =3D (*nanosec + base / 2) / base;
+    break;
+  case TRIG_ROUND_DOWN:
+    divider =3D (*nanosec) / base;
+    break;
+  case TRIG_ROUND_UP:
+    divider =3D (*nanosec + base - 1) / base;
+    break;
+  }
+
+  *nanosec =3D base * divider;
+  return divider - 1;
+}
+
+static int s626_allocate_dma_buffers(struct s626_struct * s626ptr) {
+  struct pci_dev *pcidev =3D s626ptr->pcidev;
+  struct s626_priv *devpriv =3D s626ptr->private;
+  void *addr;
+  dma_addr_t appdma;
+
+  addr =3D pci_alloc_consistent(pcidev, DMABUF_SIZE, &appdma);
+  if (!addr)
+    return -ENOMEM;
+  devpriv->ANABuf.LogicalBase =3D addr;
+  devpriv->ANABuf.PhysicalBase =3D appdma;
+
+  addr =3D pci_alloc_consistent(pcidev, DMABUF_SIZE, &appdma);
+  if (!addr)
+    return -ENOMEM;
+  devpriv->RPSBuf.LogicalBase =3D addr;
+  devpriv->RPSBuf.PhysicalBase =3D appdma;
+
+  return 0;
+}
+
+static int s626_dio_clear_irq(struct s626_struct * s626ptr) {
+  unsigned int group;
+
+  /* disable edge capture write command */
+  DEBIwrite(s626ptr, LP_MISC1, MISC1_NOEDCAP);
+
+  for (group =3D 0; group < S626_DIO_BANKS; group++) {
+    /* clear pending events and interrupt */
+    DEBIwrite(s626ptr,
+        ((struct s626_subd_dio_private *) (&(a4l_get_subd(s626ptr->dev,
+            group + 2)->priv)))->WRCapSel, 0xffff);
+  }
+
+  return 0;
+}
+
+static int s626_dio_set_irq(struct s626_struct * s626ptr, unsigned int
chan) {
+  unsigned int group;
+  unsigned int bitmask;
+  unsigned int status;
+
+  /* select dio bank */
+  group =3D chan / 16;
+  bitmask =3D 1 << (chan - (16 * group));
+
+  /* set channel to capture positive edge */
+  status =3D
+      DEBIread(s626ptr,
+          ((struct s626_subd_dio_private *) (&(a4l_get_subd(s626ptr->dev,
+              group + 2)->priv)))->RDEdgSel);
+  DEBIwrite(s626ptr,
+      ((struct s626_subd_dio_private *) (&(a4l_get_subd(s626ptr->dev,
group + 2)->priv)))->WREdgSel,
+      bitmask | status);
+
+  /* enable interrupt on selected channel */
+  status =3D
+      DEBIread(s626ptr,
+          ((struct s626_subd_dio_private *) (&(a4l_get_subd(s626ptr->dev,
+              group + 2)->priv)))->RDIntSel);
+  DEBIwrite(s626ptr,
+      ((struct s626_subd_dio_private *) (&(a4l_get_subd(s626ptr->dev,
group + 2)->priv)))->WRIntSel,
+      bitmask | status);
+
+  /* enable edge capture write command */
+  DEBIwrite(s626ptr, LP_MISC1, MISC1_EDCAP);
+
+  /* enable edge capture on selected channel */
+  status =3D
+      DEBIread(s626ptr,
+          ((struct s626_subd_dio_private *) (&(a4l_get_subd(s626ptr->dev,
+              group + 2)->priv)))->RDCapSel);
+  DEBIwrite(s626ptr,
+      ((struct s626_subd_dio_private *) (&(a4l_get_subd(s626ptr->dev,
group + 2)->priv)))->WRCapSel,
+      bitmask | status);
+
+  return 0;
+}
+
+static int s626_dio_reset_irq(struct s626_struct * s626ptr, unsigned int
group,
+    unsigned int mask) {
+  /* disable edge capture write command */
+  DEBIwrite(s626ptr, LP_MISC1, MISC1_NOEDCAP);
+
+  /* enable edge capture on selected channel */
+  DEBIwrite(s626ptr,
+      ((struct s626_subd_dio_private *) (&(a4l_get_subd(s626ptr->dev,
group + 2)->priv)))->WRCapSel,
+      mask);
+
+  return 0;
+}
+
+/*
+ * this functions build the RPS program for hardware driven acquistion
+ */
+static void ResetADC(struct s626_struct * s626ptr, uint8_t *ppl,
+    a4l_cmd_t * cmd) {
+  struct s626_priv *devpriv =3D s626ptr->private;
+  register uint32_t *pRPS;
+  uint32_t JmpAdrs;
+  uint16_t i;
+  uint16_t n;
+  uint32_t LocalPPL;
+
+  /*  Stop RPS program in case it is currently running. */
+  MC_DISABLE(P_MC1, MC1_ERPS1);
+
+  /*  Set starting logical address to write RPS commands. */
+  pRPS =3D (uint32_t *) devpriv->RPSBuf.LogicalBase;
+
+  /*  Initialize RPS instruction pointer. */
+  WR7146(P_RPSADDR1, (uint32_t) devpriv->RPSBuf.PhysicalBase);
+
+  /*  Construct RPS program in RPSBuf DMA buffer */
+
+  if (cmd !=3D NULL && cmd->scan_begin_src !=3D TRIG_FOLLOW) {
+    /*  Wait for Start trigger. */
+    *pRPS++ =3D RPS_PAUSE | RPS_SIGADC;
+    *pRPS++ =3D RPS_CLRSIGNAL | RPS_SIGADC;
+  }
+
+  /* SAA7146 BUG WORKAROUND Do a dummy DEBI Write.  This is necessary
+   * because the first RPS DEBI Write following a non-RPS DEBI write
+   * seems to always fail.  If we don't do this dummy write, the ADC
+   * gain might not be set to the value required for the first slot in
+   * the poll list; the ADC gain would instead remain unchanged from
+   * the previously programmed value.
+   */
+  *pRPS++ =3D RPS_LDREG | (P_DEBICMD >> 2);
+  /* Write DEBI Write command and address to shadow RAM. */
+
+  *pRPS++ =3D DEBI_CMD_WRWORD | LP_GSEL;
+  *pRPS++ =3D RPS_LDREG | (P_DEBIAD >> 2);
+  /*  Write DEBI immediate data  to shadow RAM: */
+
+  *pRPS++ =3D GSEL_BIPOLAR5V;
+  /*  arbitrary immediate data  value. */
+
+  *pRPS++ =3D RPS_CLRSIGNAL | RPS_DEBI;
+  /*  Reset "shadow RAM  uploaded" flag. */
+  *pRPS++ =3D RPS_UPLOAD | RPS_DEBI; /*  Invoke shadow RAM upload. */
+  *pRPS++ =3D RPS_PAUSE | RPS_DEBI; /*  Wait for shadow upload to finish. =
*/
+
+  /* Digitize all slots in the poll list. This is implemented as a
+   * for loop to limit the slot count to 16 in case the application
+   * forgot to set the EOPL flag in the final slot.
+   */
+  for (devpriv->AdcItems =3D 0; devpriv->AdcItems < 16; devpriv->AdcItems+=
+)
{
+    /* Convert application's poll list item to private board class
+     * format.  Each app poll list item is an uint8_t with form
+     * (EOPL,x,x,RANGE,CHAN<3:0>), where RANGE code indicates 0 =3D
+     * +-10V, 1 =3D +-5V, and EOPL =3D End of Poll List marker.
+     */
+    LocalPPL =3D (*ppl << 8) | (*ppl & 0x10 ? GSEL_BIPOLAR5V :
GSEL_BIPOLAR10V);
+
+    /*  Switch ADC analog gain. */
+    *pRPS++ =3D RPS_LDREG | (P_DEBICMD >> 2); /*  Write DEBI command */
+    /*  and address to */
+    /*  shadow RAM. */
+    *pRPS++ =3D DEBI_CMD_WRWORD | LP_GSEL;
+    *pRPS++ =3D RPS_LDREG | (P_DEBIAD >> 2); /*  Write DEBI */
+    /*  immediate data to */
+    /*  shadow RAM. */
+    *pRPS++ =3D LocalPPL;
+    *pRPS++ =3D RPS_CLRSIGNAL | RPS_DEBI; /*  Reset "shadow RAM uploaded" =
*/
+    /*  flag. */
+    *pRPS++ =3D RPS_UPLOAD | RPS_DEBI; /*  Invoke shadow RAM upload. */
+    *pRPS++ =3D RPS_PAUSE | RPS_DEBI; /*  Wait for shadow upload to */
+    /*  finish. */
+
+    /*  Select ADC analog input channel. */
+    *pRPS++ =3D RPS_LDREG | (P_DEBICMD >> 2);
+    /*  Write DEBI command and address to  shadow RAM. */
+    *pRPS++ =3D DEBI_CMD_WRWORD | LP_ISEL;
+    *pRPS++ =3D RPS_LDREG | (P_DEBIAD >> 2);
+    /*  Write DEBI immediate data to shadow RAM. */
+    *pRPS++ =3D LocalPPL;
+    *pRPS++ =3D RPS_CLRSIGNAL | RPS_DEBI;
+    /*  Reset "shadow RAM uploaded"  flag. */
+
+    *pRPS++ =3D RPS_UPLOAD | RPS_DEBI;
+    /*  Invoke shadow RAM upload. */
+
+    *pRPS++ =3D RPS_PAUSE | RPS_DEBI;
+    /*  Wait for shadow upload to finish. */
+
+    /* Delay at least 10 microseconds for analog input settling.
+     * Instead of padding with NOPs, we use RPS_JUMP instructions
+     * here; this allows us to produce a longer delay than is
+     * possible with NOPs because each RPS_JUMP flushes the RPS'
+     * instruction prefetch pipeline.
+     */
+    JmpAdrs =3D (uint32_t) devpriv->RPSBuf.PhysicalBase
+        + (uint32_t) ((unsigned long) pRPS
+            - (unsigned long) devpriv->RPSBuf.LogicalBase);
+    for (i =3D 0; i < (10 * RPSCLK_PER_US / 2); i++) {
+      JmpAdrs +=3D 8; /*  Repeat to implement time delay: */
+      *pRPS++ =3D RPS_JUMP; /*  Jump to next RPS instruction. */
+      *pRPS++ =3D JmpAdrs;
+    }
+
+    if (cmd !=3D NULL && cmd->convert_src !=3D TRIG_NOW) {
+      /*  Wait for Start trigger. */
+      *pRPS++ =3D RPS_PAUSE | RPS_SIGADC;
+      *pRPS++ =3D RPS_CLRSIGNAL | RPS_SIGADC;
+    }
+    /*  Start ADC by pulsing GPIO1. */
+    *pRPS++ =3D RPS_LDREG | (P_GPIO >> 2); /*  Begin ADC Start pulse. */
+    *pRPS++ =3D GPIO_BASE | GPIO1_LO;
+    *pRPS++ =3D RPS_NOP;
+    /*  VERSION 2.03 CHANGE: STRETCH OUT ADC START PULSE. */
+    *pRPS++ =3D RPS_LDREG | (P_GPIO >> 2); /*  End ADC Start pulse. */
+    *pRPS++ =3D GPIO_BASE | GPIO1_HI;
+
+    /* Wait for ADC to complete (GPIO2 is asserted high when ADC not
+     * busy) and for data from previous conversion to shift into FB
+     * BUFFER 1 register.
+     */
+    *pRPS++ =3D RPS_PAUSE | RPS_GPIO2; /*  Wait for ADC done. */
+
+    /*  Transfer ADC data from FB BUFFER 1 register to DMA buffer. */
+    *pRPS++ =3D RPS_STREG | (BUGFIX_STREG(P_FB_BUFFER1) >> 2);
+    *pRPS++ =3D (uint32_t) devpriv->ANABuf.PhysicalBase
+        + (devpriv->AdcItems << 2);
+
+    /*  If this slot's EndOfPollList flag is set, all channels have */
+    /*  now been processed. */
+    if (*ppl++ & EOPL) {
+      devpriv->AdcItems++; /*  Adjust poll list item count. */
+      break; /*  Exit poll list processing loop. */
+    }
+  }
+
+  /* VERSION 2.01 CHANGE: DELAY CHANGED FROM 250NS to 2US.  Allow the
+   * ADC to stabilize for 2 microseconds before starting the final
+   * (dummy) conversion.  This delay is necessary to allow sufficient
+   * time between last conversion finished and the start of the dummy
+   * conversion.  Without this delay, the last conversion's data value
+   * is sometimes set to the previous conversion's data value.
+   */
+  for (n =3D 0; n < (2 * RPSCLK_PER_US); n++)
+    *pRPS++ =3D RPS_NOP;
+
+  /* Start a dummy conversion to cause the data from the last
+   * conversion of interest to be shifted in.
+   */
+  *pRPS++ =3D RPS_LDREG | (P_GPIO >> 2); /*  Begin ADC Start pulse. */
+  *pRPS++ =3D GPIO_BASE | GPIO1_LO;
+  *pRPS++ =3D RPS_NOP;
+  /* VERSION 2.03 CHANGE: STRETCH OUT ADC START PULSE. */
+  *pRPS++ =3D RPS_LDREG | (P_GPIO >> 2); /*  End ADC Start pulse. */
+  *pRPS++ =3D GPIO_BASE | GPIO1_HI;
+
+  /* Wait for the data from the last conversion of interest to arrive
+   * in FB BUFFER 1 register.
+   */
+  *pRPS++ =3D RPS_PAUSE | RPS_GPIO2; /*  Wait for ADC done. */
+
+  /*  Transfer final ADC data from FB BUFFER 1 register to DMA buffer. */
+  *pRPS++ =3D RPS_STREG | (BUGFIX_STREG(P_FB_BUFFER1) >> 2); /*  */
+  *pRPS++ =3D (uint32_t) devpriv->ANABuf.PhysicalBase + (devpriv->AdcItems
<< 2);
+
+  /*  Indicate ADC scan loop is finished. */
+  /*  *pRPS++=3D RPS_CLRSIGNAL | RPS_SIGADC ;  // Signal ReadADC() that sc=
an
is done. */
+
+  /* invoke interrupt */
+  if (devpriv->ai_cmd_running =3D=3D 1) {
+    *pRPS++ =3D RPS_IRQ;
+  }
+  /*  Restart RPS program at its beginning. */
+  *pRPS++ =3D RPS_JUMP; /*  Branch to start of RPS program. */
+  *pRPS++ =3D (uint32_t) devpriv->RPSBuf.PhysicalBase;
+
+  /*  End of RPS program build */
+}
+
+/* TO COMPLETE, IF NECESSARY */
+static int s626_ai_insn_config(a4l_subd_t *subd, a4l_kinsn_t *insn) {
+
+  return -EINVAL;
+}
+
+static unsigned int s626_ai_reg_to_uint(int data) {
+  unsigned int tempdata;
+
+  tempdata =3D (data >> 18);
+  if (tempdata & 0x2000)
+    tempdata &=3D 0x1fff;
+  else
+    tempdata +=3D (1 << 13);
+
+  return tempdata;
+}
+
+static int s626_ai_insn_read(a4l_subd_t *subd, a4l_kinsn_t *insn) {
+  uint16_t chan =3D CR_CHAN(insn->chan_desc);
+  uint16_t range =3D CR_RNG(insn->chan_desc);
+  uint16_t AdcSpec =3D 0;
+  uint16_t *data =3D (uint16_t *) insn->data;
+  uint32_t GpioImage;
+  int n;
+
+  struct s626_priv *devpriv =3D NULL;
+  struct list_head *ptr;
+  struct s626_struct * s626ptr =3D NULL;
+
+  list_for_each( ptr, &s626_list) {
+    s626ptr =3D list_entry(ptr, struct s626_struct, list);
+    if (s626ptr->dev =3D=3D subd->dev) {
+      devpriv =3D s626ptr->private;
+      break;
+    }
+  }
+
+  if (devpriv =3D=3D NULL) {
+    __a4l_err( "Inside %s, error, no device\n", __PRETTY_FUNCTION__);
+    return -ENODEV;
+  }
+
+  /* interrupt call test  */
+  /*   writel(IRQ_GPIO3,devpriv->base_addr+P_PSR); */
+  /* Writing a logical 1 into any of the RPS_PSR bits causes the
+   * corresponding interrupt to be generated if enabled
+   */
+
+  /* Convert application's ADC specification into form
+   *  appropriate for register programming.
+   */
+  if (range =3D=3D 0)
+    AdcSpec =3D (chan << 8) | (GSEL_BIPOLAR5V);
+  else
+    AdcSpec =3D (chan << 8) | (GSEL_BIPOLAR10V);
+
+  /*  Switch ADC analog gain. */
+  DEBIwrite(s626ptr, LP_GSEL, AdcSpec); /*  Set gain. */
+
+  /*  Select ADC analog input channel. */
+  DEBIwrite(s626ptr, LP_ISEL, AdcSpec); /*  Select channel. */
+
+  //for (n =3D 0; n < insn->n; n++)
+  for (n =3D 0; n < insn->data_size / sizeof(uint16_t); n++) {
+
+    /*  Delay 10 microseconds for analog input settling. */
+    udelay(10);
+
+    /*  Start ADC by pulsing GPIO1 low. */
+    GpioImage =3D RR7146(P_GPIO);
+    /*  Assert ADC Start command */
+    WR7146(P_GPIO, GpioImage & ~GPIO1_HI);
+    /*    and stretch it out. */
+    WR7146(P_GPIO, GpioImage & ~GPIO1_HI);
+    WR7146(P_GPIO, GpioImage & ~GPIO1_HI);
+    /*  Negate ADC Start command. */
+    WR7146(P_GPIO, GpioImage | GPIO1_HI);
+
+    /*  Wait for ADC to complete (GPIO2 is asserted high when */
+    /*  ADC not busy) and for data from previous conversion to */
+    /*  shift into FB BUFFER 1 register. */
+
+    /*  Wait for ADC done. */
+    while (!(RR7146(P_PSR) & PSR_GPIO2))
+      ;
+
+    /*  Fetch ADC data. */
+    if (n !=3D 0)
+      data[n - 1] =3D s626_ai_reg_to_uint(RR7146(P_FB_BUFFER1));
+
+    /* Allow the ADC to stabilize for 4 microseconds before
+     * starting the next (final) conversion.  This delay is
+     * necessary to allow sufficient time between last
+     * conversion finished and the start of the next
+     * conversion.  Without this delay, the last conversion's
+     * data value is sometimes set to the previous
+     * conversion's data value.
+     */
+    udelay(4);
+  }
+
+  /* Start a dummy conversion to cause the data from the
+   * previous conversion to be shifted in. */
+  GpioImage =3D RR7146(P_GPIO);
+
+  /* Assert ADC Start command */
+  WR7146(P_GPIO, GpioImage & ~GPIO1_HI);
+  /*    and stretch it out. */
+  WR7146(P_GPIO, GpioImage & ~GPIO1_HI);
+  WR7146(P_GPIO, GpioImage & ~GPIO1_HI);
+  /*  Negate ADC Start command. */
+  WR7146(P_GPIO, GpioImage | GPIO1_HI);
+
+  /*  Wait for the data to arrive in FB BUFFER 1 register. */
+
+  /*  Wait for ADC done. */
+  while (!(RR7146(P_PSR) & PSR_GPIO2))
+    ;
+
+  /*  Fetch ADC data from audio interface's input shift register. */
+
+  /*  Fetch ADC data. */
+  if (n !=3D 0)
+    data[n - 1] =3D s626_ai_reg_to_uint(RR7146(P_FB_BUFFER1));
+
+  return n;
+}
+
+static int s626_ai_load_polllist(uint8_t *ppl, a4l_cmd_t *cmd) {
+
+  int n;
+
+  for (n =3D 0; n < cmd->nb_chan; n++) {
+    if (CR_RNG((cmd->chan_descs)[n]) =3D=3D 0)
+      ppl[n] =3D (CR_CHAN((cmd->chan_descs)[n])) | (RANGE_5V);
+    else
+      ppl[n] =3D (CR_CHAN((cmd->chan_descs)[n])) | (RANGE_10V);
+  }
+  if (n !=3D 0)
+    ppl[n - 1] |=3D EOPL;
+
+  return n;
+}
+
+static int s626_ai_inttrig(struct a4l_subdevice * subdev,
+    unsigned long int trignum) {
+  struct s626_priv *devpriv =3D NULL;
+  struct list_head *ptr;
+  struct s626_struct * s626ptr =3D NULL;
+
+  list_for_each( ptr, &s626_list) {
+    s626ptr =3D list_entry(ptr, struct s626_struct, list);
+    if (s626ptr->dev =3D=3D subdev->dev) {
+      devpriv =3D s626ptr->private;
+      break;
+    }
+  }
+
+  if (devpriv =3D=3D NULL) {
+    __a4l_err( "Inside %s, error, no device\n", __PRETTY_FUNCTION__);
+    return -ENODEV;
+  }
+
+  if (trignum !=3D 0)
+    return -EINVAL;
+
+  /*  Start executing the RPS program. */
+  MC_ENABLE(P_MC1, MC1_ERPS1);
+
+  subdev->trigger =3D NULL;
+
+  return 1;
+}
+
+/*  TO COMPLETE  */
+static int s626_ai_cmd(struct a4l_subdevice * subdev, a4l_cmd_t * cmd) {
+  uint8_t ppl[16];
+  //struct comedi_cmd *cmd =3D &s->async->cmd;
+  struct enc_private *k;
+  int tick;
+
+  struct s626_priv *devpriv =3D NULL;
+  struct list_head *ptr;
+  struct s626_struct * s626ptr =3D NULL;
+
+  list_for_each( ptr, &s626_list) {
+    s626ptr =3D list_entry(ptr, struct s626_struct, list);
+    if (s626ptr->dev =3D=3D subdev->dev) {
+      devpriv =3D s626ptr->private;
+      break;
+    }
+  }
+
+  if (devpriv =3D=3D NULL) {
+    __a4l_err( "Inside %s, error, no device\n", __PRETTY_FUNCTION__);
+    return -ENODEV;
+  }
+
+  if (devpriv->ai_cmd_running) {
+    printk(KERN_ERR "s626_ai_cmd: Another ai_cmd is running\n");
+    return -EBUSY;
+  }
+  /* disable interrupt */
+  writel(0, devpriv->base_addr + P_IER);
+
+  /* clear interrupt request */
+  writel(IRQ_RPS1 | IRQ_GPIO3, devpriv->base_addr + P_ISR);
+
+  /* clear any pending interrupt */
+  s626_dio_clear_irq(s626ptr);
+  /*   s626_enc_clear_irq(dev); */
+
+  /* reset ai_cmd_running flag */
+  devpriv->ai_cmd_running =3D 0;
+
+  /*  test if cmd is valid */
+  if (cmd =3D=3D NULL)
+    return -EINVAL;
+
+  if (a4l_get_irq(s626ptr->dev) =3D=3D 0) {
+    __a4l_err("s626_ai_cmd: cannot run command without an irq\n");
+    return -EIO;
+  }
+
+  s626_ai_load_polllist(ppl, cmd);
+  devpriv->ai_cmd_running =3D 1;
+  devpriv->ai_convert_count =3D 0;
+
+  switch (cmd->scan_begin_src) {
+  case TRIG_FOLLOW:
+    break;
+  case TRIG_TIMER:
+    /*  set a conter to generate adc trigger at scan_begin_arg interval */
+    k =3D &encpriv[5];
+    tick =3D s626_ns_to_timer((int *) &cmd->scan_begin_arg,
+        cmd->flags & TRIG_ROUND_MASK);
+
+    /* load timer value and enable interrupt */
+    s626_timer_load(s626ptr, k, tick);
+    k->SetEnable(s626ptr, k, CLKENAB_ALWAYS);
+    break;
+  case TRIG_EXT:
+    /*  set the digital line and interrupt for scan trigger */
+    if (cmd->start_src !=3D TRIG_EXT)
+      s626_dio_set_irq(s626ptr, cmd->scan_begin_arg);
+    break;
+  }
+
+  switch (cmd->convert_src) {
+  case TRIG_NOW:
+    break;
+  case TRIG_TIMER:
+    /*  set a conter to generate adc trigger at convert_arg interval */
+    k =3D &encpriv[4];
+    tick =3D s626_ns_to_timer((int *) &cmd->convert_arg,
+        cmd->flags & TRIG_ROUND_MASK);
+
+    /* load timer value and enable interrupt */
+    s626_timer_load(s626ptr, k, tick);
+    k->SetEnable(s626ptr, k, CLKENAB_INDEX);
+    break;
+  case TRIG_EXT:
+    /*  set the digital line and interrupt for convert trigger */
+    if (cmd->scan_begin_src !=3D TRIG_EXT && cmd->start_src =3D=3D TRIG_EX=
T)
+      s626_dio_set_irq(s626ptr, cmd->convert_arg);
+    break;
+  }
+
+  switch (cmd->stop_src) {
+  case TRIG_COUNT:
+    /*  data arrives as one packet */
+    devpriv->ai_sample_count =3D cmd->stop_arg;
+    devpriv->ai_continous =3D 0;
+    break;
+  case TRIG_NONE:
+    /*  continous acquisition */
+    devpriv->ai_continous =3D 1;
+    devpriv->ai_sample_count =3D 1;
+    break;
+  }
+
+  ResetADC(s626ptr, ppl, cmd);
+
+  switch (cmd->start_src) {
+  case TRIG_NOW:
+    /*  Trigger ADC scan loop start by setting RPS Signal 0. */
+    /*  MC_ENABLE( P_MC2, MC2_ADC_RPS ); */
+
+    /*  Start executing the RPS program. */
+    MC_ENABLE(P_MC1, MC1_ERPS1);
+
+    subdev->trigger =3D NULL;
+    break;
+  case TRIG_EXT:
+    /* configure DIO channel for acquisition trigger */
+    s626_dio_set_irq(s626ptr, cmd->start_arg);
+
+    subdev->trigger =3D NULL;
+    break;
+  case TRIG_INT:
+    subdev->trigger =3D s626_ai_inttrig;
+    break;
+  }
+
+  /* enable interrupt */
+  writel(IRQ_GPIO3 | IRQ_RPS1, devpriv->base_addr + P_IER);
+
+  return 0;
+}
+
+#define TRIG_INVALID    0x00000000
+
+static inline int cfc_check_trigger_src(unsigned int *src, unsigned int
flags) {
+  unsigned int orig_src =3D *src;
+
+  *src =3D orig_src & flags;
+  if (*src =3D=3D TRIG_INVALID || *src !=3D orig_src)
+    return -EINVAL;
+  return 0;
+}
+
+static inline int cfc_check_trigger_is_unique(unsigned int src) {
+  /* this test is true if more than one _src bit is set */
+  if ((src & (src - 1)) !=3D 0)
+    return -EINVAL;
+  return 0;
+}
+
+static inline int cfc_check_trigger_arg_is(unsigned int *arg, unsigned int
val) {
+  if (*arg !=3D val) {
+    *arg =3D val;
+    return -EINVAL;
+  }
+  return 0;
+}
+
+static inline int cfc_check_trigger_arg_min(unsigned int *arg, unsigned
int val) {
+  if (*arg < val) {
+    *arg =3D val;
+    return -EINVAL;
+  }
+  return 0;
+}
+
+static inline int cfc_check_trigger_arg_max(unsigned int *arg, unsigned
int val) {
+  if (*arg > val) {
+    *arg =3D val;
+    return -EINVAL;
+  }
+  return 0;
+}
+
+static int s626_ai_cmdtest(struct a4l_subdevice * subdev, a4l_cmd_t * cmd)
{
+  int err =3D 0;
+  int tmp;
+
+  /* Step 1 : check if triggers are trivially valid */
+
+  err |=3D cfc_check_trigger_src(&cmd->start_src, TRIG_NOW | TRIG_INT |
TRIG_EXT);
+  err |=3D cfc_check_trigger_src(&cmd->scan_begin_src,
+      TRIG_TIMER | TRIG_EXT | TRIG_FOLLOW);
+  err |=3D cfc_check_trigger_src(&cmd->convert_src,
+      TRIG_TIMER | TRIG_EXT | TRIG_NOW);
+  err |=3D cfc_check_trigger_src(&cmd->scan_end_src, TRIG_COUNT);
+  err |=3D cfc_check_trigger_src(&cmd->stop_src, TRIG_COUNT | TRIG_NONE);
+
+  if (err)
+    return 1;
+
+  /* Step 2a : make sure trigger sources are unique */
+
+  err |=3D cfc_check_trigger_is_unique(cmd->start_src);
+  err |=3D cfc_check_trigger_is_unique(cmd->scan_begin_src);
+  err |=3D cfc_check_trigger_is_unique(cmd->convert_src);
+  err |=3D cfc_check_trigger_is_unique(cmd->stop_src);
+
+  /* Step 2b : and mutually compatible */
+
+  if (err)
+    return 2;
+
+  /* step 3: make sure arguments are trivially compatible */
+
+  if (cmd->start_src !=3D TRIG_EXT)
+    err |=3D cfc_check_trigger_arg_is(&cmd->start_arg, 0);
+  if (cmd->start_src =3D=3D TRIG_EXT)
+    err |=3D cfc_check_trigger_arg_max(&cmd->start_arg, 39);
+
+  if (cmd->scan_begin_src =3D=3D TRIG_EXT)
+    err |=3D cfc_check_trigger_arg_max(&cmd->scan_begin_arg, 39);
+
+  if (cmd->convert_src =3D=3D TRIG_EXT)
+    err |=3D cfc_check_trigger_arg_max(&cmd->convert_arg, 39);
+
+#define MAX_SPEED 200000  /* in nanoseconds */
+#define MIN_SPEED 2000000000  /* in nanoseconds */
+
+  if (cmd->scan_begin_src =3D=3D TRIG_TIMER) {
+    err |=3D cfc_check_trigger_arg_min(&cmd->scan_begin_arg, MAX_SPEED);
+    err |=3D cfc_check_trigger_arg_max(&cmd->scan_begin_arg, MIN_SPEED);
+  } else {
+    /* external trigger */
+    /* should be level/edge, hi/lo specification here */
+    /* should specify multiple external triggers */
+    /*    err |=3D cfc_check_trigger_arg_max(&cmd->scan_begin_arg, 9); */
+  }
+  if (cmd->convert_src =3D=3D TRIG_TIMER) {
+    err |=3D cfc_check_trigger_arg_min(&cmd->convert_arg, MAX_SPEED);
+    err |=3D cfc_check_trigger_arg_max(&cmd->convert_arg, MIN_SPEED);
+  } else {
+    /* external trigger */
+    /* see above */
+    /*    err |=3D cfc_check_trigger_arg_max(&cmd->scan_begin_arg, 9); */
+  }
+
+  err |=3D cfc_check_trigger_arg_is(&cmd->scan_end_arg, cmd->nb_chan);
+
+  if (cmd->stop_src =3D=3D TRIG_COUNT)
+    err |=3D cfc_check_trigger_arg_max(&cmd->stop_arg, 0x00ffffff);
+  else
+    /* TRIG_NONE */
+    err |=3D cfc_check_trigger_arg_is(&cmd->stop_arg, 0);
+
+  if (err)
+    return 3;
+
+  /* step 4: fix up any arguments */
+
+  if (cmd->scan_begin_src =3D=3D TRIG_TIMER) {
+    tmp =3D cmd->scan_begin_arg;
+    s626_ns_to_timer((int *) &cmd->scan_begin_arg,
+        cmd->flags & TRIG_ROUND_MASK);
+    if (tmp !=3D cmd->scan_begin_arg)
+      err++;
+  }
+  if (cmd->convert_src =3D=3D TRIG_TIMER) {
+    tmp =3D cmd->convert_arg;
+    s626_ns_to_timer((int *) &cmd->convert_arg, cmd->flags &
TRIG_ROUND_MASK);
+    if (tmp !=3D cmd->convert_arg)
+      err++;
+    if (cmd->scan_begin_src =3D=3D TRIG_TIMER
+        && cmd->scan_begin_arg < cmd->convert_arg * cmd->scan_end_arg) {
+      cmd->scan_begin_arg =3D cmd->convert_arg * cmd->scan_end_arg;
+      err++;
+    }
+  }
+
+  if (err)
+    return 4;
+
+  return 0;
+}
+
+static int s626_ai_cancel(struct a4l_subdevice * subdev) {
+  struct s626_priv *devpriv =3D NULL;
+  struct list_head *ptr;
+  struct s626_struct * s626ptr =3D NULL;
+
+  list_for_each( ptr, &s626_list) {
+    s626ptr =3D list_entry(ptr, struct s626_struct, list);
+    if (s626ptr->dev =3D=3D subdev->dev) {
+      devpriv =3D s626ptr->private;
+      break;
+    }
+  }
+
+  if (devpriv =3D=3D NULL) {
+    __a4l_err( "Inside %s, error, no device\n", __PRETTY_FUNCTION__);
+    return -ENODEV;
+  }
+
+  /*  Stop RPS program in case it is currently running. */
+  MC_DISABLE(P_MC1, MC1_ERPS1);
+
+  /* disable master interrupt */
+  writel(0, devpriv->base_addr + P_IER);
+
+  devpriv->ai_cmd_running =3D 0;
+
+  return 0;
+}
+
+static int s626_ao_winsn(a4l_subd_t *subd, a4l_kinsn_t *insn) {
+  struct s626_priv *devpriv =3D NULL;
+  struct list_head *ptr;
+  struct s626_struct * s626ptr =3D NULL;
+
+  struct s626_subd_ao_private *subdpriv =3D
+      (struct s626_subd_ao_private *) subd->priv;
+  uint16_t *data =3D (uint16_t *) insn->data;
+  int chan =3D CR_CHAN(insn->chan_desc);
+  int16_t dacdata;
+
+  list_for_each( ptr, &s626_list) {
+    s626ptr =3D list_entry(ptr, struct s626_struct, list);
+    if (s626ptr->dev =3D=3D subd->dev) {
+      devpriv =3D s626ptr->private;
+      break;
+    }
+  }
+
+  dacdata =3D (int16_t) data[0];
+  dacdata -=3D (0x1fff);
+
+  subdpriv->readback[chan] =3D dacdata;
+
+  SetDAC(s626ptr, chan, dacdata);
+
+  return 0;
+}
+
+static int s626_ao_rinsn(a4l_subd_t *subd, a4l_kinsn_t *insn) {
+  struct s626_subd_ao_private *subdpriv =3D
+      (struct s626_subd_ao_private *) subd->priv;
+  uint16_t *data =3D (uint16_t *) insn->data;
+  int chan =3D CR_CHAN(insn->chan_desc);
+
+  data[0] =3D subdpriv->readback[chan];
+
+  return 0;
+}
+
+/* *************** DIGITAL I/O FUNCTIONS ***************
+ * All DIO functions address a group of DIO channels by means of
+ * "group" argument.  group may be 0, 1 or 2, which correspond to DIO
+ * ports A, B and C, respectively.
+ */
+
+static void s626_dio_init(struct s626_struct * s626ptr) {
+  uint16_t group;
+  a4l_subd_t *s;
+
+  //  Prepare to treat writes to WRCapSel as capture disables.
+  DEBIwrite(s626ptr, LP_MISC1, MISC1_NOEDCAP);
+
+  //  For each group of sixteen channels ...
+  for (group =3D 0; group < S626_DIO_BANKS; group++) {
+    s =3D a4l_get_subd(s626ptr->dev, group + 2);
+    DEBIwrite(s626ptr,
+        ((struct s626_subd_dio_private *) (&(s->priv)))->WRIntSel, 0); //
Disable all interrupts.
+    DEBIwrite(s626ptr,
+        ((struct s626_subd_dio_private *) (&(s->priv)))->WRCapSel,
0xFFFF); //  Disable all event
+    //  captures.
+    DEBIwrite(s626ptr,
+        ((struct s626_subd_dio_private *) (&(s->priv)))->WREdgSel, 0); //
Init all DIOs to
+    //  default edge
+    //  polarity.
+    DEBIwrite(s626ptr, ((struct s626_subd_dio_private *)
(&(s->priv)))->WRDOut,
+        0); //  Program all outputs
+    //  to inactive state.
+  }
+}
+
+static int s626_dio_insn_config(a4l_subd_t *subd, a4l_kinsn_t *insn) {
+  struct s626_subd_dio_private *subdpriv =3D
+      (struct s626_subd_dio_private *) subd->priv;
+  unsigned int *data =3D (unsigned int *) insn->data;
+  int chan =3D CR_CHAN(insn->chan_desc);
+  int group, mask;
+
+  struct s626_priv *devpriv =3D NULL;
+  struct list_head *ptr;
+  struct s626_struct * s626ptr =3D NULL;
+
+  list_for_each( ptr, &s626_list) {
+    s626ptr =3D list_entry(ptr, struct s626_struct, list);
+    if (s626ptr->dev =3D=3D subd->dev) {
+      devpriv =3D s626ptr->private;
+      break;
+    }
+  }
+
+  group =3D chan >> 2;
+  mask =3D 0xF << (group << 2);
+
+  switch (data[0]) {
+  case A4L_INSN_CONFIG_DIO_OUTPUT:
+    subdpriv->state |=3D 1 << (group + 10); // bit 10/11 set the
+    // * group 1/2's mode
+    subdpriv->io_bits |=3D mask;
+    break;
+  case A4L_INSN_CONFIG_DIO_INPUT:
+    subdpriv->state &=3D ~(1 << (group + 10)); // 1 is output, 0 is
+    //  * input.
+    subdpriv->io_bits &=3D ~mask;
+    break;
+  case A4L_INSN_CONFIG_DIO_QUERY:
+    data[1] =3D (subdpriv->io_bits & mask) ? A4L_OUTPUT : A4L_INPUT;
+    return 0;
+  default:
+    return -EINVAL;
+  }
+
+  outw(subdpriv->state, ADDR_REG(REG_DIO));
+
+  return 0;
+}
+
+/* DIO devices are slightly special.  Although it is possible to
+ * implement the insn_read/insn_write interface, it is much more
+ * useful to applications if you implement the insn_bits interface.
+ * This allows packed reading/writing of the DIO channels.  The comedi
+ * core can convert between insn_bits and insn_read/write */
+
+static int s626_dio_insn_bits(a4l_subd_t *subd, a4l_kinsn_t *insn) {
+  /*
+   * The insn data consists of a mask in data[0] and the new data in
+   * data[1]. The mask defines which bits we are concerning about.
+   * The new data must be anded with the mask.  Each channel
+   * corresponds to a bit.
+   */
+
+  struct s626_priv *devpriv =3D NULL;
+  struct list_head *ptr;
+  struct s626_struct * s626ptr =3D NULL;
+
+  //a4l_dev_t *dev =3D subd->dev;
+  struct s626_subd_dio_private *subdpriv =3D
+      (struct s626_subd_dio_private *) subd->priv;
+  uint16_t *data =3D (uint16_t *) insn->data;
+
+  list_for_each( ptr, &s626_list) {
+    s626ptr =3D list_entry(ptr, struct s626_struct, list);
+    if (s626ptr->dev =3D=3D subd->dev) {
+      devpriv =3D s626ptr->private;
+      break;
+    }
+  }
+
+  if (data[0]) {
+    subdpriv->state &=3D ~data[0];
+    subdpriv->state |=3D data[0] & data[1];
+
+    // Write out the new digital output lines
+    DEBIwrite(s626ptr, subdpriv->WRDOut, subdpriv->state);
+  }
+  data[1] =3D DEBIread(s626ptr, subdpriv->RDDIn);
+
+  return 0;
+}
+
+static int s626_gpct_insn_config(a4l_subd_t *subd, a4l_kinsn_t *insn) {
+  a4l_dev_t *dev =3D subd->dev;
+  struct s626_subd_gpct_private *subdpriv =3D
+      (struct s626_subd_gpct_private *) subd->priv;
+  unsigned int *data =3D (unsigned int *) insn->data;
+  int subdev_channel =3D CR_CHAN(insn->chan_desc);
+  int i;
+
+  struct s626_priv *devpriv =3D NULL;
+  struct list_head *ptr;
+  struct s626_struct * s626ptr =3D NULL;
+
+  list_for_each( ptr, &s626_list) {
+    s626ptr =3D list_entry(ptr, struct s626_struct, list);
+    if (s626ptr->dev =3D=3D subd->dev) {
+      devpriv =3D s626ptr->private;
+      break;
+    }
+  }
+
+  a4l_dbg(1, drv_dbg, dev,
+      "s626_gpct_insn_config: Configuring Channel %d\n",
+      subdev_channel);
+
+  for (i =3D 0; i < MAX_GPCT_CONFIG_DATA; i++) {
+    subdpriv->config[subdev_channel].data[i] =3D data[i];
+    a4l_dbg(1, drv_dbg, dev, "data[%d]=3D%x\n", i, data[i]);
+  }
+
+  switch (data[0]) {
+  case A4L_INSN_CONFIG_GPCT_QUADRATURE_ENCODER: {
+    uint16_t Setup =3D (LOADSRC_INDX << BF_LOADSRC) | /*  Preload upon */
+    /*  index. */
+    (INDXSRC_SOFT << BF_INDXSRC) | /*  Disable hardware index. */
+    (CLKSRC_COUNTER << BF_CLKSRC) | /*  Operating mode is Counter. */
+    (CLKPOL_POS << BF_CLKPOL) | /*  Active high clock. */
+    /* ( CNTDIR_UP << BF_CLKPOL ) |      // Count direction is Down. */
+    (CLKMULT_1X << BF_CLKMULT) | /*  Clock multiplier is 1x. */
+    (CLKENAB_INDEX << BF_CLKENAB);
+    /*   uint16_t DisableIntSrc=3DTRUE; */
+    /*  uint32_t Preloadvalue;              //Counter initial value */
+    uint16_t valueSrclatch =3D LATCHSRC_AB_READ;
+    uint16_t enab =3D CLKENAB_ALWAYS;
+    struct enc_private *k =3D
+        &(subdpriv->enc_private_data[CR_CHAN(insn->chan_desc)]);
+
+    /*   (data=3D=3DNULL) ? (Preloadvalue=3D0) : (Preloadvalue=3Ddata[0]);=
 */
+
+    k->SetMode(s626ptr, k, Setup, TRUE);
+    Preload(s626ptr, k, data[1]);
+    k->PulseIndex(s626ptr, k);
+    SetLatchSource(s626ptr, k, valueSrclatch);
+    k->SetEnable(s626ptr, k, (uint16_t) (enab !=3D 0));
+    break;
+  }
+  default:
+    __a4l_err("s626_gpct_insn_config: unsupported GPCT_insn_config\n");
+    return -EINVAL;
+    break;
+  }
+
+  return 0;
+
+}
+
+static int s626_gpct_rinsn(a4l_subd_t *subd, a4l_kinsn_t *insn) {
+  uint32_t *data =3D (uint32_t *) insn->data;
+  struct s626_subd_gpct_private *subdpriv =3D
+      (struct s626_subd_gpct_private *) subd->priv;
+  int i;
+  struct enc_private *k =3D
+      &(subdpriv->enc_private_data[CR_CHAN(insn->chan_desc)]);
+
+  struct s626_priv *devpriv =3D NULL;
+  struct list_head *ptr;
+  struct s626_struct * s626ptr =3D NULL;
+
+  list_for_each( ptr, &s626_list) {
+    s626ptr =3D list_entry(ptr, struct s626_struct, list);
+    if (s626ptr->dev =3D=3D subd->dev) {
+      devpriv =3D s626ptr->private;
+      break;
+    }
+  }
+
+  if (insn->data_size <=3D 0) {
+    __a4l_err("s626_gpct_rinsn: data size should be > 0\n");
+    return -EINVAL;
+  }
+
+  for (i =3D 0; i < insn->data_size / sizeof(uint32_t); i++) {
+    data[i] =3D ReadLatch(s626ptr, k);
+  }
+
+  return 0;
+}
+
+static int s626_gpct_winsn(a4l_subd_t *subd, a4l_kinsn_t *insn) {
+  a4l_dev_t *dev =3D subd->dev;
+  struct s626_subd_gpct_private *subdpriv =3D
+      (struct s626_subd_gpct_private *) subd->priv;
+  uint32_t *data =3D (uint32_t *) insn->data;
+  int subdev_channel =3D CR_CHAN(insn->chan_desc);
+  short value;
+  union cmReg cmReg;
+
+  struct s626_priv *devpriv =3D NULL;
+  struct list_head *ptr;
+  struct s626_struct * s626ptr =3D NULL;
+
+  list_for_each( ptr, &s626_list) {
+    s626ptr =3D list_entry(ptr, struct s626_struct, list);
+    if (s626ptr->dev =3D=3D subd->dev) {
+      devpriv =3D s626ptr->private;
+      break;
+    }
+  }
+
+  a4l_dbg(1, drv_dbg, dev,
+      "s626_gpct_winsn: GPCT_INSN_WRITE on channel %d\n",
+      subdev_channel);
+
+  cmReg.value =3D inw(ADDR_CHAN_REG(REG_C0M, subdev_channel));
+  a4l_dbg(1, drv_dbg, dev,
+      "s626_gpct_winsn: Counter Mode Register: %x\n", cmReg.value);
+
+  /* Check what Application of Counter this channel is configured for */
+  switch (subdpriv->config[subdev_channel].app) {
+  case PositionMeasurement:
+    a4l_dbg(1, drv_dbg, dev, "s626_gpct_winsn: INSN_WRITE: PM\n");
+    outw(0xFFFF & ((*data) >> 16), ADDR_CHAN_REG(REG_C0H,
+        subdev_channel));
+    outw(0xFFFF & (*data), ADDR_CHAN_REG(REG_C0L, subdev_channel));
+    break;
+
+  case SinglePulseGeneration:
+    a4l_dbg(1, drv_dbg, dev, "s626_gpct_winsn: INSN_WRITE: SPG\n");
+    outw(0xFFFF & ((*data) >> 16), ADDR_CHAN_REG(REG_C0H,
+        subdev_channel));
+    outw(0xFFFF & (*data), ADDR_CHAN_REG(REG_C0L, subdev_channel));
+    break;
+
+  case PulseTrainGeneration:
+    /*
+     * data[0] contains the PULSE_WIDTH
+     * data[1] contains the PULSE_PERIOD
+     * @pre PULSE_PERIOD > PULSE_WIDTH > 0
+     * The above periods must be expressed as a multiple of the
+     * pulse frequency on the selected source
+     */
+    a4l_dbg(1, drv_dbg, dev, "s626_gpct_winsn: INSN_WRITE: PTG\n");
+    if ((data[1] > data[0]) && (data[0] > 0)) {
+      (subdpriv->config[subdev_channel]).data[0] =3D data[0];
+      (subdpriv->config[subdev_channel]).data[1] =3D data[1];
+    } else {
+      __a4l_err(
+          "s626_gpct_winsn: INSN_WRITE: PTG: Problem with Pulse params ->
%du %du\n",
+          data[0], data[1]);
+      return -EINVAL;
+    }
+
+    value =3D (short) ((*data >> 16) & 0xFFFF);
+    outw(value, ADDR_CHAN_REG(REG_C0H, subdev_channel));
+    value =3D (short) (*data & 0xFFFF);
+    outw(value, ADDR_CHAN_REG(REG_C0L, subdev_channel));
+    break;
+  default: /* Impossible */
+    __a4l_err(
+        "s626_gpct_winsn: INSN_WRITE: Functionality %d not implemented
yet\n",
+        subdpriv->config[subdev_channel].app);
+    return -EINVAL;
+  }
+
+  return 0;
+}
+
+/* --- Channels descriptor --- */
+
+static a4l_chdesc_t s626_chan_desc_ai =3D { .mode =3D A4L_CHAN_GLOBAL_CHAN=
DESC,
+    .length =3D S626_AI_CHANS, .chans =3D
+        { { A4L_CHAN_AREF_GROUND, S626_AI_BITS }, }, };
+
+static a4l_chdesc_t s626_chan_desc_ao =3D { .mode =3D A4L_CHAN_GLOBAL_CHAN=
DESC,
+    .length =3D S626_AO_CHANS, .chans =3D
+        { { A4L_CHAN_AREF_GROUND, S626_AO_BITS }, }, };
+
+static a4l_chdesc_t s626_chan_desc_dioA =3D { .mode =3D
A4L_CHAN_GLOBAL_CHANDESC,
+    .length =3D S626_DIO_CHANS, .chans =3D
+        { { A4L_CHAN_AREF_GROUND, S626_DIO_BITS }, }, };
+
+static a4l_chdesc_t s626_chan_desc_dioB =3D { .mode =3D
A4L_CHAN_GLOBAL_CHANDESC,
+    .length =3D S626_DIO_CHANS, .chans =3D
+        { { A4L_CHAN_AREF_GROUND, S626_DIO_BITS }, }, };
+
+static a4l_chdesc_t s626_chan_desc_dioC =3D { .mode =3D
A4L_CHAN_GLOBAL_CHANDESC,
+    .length =3D S626_DIO_CHANS, .chans =3D
+        { { A4L_CHAN_AREF_GROUND, S626_DIO_BITS }, }, };
+
+static a4l_chdesc_t s626_chan_desc_gpct =3D { .mode =3D
A4L_CHAN_GLOBAL_CHANDESC,
+    .length =3D S626_GPCT_CHANS, .chans =3D {
+        { A4L_CHAN_AREF_GROUND, S626_GPCT_BITS }, }, };
+
+/* --- Subdevice initialization functions --- */
+
+/* Analog input subdevice */
+static void setup_subd_ai(a4l_subd_t *subd) {
+  subd->flags =3D A4L_SUBD_AI | A4L_SUBD_MASK_READ;
+  subd->chan_desc =3D &s626_chan_desc_ai;
+  subd->rng_desc =3D &a4l_range_bipolar10;
+
+  subd->insn_config =3D s626_ai_insn_config;
+  subd->insn_read =3D s626_ai_insn_read;
+  subd->do_cmd =3D s626_ai_cmd;
+  subd->do_cmdtest =3D s626_ai_cmdtest;
+  subd->cancel =3D s626_ai_cancel;
+}
+
+/* Analog output subdevice */
+static void setup_subd_ao(a4l_subd_t *subd) {
+  subd->flags =3D A4L_SUBD_AO | A4L_SUBD_MASK_WRITE;
+  subd->chan_desc =3D &s626_chan_desc_ao;
+  subd->rng_desc =3D &a4l_range_bipolar10;
+
+  subd->insn_write =3D s626_ao_winsn;
+  subd->insn_read =3D s626_ao_rinsn;
+
+  memset(&(subd->priv), 0, sizeof(struct s626_subd_ao_private));
+}
+
+/* Digital i/o subdevice */
+static void setup_subd_dioA(a4l_subd_t *subd) {
+  subd->flags =3D A4L_SUBD_DIO;
+  subd->chan_desc =3D &s626_chan_desc_dioA;
+  subd->rng_desc =3D &range_digital;
+  subd->insn_bits =3D s626_dio_insn_bits;
+  subd->insn_config =3D s626_dio_insn_config;
+  memcpy(&(subd->priv), (const void *) (&s626_subd_dio_private_A),
+      sizeof(struct s626_subd_dio_private));
+}
+static void setup_subd_dioB(a4l_subd_t *subd) {
+  subd->flags =3D A4L_SUBD_DIO;
+  subd->chan_desc =3D &s626_chan_desc_dioB;
+  subd->rng_desc =3D &range_digital;
+  subd->insn_bits =3D s626_dio_insn_bits;
+  subd->insn_config =3D s626_dio_insn_config;
+  memcpy(&(subd->priv), (const void *) (&s626_subd_dio_private_B),
+      sizeof(struct s626_subd_dio_private));
+}
+static void setup_subd_dioC(a4l_subd_t *subd) {
+  subd->flags =3D A4L_SUBD_DIO;
+  subd->chan_desc =3D &s626_chan_desc_dioC;
+  subd->rng_desc =3D &range_digital;
+  subd->insn_bits =3D s626_dio_insn_bits;
+  subd->insn_config =3D s626_dio_insn_config;
+  memcpy(&(subd->priv), (const void *) (&s626_subd_dio_private_C),
+      sizeof(struct s626_subd_dio_private));
+}
+
+/* General purpose counter/timer (gpct) */
+static void setup_subd_gpct(a4l_subd_t *subd) {
+  subd->flags =3D A4L_SUBD_COUNTER;
+  subd->chan_desc =3D &s626_chan_desc_gpct;
+  subd->insn_read =3D s626_gpct_rinsn;
+  subd->insn_config =3D s626_gpct_insn_config;
+  subd->insn_write =3D s626_gpct_winsn;
+
+  //only the first field of the private structure for this subdevice
+  memcpy(&(subd->priv), (const void *) (&enc_private_data_init[0]),
+      sizeof(struct enc_private) * S626_GPCT_CHANS);
+}
+
+static struct setup_subd setup_subds[6] =3D { { .setup_func =3D setup_subd=
_ai,
+    .sizeof_priv =3D sizeof(struct s626_subd_ai_private), }, { .setup_func=
 =3D
+    setup_subd_ao, .sizeof_priv =3D sizeof(struct s626_subd_ao_private), }=
, {
+    .setup_func =3D setup_subd_dioA, .sizeof_priv =3D
+        sizeof(struct s626_subd_dio_private), }, {
+    .setup_func =3D setup_subd_dioB, .sizeof_priv =3D
+        sizeof(struct s626_subd_dio_private), }, {
+    .setup_func =3D setup_subd_dioC, .sizeof_priv =3D
+        sizeof(struct s626_subd_dio_private), }, {
+    .setup_func =3D setup_subd_gpct, .sizeof_priv =3D
+        sizeof(struct s626_subd_gpct_private), }, };
+
+static void CountersInit(struct s626_struct * s626ptr) {
+  int chan;
+  struct enc_private *k;
+  uint16_t Setup =3D (LOADSRC_INDX << BF_LOADSRC) | //  Preload upon
+      //  index.
+      (INDXSRC_SOFT << BF_INDXSRC) | //  Disable hardware index.
+      (CLKSRC_COUNTER << BF_CLKSRC) | //  Operating mode is counter.
+      (CLKPOL_POS << BF_CLKPOL) | //  Active high clock.
+      (CNTDIR_UP << BF_CLKPOL) | //  Count direction is up.
+      (CLKMULT_1X << BF_CLKMULT) | //  Clock multiplier is 1x.
+      (CLKENAB_INDEX << BF_CLKENAB); //  Enabled by index
+
+  //  Disable all counter interrupts and clear any captured counter events.
+  for (chan =3D 0; chan < S626_ENCODER_CHANNELS; chan++) {
+
+    k =3D &(((struct s626_subd_gpct_private *) (a4l_get_subd(s626ptr->dev,
+        SUBD_ENC)->priv))->enc_private_data[chan]); // &encpriv[chan];
+
+    k->SetMode(s626ptr, k, Setup, TRUE);
+    k->SetIntSrc(s626ptr, k, 0);
+    k->ResetCapFlags(s626ptr, k);
+    k->SetEnable(s626ptr, k, CLKENAB_ALWAYS);
+  }
+}
+
+static void s626_initialize(struct s626_struct * s626ptr) {
+  struct s626_priv *devpriv =3D s626ptr->private;
+  dma_addr_t pPhysBuf;
+  uint16_t chan;
+  int i;
+
+  /* Enable DEBI and audio pins, enable I2C interface */
+  MC_ENABLE(P_MC1, MC1_DEBI | MC1_AUDIO | MC1_I2C);
+
+  /*
+   *  Configure DEBI operating mode
+   *
+   *   Local bus is 16 bits wide
+   *   Declare DEBI transfer timeout interval
+   *   Set up byte lane steering
+   *   Intel-compatible local bus (DEBI never times out)
+   */
+  WR7146(P_DEBICFG,
+      DEBI_CFG_SLAVE16 | (DEBI_TOUT << DEBI_CFG_TOUT_BIT) | DEBI_SWAP |
DEBI_CFG_INTEL);
+
+  /* Disable MMU paging */
+  WR7146(P_DEBIPAGE, DEBI_PAGE_DISABLE);
+
+  /* Init GPIO so that ADC Start* is negated */
+  WR7146(P_GPIO, GPIO_BASE | GPIO1_HI);
+
+  /* I2C device address for onboard eeprom (revb) */
+  devpriv->I2CAdrs =3D 0xA0;
+
+  /*
+   * Issue an I2C ABORT command to halt any I2C
+   * operation in progress and reset BUSY flag.
+   */
+  WR7146(P_I2CSTAT, I2C_CLKSEL | I2C_ABORT);
+  MC_ENABLE(P_MC2, MC2_UPLD_IIC);
+  while ((RR7146(P_MC2) & MC2_UPLD_IIC) =3D=3D 0)
+    ;
+
+  /*
+   * Per SAA7146 data sheet, write to STATUS
+   * reg twice to reset all  I2C error flags.
+   */
+  for (i =3D 0; i < 2; i++) {
+    WR7146(P_I2CSTAT, I2C_CLKSEL);
+    MC_ENABLE(P_MC2, MC2_UPLD_IIC);
+    while (!MC_TEST(P_MC2, MC2_UPLD_IIC))
+      ;
+  }
+
+  /*
+   * Init audio interface functional attributes: set DAC/ADC
+   * serial clock rates, invert DAC serial clock so that
+   * DAC data setup times are satisfied, enable DAC serial
+   * clock out.
+   */
+  WR7146(P_ACON2, ACON2_INIT);
+
+  /*
+   * Set up TSL1 slot list, which is used to control the
+   * accumulation of ADC data: RSD1 =3D shift data in on SD1.
+   * SIB_A1  =3D store data uint8_t at next available location
+   * in FB BUFFER1 register.
+   */
+  WR7146(P_TSL1, RSD1 | SIB_A1);
+  WR7146(P_TSL1 + 4, RSD1 | SIB_A1 | EOS);
+
+  /* Enable TSL1 slot list so that it executes all the time */
+  WR7146(P_ACON1, ACON1_ADCSTART);
+
+  /*
+   * Initialize RPS registers used for ADC
+   */
+
+  /* Physical start of RPS program */
+  WR7146(P_RPSADDR1, (uint32_t)devpriv->RPSBuf.PhysicalBase);
+  /* RPS program performs no explicit mem writes */
+  WR7146(P_RPSPAGE1, 0);
+  /* Disable RPS timeouts */
+  WR7146(P_RPS1_TOUT, 0);
+
+#if 0
+  /*
+   * SAA7146 BUG WORKAROUND
+   *
+   * Initialize SAA7146 ADC interface to a known state by
+   * invoking ADCs until FB BUFFER 1 register shows that it
+   * is correctly receiving ADC data. This is necessary
+   * because the SAA7146 ADC interface does not start up in
+   * a defined state after a PCI reset.
+   */
+
+  {
+    uint8_t PollList;
+    uint16_t AdcData;
+    uint16_t StartVal;
+    uint16_t index;
+    unsigned int data[16];
+
+    /* Create a simple polling list for analog input channel 0 */
+    PollList =3D EOPL;
+    ResetADC(dev, &PollList);
+
+    /* Get initial ADC value */
+    s626_ai_rinsn(dev, dev->subdevices, NULL, data);
+    StartVal =3D data[0];
+
+    /*
+     * VERSION 2.01 CHANGE: TIMEOUT ADDED TO PREVENT HANGED EXECUTION.
+     *
+     * Invoke ADCs until the new ADC value differs from the initial
+     * value or a timeout occurs.  The timeout protects against the
+     * possibility that the driver is restarting and the ADC data is a
+     * fixed value resulting from the applied ADC analog input being
+     * unusually quiet or at the rail.
+     */
+    for (index =3D 0; index < 500; index++) {
+      s626_ai_rinsn(dev, dev->subdevices, NULL, data);
+      AdcData =3D data[0];
+      if (AdcData !=3D StartVal)
+      break;
+    }
+
+  }
+#endif  /* SAA7146 BUG WORKAROUND */
+
+  /*
+   * Initialize the DAC interface
+   */
+
+  /*
+   * Init Audio2's output DMAC attributes:
+   *   burst length =3D 1 DWORD
+   *   threshold =3D 1 DWORD.
+   */
+  WR7146(P_PCI_BT_A, 0);
+
+  /*
+   * Init Audio2's output DMA physical addresses.  The protection
+   * address is set to 1 DWORD past the base address so that a
+   * single DWORD will be transferred each time a DMA transfer is
+   * enabled.
+   */
+  pPhysBuf =3D devpriv->ANABuf.PhysicalBase + (DAC_WDMABUF_OS *
sizeof(uint32_t));
+  WR7146(P_BASEA2_OUT, (uint32_t) pPhysBuf);
+  WR7146(P_PROTA2_OUT, (uint32_t) (pPhysBuf + sizeof(uint32_t)));
+
+  /*
+   * Cache Audio2's output DMA buffer logical address.  This is
+   * where DAC data is buffered for A2 output DMA transfers.
+   */
+  devpriv->pDacWBuf =3D (uint32_t *) devpriv->ANABuf.LogicalBase +
DAC_WDMABUF_OS;
+
+  /*
+   * Audio2's output channels does not use paging.  The
+   * protection violation handling bit is set so that the
+   * DMAC will automatically halt and its PCI address pointer
+   * will be reset when the protection address is reached.
+   */
+  WR7146(P_PAGEA2_OUT, 8);
+
+  /*
+   * Initialize time slot list 2 (TSL2), which is used to control
+   * the clock generation for and serialization of data to be sent
+   * to the DAC devices.  Slot 0 is a NOP that is used to trap TSL
+   * execution; this permits other slots to be safely modified
+   * without first turning off the TSL sequencer (which is
+   * apparently impossible to do).  Also, SD3 (which is driven by a
+   * pull-up resistor) is shifted in and stored to the MSB of
+   * FB_BUFFER2 to be used as evidence that the slot sequence has
+   * not yet finished executing.
+   */
+
+  /* Slot 0: Trap TSL execution, shift 0xFF into FB_BUFFER2 */
+  SETVECT(0, XSD2 | RSD3 | SIB_A2 | EOS);
+
+  /*
+   * Initialize slot 1, which is constant.  Slot 1 causes a
+   * DWORD to be transferred from audio channel 2's output FIFO
+   * to the FIFO's output buffer so that it can be serialized
+   * and sent to the DAC during subsequent slots.  All remaining
+   * slots are dynamically populated as required by the target
+   * DAC device.
+   */
+
+  /* Slot 1: Fetch DWORD from Audio2's output FIFO */
+  SETVECT(1, LF_A2);
+
+  /* Start DAC's audio interface (TSL2) running */
+  WR7146(P_ACON1, ACON1_DACSTART);
+
+  /*
+   * Init Trim DACs to calibrated values.  Do it twice because the
+   * SAA7146 audio channel does not always reset properly and
+   * sometimes causes the first few TrimDAC writes to malfunction.
+   */
+  LoadTrimDACs(s626ptr);
+  LoadTrimDACs(s626ptr);
+
+  /*
+   * Manually init all gate array hardware in case this is a soft
+   * reset (we have no way of determining whether this is a warm
+   * or cold start).  This is necessary because the gate array will
+   * reset only in response to a PCI hard reset; there is no soft
+   * reset function.
+   */
+
+  /*
+   * Init all DAC outputs to 0V and init all DAC setpoint and
+   * polarity images.
+   */
+  for (chan =3D 0; chan < S626_DAC_CHANNELS; chan++)
+    SetDAC(s626ptr, chan, 0);
+
+  /* Init counters */
+  CountersInit(s626ptr);
+
+  /*
+   * Without modifying the state of the Battery Backup enab, disable
+   * the watchdog timer, set DIO channels 0-5 to operate in the
+   * standard DIO (vs. counter overflow) mode, disable the battery
+   * charger, and reset the watchdog interval selector to zero.
+   */
+  WriteMISC2(s626ptr,
+      (uint16_t) (DEBIread(s626ptr, LP_RDMISC2) & MISC2_BATT_ENABLE));
+
+  /* Initialize the digital I/O subsystem */
+
+  s626_dio_init(s626ptr);
+
+  /* enable interrupt test */
+  /* writel(IRQ_GPIO3 | IRQ_RPS1, devpriv->base_addr + P_IER); */
+}
+
+static int dev_s626_attach(a4l_dev_t *dev, a4l_lnkdesc_t *arg) {
+
+  int i, err =3D 0;
+  struct s626_struct * s626ptr =3D NULL;
+
+  a4l_info(dev, "Attaching s626\n");
+
+  s626ptr =3D kmalloc(sizeof(struct s626_struct), GFP_KERNEL);
+  if (s626ptr =3D=3D NULL) {
+    __a4l_err("No memory for s626 structure\n");
+    return -ENOMEM;
+  }
+
+  //zero whole struct
+  memset(s626ptr, 0x00, sizeof(struct s626_struct));
+
+  s626ptr->dev =3D dev;
+
+  //init lock
+  a4l_lock_init(&s626ptr->lock);
+
+  s626ptr->private =3D kmalloc(sizeof(struct s626_priv), GFP_KERNEL);
+  if (s626ptr->private =3D=3D NULL) {
+    __a4l_err("No memory for s626 private data\n");
+    return -ENOMEM;
+  }
+
+  //add item to the list
+  list_add(&(s626ptr->list), &s626_list);
+
+  err =3D pci_register_driver(&drv_pci_s626);
+
+  if (err < 0) {
+    __a4l_err("pci_register_driver =3D %d\n", err);
+    return -ENOMEM;
+  }
+
+  pci_set_master(s626ptr->pcidev);
+
+  err =3D pci_request_regions(s626ptr->pcidev, dev->driver->board_name);
+
+  if (err < 0) {
+    __a4l_err( "Can't request regions\n");
+    pci_disable_device(s626ptr->pcidev);
+    return -ENOMEM;
+  }
+
+  s626ptr->private->base_addr =3D ioremap(pci_resource_start(
s626ptr->pcidev, 0),
+      pci_resource_len( s626ptr->pcidev, 0));
+
+  if (s626ptr->private->base_addr =3D=3D NULL) {
+    return -ENOMEM;
+  }
+
+  //disable master interrupt
+  writel(0, s626ptr->private->base_addr + P_IER);
+
+  // soft reset
+  writel(MC1_SOFT_RESET, s626ptr->private->base_addr + P_MC1);
+
+  // DMA FIXME DMA
+  err =3D s626_allocate_dma_buffers(s626ptr);
+  if (err) {
+    return err;
+  }
+
+  if (s626ptr->pcidev->irq) {
+    err =3D a4l_request_irq(dev, s626ptr->pcidev->irq, s626_irq_handler,
+        A4L_IRQ_SHARED, dev);
+
+    if (err < 0)
+      return err;
+  }
+
+  /* Allocate the subdevice structures. */
+  for (i =3D 0; i < 6; ++i) {
+    a4l_subd_t *subd =3D a4l_alloc_subd(setup_subds[i].sizeof_priv,
+        setup_subds[i].setup_func);
+
+    if (subd =3D=3D NULL)
+      return -ENOMEM;
+
+    err =3D a4l_add_subd(dev, subd);
+    if (err !=3D i)
+      return err;
+  }
+
+  // Running initialization
+  s626_initialize(s626ptr);
+
+  return 0;
+
+}
+
+static int dev_s626_detach(a4l_dev_t *dev) {
+  struct list_head *ptr;
+  struct s626_struct * s626ptr =3D NULL;
+  struct s626_priv *devpriv =3D NULL;
+
+  a4l_info(dev, "Detaching s626\n");
+
+  list_for_each( ptr, &s626_list) {
+    s626ptr =3D list_entry(ptr, struct s626_struct, list);
+    if (s626ptr->dev =3D=3D dev) {
+      devpriv =3D s626ptr->private;
+      break;
+    }
+  }
+
+  if (devpriv =3D=3D NULL) {
+    __a4l_err( "Inside %s, error, no device\n", __PRETTY_FUNCTION__);
+    return -ENODEV;
+  }
+
+  if (s626ptr->private) {
+    /* stop ai_command */
+    s626ptr->private->ai_cmd_running =3D 0;
+
+    if (s626ptr->private->base_addr) {
+      /* interrupt mask */
+      WR7146(P_IER, 0);
+      /*  Disable master interrupt. */
+      WR7146(P_ISR, IRQ_GPIO3 | IRQ_RPS1);
+      /*  Clear board's IRQ status flag. */
+
+      /*  Disable the watchdog timer and battery charger. */
+      WriteMISC2(s626ptr, 0);
+
+      /*  Close all interfaces on 7146 device. */
+      WR7146(P_MC1, MC1_SHUTDOWN);
+      WR7146(P_ACON1, ACON1_BASE);
+
+      CloseDMAB(s626ptr, &s626ptr->private->RPSBuf, DMABUF_SIZE);
+      CloseDMAB(s626ptr, &s626ptr->private->ANABuf, DMABUF_SIZE);
+    }
+
+    if (a4l_get_irq(dev) !=3D A4L_IRQ_UNUSED)
+      a4l_free_irq(dev, a4l_get_irq(dev));
+
+    if (s626ptr->private->base_addr)
+      iounmap(s626ptr->private->base_addr);
+  }
+
+  pci_release_regions(s626ptr->pcidev);
+  pci_disable_device(s626ptr->pcidev);
+
+  pci_unregister_driver(&drv_pci_s626);
+
+  if (s626ptr->private)
+    kfree(s626ptr->private);
+
+  list_del(&(s626ptr->list));
+
+  kfree(s626ptr);
+
+  return 0;
+}
+
+static int s626_pci_probe(struct pci_dev *dev, const struct pci_device_id
*ent) {
+  struct list_head *ptr;
+  struct s626_struct * s626ptr =3D NULL;
+  int err =3D 0;
+
+  //try to enable device on PCI
+  if (pci_enable_device(dev) < 0) {
+    __a4l_err("error enabling s626\n");
+    err =3D -EIO;
+  }
+
+  list_for_each( ptr, &s626_list) {
+    s626ptr =3D list_entry(ptr, struct s626_struct, list);
+    if (s626ptr->pcidev =3D=3D NULL) {
+      s626ptr->pcidev =3D dev;
+    }
+  }
+
+  return err;
+}
+
+static void s626_pci_remove(struct pci_dev *dev) {
+}
+
+static a4l_drv_t drv_s626 =3D { .owner =3D THIS_MODULE, .board_name =3D "S=
626",
+    .attach =3D dev_s626_attach, .detach =3D dev_s626_detach, .privdata_si=
ze =3D
+        sizeof(struct s626_priv), };
+
+static int __init drv_s626_init(void) {
+  return a4l_register_drv(&drv_s626);
+}
+
+static void __exit drv_s626_cleanup(void) {
+  a4l_unregister_drv(&drv_s626);
+}
+
+MODULE_DESCRIPTION("Analogy driver for Sensoray Model 626 board.");
+MODULE_LICENSE("GPL");
+
+module_init(drv_s626_init);
+module_exit(drv_s626_cleanup);
+
diff --git a/ksrc/drivers/analogy/sensoray/s626.h
b/ksrc/drivers/analogy/sensoray/s626.h
new file mode 100755
index 0000000..feb2f86
--- /dev/null
+++ b/ksrc/drivers/analogy/sensoray/s626.h
@@ -0,0 +1,1136 @@
+/*
+ comedi/drivers/s626.h
+ Sensoray s626 Comedi driver, header file
+
+ COMEDI - Linux Control and Measurement Device Interface
+ Copyright (C) 2000 David A. Schleef <ds@schleef.org>
+
+ Based on Sensoray Model 626 Linux driver Version 0.2
+ Copyright (C) 2002-2004 Sensoray Co., Inc.
+
+ This program is free software; you can redistribute it and/or modify
+ it under the terms of the GNU General Public License as published by
+ the Free Software Foundation; either version 2 of the License, or
+ (at your option) any later version.
+
+ This program is distributed in the hope that it will be useful,
+ but WITHOUT ANY WARRANTY; without even the implied warranty of
+ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ GNU General Public License for more details.
+
+ You should have received a copy of the GNU General Public License
+ along with this program; if not, write to the Free Software
+ Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+
+ */
+
+/*
+ Driver: s626.o (s626.ko)
+ Description: Sensoray 626 driver
+ Devices: Sensoray s626
+ Authors: Gianluca Palli <gpalli@deis.unibo.it>,
+ Updated: Thu, 12 Jul 2005
+ Status: experimental
+
+ Configuration Options:
+ analog input:
+ none
+
+ analog output:
+ none
+
+ digital channel:
+ s626 has 3 dio subdevices (2,3 and 4) each with 16 i/o channels
+ supported configuration options:
+ INSN_CONFIG_DIO_QUERY
+ COMEDI_INPUT
+ COMEDI_OUTPUT
+
+ encoder:
+ Every channel must be configured before reading.
+
+ Example code
+
+ insn.insn=3DINSN_CONFIG;   // configuration instruction
+ insn.n=3D1;                // number of operation (must be 1)
+ insn.data=3D&initialvalue; // initial value loaded into encoder
+ // during configuration
+ insn.subdev=3D5;           // encoder subdevice
+ insn.chanspec=3DCR_PACK(encoder_channel,0,AREF_OTHER); // encoder_channel
+ // to configure
+
+ comedi_do_insn(cf,&insn); // executing configuration
+ */
+
+#if !defined(TRUE)
+#define TRUE    (1)
+#endif
+
+#if !defined(FALSE)
+#define FALSE   (0)
+#endif
+
+#include <linux/slab.h>
+
+#define S626_SIZE 0x0200
+#define DMABUF_SIZE            4096    /*  4k pages */
+
+#define S626_ADC_CHANNELS       16
+#define S626_DAC_CHANNELS       4
+#define S626_ENCODER_CHANNELS   6
+#define S626_DIO_CHANNELS       48
+#define S626_DIO_BANKS        3    /*  Number of DIO groups. */
+#define S626_DIO_EXTCHANS    40    /*  Number of */
+/*  extended-capability */
+/*  DIO channels. */
+
+#define NUM_TRIMDACS    12    /*  Number of valid TrimDAC channels. */
+
+/*  PCI bus interface types. */
+#define INTEL                1    /*  Intel bus type. */
+#define MOTOROLA            2    /*  Motorola bus type. */
+
+#define PLATFORM        INTEL    /*  *** SELECT PLATFORM TYPE *** */
+
+#define RANGE_5V                0x10    /*  +/-5V range */
+#define RANGE_10V               0x00    /*  +/-10V range */
+
+#define EOPL            0x80    /*  End of ADC poll list marker. */
+#define GSEL_BIPOLAR5V        0x00F0    /*  LP_GSEL setting for 5V bipolar
range. */
+#define GSEL_BIPOLAR10V        0x00A0    /*  LP_GSEL setting for 10V
bipolar range. */
+
+/*  Error codes that must be visible to this base class. */
+#define ERR_ILLEGAL_PARM    0x00010000    /*  Illegal function parameter
value was specified. */
+#define ERR_I2C            0x00020000    /*  I2C error. */
+#define ERR_COUNTERSETUP    0x00200000    /*  Illegal setup specified for
counter channel. */
+#define ERR_DEBI_TIMEOUT    0x00400000    /*  DEBI transfer timed out. */
+
+/*  Organization (physical order) and size (in DWORDs) of logical DMA
buffers contained by ANA_DMABUF. */
+#define ADC_DMABUF_DWORDS    40    /*  ADC DMA buffer must hold 16
samples, plus pre/post garbage samples. */
+#define DAC_WDMABUF_DWORDS    1    /*  DAC output DMA buffer holds a
single sample. */
+
+/*  All remaining space in 4KB DMA buffer is available for the RPS1
program. */
+
+/*  Address offsets, in DWORDS, from base of DMA buffer. */
+#define DAC_WDMABUF_OS        ADC_DMABUF_DWORDS
+
+/*  Interrupt enab bit in ISR and IER. */
+#define IRQ_GPIO3        0x00000040    /*  IRQ enable for GPIO3. */
+#define IRQ_RPS1                0x10000000
+#define ISR_AFOU        0x00000800
+/* Audio fifo under/overflow  detected. */
+
+#define IRQ_COINT1A             0x0400    /* conter 1A overflow interrupt
mask */
+#define IRQ_COINT1B             0x0800    /* conter 1B overflow interrupt
mask */
+#define IRQ_COINT2A             0x1000    /* conter 2A overflow interrupt
mask */
+#define IRQ_COINT2B             0x2000    /* conter 2B overflow interrupt
mask */
+#define IRQ_COINT3A             0x4000    /* conter 3A overflow interrupt
mask */
+#define IRQ_COINT3B             0x8000    /* conter 3B overflow interrupt
mask */
+
+/*  RPS command codes. */
+#define RPS_CLRSIGNAL        0x00000000    /*  CLEAR SIGNAL */
+#define RPS_SETSIGNAL        0x10000000    /*  SET SIGNAL */
+#define RPS_NOP            0x00000000    /*  NOP */
+#define RPS_PAUSE        0x20000000    /*  PAUSE */
+#define RPS_UPLOAD        0x40000000    /*  UPLOAD */
+#define RPS_JUMP        0x80000000    /*  JUMP */
+#define RPS_LDREG        0x90000100    /*  LDREG (1 uint32_t only) */
+#define RPS_STREG        0xA0000100    /*  STREG (1 uint32_t only) */
+#define RPS_STOP        0x50000000    /*  STOP */
+#define RPS_IRQ                 0x60000000    /*  IRQ */
+
+#define RPS_LOGICAL_OR        0x08000000    /*  Logical OR conditionals. */
+#define RPS_INVERT        0x04000000    /*  Test for negated semaphores. */
+#define RPS_DEBI        0x00000002    /*  DEBI done */
+
+#define RPS_SIG0        0x00200000    /*  RPS semaphore 0 (used by ADC). */
+#define RPS_SIG1        0x00400000    /*  RPS semaphore 1 (used by DAC). */
+#define RPS_SIG2        0x00800000    /*  RPS semaphore 2 (not used). */
+#define RPS_GPIO2        0x00080000    /*  RPS GPIO2 */
+#define RPS_GPIO3        0x00100000    /*  RPS GPIO3 */
+
+#define RPS_SIGADC        RPS_SIG0    /*  Trigger/status for ADC's RPS
program. */
+#define RPS_SIGDAC        RPS_SIG1    /*  Trigger/status for DAC's RPS
program. */
+
+/*  RPS clock parameters. */
+#define RPSCLK_SCALAR        8    /*  This is apparent ratio of PCI/RPS
clks (undocumented!!). */
+#define RPSCLK_PER_US        (33 / RPSCLK_SCALAR)    /*  Number of RPS
clocks in one microsecond. */
+
+/*  Event counter source addresses. */
+#define SBA_RPS_A0        0x27    /*  Time of RPS0 busy, in PCI clocks. */
+
+/*  GPIO constants. */
+#define GPIO_BASE        0x10004000    /*  GPIO 0,2,3 =3D inputs, GPIO3 =
=3D
IRQ; GPIO1 =3D out. */
+#define GPIO1_LO        0x00000000    /*  GPIO1 set to LOW. */
+#define GPIO1_HI        0x00001000    /*  GPIO1 set to HIGH. */
+
+/*  Primary Status Register (PSR) constants. */
+#define PSR_DEBI_E        0x00040000    /*  DEBI event flag. */
+#define PSR_DEBI_S        0x00080000    /*  DEBI status flag. */
+#define PSR_A2_IN        0x00008000    /*  Audio output DMA2 protection
address reached. */
+#define PSR_AFOU        0x00000800    /*  Audio FIFO under/overflow
detected. */
+#define PSR_GPIO2        0x00000020    /*  GPIO2 input pin: 0=3DAdcBusy,
1=3DAdcIdle. */
+#define PSR_EC0S        0x00000001    /*  Event counter 0 threshold
reached. */
+
+/*  Secondary Status Register (SSR) constants. */
+#define SSR_AF2_OUT        0x00000200    /*  Audio 2 output FIFO
under/overflow detected. */
+
+/*  Master Control Register 1 (MC1) constants. */
+#define MC1_SOFT_RESET        0x80000000    /*  Invoke 7146 soft reset. */
+#define MC1_SHUTDOWN        0x3FFF0000    /*  Shut down all MC1-controlled
enables. */
+
+#define MC1_ERPS1        0x2000    /*  enab/disable RPS task 1. */
+#define MC1_ERPS0        0x1000    /*  enab/disable RPS task 0. */
+#define MC1_DEBI        0x0800    /*  enab/disable DEBI pins. */
+#define MC1_AUDIO        0x0200    /*  enab/disable audio port pins. */
+#define MC1_I2C            0x0100    /*  enab/disable I2C interface. */
+#define MC1_A2OUT        0x0008    /*  enab/disable transfer on A2 out. */
+#define MC1_A2IN        0x0004    /*  enab/disable transfer on A2 in. */
+#define MC1_A1IN        0x0001    /*  enab/disable transfer on A1 in. */
+
+/*  Master Control Register 2 (MC2) constants. */
+#define MC2_UPLD_DEBIq        0x00020002    /*  Upload DEBI registers. */
+#define MC2_UPLD_IICq        0x00010001    /*  Upload I2C registers. */
+#define MC2_RPSSIG2_ONq        0x20002000    /*  Assert RPS_SIG2. */
+#define MC2_RPSSIG1_ONq        0x10001000    /*  Assert RPS_SIG1. */
+#define MC2_RPSSIG0_ONq        0x08000800    /*  Assert RPS_SIG0. */
+#define MC2_UPLD_DEBI_MASKq    0x00000002    /*  Upload DEBI mask. */
+#define MC2_UPLD_IIC_MASKq    0x00000001    /*  Upload I2C mask. */
+#define MC2_RPSSIG2_MASKq    0x00002000    /*  RPS_SIG2 bit mask. */
+#define MC2_RPSSIG1_MASKq    0x00001000    /*  RPS_SIG1 bit mask. */
+#define MC2_RPSSIG0_MASKq    0x00000800    /*  RPS_SIG0 bit mask. */
+
+#define MC2_DELAYTRIG_4USq    MC2_RPSSIG1_ON
+#define MC2_DELAYBUSY_4USq    MC2_RPSSIG1_MASK
+
+#define    MC2_DELAYTRIG_6USq    MC2_RPSSIG2_ON
+#define MC2_DELAYBUSY_6USq    MC2_RPSSIG2_MASK
+
+#define MC2_UPLD_DEBI        0x0002    /*  Upload DEBI. */
+#define MC2_UPLD_IIC        0x0001    /*  Upload I2C. */
+#define MC2_RPSSIG2        0x2000    /*  RPS signal 2 (not used). */
+#define MC2_RPSSIG1        0x1000    /*  RPS signal 1 (DAC RPS busy). */
+#define MC2_RPSSIG0        0x0800    /*  RPS signal 0 (ADC RPS busy). */
+
+#define MC2_ADC_RPS        MC2_RPSSIG0    /*  ADC RPS busy. */
+#define MC2_DAC_RPS        MC2_RPSSIG1    /*  DAC RPS busy. */
+
+/* ***** oldies ***** */
+#define MC2_UPLD_DEBIQ        0x00020002    /*  Upload DEBI registers. */
+#define MC2_UPLD_IICQ        0x00010001    /*  Upload I2C registers. */
+
+/*  PCI BUS (SAA7146) REGISTER ADDRESS OFFSETS */
+#define P_PCI_BT_A        0x004C    /* Audio DMA burst/threshold control.
*/
+#define P_DEBICFG               0x007C    /* DEBI configuration. */
+#define P_DEBICMD               0x0080    /* DEBI command. */
+#define P_DEBIPAGE              0x0084    /* DEBI page. */
+#define P_DEBIAD                0x0088    /* DEBI target address. */
+#define P_I2CCTRL               0x008C    /* I2C control. */
+#define P_I2CSTAT               0x0090    /* I2C status. */
+#define P_BASEA2_IN        0x00AC    /* Audio input 2 base physical DMAbuf
+                     * address. */
+#define P_PROTA2_IN        0x00B0    /* Audio input 2 physical DMAbuf
+                     * protection address. */
+#define P_PAGEA2_IN        0x00B4    /* Audio input 2 paging attributes. */
+#define P_BASEA2_OUT        0x00B8    /* Audio output 2 base physical
DMAbuf
+                     * address. */
+#define P_PROTA2_OUT        0x00BC    /* Audio output 2 physical DMAbuf
+                     * protection address. */
+#define P_PAGEA2_OUT        0x00C0    /* Audio output 2 paging attributes.
*/
+#define P_RPSPAGE0              0x00C4    /* RPS0 page. */
+#define P_RPSPAGE1              0x00C8    /* RPS1 page. */
+#define P_RPS0_TOUT        0x00D4    /* RPS0 time-out. */
+#define P_RPS1_TOUT        0x00D8    /* RPS1 time-out. */
+#define P_IER                   0x00DC    /* Interrupt enable. */
+#define P_GPIO                  0x00E0    /* General-purpose I/O. */
+#define P_EC1SSR        0x00E4    /* Event counter set 1 source select. */
+#define P_ECT1R            0x00EC    /* Event counter threshold set 1. */
+#define P_ACON1                 0x00F4    /* Audio control 1. */
+#define P_ACON2                 0x00F8    /* Audio control 2. */
+#define P_MC1                   0x00FC    /* Master control 1. */
+#define P_MC2                   0x0100    /* Master control 2. */
+#define P_RPSADDR0              0x0104    /* RPS0 instruction pointer. */
+#define P_RPSADDR1              0x0108    /* RPS1 instruction pointer. */
+#define P_ISR                   0x010C    /* Interrupt status. */
+#define P_PSR                   0x0110    /* Primary status. */
+#define P_SSR                   0x0114    /* Secondary status. */
+#define P_EC1R            0x0118    /* Event counter set 1. */
+#define P_ADP4            0x0138    /* Logical audio DMA pointer of audio
+                     * input FIFO A2_IN. */
+#define P_FB_BUFFER1            0x0144    /* Audio feedback buffer 1. */
+#define P_FB_BUFFER2            0x0148    /* Audio feedback buffer 2. */
+#define P_TSL1                  0x0180    /* Audio time slot list 1. */
+#define P_TSL2                  0x01C0    /* Audio time slot list 2. */
+
+/*  LOCAL BUS (GATE ARRAY) REGISTER ADDRESS OFFSETS */
+/*  Analog I/O registers: */
+#define LP_DACPOL        0x0082    /*   Write DAC polarity. */
+#define LP_GSEL            0x0084    /*   Write ADC gain. */
+#define LP_ISEL            0x0086    /*   Write ADC channel select. */
+/*  Digital I/O (write only): */
+#define LP_WRINTSELA        0x0042    /*   Write A interrupt enable. */
+#define LP_WREDGSELA        0x0044    /*   Write A edge selection. */
+#define LP_WRCAPSELA        0x0046    /*   Write A capture enable. */
+#define LP_WRDOUTA        0x0048    /*   Write A digital output. */
+#define LP_WRINTSELB        0x0052    /*   Write B interrupt enable. */
+#define LP_WREDGSELB        0x0054    /*   Write B edge selection. */
+#define LP_WRCAPSELB        0x0056    /*   Write B capture enable. */
+#define LP_WRDOUTB        0x0058    /*   Write B digital output. */
+#define LP_WRINTSELC        0x0062    /*   Write C interrupt enable. */
+#define LP_WREDGSELC        0x0064    /*   Write C edge selection. */
+#define LP_WRCAPSELC        0x0066    /*   Write C capture enable. */
+#define LP_WRDOUTC        0x0068    /*   Write C digital output. */
+
+/*  Digital I/O (read only): */
+#define LP_RDDINA        0x0040    /*   Read digital input. */
+#define LP_RDCAPFLGA        0x0048    /*   Read edges captured. */
+#define LP_RDINTSELA        0x004A    /*   Read interrupt enable register.
*/
+#define LP_RDEDGSELA        0x004C    /*   Read edge selection register. */
+#define LP_RDCAPSELA        0x004E    /*   Read capture enable register. */
+#define LP_RDDINB        0x0050    /*   Read digital input. */
+#define LP_RDCAPFLGB        0x0058    /*   Read edges captured. */
+#define LP_RDINTSELB        0x005A    /*   Read interrupt enable register.
*/
+#define LP_RDEDGSELB        0x005C    /*   Read edge selection register. */
+#define LP_RDCAPSELB        0x005E    /*   Read capture enable register. */
+#define LP_RDDINC        0x0060    /*   Read digital input. */
+#define LP_RDCAPFLGC        0x0068    /*   Read edges captured. */
+#define LP_RDINTSELC        0x006A    /*   Read interrupt enable register.
*/
+#define LP_RDEDGSELC        0x006C    /*   Read edge selection register. */
+#define LP_RDCAPSELC        0x006E    /*   Read capture enable register. */
+
+/*  Counter Registers (read/write): */
+#define LP_CR0A            0x0000    /*   0A setup register. */
+#define LP_CR0B            0x0002    /*   0B setup register. */
+#define LP_CR1A            0x0004    /*   1A setup register. */
+#define LP_CR1B            0x0006    /*   1B setup register. */
+#define LP_CR2A            0x0008    /*   2A setup register. */
+#define LP_CR2B            0x000A    /*   2B setup register. */
+
+/*  Counter PreLoad (write) and Latch (read) Registers: */
+#define    LP_CNTR0ALSW        0x000C    /*   0A lsw. */
+#define    LP_CNTR0AMSW        0x000E    /*   0A msw. */
+#define    LP_CNTR0BLSW        0x0010    /*   0B lsw. */
+#define    LP_CNTR0BMSW        0x0012    /*   0B msw. */
+#define    LP_CNTR1ALSW        0x0014    /*   1A lsw. */
+#define    LP_CNTR1AMSW        0x0016    /*   1A msw. */
+#define    LP_CNTR1BLSW        0x0018    /*   1B lsw. */
+#define    LP_CNTR1BMSW        0x001A    /*   1B msw. */
+#define    LP_CNTR2ALSW        0x001C    /*   2A lsw. */
+#define    LP_CNTR2AMSW        0x001E    /*   2A msw. */
+#define    LP_CNTR2BLSW        0x0020    /*   2B lsw. */
+#define    LP_CNTR2BMSW        0x0022    /*   2B msw. */
+
+/*  Miscellaneous Registers (read/write): */
+#define LP_MISC1        0x0088    /*   Read/write Misc1. */
+#define LP_WRMISC2        0x0090    /*   Write Misc2. */
+#define LP_RDMISC2        0x0082    /*   Read Misc2. */
+
+/*  Bit masks for MISC1 register that are the same for reads and writes. */
+#define MISC1_WENABLE        0x8000    /* enab writes to MISC2 (except
Clear
+                     * Watchdog bit). */
+#define MISC1_WDISABLE        0x0000    /* Disable writes to MISC2. */
+#define MISC1_EDCAP        0x1000    /* enab edge capture on DIO chans
+                     * specified by  LP_WRCAPSELx. */
+#define MISC1_NOEDCAP        0x0000    /* Disable edge capture on specified
+                     * DIO chans. */
+
+/*  Bit masks for MISC1 register reads. */
+#define RDMISC1_WDTIMEOUT    0x4000    /*  Watchdog timer timed out. */
+
+/*  Bit masks for MISC2 register writes. */
+#define WRMISC2_WDCLEAR        0x8000    /*  Reset watchdog timer to zero.
*/
+#define WRMISC2_CHARGE_ENABLE    0x4000    /*  enab battery trickle
charging. */
+
+/*  Bit masks for MISC2 register that are the same for reads and writes. */
+#define MISC2_BATT_ENABLE    0x0008    /*  Backup battery enable. */
+#define MISC2_WDENABLE        0x0004    /*  Watchdog timer enable. */
+#define MISC2_WDPERIOD_MASK    0x0003    /*  Watchdog interval */
+/*  select mask. */
+
+/*  Bit masks for ACON1 register. */
+#define A2_RUN            0x40000000    /*  Run A2 based on TSL2. */
+#define A1_RUN            0x20000000    /*  Run A1 based on TSL1. */
+#define A1_SWAP            0x00200000    /*  Use big-endian for A1. */
+#define A2_SWAP            0x00100000    /*  Use big-endian for A2. */
+#define WS_MODES        0x00019999    /*  WS0 =3D TSL1 trigger */
+/*  input, WS1-WS4 =3D */
+/*  CS* outputs. */
+
+#if PLATFORM =3D=3D INTEL        /* Base ACON1 config: always run A1 based
+                 * on TSL1. */
+#define ACON1_BASE        (WS_MODES | A1_RUN)
+#elif PLATFORM =3D=3D MOTOROLA
+#define ACON1_BASE        (WS_MODES | A1_RUN | A1_SWAP | A2_SWAP)
+#endif
+
+#define ACON1_ADCSTART        ACON1_BASE    /* Start ADC: run A1
+                         *  based on TSL1. */
+#define ACON1_DACSTART        (ACON1_BASE | A2_RUN)
+/* Start transmit to DAC: run A2 based on TSL2. */
+#define ACON1_DACSTOP        ACON1_BASE    /*  Halt A2. */
+
+/*  Bit masks for ACON2 register. */
+#define A1_CLKSRC_BCLK1        0x00000000    /*  A1 bit rate =3D BCLK1
(ADC). */
+#define A2_CLKSRC_X1        0x00800000    /*  A2 bit rate =3D ACLK/1 (DACs=
).
*/
+#define A2_CLKSRC_X2        0x00C00000    /*  A2 bit rate =3D ACLK/2 (DACs=
).
*/
+#define A2_CLKSRC_X4        0x01400000    /*  A2 bit rate =3D ACLK/4 (DACs=
).
*/
+#define INVERT_BCLK2        0x00100000    /*  Invert BCLK2 (DACs). */
+#define BCLK2_OE        0x00040000    /*  enab BCLK2 (DACs). */
+#define ACON2_XORMASK        0x000C0000    /*  XOR mask for ACON2 */
+/*  active-low bits. */
+
+#define ACON2_INIT        (ACON2_XORMASK ^ (A1_CLKSRC_BCLK1 | A2_CLKSRC_X2
| INVERT_BCLK2 | BCLK2_OE))
+
+/*  Bit masks for timeslot records. */
+#define WS1                 0x40000000    /*  WS output to assert. */
+#define WS2                 0x20000000
+#define WS3                 0x10000000
+#define WS4                 0x08000000
+#define RSD1            0x01000000    /* Shift A1 data in on SD1. */
+#define SDW_A1            0x00800000    /* Store rcv'd char at next
+                         * char slot of DWORD1 buffer. */
+#define SIB_A1            0x00400000    /* Store rcv'd char at next
+                         * char slot of FB1 buffer. */
+#define SF_A1            0x00200000    /* Write unsigned long
+                         * buffer to input FIFO. */
+
+/* Select parallel-to-serial converter's data source: */
+#define XFIFO_0            0x00000000    /*    Data fifo byte 0. */
+#define XFIFO_1            0x00000010    /*    Data fifo byte 1. */
+#define XFIFO_2            0x00000020    /*    Data fifo byte 2. */
+#define XFIFO_3            0x00000030    /*    Data fifo byte 3. */
+#define XFB0            0x00000040    /*    FB_BUFFER byte 0. */
+#define XFB1            0x00000050    /*    FB_BUFFER byte 1. */
+#define XFB2            0x00000060    /*    FB_BUFFER byte 2. */
+#define XFB3            0x00000070    /*    FB_BUFFER byte 3. */
+#define SIB_A2            0x00000200    /* Store next dword from A2's
+                         * input shifter to FB2 buffer. */
+#define SF_A2            0x00000100    /* Store next dword from A2's
+                         * input shifter to its input
+                         * fifo. */
+#define LF_A2            0x00000080    /* Load next dword from A2's
+                         * output fifo into its
+                         * output dword buffer. */
+#define XSD2            0x00000008    /*  Shift data out on SD2. */
+#define RSD3            0x00001800    /*  Shift data in on SD3. */
+#define RSD2            0x00001000    /*  Shift data in on SD2. */
+#define LOW_A2            0x00000002    /*  Drive last SD low */
+/*  for 7 clks, then */
+/*  tri-state. */
+#define EOS                 0x00000001    /*  End of superframe. */
+
+/*  I2C configuration constants. */
+#define I2C_CLKSEL        0x0400
+/* I2C bit rate =3D PCIclk/480 =3D 68.75 KHz. */
+
+#define I2C_BITRATE        68.75
+/* I2C bus data bit rate (determined by I2C_CLKSEL) in KHz. */
+
+#define I2C_WRTIME        15.0
+/* Worst case time, in msec, for EEPROM internal write op. */
+
+/*  I2C manifest constants. */
+
+/*  Max retries to wait for EEPROM write. */
+#define I2C_RETRIES        (I2C_WRTIME * I2C_BITRATE / 9.0)
+#define I2C_ERR            0x0002    /*  I2C control/status */
+/*  flag ERROR. */
+#define I2C_BUSY        0x0001    /*  I2C control/status */
+/*  flag BUSY. */
+#define I2C_ABORT        0x0080    /*  I2C status flag ABORT. */
+#define I2C_ATTRSTART        0x3    /*  I2C attribute START. */
+#define I2C_ATTRCONT        0x2    /*  I2C attribute CONT. */
+#define I2C_ATTRSTOP        0x1    /*  I2C attribute STOP. */
+#define I2C_ATTRNOP        0x0    /*  I2C attribute NOP. */
+
+/*  I2C read command  | EEPROM address. */
+#define I2CR            (devpriv->I2CAdrs | 1)
+
+/*  I2C write command | EEPROM address. */
+#define I2CW            (devpriv->I2CAdrs)
+
+/*  Code macros used for constructing I2C command bytes. */
+#define I2C_B2(ATTR, VAL)    (((ATTR) << 6) | ((VAL) << 24))
+#define I2C_B1(ATTR, VAL)    (((ATTR) << 4) | ((VAL) << 16))
+#define I2C_B0(ATTR, VAL)    (((ATTR) << 2) | ((VAL) <<  8))
+
+/* oldest */
+#define P_DEBICFGq              0x007C    /*  DEBI configuration. */
+#define P_DEBICMDq              0x0080    /*  DEBI command. */
+#define P_DEBIPAGEq             0x0084    /*  DEBI page. */
+#define P_DEBIADq               0x0088    /*  DEBI target address. */
+
+#define DEBI_CFG_TOQ        0x03C00000    /*  timeout (15 PCI cycles) */
+#define DEBI_CFG_FASTQ        0x10000000    /*  fast mode enable */
+#define DEBI_CFG_16Q        0x00080000    /*  16-bit access enable */
+#define DEBI_CFG_INCQ        0x00040000    /*  enable address increment */
+#define DEBI_CFG_TIMEROFFQ    0x00010000    /*  disable timer */
+#define DEBI_CMD_RDQ        0x00050000    /*  read immediate 2 bytes */
+#define DEBI_CMD_WRQ        0x00040000    /*  write immediate 2 bytes */
+#define DEBI_PAGE_DISABLEQ    0x00000000    /*  paging disable */
+
+/*  DEBI command constants. */
+#define DEBI_CMD_SIZE16        (2 << 17)    /*  Transfer size is */
+/*  always 2 bytes. */
+#define DEBI_CMD_READ        0x00010000    /*  Read operation. */
+#define DEBI_CMD_WRITE        0x00000000    /*  Write operation. */
+
+/*  Read immediate 2 bytes. */
+#define DEBI_CMD_RDWORD        (DEBI_CMD_READ  | DEBI_CMD_SIZE16)
+
+/*  Write immediate 2 bytes. */
+#define DEBI_CMD_WRWORD        (DEBI_CMD_WRITE | DEBI_CMD_SIZE16)
+
+/*  DEBI configuration constants. */
+#define DEBI_CFG_XIRQ_EN    0x80000000    /*  enab external */
+/*  interrupt on GPIO3. */
+#define DEBI_CFG_XRESUME    0x40000000    /*  Resume block */
+/*  transfer when XIRQ */
+/*  deasserted. */
+#define DEBI_CFG_FAST        0x10000000    /*  Fast mode enable. */
+
+/*  4-bit field that specifies DEBI timeout value in PCI clock cycles: */
+#define DEBI_CFG_TOUT_BIT    22    /*    Finish DEBI cycle after */
+/*    this many clocks. */
+
+/*  2-bit field that specifies Endian byte lane steering: */
+#define DEBI_CFG_SWAP_NONE    0x00000000    /*    Straight - don't */
+/*    swap any bytes */
+/*    (Intel). */
+#define DEBI_CFG_SWAP_2        0x00100000    /*    2-byte swap (Motorola).
*/
+#define DEBI_CFG_SWAP_4        0x00200000    /*    4-byte swap. */
+#define DEBI_CFG_16        0x00080000    /*  Slave is able to */
+/*  serve 16-bit */
+/*  cycles. */
+
+#define DEBI_CFG_SLAVE16    0x00080000    /*  Slave is able to */
+/*  serve 16-bit */
+/*  cycles. */
+#define DEBI_CFG_INC        0x00040000    /*  enab address */
+/*  increment for block */
+/*  transfers. */
+#define DEBI_CFG_INTEL        0x00020000    /*  Intel style local bus. */
+#define DEBI_CFG_TIMEROFF    0x00010000    /*  Disable timer. */
+
+#if PLATFORM =3D=3D INTEL
+
+#define DEBI_TOUT        7    /*  Wait 7 PCI clocks */
+/*  (212 ns) before */
+/*  polling RDY. */
+
+/*  Intel byte lane steering (pass through all byte lanes). */
+#define DEBI_SWAP        DEBI_CFG_SWAP_NONE
+
+#elif PLATFORM =3D=3D MOTOROLA
+
+#define DEBI_TOUT        15    /*  Wait 15 PCI clocks (454 ns) */
+/*  maximum before timing out. */
+#define DEBI_SWAP        DEBI_CFG_SWAP_2    /*  Motorola byte lane
steering. */
+
+#endif
+
+/*  DEBI page table constants. */
+#define DEBI_PAGE_DISABLE    0x00000000    /*  Paging disable. */
+
+/* ******* EXTRA FROM OTHER SANSORAY  * .h  ******* */
+
+/*  LoadSrc values: */
+#define LOADSRC_INDX        0    /*  Preload core in response to */
+/*  Index. */
+#define LOADSRC_OVER        1    /*  Preload core in response to */
+/*  Overflow. */
+#define LOADSRCB_OVERA        2    /*  Preload B core in response */
+/*  to A Overflow. */
+#define LOADSRC_NONE        3    /*  Never preload core. */
+
+/*  IntSrc values: */
+#define INTSRC_NONE         0    /*  Interrupts disabled. */
+#define INTSRC_OVER         1    /*  Interrupt on Overflow. */
+#define INTSRC_INDX         2    /*  Interrupt on Index. */
+#define INTSRC_BOTH         3    /*  Interrupt on Index or Overflow. */
+
+/*  LatchSrc values: */
+#define LATCHSRC_AB_READ    0    /*  Latch on read. */
+#define LATCHSRC_A_INDXA    1    /*  Latch A on A Index. */
+#define LATCHSRC_B_INDXB    2    /*  Latch B on B Index. */
+#define LATCHSRC_B_OVERA    3    /*  Latch B on A Overflow. */
+
+/*  IndxSrc values: */
+#define INDXSRC_HARD        0    /*  Hardware or software index. */
+#define INDXSRC_SOFT        1    /*  Software index only. */
+
+/*  IndxPol values: */
+#define INDXPOL_POS         0    /*  Index input is active high. */
+#define INDXPOL_NEG         1    /*  Index input is active low. */
+
+/*  ClkSrc values: */
+#define CLKSRC_COUNTER        0    /*  Counter mode. */
+#define CLKSRC_TIMER        2    /*  Timer mode. */
+#define CLKSRC_EXTENDER        3    /*  Extender mode. */
+
+/*  ClkPol values: */
+#define CLKPOL_POS        0    /*  Counter/Extender clock is */
+/*  active high. */
+#define CLKPOL_NEG        1    /*  Counter/Extender clock is */
+/*  active low. */
+#define CNTDIR_UP        0    /*  Timer counts up. */
+#define CNTDIR_DOWN         1    /*  Timer counts down. */
+
+/*  ClkEnab values: */
+#define CLKENAB_ALWAYS        0    /*  Clock always enabled. */
+#define CLKENAB_INDEX        1    /*  Clock is enabled by index. */
+
+/*  ClkMult values: */
+#define CLKMULT_4X         0    /*  4x clock multiplier. */
+#define CLKMULT_2X         1    /*  2x clock multiplier. */
+#define CLKMULT_1X         2    /*  1x clock multiplier. */
+
+/*  Bit Field positions in COUNTER_SETUP structure: */
+#define BF_LOADSRC        9    /*  Preload trigger. */
+#define BF_INDXSRC        7    /*  Index source. */
+#define BF_INDXPOL        6    /*  Index polarity. */
+#define BF_CLKSRC        4    /*  Clock source. */
+#define BF_CLKPOL        3    /*  Clock polarity/count direction. */
+#define BF_CLKMULT        1    /*  Clock multiplier. */
+#define BF_CLKENAB        0    /*  Clock enable. */
+
+/*  Enumerated counter operating modes specified by ClkSrc bit field in */
+/*  a COUNTER_SETUP. */
+
+#define CLKSRC_COUNTER        0    /*  Counter: ENC_C clock, ENC_D */
+/*  direction. */
+#define CLKSRC_TIMER        2    /*  Timer: SYS_C clock, */
+/*  direction specified by */
+/*  ClkPol. */
+#define CLKSRC_EXTENDER        3    /*  Extender: OVR_A clock, */
+/*  ENC_D direction. */
+
+/*  Enumerated counter clock multipliers. */
+
+#define MULT_X0            0x0003    /*  Supports no multipliers; */
+/*  fixed physical multiplier =3D */
+/*  3. */
+#define MULT_X1            0x0002    /*  Supports multiplier x1; */
+/*  fixed physical multiplier =3D */
+/*  2. */
+#define MULT_X2            0x0001    /*  Supports multipliers x1, */
+/*  x2; physical multipliers =3D */
+/*  1 or 2. */
+#define MULT_X4            0x0000    /*  Supports multipliers x1, */
+/*  x2, x4; physical */
+/*  multipliers =3D 0, 1 or 2. */
+
+/*  Sanity-check limits for parameters. */
+
+#define NUM_COUNTERS        6    /*  Maximum valid counter */
+/*  logical channel number. */
+#define NUM_INTSOURCES        4
+#define NUM_LATCHSOURCES    4
+#define NUM_CLKMULTS        4
+#define NUM_CLKSOURCES        4
+#define NUM_CLKPOLS        2
+#define NUM_INDEXPOLS        2
+#define NUM_INDEXSOURCES    2
+#define NUM_LOADTRIGS        4
+
+/*  Bit field positions in CRA and CRB counter control registers. */
+
+/*  Bit field positions in CRA: */
+#define CRABIT_INDXSRC_B    14    /*    B index source. */
+#define CRABIT_CLKSRC_B        12    /*    B clock source. */
+#define CRABIT_INDXPOL_A    11    /*    A index polarity. */
+#define CRABIT_LOADSRC_A     9    /*    A preload trigger. */
+#define CRABIT_CLKMULT_A     7    /*    A clock multiplier. */
+#define CRABIT_INTSRC_A         5    /*    A interrupt source. */
+#define CRABIT_CLKPOL_A         4    /*    A clock polarity. */
+#define CRABIT_INDXSRC_A     2    /*    A index source. */
+#define CRABIT_CLKSRC_A         0    /*    A clock source. */
+
+/*  Bit field positions in CRB: */
+#define CRBBIT_INTRESETCMD    15    /*    Interrupt reset command. */
+#define CRBBIT_INTRESET_B    14    /*    B interrupt reset enable. */
+#define CRBBIT_INTRESET_A    13    /*    A interrupt reset enable. */
+#define CRBBIT_CLKENAB_A    12    /*    A clock enable. */
+#define CRBBIT_INTSRC_B        10    /*    B interrupt source. */
+#define CRBBIT_LATCHSRC         8    /*    A/B latch source. */
+#define CRBBIT_LOADSRC_B     6    /*    B preload trigger. */
+#define CRBBIT_CLKMULT_B     3    /*    B clock multiplier. */
+#define CRBBIT_CLKENAB_B     2    /*    B clock enable. */
+#define CRBBIT_INDXPOL_B     1    /*    B index polarity. */
+#define CRBBIT_CLKPOL_B         0    /*    B clock polarity. */
+
+/*  Bit field masks for CRA and CRB. */
+
+#define CRAMSK_INDXSRC_B    ((uint16_t)(3 << CRABIT_INDXSRC_B))
+#define CRAMSK_CLKSRC_B        ((uint16_t)(3 << CRABIT_CLKSRC_B))
+#define CRAMSK_INDXPOL_A    ((uint16_t)(1 << CRABIT_INDXPOL_A))
+#define CRAMSK_LOADSRC_A    ((uint16_t)(3 << CRABIT_LOADSRC_A))
+#define CRAMSK_CLKMULT_A    ((uint16_t)(3 << CRABIT_CLKMULT_A))
+#define CRAMSK_INTSRC_A        ((uint16_t)(3 << CRABIT_INTSRC_A))
+#define CRAMSK_CLKPOL_A        ((uint16_t)(3 << CRABIT_CLKPOL_A))
+#define CRAMSK_INDXSRC_A    ((uint16_t)(3 << CRABIT_INDXSRC_A))
+#define CRAMSK_CLKSRC_A        ((uint16_t)(3 << CRABIT_CLKSRC_A))
+
+#define CRBMSK_INTRESETCMD    ((uint16_t)(1 << CRBBIT_INTRESETCMD))
+#define CRBMSK_INTRESET_B    ((uint16_t)(1 << CRBBIT_INTRESET_B))
+#define CRBMSK_INTRESET_A    ((uint16_t)(1 << CRBBIT_INTRESET_A))
+#define CRBMSK_CLKENAB_A    ((uint16_t)(1 << CRBBIT_CLKENAB_A))
+#define CRBMSK_INTSRC_B        ((uint16_t)(3 << CRBBIT_INTSRC_B))
+#define CRBMSK_LATCHSRC        ((uint16_t)(3 << CRBBIT_LATCHSRC))
+#define CRBMSK_LOADSRC_B    ((uint16_t)(3 << CRBBIT_LOADSRC_B))
+#define CRBMSK_CLKMULT_B    ((uint16_t)(3 << CRBBIT_CLKMULT_B))
+#define CRBMSK_CLKENAB_B    ((uint16_t)(1 << CRBBIT_CLKENAB_B))
+#define CRBMSK_INDXPOL_B    ((uint16_t)(1 << CRBBIT_INDXPOL_B))
+#define CRBMSK_CLKPOL_B        ((uint16_t)(1 << CRBBIT_CLKPOL_B))
+
+#define CRBMSK_INTCTRL        (CRBMSK_INTRESETCMD | CRBMSK_INTRESET_A |
CRBMSK_INTRESET_B)    /*  Interrupt reset control bits. */
+
+/*  Bit field positions for standardized SETUP structure. */
+
+#define STDBIT_INTSRC        13
+#define STDBIT_LATCHSRC        11
+#define STDBIT_LOADSRC         9
+#define STDBIT_INDXSRC         7
+#define STDBIT_INDXPOL         6
+#define STDBIT_CLKSRC         4
+#define STDBIT_CLKPOL         3
+#define STDBIT_CLKMULT         1
+#define STDBIT_CLKENAB         0
+
+/*  Bit field masks for standardized SETUP structure. */
+
+#define STDMSK_INTSRC        ((uint16_t)(3 << STDBIT_INTSRC))
+#define STDMSK_LATCHSRC        ((uint16_t)(3 << STDBIT_LATCHSRC))
+#define STDMSK_LOADSRC        ((uint16_t)(3 << STDBIT_LOADSRC))
+#define STDMSK_INDXSRC        ((uint16_t)(1 << STDBIT_INDXSRC))
+#define STDMSK_INDXPOL        ((uint16_t)(1 << STDBIT_INDXPOL))
+#define STDMSK_CLKSRC        ((uint16_t)(3 << STDBIT_CLKSRC))
+#define STDMSK_CLKPOL        ((uint16_t)(1 << STDBIT_CLKPOL))
+#define STDMSK_CLKMULT        ((uint16_t)(3 << STDBIT_CLKMULT))
+#define STDMSK_CLKENAB        ((uint16_t)(1 << STDBIT_CLKENAB))
+
+struct bufferDMA {
+  dma_addr_t PhysicalBase;
+  void *LogicalBase;
+  uint32_t DMAHandle;
+};
+
+#define SUBD_AI 0
+#define SUBD_AO 1
+#define SUBD_DIO_A 2
+#define SUBD_DIO_B 3
+#define SUBD_DIO_C 4
+#define SUBD_ENC 5
+
+/* Board description */
+#define S626_GPCT_CHANS 6
+#define S626_GPCT_BITS  24
+#define S626_AI_CHANS 16
+#define S626_AI_BITS  16
+#define S626_AI_TIMEOUT 100
+#define S626_AO_CHANS 4
+#define S626_AO_BITS  16
+#define S626_DIO_CHANS  16
+#define S626_DIO_BITS 1
+
+/* Ports */
+#define S626_IOSIZE   0x40  /* 64 bytes */
+#define S626_DEFAULT_ADDRESS  0x2C0 /* Manufacturing default */
+
+/* Registers */
+#define REG_TCR 0x00
+#define REG_WDC 0x02
+#define REG_DAC 0x04
+#define REG_ADC 0x06
+#define REG_ADD 0x08
+#define REG_DIO 0x0A
+#define REG_IER 0x0C
+#define REG_ISR 0x0E
+#define REG_MSC 0x10
+#define REG_C0L 0x12
+#define REG_C0H 0x14
+#define REG_C0M 0x16
+#define REG_C0C 0x18
+#define REG_C1L 0x1A
+#define REG_C1H 0x1C
+#define REG_C1M 0x1E
+#define REG_C1C 0x20
+#define REG_C2L 0x22
+#define REG_C2H 0x24
+#define REG_C2M 0x26
+#define REG_C2C 0x28
+#define REG_C3L 0x2A
+#define REG_C3H 0x2C
+#define REG_C3M 0x2E
+#define REG_C3C 0x30
+#define REG_EED 0x32
+#define REG_EEC 0x34
+
+#define ISR_ADC_DONE 0x4
+
+#define ADDR_REG(reg) (s626ptr->private->io_base + (reg))
+#define ADDR_CHAN_REG(reg, chan) (s626ptr->private->io_base + (reg) +
(chan) * 8)
+
+/* #define WR7146(REGARDS,CTRLWORD)
+ writel(CTRLWORD,(uint32_t)(devpriv->base_addr+(REGARDS))) */
+#define WR7146(REGARDS, CTRLWORD) writel(CTRLWORD,
devpriv->base_addr+(REGARDS))
+
+/*  enab/disable a function or test status bit(s) that are accessed */
+/*  through Main Control Registers 1 or 2. */
+#define MC_ENABLE(REGADRS, CTRLWORD)  writel(((uint32_t)(CTRLWORD) << 16)
| (uint32_t)(CTRLWORD), devpriv->base_addr+(REGADRS))
+
+#define MC_DISABLE(REGADRS, CTRLWORD) writel((uint32_t)(CTRLWORD) << 16 ,
devpriv->base_addr+(REGADRS))
+
+#define MC_TEST(REGADRS, CTRLWORD)  ((readl(devpriv->base_addr+(REGADRS))
& CTRLWORD) !=3D 0)
+
+/* #define WR7146(REGARDS,CTRLWORD)
+ writel(CTRLWORD,(uint32_t)(devpriv->base_addr+(REGARDS))) */
+#define WR7146(REGARDS, CTRLWORD) writel(CTRLWORD,
devpriv->base_addr+(REGARDS))
+
+/* #define RR7146(REGARDS)
+ readl((uint32_t)(devpriv->base_addr+(REGARDS))) */
+#define RR7146(REGARDS)   readl(devpriv->base_addr+(REGARDS))
+
+#define NUMBER_OF_SUBDEVICES 1
+
+#define BUGFIX_STREG(REGADRS)   (REGADRS - 4)
+
+/*  Write a time slot control record to TSL2. */
+#define VECTPORT(VECTNUM)   (P_TSL2 + ((VECTNUM) << 2))
+#define SETVECT(VECTNUM, VECTVAL) WR7146(VECTPORT(VECTNUM), (VECTVAL))
+
+/*  Slot 0 base settings. */
+#define VECT0 (XSD2 | RSD3 | SIB_A2)
+/*  Slot 0 always shifts in  0xFF and store it to  FB_BUFFER2. */
+
+#define encpriv (    (struct enc_private *)   &((
a4l_get_subd(s626ptr->dev, 5) )->priv)  )
+
+/*  Counter overflow/index event flag masks for RDMISC2. */
+#define INDXMASK(C)   (1 << (((C) > 2) ? ((C) * 2 - 1) : ((C) * 2 +  4)))
+#define OVERMASK(C)   (1 << (((C) > 2) ? ((C) * 2 + 5) : ((C) * 2 + 10)))
+#define EVBITS(C)   { 0, OVERMASK(C), INDXMASK(C), OVERMASK(C) |
INDXMASK(C) }
+
+struct s626_priv {
+  unsigned long io_base;
+
+  void __iomem *base_addr;
+  uint8_t ai_cmd_running; /*  ai_cmd is running */
+  uint8_t ai_continous; /*  continous acquisition */
+  int ai_sample_count; /*  number of samples to acquire */
+  unsigned int ai_sample_timer;
+  /*  time between samples in  units of the timer */
+  int ai_convert_count; /*  conversion counter */
+  unsigned int ai_convert_timer;
+  /*  time between conversion in  units of the timer */
+  uint16_t CounterIntEnabs;
+  /* Counter interrupt enable  mask for MISC2 register. */
+  uint8_t AdcItems; /* Number of items in ADC poll  list. */
+  struct bufferDMA RPSBuf; /* DMA buffer used to hold ADC (RPS1) program.
*/
+  struct bufferDMA ANABuf;
+  /* DMA buffer used to receive ADC data and hold DAC data. */
+  uint32_t *pDacWBuf;
+  /* Pointer to logical adrs of DMA buffer used to hold DAC  data. */
+  uint16_t Dacpol; /* Image of DAC polarity register. */
+  uint8_t TrimSetpoint[12]; /* Images of TrimDAC setpoints */
+  /* Charge Enabled (0 or WRMISC2_CHARGE_ENABLE). */
+  uint32_t I2CAdrs;
+  /* I2C device address for onboard EEPROM (board rev dependent). */
+  /*   short         I2Cards; */
+  unsigned int ao_readback[S626_DAC_CHANNELS];
+};
+
+struct s626_struct {
+  struct list_head list;
+  a4l_lock_t lock;
+
+  struct pci_dev * pcidev;
+  a4l_dev_t * dev;
+
+  resource_size_t phys_addr;
+  void * io_addr;
+  resource_size_t daq_phys_addr;
+  void * daq_io_addr;
+
+  struct s626_priv * private;
+};
+
+/*  COUNTER OBJECT ------------------------------------------------ */
+struct enc_private {
+  /*  Pointers to functions that differ for A and B counters: */
+  uint16_t (*GetEnable)(struct s626_struct * s626ptr, struct enc_private
*); /* Return clock enable. */
+  uint16_t (*GetIntSrc)(struct s626_struct * s626ptr, struct enc_private
*); /* Return interrupt source. */
+  uint16_t (*GetLoadTrig)(struct s626_struct * s626ptr, struct enc_private
*); /* Return preload trigger source. */
+  uint16_t (*GetMode)(struct s626_struct * s626ptr, struct enc_private *);
/* Return standardized operating mode. */
+  void (*PulseIndex)(struct s626_struct * s626ptr, struct enc_private *);
/* Generate soft index strobe. */
+  void (*SetEnable)(struct s626_struct * s626ptr, struct enc_private *,
+      uint16_t enab); /* Program clock enable. */
+  void (*SetIntSrc)(struct s626_struct * s626ptr, struct enc_private *,
+      uint16_t IntSource); /* Program interrupt source. */
+  void (*SetLoadTrig)(struct s626_struct * s626ptr, struct enc_private *,
+      uint16_t Trig); /* Program preload trigger source. */
+  void (*SetMode)(struct s626_struct * s626ptr, struct enc_private *,
+      uint16_t Setup, uint16_t DisableIntSrc); /* Program standardized
operating mode. */
+  void (*ResetCapFlags)(struct s626_struct * s626ptr, struct enc_private
*); /* Reset event capture flags. */
+
+  uint16_t MyCRA; /*    Address of CRA register. */
+  uint16_t MyCRB; /*    Address of CRB register. */
+  uint16_t MyLatchLsw; /*    Address of Latch least-significant-word */
+  /*    register. */
+  uint16_t MyEventBits[4]; /*    Bit translations for IntSrc -->RDMISC2. */
+};
+
+struct s626_subd_dio_private {
+  uint16_t RDDIn;
+  uint16_t WRDOut;
+  uint16_t RDEdgSel;
+  uint16_t WREdgSel;
+  uint16_t RDCapSel;
+  uint16_t WRCapSel;
+  uint16_t RDCapFlg;
+  uint16_t RDIntSel;
+  uint16_t WRIntSel;
+  int io_bits;
+  unsigned int state;
+};
+
+struct counter_mode_register_t {
+#if defined (__LITTLE_ENDIAN_BITFIELD)
+  unsigned short coutSource :1;
+  unsigned short coutPolarity :1;
+  unsigned short autoLoadResetRcap :3;
+  unsigned short hwCtEnableSource :2;
+  unsigned short ctEnableCtrl :2;
+  unsigned short clockSource :2;
+  unsigned short countDir :1;
+  unsigned short countDirCtrl :1;
+  unsigned short outputRegLatchCtrl :1;
+  unsigned short preloadRegSel :1;
+  unsigned short reserved :1;
+#elif defined(__BIG_ENDIAN_BITFIELD)
+unsigned short reserved:1;
+unsigned short preloadRegSel:1;
+unsigned short outputRegLatchCtrl:1;
+unsigned short countDirCtrl:1;
+unsigned short countDir:1;
+unsigned short clockSource:2;
+unsigned short ctEnableCtrl:2;
+unsigned short hwCtEnableSource:2;
+unsigned short autoLoadResetRcap:3;
+unsigned short coutPolarity:1;
+unsigned short coutSource:1;
+#else
+#error Unknown bit field order
+#endif
+};
+
+union cmReg {
+  struct counter_mode_register_t reg;
+  unsigned short value;
+};
+
+/* Application Classes for GPCT Subdevices */
+enum S626_GPCT_APP_CLASS {
+  CountingAndTimeMeasurement,
+  SinglePulseGeneration,
+  PulseTrainGeneration,
+  PositionMeasurement,
+  Miscellaneous
+};
+
+/* GPCT subdevices configuration */
+#define MAX_GPCT_CONFIG_DATA 6
+
+struct s626GPCTConfig {
+  enum S626_GPCT_APP_CLASS app;
+  int data[MAX_GPCT_CONFIG_DATA];
+};
+
+struct setup_subd {
+  void (*setup_func)(a4l_subd_t *);
+  int sizeof_priv;
+};
+
+struct s626_subd_gpct_private {
+  struct enc_private enc_private_data[S626_GPCT_CHANS];
+  struct s626GPCTConfig config[S626_GPCT_CHANS];
+};
+
+struct s626_subd_ai_private {
+  uint16_t config;
+};
+
+struct s626_subd_ao_private {
+  uint16_t readback[S626_AO_CHANS];
+};
+
+static void ResetCapFlags_A(struct s626_struct * s626ptr, struct
enc_private *k);
+
+static void ResetCapFlags_B(struct s626_struct * s626ptr, struct
enc_private *k);
+
+static uint16_t GetMode_A(struct s626_struct * s626ptr, struct enc_private
*k);
+
+static uint16_t GetMode_B(struct s626_struct * s626ptr, struct enc_private
*k);
+
+static void SetMode_A(struct s626_struct * s626ptr, struct enc_private *k,
+    uint16_t Setup, uint16_t DisableIntSrc);
+
+static void SetMode_B(struct s626_struct * s626ptr, struct enc_private *k,
+    uint16_t Setup, uint16_t DisableIntSrc);
+
+static void SetEnable_A(struct s626_struct * s626ptr, struct enc_private
*k,
+    uint16_t enab);
+
+static void SetEnable_B(struct s626_struct * s626ptr, struct enc_private
*k,
+    uint16_t enab);
+
+static uint16_t GetEnable_A(struct s626_struct * s626ptr, struct
enc_private *k);
+
+static uint16_t GetEnable_B(struct s626_struct * s626ptr, struct
enc_private *k);
+
+static void SetLoadTrig_A(struct s626_struct * s626ptr, struct enc_private
*k,
+    uint16_t Trig);
+
+static void SetLoadTrig_B(struct s626_struct * s626ptr, struct enc_private
*k,
+    uint16_t Trig);
+
+static uint16_t GetLoadTrig_A(struct s626_struct * s626ptr,
+    struct enc_private *k);
+
+static uint16_t GetLoadTrig_B(struct s626_struct * s626ptr,
+    struct enc_private *k);
+
+static void SetIntSrc_A(struct s626_struct * s626ptr, struct enc_private
*k,
+    uint16_t IntSource);
+
+static void SetIntSrc_B(struct s626_struct * s626ptr, struct enc_private
*k,
+    uint16_t IntSource);
+
+static uint16_t GetIntSrc_A(struct s626_struct * s626ptr, struct
enc_private *k);
+
+static uint16_t GetIntSrc_B(struct s626_struct * s626ptr, struct
enc_private *k);
+
+static void PulseIndex_A(struct s626_struct * s626ptr, struct enc_private
*k);
+
+static void PulseIndex_B(struct s626_struct * s626ptr, struct enc_private
*k);
+
+static void CloseDMAB(struct s626_struct * s626ptr, struct bufferDMA *pdma,
+    size_t bsize);
+
+static uint16_t DEBIread(struct s626_struct * s626ptr, uint16_t addr);
+
+static void DEBIwrite(struct s626_struct * s626ptr, uint16_t addr,
+    uint16_t wdata);
+
+static void DEBItransfer(struct s626_struct * s626ptr);
+
+static void DEBIreplace(struct s626_struct * s626ptr, uint16_t addr,
+    uint16_t mask, uint16_t wdata);
+
+static uint32_t I2Chandshake(struct s626_struct * s626ptr, uint32_t val);
+
+static uint8_t I2Cread(struct s626_struct * s626ptr, uint8_t addr);
+
+static void WriteMISC2(struct s626_struct * s626ptr, uint16_t NewImage);
+
+static void Preload(struct s626_struct * s626ptr, struct enc_private *k,
+    uint32_t value);
+
+static void SendDAC(struct s626_struct * s626ptr, uint32_t val);
+
+static void SetDAC(struct s626_struct * s626ptr, uint16_t chan, short
dacdata);
+
+static void WriteTrimDAC(struct s626_struct * s626ptr, uint8_t LogicalChan,
+    uint8_t DacData);
+
+static void LoadTrimDACs(struct s626_struct * s626ptr);
+
+static uint32_t ReadLatch(struct s626_struct * s626ptr, struct enc_private
*k);
+
+static void SetLatchSource(struct s626_struct * s626ptr, struct
enc_private *k,
+    uint16_t value);
+
+static void s626_timer_load(struct s626_struct * s626ptr, struct
enc_private *k,
+    int tick);
+
+int s626_irq_handler(unsigned int irq, void *d);
+
+static int s626_ns_to_timer(int *nanosec, int round_mode);
+
+static int s626_allocate_dma_buffers(struct s626_struct * s626ptr);
+
+static int s626_dio_clear_irq(struct s626_struct * s626ptr);
+
+static int s626_dio_set_irq(struct s626_struct * s626ptr, unsigned int
chan);
+
+static int s626_dio_reset_irq(struct s626_struct * s626ptr, unsigned int
group,
+    unsigned int mask);
+
+static void ResetADC(struct s626_struct * s626ptr, uint8_t *ppl,
+    a4l_cmd_t * cmd);
+
+static int s626_ai_insn_config(a4l_subd_t *subd, a4l_kinsn_t *insn);
+
+static unsigned int s626_ai_reg_to_uint(int data);
+
+static int s626_ai_insn_read(a4l_subd_t *subd, a4l_kinsn_t *insn);
+
+static int s626_ai_load_polllist(uint8_t *ppl, a4l_cmd_t *cmd);
+
+static int s626_ai_inttrig(struct a4l_subdevice * subdev,
+    unsigned long int trignum);
+
+static int s626_ai_cmd(struct a4l_subdevice * subdev, a4l_cmd_t * cmd);
+
+static inline int cfc_check_trigger_src(unsigned int *src, unsigned int
flags);
+
+static inline int cfc_check_trigger_is_unique(unsigned int src);
+
+static inline int cfc_check_trigger_arg_is(unsigned int *arg, unsigned int
val);
+
+static inline int cfc_check_trigger_arg_min(unsigned int *arg, unsigned
int val);
+
+static inline int cfc_check_trigger_arg_max(unsigned int *arg, unsigned
int val);
+
+static int s626_ai_cmdtest(struct a4l_subdevice * subdev, a4l_cmd_t * cmd);
+
+static int s626_ai_cancel(struct a4l_subdevice * subdev);
+
+static int s626_ao_winsn(a4l_subd_t *subd, a4l_kinsn_t *insn);
+
+static int s626_ao_rinsn(a4l_subd_t *subd, a4l_kinsn_t *insn);
+
+static void s626_dio_init(struct s626_struct * s626ptr);
+
+static int s626_dio_insn_config(a4l_subd_t *subd, a4l_kinsn_t *insn);
+
+static int s626_dio_insn_bits(a4l_subd_t *subd, a4l_kinsn_t *insn);
+
+static int s626_gpct_insn_config(a4l_subd_t *subd, a4l_kinsn_t *insn);
+
+static int s626_gpct_rinsn(a4l_subd_t *subd, a4l_kinsn_t *insn);
+
+static int s626_gpct_winsn(a4l_subd_t *subd, a4l_kinsn_t *insn);
+
+static void setup_subd_ai(a4l_subd_t *subd);
+
+static void setup_subd_ao(a4l_subd_t *subd);
+
+static void setup_subd_dioA(a4l_subd_t *subd);
+
+static void setup_subd_dioB(a4l_subd_t *subd);
+
+static void setup_subd_dioC(a4l_subd_t *subd);
+
+static void setup_subd_gpct(a4l_subd_t *subd);
+
+static void CountersInit(struct s626_struct * s626ptr);
+
+static void s626_initialize(struct s626_struct * s626ptr);
+
+static int dev_s626_attach(a4l_dev_t *dev, a4l_lnkdesc_t *arg);
+
+static int dev_s626_detach(a4l_dev_t *dev);
+
+static int s626_pci_probe(struct pci_dev *dev, const struct pci_device_id
*ent);
+
+static void s626_pci_remove(struct pci_dev *dev);
-- =

1.7.9.5
-------------- next part --------------
A non-text attachment was scrubbed...
Name: s626_driver.patch
Type: text/x-patch
Size: 145547 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140228/53d0218=
9/attachment.bin>
