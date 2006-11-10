Message-ID: <4554636C.4070704@domain.hid>
Date: Fri, 10 Nov 2006 12:33:00 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010405030304000308050600"
Subject: [Xenomai-core] [PATCH] Doxygen hyperlinking utilitiy and demo
	programs
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------010405030304000308050600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

the attached patch adds the RT-Socket-CAN utility programs as examples 
to the Doxygen documentation setup. This creates some nice cross 
reference from the documented API functions to the example code lines 
and vice versa. In a similar way, the Xenomai demo programs and code 
snippets could be integrated making it much easier to find example code 
or the description of an API function used in an example.

Please have a look and comment?

Thanks.

Wolfgang.

--------------010405030304000308050600
Content-Type: text/x-patch;
 name="xenomai-doxygen-examples.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-doxygen-examples.patch"

Index: include/rtdm/rtcan.h
===================================================================
--- include/rtdm/rtcan.h	(revision 1810)
+++ include/rtdm/rtcan.h	(working copy)
@@ -1116,7 +1116,15 @@
 
 /** @} */
 
+/*!
+ * @anchor Utilities @name CAN test and utility functions
+ * @{ */
+/** @example rtcanconfig.c */
+/** @example rtcansend.c */
+/** @example rtcanrecv.c */
 /** @} */
 
+/** @} */
 
+
 #endif /* _RTCAN_H */
Index: doc/doxygen/Doxyfile-common.in
===================================================================
--- doc/doxygen/Doxyfile-common.in	(revision 1810)
+++ doc/doxygen/Doxyfile-common.in	(working copy)
@@ -383,27 +383,27 @@
 # EXCLUDE_PATTERNS tag to specify one or more wildcard patterns to exclude 
 # certain files from those directories.
 
-EXCLUDE_PATTERNS       = 
+EXCLUDE_PATTERNS       = "*.c"
 
 # The EXAMPLE_PATH tag can be used to specify one or more files or 
 # directories that contain example code fragments that are included (see 
 # the \include command).
 
-EXAMPLE_PATH           = 
+EXAMPLE_PATH           = ../../src/utils
 
 # If the value of the EXAMPLE_PATH tag contains directories, you can use the 
 # EXAMPLE_PATTERNS tag to specify one or more wildcard pattern (like *.cpp 
 # and *.h) to filter out the source-files in the directories. If left 
 # blank all files are included.
 
-EXAMPLE_PATTERNS       = 
+EXAMPLE_PATTERNS       =
 
 # If the EXAMPLE_RECURSIVE tag is set to YES then subdirectories will be 
 # searched for input files to be used with the \include or \dontinclude 
 # commands irrespective of the value of the RECURSIVE tag. 
 # Possible values are YES and NO. If left blank NO is used.
 
-EXAMPLE_RECURSIVE      = NO
+EXAMPLE_RECURSIVE      = YES
 
 # The IMAGE_PATH tag can be used to specify one or more files or 
 # directories that contain image that are included in the documentation (see 

--------------010405030304000308050600--

