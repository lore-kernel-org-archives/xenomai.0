Message-ID: <4EE22E83.6050406@domain.hid>
Date: Fri, 09 Dec 2011 16:51:31 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
References: <4ED66FD7.4010403@domain.hid> <4EE20EA4.6080305@domain.hid>
In-Reply-To: <4EE20EA4.6080305@domain.hid>
Content-Type: multipart/mixed; boundary="------------010405090401040403060501"
Subject: Re: [Xenomai-core] Analogy/mite
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------010405090401040403060501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 12/09/2011 02:35 PM, Anders Blomdell wrote:
> On 11/30/2011 07:03 PM, Anders Blomdell wrote:
>> Hi, just found that
>>
>> echo 0000:06:01.0 > /sys/bus/pci/drivers/analogy_mite/unbind
>>
>> does not do the same thing as
>>
>> analogy_config -r analogyN
>>
>> in fact it leaves the system in a state where using the driver results
>> in a kernel OOPS.
>>
>> Will try to look into it further tomorrow...
> Well, took quite some time to track down the 'analogy_config -r' bug
> (which was responsible for the kernel OOPS [i.e. after fixing it I have
> not got any OOPSes]).
>
> So back to the original problem, does anybody foresee that a call to
> a4l_ioctl_devcfg(cxt, NULL) from the mite driver would give any problems
> (apart from getting the context pointer from the data structures the
> mite driver has handy)? It is probably not kosher to do ioctl on a
> driver that is not open, but...
Attached is a hack (as can be gleaned from the EXPORT_SYMBOL_GPL), if 
the basic assumption that it's ok to do a a4l_ioctl_devcfg(...) during 
unbind, I could rewrite the logic to pass down a pointer to 
a4l_ioctl_devcfg to avoid this.

/Anders


-- 
Anders Blomdell                  Email: anders.blomdell@domain.hid
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden


--------------010405090401040403060501
Content-Type: text/x-patch;
 name="mite_unbind.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="mite_unbind.patch"

diff -ur xenomai-2.6.0.orig/include/analogy/device.h xenomai-2.6.0/include/analogy/device.h
--- xenomai-2.6.0.orig/include/analogy/device.h	2011-12-09 16:37:46.777999756 +0100
+++ xenomai-2.6.0/include/analogy/device.h	2011-12-09 16:41:18.660003797 +0100
@@ -43,9 +43,9 @@
 	/* Device specific flags */
 	unsigned long flags;
 
-	/* Driver assigned to this device thanks to attaching
-	   procedure */
+	/* Fields assigned to this device in attaching procedure */
 	a4l_drv_t *driver;
+	a4l_cxt_t *cxt;
 
 	/* Hidden description stuff */
 	struct list_head subdvsq;
diff -ur xenomai-2.6.0.orig/ksrc/drivers/analogy/device.c xenomai-2.6.0/ksrc/drivers/analogy/device.c
--- xenomai-2.6.0.orig/ksrc/drivers/analogy/device.c	2011-12-09 16:37:48.497999755 +0100
+++ xenomai-2.6.0/ksrc/drivers/analogy/device.c	2011-12-09 16:42:23.163001790 +0100
@@ -291,6 +291,7 @@
 	a4l_dev_t *dev = a4l_get_dev(cxt);
 
 	dev->driver = drv;
+	dev->cxt = cxt;
 
 	if (drv->privdata_size == 0)
 		__a4l_dbg(1, core_dbg,
@@ -331,6 +332,7 @@
 	if (ret != 0 && dev->priv != NULL) {
 		rtdm_free(dev->priv);
 		dev->driver = NULL;
+		dev->cxt = NULL;
 	}
 
 	return ret;
@@ -360,6 +362,7 @@
 	/* Free the private field */
 	rtdm_free(dev->priv);
 	dev->driver = NULL;
+	dev->cxt = NULL;
 
 out_release_driver:
 	return ret;
@@ -455,6 +458,7 @@
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(a4l_ioctl_devcfg);
 
 int a4l_ioctl_devinfo(a4l_cxt_t * cxt, void *arg)
 {
diff -ur xenomai-2.6.0.orig/ksrc/drivers/analogy/national_instruments/mite.c xenomai-2.6.0/ksrc/drivers/analogy/national_instruments/mite.c
--- xenomai-2.6.0.orig/ksrc/drivers/analogy/national_instruments/mite.c	2011-12-09 16:37:48.499999755 +0100
+++ xenomai-2.6.0/ksrc/drivers/analogy/national_instruments/mite.c	2011-12-09 16:43:04.147002142 +0100
@@ -103,6 +103,9 @@
 			list_entry(this, struct mite_struct, list);
 
 		if(mite->pcidev == dev) {
+			if (mite->a4ldev) {
+				a4l_ioctl_devcfg(mite->a4ldev->cxt, NULL);
+			}
 			list_del(this);
 			kfree(mite);
 			break;
@@ -117,7 +120,8 @@
 	.remove = mite_remove,
 };
 
-int a4l_mite_setup(struct mite_struct *mite, int use_iodwbsr_1)
+int a4l_mite_setup(struct mite_struct *mite, int use_iodwbsr_1,
+		   struct a4l_device *a4ldev)
 {
 	unsigned long length;
 	resource_size_t addr;
@@ -232,6 +236,7 @@
 	}
 
 	mite->used = 1;
+	mite->a4ldev = a4ldev;
 
 	return 0;
 }
@@ -255,6 +260,7 @@
 		pci_release_regions( mite->pcidev );
 
 	mite->used = 0;
+	mite->a4ldev = NULL;
 }
 
 void a4l_mite_list_devices(void)
diff -ur xenomai-2.6.0.orig/ksrc/drivers/analogy/national_instruments/mite.h xenomai-2.6.0/ksrc/drivers/analogy/national_instruments/mite.h
--- xenomai-2.6.0.orig/ksrc/drivers/analogy/national_instruments/mite.h	2011-12-09 16:37:48.499999755 +0100
+++ xenomai-2.6.0/ksrc/drivers/analogy/national_instruments/mite.h	2011-12-09 16:38:33.976999742 +0100
@@ -70,6 +70,7 @@
 	void *mite_io_addr;
 	resource_size_t daq_phys_addr;
 	void *daq_io_addr;
+	struct a4l_device *a4ldev;
 };
 
 static inline
@@ -115,7 +116,8 @@
 	return mite->pcidev->device;
 };
 
-int a4l_mite_setup(struct mite_struct *mite, int use_iodwbsr_1);
+int a4l_mite_setup(struct mite_struct *mite, int use_iodwbsr_1,
+		   struct a4l_device *a4ldev);
 void a4l_mite_unsetup(struct mite_struct *mite);
 void a4l_mite_list_devices(void);
 struct mite_struct * a4l_mite_find_device(int bus,
diff -ur xenomai-2.6.0.orig/ksrc/drivers/analogy/national_instruments/ni_660x.c xenomai-2.6.0/ksrc/drivers/analogy/national_instruments/ni_660x.c
--- xenomai-2.6.0.orig/ksrc/drivers/analogy/national_instruments/ni_660x.c	2011-12-09 16:37:48.500999755 +0100
+++ xenomai-2.6.0/ksrc/drivers/analogy/national_instruments/ni_660x.c	2011-12-09 16:38:34.215999736 +0100
@@ -1102,7 +1102,7 @@
 		private(dev)->pfi_output_selects[i] = pfi_output_select_counter;
 	}
 	
-	ret = a4l_mite_setup(private(dev)->mite, 1);
+	ret = a4l_mite_setup(private(dev)->mite, 1, dev);
 	if (ret < 0) {
 		a4l_err(dev, "%s: error setting up mite\n", __FUNCTION__);
 		return ret;
diff -ur xenomai-2.6.0.orig/ksrc/drivers/analogy/national_instruments/ni_670x.c xenomai-2.6.0/ksrc/drivers/analogy/national_instruments/ni_670x.c
--- xenomai-2.6.0.orig/ksrc/drivers/analogy/national_instruments/ni_670x.c	2011-12-09 16:37:48.500999755 +0100
+++ xenomai-2.6.0/ksrc/drivers/analogy/national_instruments/ni_670x.c	2011-12-09 16:38:34.215999737 +0100
@@ -297,7 +297,7 @@
 	devpriv->mite = mite;
 	devpriv->board_ptr = board;
 	
-	ret = a4l_mite_setup(devpriv->mite, 0);
+	ret = a4l_mite_setup(devpriv->mite, 0, dev);
 	if (ret < 0) {
 		a4l_err(dev, "%s: error setting up mite\n", __FUNCTION__);
 		return ret;
diff -ur xenomai-2.6.0.orig/ksrc/drivers/analogy/national_instruments/pcimio.c xenomai-2.6.0/ksrc/drivers/analogy/national_instruments/pcimio.c
--- xenomai-2.6.0.orig/ksrc/drivers/analogy/national_instruments/pcimio.c	2011-12-09 16:37:48.499999755 +0100
+++ xenomai-2.6.0/ksrc/drivers/analogy/national_instruments/pcimio.c	2011-12-09 16:38:34.099999737 +0100
@@ -1524,7 +1524,7 @@
 		devpriv->stc_readl = &win_in2;
 	}
 
-	ret = a4l_mite_setup(devpriv->mite, 0);
+	ret = a4l_mite_setup(devpriv->mite, 0, dev);
 	if(ret < 0)
 	{
 		a4l_err(dev, "pcmio_attach: error setting up mite\n");

--------------010405090401040403060501--

