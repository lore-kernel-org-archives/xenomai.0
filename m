Message-ID: <45E7FAE3.2080005@domain.hid>
Date: Fri, 02 Mar 2007 11:22:27 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] problems installing peak CAN dongle
References: <bc4264770703020023o4e15cdafh6e254fff4b225e8a@domain.hid>	<45E7E49C.2000005@domain.hid>	<bc4264770703020123s28450a37n60bb1e49798f32b8@domain.hid>
	<45E7F453.9090803@domain.hid>
In-Reply-To: <45E7F453.9090803@domain.hid>
Content-Type: multipart/mixed; boundary="------------040506060806020009060609"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Markus.Franke@domain.hid
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------040506060806020009060609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Markus Franke wrote:
> I had the same problems with a parallelport dongle. When I removed the
> modules "parport_pc" and "lp" the parallel port device was always
> powered off and it was not possible to receive interrupts anymore. A
> workaround for this "power off" was to append "pnpbios=off"-option to
> the kernel commandline.
> Maybe this can also help you.

Good hint. Roland, could you try that first. I think this does not 
require the parport module loaded, doesn't it?
Attached is a patch registering the PNP device in rtcan_peak_dng.c. This 
should also solve the power-down problem.

Wolfgang.

> Regards,
> Markus Franke
> 
> roland Tollenaar wrote:
>>>> FATAL: Error inserting xeno_can_peak_dng (xeno_can_peak_dng.ko): No
>>> such
>>>> device
>>> Is there som additional kernel output visible via "dmesg"?
>>
>> Yes:
>>
>> SCSI device sdb: 3963904 512-byte hdwr sectors (2030 MB)
>> sdb: Write Protect is off
>> sdb: Mode Sense: 43 00 00 00
>> sdb: assuming drive cache: write through
>> SCSI device sdb: 3963904 512-byte hdwr sectors (2030 MB)
>> sdb: Write Protect is off
>> sdb: Mode Sense: 43 00 00 00
>> sdb: assuming drive cache: write through
>> sdb: sdb1
>> sd 3:0:0:0: Attached scsi removable disk sdb
>> usb-storage: device scan complete
>> ERROR! No SJA1000 device found!
>> ERROR while trying to register SJA1000 device -19!
>> Init failed with -19
>>
>> are the final lines.
>>
>>
>>> How do you have configured the parport in the kernel? Are there modules
>>> loaded (check /proc/modules)? Retry after removing lp and parport_pc:
>>
>> Have looked can't see any. Have attached the output of /proc/modules
>>
>>
>>>    $ rmmod lp
>>>    $ rmmod parport_pc
>>
>> I get a message that it cannot find these modules in /proc/modules
>>
>>
>>
>>
>>
>>> Wolfgang.
>>>
>> ------------------------------------------------------------------------
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
> 


--------------040506060806020009060609
Content-Type: text/x-patch;
 name="xenomai-rtcan-peak-dng-parport.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-rtcan-peak-dng-parport.patch"

+ diff -u xenomai/ksrc/drivers/can/sja1000/rtcan_peak_dng.c.PARPORT xenomai/ksrc/drivers/can/sja1000/rtcan_peak_dng.c
--- xenomai/ksrc/drivers/can/sja1000/rtcan_peak_dng.c.PARPORT	2007-02-26 09:17:27.000000000 +0100
+++ xenomai/ksrc/drivers/can/sja1000/rtcan_peak_dng.c	2007-03-02 11:11:41.000000000 +0100
@@ -23,8 +23,13 @@
 
 #include <linux/module.h>
 #include <linux/ioport.h>
+#include <linux/version.h>
 #include <linux/delay.h>
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
+#include <linux/pnp.h>
+#endif /* Linux >= 2.6.0 */
+
 #include <rtdm/rtdm_driver.h>
 
 /* CAN device profile */
@@ -315,13 +320,44 @@
     rtcan_dev_free(dev);
 }
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
+static const struct pnp_device_id rtcan_peak_dng_pnp_tbl[] = {
+    /* Standard LPT Printer Port */
+    {.id = "PNP0400", .driver_data = 0},
+    /* ECP Printer Port */
+    {.id = "PNP0401", .driver_data = 0},
+    { }
+};
+
+MODULE_DEVICE_TABLE(pnp, rtcan_peak_dng_pnp_tbl);
+
+static int rtcan_peak_dng_pnp_probe(struct pnp_dev *dev,
+				    const struct pnp_device_id *id)
+{
+    return 0;
+}
+
+static struct pnp_driver rtcan_peak_dng_pnp_driver = {
+    .name     = RTCAN_DRV_NAME,
+    .id_table = rtcan_peak_dng_pnp_tbl,
+    .probe    = rtcan_peak_dng_pnp_probe,
+};
+
+static int pnp_registered;
+#endif /* Linux >= 2.6.0 */
+
 /** Init module */
 static int __init rtcan_peak_dng_init(void)
 {
     int i, ret, done = 0;
 
-    for (i = 0; 
-	 i < RTCAN_PEAK_DNG_MAX_DEV && type[i] != 0; 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
+    if (pnp_register_driver(&rtcan_peak_dng_pnp_driver) == 0)
+	pnp_registered = 1;
+#endif /* Linux >= 2.6.0 */
+
+    for (i = 0;
+	 i < RTCAN_PEAK_DNG_MAX_DEV && type[i] != 0;
 	 i++) {
 
 	if ((ret = rtcan_peak_dng_init_one(i)) != 0) {
@@ -332,6 +368,11 @@
     }
     if (done)
 	return 0;
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
+    if (pnp_registered)
+	pnp_unregister_driver(&rtcan_peak_dng_pnp_driver);
+#endif /* Linux >= 2.6.0 */
+
     printk("Please specify type=epp or type=sp\n");
     return -EINVAL;
 }
@@ -343,10 +384,15 @@
     int i;
     struct rtcan_device *dev;
 
-    for (i = 0, dev = rtcan_peak_dng_devs[i]; 
+    for (i = 0, dev = rtcan_peak_dng_devs[i];
 	 i < RTCAN_PEAK_DNG_MAX_DEV && dev != NULL;
 	 i++)
 	rtcan_peak_dng_exit_one(dev);
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
+    if (pnp_registered)
+	pnp_unregister_driver(&rtcan_peak_dng_pnp_driver);
+#endif /* Linux >= 2.6.0 */
 }
 
 module_init(rtcan_peak_dng_init);

--------------040506060806020009060609--

