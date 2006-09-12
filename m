Message-ID: <4506E11A.6030203@domain.hid>
Date: Tue, 12 Sep 2006 18:32:26 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] RTCAN_USE_REFCOUNT issue in rtcan_dev.h
References: <200609121755.04559.mfuchs@domain.hid>
In-Reply-To: <200609121755.04559.mfuchs@domain.hid>
Content-Type: multipart/mixed; boundary="------------020803010502030504070303"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Matthias Fuchs <mfuchs@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------020803010502030504070303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Matthias Fuchs wrote:
> Hi Jan,
> 
> I think there's is little typo in rtcan_dev.h:
> 
> Index: rtcan_dev.h
> ===================================================================
> --- rtcan_dev.h (revision 1564)
> +++ rtcan_dev.h (working copy)
> @@ -45,7 +45,7 @@
>  
>  /* Suppress handling of refcount if module support is not enabled
>   * or modules cannot be unloaded */
> -#if defined(CONFIG_MODULES) && !defined(CONFIG_MODULE_UNLOAD)
> +#if defined(CONFIG_MODULES) && defined(CONFIG_MODULE_UNLOAD)
>  #define RTCAN_USE_REFCOUNT
>  #endif
> 
> 
> This simple patch will allow unloading of modules.

Argh, I interpreted the meaning of CONFIG_MODULE_UNLOAD the other way 
round. But your fix will not work for 2.4, as there is no 
CONFIG_MODULE_UNLOAD. The attached one should be OK.

Thanks.

Wolfgang.

--------------020803010502030504070303
Content-Type: text/x-patch;
 name="xenomai-can-refcount.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-can-refcount.patch"

+ diff -u xenomai/ksrc/drivers/can/rtcan_dev.h.REFCOUNT xenomai/ksrc/drivers/can/rtcan_dev.h
--- xenomai/ksrc/drivers/can/rtcan_dev.h.REFCOUNT	2006-08-23 22:12:20.000000000 +0200
+++ xenomai/ksrc/drivers/can/rtcan_dev.h	2006-09-12 18:28:57.000000000 +0200
@@ -45,7 +45,9 @@
 
 /* Suppress handling of refcount if module support is not enabled
  * or modules cannot be unloaded */
-#if defined(CONFIG_MODULES) && !defined(CONFIG_MODULE_UNLOAD)
+
+#ifdef CONFIG_MODULES
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0) || defined(CONFIG_MODULE_UNLOAD)
 #define RTCAN_USE_REFCOUNT
 #endif
 

--------------020803010502030504070303--

