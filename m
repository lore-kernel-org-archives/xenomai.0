Message-ID: <45F68258.5040603@domain.hid>
Date: Tue, 13 Mar 2007 11:52:08 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060208020601090504030203"
Subject: [Xenomai-help] Latencies due to RT-Socket-CAN register accesses
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------060208020601090504030203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hallo,

in the meantime I have measured the latencies introduced through 
messages sent and received by RT-Socket-CAN. The SJA1000 register access 
times on my rather old PC with an Athlon 1100 Mhz are:

PEAK-Dongle: read  access: 11807 ns
PEAK-Dongle: write access: 11677 ns

IXXAT-PCI  : read  access:   729 ns
IXXAT-PCI  : write access:   305 ns

I measured an increase of the latency of approx. 170us with the 
PEAK-Dongle and approx 13us with the IXXAT-PCI card for the reception of 
a full CAN message (with 8 bytes payload). Sending messages is a bit 
less disturbing. I have attached a small patch to measure the SJA1000 
register access times when the driver is initialized. You are welcome to 
apply it on your setup and report the results. I'm especially interested 
in numbers for the ISA bus (or PC-104).

Wolfgang.



--------------060208020601090504030203
Content-Type: text/x-patch;
 name="xenomai-rtcan-iotest.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-rtcan-iotest.patch"

+ diff -u xenomai/ksrc/drivers/can/rtcan_dev.c.IOTEST xenomai/ksrc/drivers/can/rtcan_dev.c
+ diff -u xenomai/ksrc/drivers/can/sja1000/rtcan_sja1000.c.IOTEST xenomai/ksrc/drivers/can/sja1000/rtcan_sja1000.c
--- xenomai/ksrc/drivers/can/sja1000/rtcan_sja1000.c.IOTEST	2007-02-26 09:17:27.000000000 +0100
+++ xenomai/ksrc/drivers/can/sja1000/rtcan_sja1000.c	2007-03-13 10:01:47.000000000 +0100
@@ -728,6 +728,30 @@
     if (chip == NULL)
 	return -EINVAL;
 
+#if 1
+    {
+	nanosecs_abs_t begin, diff;
+	volatile u8 reg;
+	int i, count = 100000;
+	begin = rtdm_clock_read();
+	for (i = 0; i < count; i++) {
+	    reg = chip->read_reg(dev, 0);
+	}
+	diff = rtdm_clock_read() - begin;
+	printk("%s: register read time for %d accessed: %ld (%ld per access)\n",
+	       dev->board_name, count,
+	       (unsigned long)diff, (unsigned long)diff / count);
+	begin = rtdm_clock_read();
+	for (i = 0; i < count; i++) {
+		chip->write_reg(dev, 0, reg);
+	}
+	diff = rtdm_clock_read() - begin;
+	printk("%s: register write time for %d accessed: %ld (%ld per access)\n",
+	       dev->board_name, count,
+	       (unsigned long)diff, (unsigned long)diff / count);
+    }
+#endif
+
     /* Set dummy state for following call */
     dev->state = CAN_STATE_ACTIVE;
     /* Enter reset mode */

--------------060208020601090504030203--

