From: trem <tremyfr@domain.hid>
Date: Mon, 28 May 2007 22:08:19 +0200
Message-ID: <f3fcrk$3eg$1@domain.hid>
References: <f3es61$8a2$1@domain.hid>
	<18011.7896.952588.610032@domain.hid>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080007070707020109000004"
In-Reply-To: <18011.7896.952588.610032@domain.hid>
Sender: news <news@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] add tut02-skeleton
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
--------------080007070707020109000004
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi

Thanks for the reply (jan too). I've tried to use all of your feedback,
and I send you the new release of this tut02.

regards,
Philippe


Gilles Chanteperdrix wrote:
> trem wrote:
>  > +	mlockall(MCL_CURRENT | MCL_FUTURE);
> 
> Please show people the right way to code, check the return value of
> mlockall here.
> 
>  > +	if (rtdm_safe_copy_to_user(user_info, buf, buffer.data, size))
>  > +		rtdm_printk("ERROR : can't copy data from driver\n");
>  > +
>  > +	/* clean the kernel buffer */
>  > +	buffer.size = 0;
>  > +
>  > +	return size;
> 
> Same here, if rtdm_safe_copy_to_user returns an error, return that error
> to user-space.
> 
> 
> 


--------------080007070707020109000004
Content-Type: text/x-patch;
 name="tut02-skeleton-v2.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="tut02-skeleton-v2.patch"

Index: tut02-skeleton-app.c
===================================================================
--- tut02-skeleton-app.c	(r���vision 0)
+++ tut02-skeleton-app.c	(r���vision 0)
@@ -0,0 +1,119 @@
+/***************************************************************************
+ *   Copyright (C) 2007 by trem (Philippe Reynes)                          *
+ *   tremyfr@domain.hid                                                      *
+ *                                                                         *
+ *   This program is free software; you can redistribute it and/or modify  *
+ *   it under the terms of the GNU General Public License as published by  *
+ *   the Free Software Foundation; either version 2 of the License, or     *
+ *   (at your option) any later version.                                   *
+ *                                                                         *
+ *   This program is distributed in the hope that it will be useful,       *
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
+ *   GNU General Public License for more details.                          *
+ *                                                                         *
+ *   You should have received a copy of the GNU General Public License     *
+ *   along with this program; if not, write to the                         *
+ *   Free Software Foundation, Inc.,                                       *
+ *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
+ ***************************************************************************/
+
+/**
+ * This is an example that shows how RTDM devices can be used
+ * with a user space program in realtime context.
+ *
+ * The device tut02-skeleton-drv01 stores data that you write into.
+ * When you read from this device, previously stored data is returned,
+ * and the internal buffer is erased. But you can only do a read once per
+ * write. If you try to read more than you have written, the read is
+ * blocked unless a write is done.
+ *
+ * This program does the following:
+ * - If you give an argument to the command line, this argument is written
+ *   in the device (with rt_dev_write)
+ * - If you don't give an argument to the command line, the progam read
+ *   in the device (with rt_dev_read).
+ *
+ * To test this application, you just need to:
+ *
+ * $ export LD_LIBRARY_PATH=<path of xenomai>/lib
+ * $ insmod tut02-skeleton-drv.ko
+ * $ ./tut02-skeleton-app "Hello Master"
+ * $ ./tut02-skeleton-app
+ *
+ */
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <sys/mman.h>	/* for MCL_CURRENT and MCL_FUTURE */
+#include <string.h>		/* for strerror */
+#include <rtdm/rtdm.h>
+#include <native/task.h>
+
+#define DEVICE_NAME		"tut02-skeleton-drv01"
+
+RT_TASK rt_task_desc;
+
+int main(int argc, char *argv[])
+{
+	char buf[1024];
+	ssize_t size;
+	int device;
+	int ret;
+
+	/* no memory-swapping for this programm */
+	ret = mlockall(MCL_CURRENT | MCL_FUTURE);
+	if (ret) {
+		fprintf(stderr, "ERROR : mlockall failled: %s\n", strerror(-ret));
+		fflush(stdout);
+		exit(1);
+	}
+
+	/*
+		change the current task to RT-task
+		the task has no name to allow this program to be run several times
+	*/
+	ret = rt_task_shadow(&rt_task_desc, NULL, 1, 0);
+	if (ret)
+	{
+		fprintf(stderr, "ERROR : rt_task_shadow: %s\n", strerror(-ret));
+		fflush(stdout);
+		exit(1);
+	}
+
+	/* open the device */
+	device = rt_dev_open(DEVICE_NAME, 0);
+	if (device < 0) {
+		printf("ERROR : can't open device %s (%s)\n",
+		       DEVICE_NAME, strerror(-device));
+		fflush(stdout);
+		exit(1);
+	}
+
+	/*
+		if an argument was given on the command line, write it to the device,
+		otherwise, read in the device.
+	*/
+	if (argc == 2)
+	{
+		sprintf(buf, "%s", argv[1]);
+		size = rt_dev_write (device, (const void *)buf, strlen(buf) + 1);
+		printf("Write from device %s\t: %d bytes\n", DEVICE_NAME, size);
+	}
+	else
+	{
+		size = rt_dev_read (device, (void *)buf, 1024);
+		printf("Read in device %s\t: %s\n", DEVICE_NAME, buf);
+	}
+
+	/* close the device */
+	ret = rt_dev_close(device);
+	if (ret < 0) {
+		printf("ERROR : can't close device %s (%s)\n",
+		       DEVICE_NAME, strerror(-ret));
+		fflush(stdout);
+		exit(1);
+	}
+
+	return 0;
+}

Modification de propri���t���s sur tut02-skeleton-app.c
___________________________________________________________________
Nom : svn:eol-style
   + native

Index: tut02-skeleton-drv.c
===================================================================
--- tut02-skeleton-drv.c	(r���vision 0)
+++ tut02-skeleton-drv.c	(r���vision 0)
@@ -0,0 +1,198 @@
+/***************************************************************************
+ *   Copyright (C) 2007 by trem (Philippe Reynes)                          *
+ *   tremyfr@domain.hid                                                      *
+ *                                                                         *
+ *   This program is free software; you can redistribute it and/or modify  *
+ *   it under the terms of the GNU General Public License as published by  *
+ *   the Free Software Foundation; either version 2 of the License, or     *
+ *   (at your option) any later version.                                   *
+ *                                                                         *
+ *   This program is distributed in the hope that it will be useful,       *
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
+ *   GNU General Public License for more details.                          *
+ *                                                                         *
+ *   You should have received a copy of the GNU General Public License     *
+ *   along with this program; if not, write to the                         *
+ *   Free Software Foundation, Inc.,                                       *
+ *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
+ ***************************************************************************/
+
+/**
+ * This kernel driver demonstrates how an RTDM device can be called from
+ * a RT task and how to use a semaphore.
+ *
+ * It is a simple device, only 4 operation are provided:
+ *  - open:  start device usage
+ *  - close: ends device usage
+ *  - write: store transfered data in an internal buffer (realtime context)
+ *  - read:  return previously stored data and erase buffer (realtime context)
+ *
+ */
+
+#include <linux/module.h>
+#include <rtdm/rtdm_driver.h>
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("trem");
+
+#define SIZE_MAX			1024
+#define DEVICE_NAME			"tut02-skeleton-drv01"
+#define SOME_SUB_CLASS			4711
+
+/**
+ * The structure of the buffer
+ *
+ */
+typedef struct buffer_s {
+	int size;
+	char data[SIZE_MAX];
+} buffer_t;
+
+/**
+ * The global buffer
+ *
+ */
+buffer_t buffer;
+
+/**
+ * The global semaphore
+ *
+ */
+rtdm_sem_t sem;
+
+/**
+ * Open the device
+ *
+ * This function is called when the device shall be opened.
+ *
+ */
+static int simple_rtdm_open(struct rtdm_dev_context *context,
+				rtdm_user_info_t * user_info, int oflags)
+{
+	return 0;
+}
+
+/**
+ * Close the device
+ *
+ * This function is called when the device shall be closed.
+ *
+ */
+static int simple_rtdm_close(struct rtdm_dev_context *context,
+				rtdm_user_info_t * user_info)
+{
+	return 0;
+}
+
+/**
+ * Read from the device
+ *
+ * This function is called when the device is read in realtime context.
+ *
+ */
+static ssize_t simple_rtdm_read_rt(struct rtdm_dev_context *context,
+				    rtdm_user_info_t * user_info, void *buf,
+				    size_t nbyte)
+{
+	int ret, size;
+
+	/* take the semaphore */
+	rtdm_sem_down(&sem);
+
+	/* read the kernel buffer and sent it to user space */
+	size = (buffer.size > nbyte) ? nbyte : buffer.size;
+	ret = rtdm_safe_copy_to_user(user_info, buf, buffer.data, size);
+
+	/* if an error has occured, send it to user */
+	if (ret) return ret;
+
+	/* clean the kernel buffer */
+	buffer.size = 0;
+
+	return size;
+}
+
+/**
+ * Write in the device
+ *
+ * This function is called when the device is written in realtime context.
+ *
+ */
+static ssize_t simple_rtdm_write_rt(struct rtdm_dev_context *context,
+				     rtdm_user_info_t * user_info,
+				     const void *buf, size_t nbyte)
+{
+	int ret;
+
+	/* write the user buffer in the kernel buffer */
+	buffer.size = (nbyte > SIZE_MAX) ? SIZE_MAX : nbyte;
+	ret = rtdm_safe_copy_from_user(user_info, buffer.data, buf, buffer.size);
+
+	/* if an error has occured, send it to user */
+	if (ret) return ret;
+
+	/* release the semaphore */
+	rtdm_sem_up(&sem);
+
+	return nbyte;
+}
+
+/**
+ * This structure describe the simple RTDM device
+ *
+ */
+static struct rtdm_device device = {
+	.struct_version = RTDM_DEVICE_STRUCT_VER,
+
+	.device_flags = RTDM_NAMED_DEVICE,
+	.context_size = 0,
+	.device_name = DEVICE_NAME,
+
+	.open_nrt = simple_rtdm_open,
+	.open_rt  = simple_rtdm_open,
+
+	.ops = {
+		.close_nrt = simple_rtdm_close,
+		.close_rt  = simple_rtdm_close,
+		.read_rt   = simple_rtdm_read_rt,
+		.write_rt  = simple_rtdm_write_rt,
+	},
+
+	.device_class = RTDM_CLASS_EXPERIMENTAL,
+	.device_sub_class = SOME_SUB_CLASS,
+	.profile_version = 1,
+	.driver_name = "SimpleRTDM",
+	.driver_version = RTDM_DRIVER_VER(0, 1, 2),
+	.peripheral_name = "Simple RTDM example",
+	.provider_name = "trem",
+	.proc_name = device.device_name,
+};
+
+/**
+ * This function is called when the module is loaded
+ *
+ * It simply registers the RTDM device.
+ *
+ */
+int __init simple_rtdm_init(void)
+{
+	buffer.size = 0;		/* clear the buffer */
+	rtdm_sem_init(&sem, 0);		/* init the global semaphore */
+
+	return rtdm_dev_register(&device);
+}
+
+/**
+ * This function is called when the module is unloaded
+ *
+ * It unregister the RTDM device, polling at 1000 ms for pending users.
+ *
+ */
+void __exit simple_rtdm_exit(void)
+{
+	rtdm_dev_unregister(&device, 1000);
+}
+
+module_init(simple_rtdm_init);
+module_exit(simple_rtdm_exit);

Modification de propri���t���s sur tut02-skeleton-drv.c
___________________________________________________________________
Nom : svn:eol-style
   + native

Index: Makefile
===================================================================
--- Makefile	(r���vision 2484)
+++ Makefile	(copie de travail)
@@ -1,13 +1,13 @@
 ###### CONFIGURATION ######
 
 ### List of applications to be build
-APPLICATIONS = tut01-skeleton-app
+APPLICATIONS = tut01-skeleton-app tut02-skeleton-app
 
 ### Note: to override the search path for the xeno-config script, use "make XENO=..."
 
 
 ### List of modules to be build
-MODULES = heartbeat-x86 tut01-skeleton-drv
+MODULES = heartbeat-x86 tut01-skeleton-drv tut02-skeleton-drv
 
 ### Note: to override the kernel source path, use "make KSRC=..."
 

--------------080007070707020109000004--


