Date: Thu, 7 May 2009 16:23:28 -0700 (PDT)
From: Martin Shepherd <mcs@domain.hid>
In-Reply-To: <4A029C21.2010605@domain.hid>
Message-ID: <Pine.LNX.4.64.0905071343410.16550@domain.hid>
References: <Pine.LNX.4.64.0905061412070.24701@domain.hid>
	<4A029C21.2010605@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Xenomai-help] Selecting the appropriate RTDM _rt/_nrt ioctl at
	run-time.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org


On Thu, 7 May 2009, Jan Kiszka wrote:
> Maybe you want to study ksrc/drivers/serial16550A.c a bit. It comes with
> some (IOCTL) use cases that should be similar to yours.

Yes I'd noticed that there was an ioctl request in that code that
returned -ENOSYS when that request couldn't be serviced in the current
context, but I didn't realize that this was doing anything other than
pushing the problem back on the application, by making the
application's call to rt_dev_ioctl() fail with a -ENOSYS error.

However today I went through the code that implements the syscall
interfacing between RTDM and Xenomai, and I discovered that RTDM uses
the __xn_exec_adaptive system-call flag to tell Xenomai to restart
RTDM system calls that return -ENOSYS. So I now realize that in your
serial driver, returning -ENOSYS wasn't pushing the problem back on
the user, as I thought, but rather remedying the situation by
requesting that Xenomai call the ioctl() again from the opposite
context. This really needs to be documented, not only for those people
who like myself need to know how to use -ENOSYS in this way, but also
to prevent people from innocently returning -ENOSYS for some other
error condition, and then wondering why on earth Xenomai calls the
failed handler twice.

Just to check that I haven't misunderstood anything, am I correct in
saying that if my ioctl() returns -ENOSYS, then Xenomai will re-run
the ioctl() from the opposite realtime or non-realtime context?

Assuming that the above is true, the following is a patch to update
the doxygen documentation embedded in rtdm_driver.h, to document the
special meaning of returning -ENOSYS. This patch was performed against
a newly cloned copy of xenomai-head.

diff -Naur xenomai-head/include/rtdm/rtdm_driver.h xenomai-head-edited/include/rtdm/rtdm_driver.h
--- xenomai-head/include/rtdm/rtdm_driver.h	2009-05-07 15:57:59.000000000 -0700
+++ xenomai-head-edited/include/rtdm/rtdm_driver.h	2009-05-07 15:30:20.000000000 -0700
@@ -159,7 +159,9 @@
   * NULL if kernel mode call
   * @param[in] oflag Open flags as passed by the user
   *
- * @return 0 on success, otherwise negative error code
+ * @return 0 on success. On failure return either -ENOSYS, to request that
+ * this handler be called again from the opposite realtime/non-realtime
+ * context, or another negative error code.
   *
   * @see @c open() in IEEE Std 1003.1,
   * http://www.opengroup.org/onlinepubs/009695399 */
@@ -174,7 +176,9 @@
   * NULL if kernel mode call
   * @param[in] protocol Protocol number as passed by the user
   *
- * @return 0 on success, otherwise negative error code
+ * @return 0 on success. On failure return either -ENOSYS, to request that
+ * this handler be called again from the opposite realtime/non-realtime
+ * context, or another negative error code.
   *
   * @see @c socket() in IEEE Std 1003.1,
   * http://www.opengroup.org/onlinepubs/009695399 */
@@ -188,7 +192,9 @@
   * @param[in] user_info Opaque pointer to information about user mode caller,
   * NULL if kernel mode call
   *
- * @return 0 on success, otherwise negative error code
+ * @return 0 on success. On failure return either -ENOSYS, to request that
+ * this handler be called again from the opposite realtime/non-realtime
+ * context, or another negative error code.
   *
   * @see @c close() in IEEE Std 1003.1,
   * http://www.opengroup.org/onlinepubs/009695399 */
@@ -204,7 +210,9 @@
   * @param[in] request Request number as passed by the user
   * @param[in,out] arg Request argument as passed by the user
   *
- * @return Positiv value on success, otherwise negative error code
+ * @return A positive value or 0 on success. On failure return either
+ * -ENOSYS, to request that the function be called again from the opposite
+ * realtime/non-realtime context, or another negative error code.
   *
   * @see @c ioctl() in IEEE Std 1003.1,
   * http://www.opengroup.org/onlinepubs/009695399 */
@@ -221,7 +229,9 @@
   * @param[in] fd_index Opaque value, to be passed to rtdm_event_select_bind or
   * rtdm_sem_select_bind unmodfied
   *
- * @return 0 on success, otherwise negative error code
+ * @return 0 on success. On failure return either -ENOSYS, to request that
+ * this handler be called again from the opposite realtime/non-realtime
+ * context, or another negative error code.
   */
  typedef int (*rtdm_select_bind_handler_t)(struct rtdm_dev_context *context,
  					  rtdm_selector_t *selector,
@@ -237,7 +247,9 @@
   * @param[out] buf Input buffer as passed by the user
   * @param[in] nbyte Number of bytes the user requests to read
   *
- * @return On success, the number of bytes read, otherwise negative error code
+ * @return On success, the number of bytes read. On failure return either
+ * -ENOSYS, to request that this handler be called again from the opposite
+ * realtime/non-realtime context, or another negative error code.
   *
   * @see @c read() in IEEE Std 1003.1,
   * http://www.opengroup.org/onlinepubs/009695399 */
@@ -254,8 +266,9 @@
   * @param[in] buf Output buffer as passed by the user
   * @param[in] nbyte Number of bytes the user requests to write
   *
- * @return On success, the number of bytes written, otherwise negative error
- * code
+ * @return On success, the number of bytes written. On failure return
+ * either -ENOSYS, to request that this handler be called again from the
+ * opposite realtime/non-realtime context, or another negative error code.
   *
   * @see @c write() in IEEE Std 1003.1,
   * http://www.opengroup.org/onlinepubs/009695399 */
@@ -273,8 +286,9 @@
   * mirrored to safe kernel memory in case of user mode call
   * @param[in] flags Message flags as passed by the user
   *
- * @return On success, the number of bytes received, otherwise negative error
- * code
+ * @return On success, the number of bytes received. On failure return
+ * either -ENOSYS, to request that this handler be called again from the
+ * opposite realtime/non-realtime context, or another negative error code.
   *
   * @see @c recvmsg() in IEEE Std 1003.1,
   * http://www.opengroup.org/onlinepubs/009695399 */
@@ -292,8 +306,9 @@
   * mirrored to safe kernel memory in case of user mode call
   * @param[in] flags Message flags as passed by the user
   *
- * @return On success, the number of bytes transmitted, otherwise negative
- * error code
+ * @return On success, the number of bytes transmitted. On failure return
+ * either -ENOSYS, to request that this handler be called again from the
+ * opposite realtime/non-realtime context, or another negative error code.
   *
   * @see @c sendmsg() in IEEE Std 1003.1,
   * http://www.opengroup.org/onlinepubs/009695399 */

