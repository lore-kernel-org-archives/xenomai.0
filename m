From: trem <tremyfr@domain.hid>
Date: Tue, 21 Aug 2007 00:07:55 +0200
Message-ID: <fad3br$8n0$1@domain.hid>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090702070402080702000408"
Sender: news <news@domain.hid>
Subject: [Xenomai-core] [PATCH] change tut01 to use global buffer
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
--------------090702070402080702000408
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi

As already discussed with Jan, I've changed the tut01. Now :
- it use a global buffer
- tut01-skeleton-app has the same behaviour as tut02-skeleton-app. With
no argument, the program read in the device, with an argument, the
program write in the device.

regards,
Philippe

PS : the website seems to be down

--------------090702070402080702000408
Content-Type: text/x-patch;
 name="change_tut01_to_global_buffer.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="change_tut01_to_global_buffer.patch"

Index: tut01-skeleton-drv.c
===================================================================
--- tut01-skeleton-drv.c	(r���vision 2945)
+++ tut01-skeleton-drv.c	(copie de travail)
@@ -25,7 +25,7 @@
  *  - open:  start device usage
  *  - close: ends device usage
  *  - write: store transfered data in an internal buffer
- *  - read:  return previously stored data and erase buffer
+ *  - read:  return previously stored data
  *
  */
 
@@ -39,17 +39,18 @@
 #define DEVICE_NAME		"tut01-skeleton-drv01"
 #define SOME_SUB_CLASS		4711
 
+
 /**
- * The context of a device instance
+ * The size of the global buffer 
  *
- * A context is created each time a device is opened and passed to
- * other device handlers when they are called.
+ */
+int global_buffer_size = 0;
+
+/**
+ * A global buffer 
  *
  */
-typedef struct buffer_s {
-	int size;
-	char data[SIZE_MAX];
-} buffer_t;
+char global_buffer[SIZE_MAX]; 
 
 /**
  * Open the device
@@ -60,9 +61,6 @@
 static int simple_rtdm_open_nrt(struct rtdm_dev_context *context,
 				rtdm_user_info_t * user_info, int oflags)
 {
-	buffer_t * buffer = (buffer_t *) context->dev_private;
-	buffer->size = 0; /* clear the buffer */
-
 	return 0;
 }
 
@@ -88,11 +86,9 @@
 				    rtdm_user_info_t * user_info, void *buf,
 				    size_t nbyte)
 {
-	buffer_t * buffer = (buffer_t *) context->dev_private;
-	int size = (buffer->size > nbyte) ? nbyte : buffer->size;
+	int size = (global_buffer_size > nbyte) ? nbyte : global_buffer_size; 
 
-	buffer->size = 0;
-	if (rtdm_safe_copy_to_user(user_info, buf, buffer->data, size))
+	if (rtdm_safe_copy_to_user(user_info, buf, global_buffer, size))
 		rtdm_printk("ERROR : can't copy data from driver\n");
 
 	return size;
@@ -108,13 +104,12 @@
 				     rtdm_user_info_t * user_info,
 				     const void *buf, size_t nbyte)
 {
-	buffer_t * buffer = (buffer_t *) context->dev_private;
+	global_buffer_size = (nbyte > SIZE_MAX) ? SIZE_MAX : nbyte;
 
-	buffer->size = (nbyte > SIZE_MAX) ? SIZE_MAX : nbyte;
-	if (rtdm_safe_copy_from_user(user_info, buffer->data, buf, buffer->size))
+	if (rtdm_safe_copy_from_user(user_info, global_buffer, buf, global_buffer_size))
 		rtdm_printk("ERROR : can't copy data to driver\n");
 
-	return nbyte;
+	return global_buffer_size;
 }
 
 /**
@@ -125,7 +120,7 @@
 	.struct_version = RTDM_DEVICE_STRUCT_VER,
 
 	.device_flags = RTDM_NAMED_DEVICE,
-	.context_size = sizeof(buffer_t),
+	.context_size = 0,				/* no context for this device */
 	.device_name = DEVICE_NAME,
 
 	.open_nrt = simple_rtdm_open_nrt,
Index: tut01-skeleton-app.c
===================================================================
--- tut01-skeleton-app.c	(r���vision 2945)
+++ tut01-skeleton-app.c	(copie de travail)
@@ -23,23 +23,20 @@
  * with a user space program.
  *
  * The device tut01-skeleton-drv01 stores data that you write into.
- * When you read from this device, previously stored data is returned,
- * and the internal buffer is erased.
  *
  * This program does the following:
  *  1. open the device (with rt_dev_open)
- *  2. read from the device (with rt_dev_read), so previous data is deleted
- *  3. write "HelloWorld!" in the device (with rt_dev_write)
- *  4. read from the device (with rt_dev_read), it should be "HelloWorld!"
- *  5. read again from the device to check that it contains no data
- *     (deleted on last read)
- *  6. close the device (with rt_dev_close)
+ *  2. read from the device (with rt_dev_read) if no argument
+ *  3. write argument (with rt_dev_write) if an argument is given 
+ *  4. close the device (with rt_dev_close)
  *
  * To test this application, you just need to:
  *
  * $ export LD_LIBRARY_PATH=<path of xenomai>/lib
  * $ insmod tut01-skeleton-drv.ko
  * $ ./tut01-skeleton-app
+ * or
+ * $ ./tut01-skeleton-app "Hi all"
  *
  */
 
@@ -50,7 +47,7 @@
 
 #define DEVICE_NAME		"tut01-skeleton-drv01"
 
-int main(int argc, char *argv)
+int main(int argc, char *argv[])
 {
 	char buf[1024];
 	ssize_t size;
@@ -62,33 +59,28 @@
 	if (device < 0) {
 		printf("ERROR : can't open device %s (%s)\n",
 		       DEVICE_NAME, strerror(-device));
-		fflush(stdout);
 		exit(1);
 	}
 
-	/* first read */
-	size = rt_dev_read (device, (void *)buf, 1024);
-	printf("Read in device %s\t: %d bytes\n", DEVICE_NAME, size);
+        /*
+         * If an argument was given on the command line, write it to the device,
+         * otherwise, read from the device.
+         */
+        if (argc == 2)
+        {
+                sprintf(buf, "%s", argv[1]);
+                size = rt_dev_write (device, (const void *)buf, strlen(buf) + 1);
+                printf("Write from device %s\t: %d bytes\n", DEVICE_NAME, size);
+        } else {
+                size = rt_dev_read (device, (void *)buf, 1024);
+                printf("Read in device %s\t: %s\n", DEVICE_NAME, buf);
+        }
 
-	/* first write */
-	sprintf(buf, "HelloWorld!");
-	size = rt_dev_write (device, (const void *)buf, strlen(buf) + 1);
-	printf("Write from device %s\t: %d bytes\n", DEVICE_NAME, size);
-
-	/* second read */
-	size = rt_dev_read (device, (void *)buf, 1024);
-	printf("Read in device %s\t: %s\n", DEVICE_NAME, buf);
-
-	/* third read */
-	size = rt_dev_read (device, (void *)buf, 1024);
-	printf("Read in device %s\t: %d bytes\n", DEVICE_NAME, size);
-
 	/* close the device */
 	ret = rt_dev_close(device);
 	if (ret < 0) {
 		printf("ERROR : can't close device %s (%s)\n",
 		       DEVICE_NAME, strerror(-ret));
-		fflush(stdout);
 		exit(1);
 	}
 

--------------090702070402080702000408--


