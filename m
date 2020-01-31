From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 1/8] doc: fix assorted Doxygen warnings
Date: Fri, 31 Jan 2020 16:27:06 +0100
Message-Id: <20200131152713.1811748-2-rpm@xenomai.org>
In-Reply-To: <20200131152713.1811748-1-rpm@xenomai.org>
References: <20200131152713.1811748-1-rpm@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Philippe Gerum <rpm@xenomai.org>

WARN_IF_UNDOCUMENTED is switched to "NO" to prevent a truckload of
useless warnings from Doxygen since most ioctl calls are not
documented.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 doc/doxygen/xeno3prm-common.conf.in            | 13 ++++---------
 include/cobalt/kernel/rtdm/analogy/subdevice.h |  2 --
 include/cobalt/kernel/rtdm/driver.h            |  6 ++----
 include/cobalt/kernel/stat.h                   |  2 +-
 include/cobalt/kernel/timer.h                  |  2 --
 include/rtdm/uapi/can.h                        |  4 ++--
 kernel/cobalt/rtdm/device.c                    |  2 +-
 kernel/cobalt/timer.c                          |  3 +++
 8 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/doc/doxygen/xeno3prm-common.conf.in b/doc/doxygen/xeno3prm-common.conf.in
index 097a5827a..cd7765053 100644
--- a/doc/doxygen/xeno3prm-common.conf.in
+++ b/doc/doxygen/xeno3prm-common.conf.in
@@ -131,9 +131,9 @@ TAB_SIZE               = 8
 # You can put \n's in the value part of an alias to insert newlines.
 
 ALIASES                = \
- 		       "coretags{1}=@par Tags\n@ref cobalt-core-tags \"\1\""	\
- 		       "apitags{1}=@par Tags\n@ref api-tags \"\1\""	\
-		       "sideeffect=@par Side effects\n"
+ 		       "coretags{1}=@par Tags^^@ref cobalt-core-tags \"\1\""	\
+ 		       "apitags{1}=@par Tags^^@ref api-tags \"\1\""	\
+		       "sideeffect=@par Side effects^^"
 
 # Set the OPTIMIZE_OUTPUT_FOR_C tag to YES if your project consists of C sources 
 # only. Doxygen will then generate output that is more tailored for C. 
@@ -316,7 +316,7 @@ WARNINGS               = YES
 # for undocumented members. If EXTRACT_ALL is set to YES then this flag will 
 # automatically be disabled.
 
-WARN_IF_UNDOCUMENTED   = YES
+WARN_IF_UNDOCUMENTED   = NO
 
 # If WARN_IF_DOC_ERROR is set to YES, doxygen will generate warnings for 
 # potential errors in the documentation, such as not documenting some 
@@ -710,11 +710,6 @@ ALLEXTERNALS           = NO
 
 EXTERNAL_GROUPS        = YES
 
-# The PERL_PATH should be the absolute path and name of the perl script 
-# interpreter (i.e. the result of `which perl').
-
-PERL_PATH              = /usr/bin/perl
-
 #---------------------------------------------------------------------------
 # Configuration options related to the dot tool   
 #---------------------------------------------------------------------------
diff --git a/include/cobalt/kernel/rtdm/analogy/subdevice.h b/include/cobalt/kernel/rtdm/analogy/subdevice.h
index 62433c7e1..21c09dfb9 100644
--- a/include/cobalt/kernel/rtdm/analogy/subdevice.h
+++ b/include/cobalt/kernel/rtdm/analogy/subdevice.h
@@ -89,8 +89,6 @@ struct a4l_subdevice {
 		  /**< Private data */
 };
 
-/*! @} subdevice */
-
 /* --- Subdevice related functions and macros --- */
 
 struct a4l_channel *a4l_get_chfeat(struct a4l_subdevice * sb, int idx);
diff --git a/include/cobalt/kernel/rtdm/driver.h b/include/cobalt/kernel/rtdm/driver.h
index 57495f12f..894e6f67e 100644
--- a/include/cobalt/kernel/rtdm/driver.h
+++ b/include/cobalt/kernel/rtdm/driver.h
@@ -210,7 +210,7 @@ static inline struct rtdm_device *rtdm_fd_device(struct rtdm_fd *fd)
  * This descriptor details the profile information associated to a
  * RTDM class of device managed by a driver.
  *
- * @anchor rtdm_profile_info @name RTDM profile information descriptor
+ * @anchor rtdm_profile_info
  */
 struct rtdm_profile_info {
 	/** Device class name */
@@ -218,7 +218,7 @@ struct rtdm_profile_info {
 	/** Device class ID, see @ref RTDM_CLASS_xxx */
 	int class_id;
 	/** Device sub-class, see RTDM_SUBCLASS_xxx definition in the
-	 *  @ref rtdm_profiles "Device Profiles" */
+	    @ref rtdm_profiles "Device Profiles" */
 	int subclass_id;
 	/** Supported device profile version */
 	int version;
@@ -389,8 +389,6 @@ struct rtdm_device {
 	};
 };
 
-/** @} devregister */
-
 /* --- device registration --- */
 
 int rtdm_dev_register(struct rtdm_device *device);
diff --git a/include/cobalt/kernel/stat.h b/include/cobalt/kernel/stat.h
index 2e0651417..b857cd19f 100644
--- a/include/cobalt/kernel/stat.h
+++ b/include/cobalt/kernel/stat.h
@@ -22,7 +22,7 @@
 
 #include <cobalt/kernel/clock.h>
 
-/*
+/**
  * @ingroup cobalt_core_thread
  * @defgroup cobalt_core_stat Thread runtime statistics
  * @{
diff --git a/include/cobalt/kernel/timer.h b/include/cobalt/kernel/timer.h
index 3ea2d3ce3..889504324 100644
--- a/include/cobalt/kernel/timer.h
+++ b/include/cobalt/kernel/timer.h
@@ -502,8 +502,6 @@ static inline void xntimer_dequeue(struct xntimer *timer,
 	timer->status |= XNTIMER_DEQUEUED;
 }
 
-/** @} */
-
 unsigned long long xntimer_get_overruns(struct xntimer *timer,
 					struct xnthread *waiter,
 					xnticks_t now);
diff --git a/include/rtdm/uapi/can.h b/include/rtdm/uapi/can.h
index a33003f68..8d0d837d5 100644
--- a/include/rtdm/uapi/can.h
+++ b/include/rtdm/uapi/can.h
@@ -466,9 +466,9 @@ struct can_ifreq {
  * @anchor CANIOCTLs @name IOCTLs
  * CAN device IOCTLs
  *
- * @deprecated Passing <TT>struct ifreq<TT> as a request descriptor
+ * @deprecated Passing \c struct \c ifreq as a request descriptor
  * for CAN IOCTLs is still accepted for backward compatibility,
- * however it is recommended to switch to <TT>struct can_ifreq<TT> at
+ * however it is recommended to switch to \c struct \c can_ifreq at
  * the first opportunity.
  *
  * @{ */
diff --git a/kernel/cobalt/rtdm/device.c b/kernel/cobalt/rtdm/device.c
index 7d76d2cc5..736e82da7 100644
--- a/kernel/cobalt/rtdm/device.c
+++ b/kernel/cobalt/rtdm/device.c
@@ -646,4 +646,4 @@ void rtdm_cleanup(void)
 	 */
 }
 
-/*@}*/
+/** @} */
diff --git a/kernel/cobalt/timer.c b/kernel/cobalt/timer.c
index ae3f2e5ba..b8b60c4e5 100644
--- a/kernel/cobalt/timer.c
+++ b/kernel/cobalt/timer.c
@@ -601,6 +601,9 @@ void xntimer_release_ipi(void)
  *
  * @param timer The address of a valid timer descriptor.
  *
+ * @param waiter The thread for which the overrun count is being
+ * collected.
+ *
  * @param now current date (as
  * xnclock_read_raw(xntimer_clock(timer)))
  *
-- 
2.24.1


