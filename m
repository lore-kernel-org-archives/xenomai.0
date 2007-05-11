Date: Fri, 11 May 2007 09:31:10 +0000
Message-ID: <XqI9Fhxa.1178875870.3777430.dchabal@domain.hid>
From: "CHABAL David" <david.chabal@domain.hid>
Errors-To: "CHABAL David" <david.chabal@domain.hid>
MIME-Version: 1.0 
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-core] 16550A driver and Moxa card / solved
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

Hello,

I met some trouble with the 16550A driver provided in Xenomai 2.3.1
and my Moxa cards (PCI / 8 * RS232 / 168U ).

It was a problem of baudrate computation before setting the LCR_DLAB
register.

The formula implemented by the Xenomai driver is different from the one
provided by Moxa. So I copy/paste the formula from the mxser.c file
(present in the
kernel distro), and it seems to work fine.

I think it's Moxa card dependant, may be caused by the high default baud
rate of this card.

I post here my patch below, it may interest someone.

David

----------------------------------------------



@@ -29,7 +29,7 @@
 #define IN_BUFFER_SIZE      4096
 #define OUT_BUFFER_SIZE     4096

-#define DEFAULT_BAUD_BASE   115200
+#define DEFAULT_BAUD_BASE   921600
 #define DEFAULT_TX_FIFO     16

 #define PARITY_MASK         0x03
@@ -316,8 +316,23 @@

     if (testbits(config->config_mask, RTSER_SET_BAUD)) {
         ctx->config.baud_rate =3D config->baud_rate;
-        baud_div =3D (baud_base[dev_id] + (ctx->config.baud_rate >> 1)) /
-                   ctx->config.baud_rate;
+        if (ctx->config.baud_rate =3D=3D 134)
+        {
+          baud_div =3D (2 * baud_base[dev_id] / 269);
+        }
+        else
+        {
+          if (ctx->config.baud_rate)
+          {
+            baud_div =3D baud_base[dev_id] / ctx->config.baud_rate;
+                 if (baud_div =3D=3D 0)
+              baud_div =3D 1;
+               }
+          else
+          {
+                 baud_div =3D 0;
+          }
+        }
         outb(LCR_DLAB,        LCR(dev_id));
         outb(baud_div & 0xff, DLL(dev_id));
         outb(baud_div >> 8,   DLM(dev_id));

