Message-ID: <43B0923A.6000903@domain.hid>
Date: Tue, 27 Dec 2005 02:00:42 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RTDM Questions
References: <43AC14DD.4070808@domain.hid>
In-Reply-To: <43AC14DD.4070808@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB7E5FA88F2166E4E73A57550"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sean McGranaghan <smm@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB7E5FA88F2166E4E73A57550
Content-Type: multipart/mixed; boundary="------------060901060507030701030504"

This is a multi-part message in MIME format.
--------------060901060507030701030504
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Sean McGranaghan wrote:
> Hello all,
> 
> First all let me say thanks for all the help to this point. This group has 
> always responded quickly to my questions. You are all doinga great job getting 
> the Xenomai system out there and building a comminity around it.
> 
> I have been writing an RTDM driver and came across two issues. I am using 
> Xenomai 2.0 with a 2.6.14.3 Kernel. I have attached a driver and test 
> application to demonstrate the issues. The test driver creates an RT_QUEUE with 
> a simple ioctl() send/recv interface. (This driver is for demonstration only, it 
> does nothing useful) The test application is used to run simple 
> open/close/send/recv operations on the device. The driver is created for 
> exclusive access.
> 
> The driver and test application can be built with the given make files. Once 
> built you can run the test application with no arguments to get the program usage.
> 
> Issue 1: It appears there is a null reference bug in the RTDM code. Load the 
> driver module and then run test 2 of the test application. When the second 
> device open is executed you get a kernel oops instead of a device busy error 
> status. (Please ignore this question if this is fixed in the latest version of 
> 2.0.x. I am in the process of building a new test box with the latest version.)

Kind of zombie bug: I could have sworn having this one fixed in some
earlier RTDM revision, maybe even one of the RTnet-only days. Anyway,
the attached patch (rtdm-excl-dev.patch) fixes it - finally. Thanks for
reporting.

@Philippe: please apply to both trees.

> 
> Issue 2: I am trying to figure out how signals are received and processed in 
> realtime tasks. Here is the scenario. Run test 4. The test application creates a 
> realtime task that waits indefinitely on the RT_QUEUE. The application will wait 
> for a signal from the user (SIGINT). When the signal is sent I can see the 
> kernel log indicate that the driver was interrupted on the queue receive. I 
> would expect the realtime task to get an EINTR back from the ioctl(), but the 
> task never gets control back after the signal. What am I missing here?
> 

Well, this is actually no Xenomai or RTDM issue here. If you don't catch
SIGINT, your process will terminate on arrival. Thus there is no chance
for the test task to grab the driver's EINTR. If you catch it via
signal(), the main thread always seems to get it, not the (real-time)
sub-threads. That's what makes signals so "nice" in multithreaded
environments... Try to play with pthread_sigmask or pthread_kill to
create the test scenario you want.

While reading and testing your code I discovered one pitfall: you did
not register some non-RT close handler. In case the application failed
to close the device, I was not able to enforce a closure via "echo
FILE_DESCR > /proc/xenomai/rtdm/open_fildes". That made your driver
un-removable in this case.

To avoid such issues in the future, especially when we once may add
auto-cleanup during process termination, I decided to enforce the
registeration of a non-RT handler for close (rtdm-nrt-close.patch).

@Philippe: please apply this one to SVN trunk.

Jan

--------------060901060507030701030504
Content-Type: text/x-patch;
 name="rtdm-excl-dev.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rtdm-excl-dev.patch"

Index: ksrc/skins/rtdm/core.c
===================================================================
--- ksrc/skins/rtdm/core.c	(Revision 304)
+++ ksrc/skins/rtdm/core.c	(Arbeitskopie)
@@ -129,7 +129,7 @@
 
     xnlock_put_irqrestore(&rt_fildes_lock, s);
 
-    *context_ptr = context = device->reserved.exclusive_context;
+    context = device->reserved.exclusive_context;
     if (context) {
         xnlock_get_irqsave(&rt_dev_lock, s);
 
@@ -140,6 +140,8 @@
         context->device = device;
 
         xnlock_put_irqrestore(&rt_dev_lock, s);
+
+        *context_ptr = context;
     } else {
         if (nrt_mem)
             context = kmalloc(sizeof(struct rtdm_dev_context) +


--------------060901060507030701030504
Content-Type: text/x-patch;
 name="rtdm-nrt-close.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rtdm-nrt-close.patch"

Index: ksrc/skins/rtdm/device.c
===================================================================
--- ksrc/skins/rtdm/device.c	(Revision 304)
+++ ksrc/skins/rtdm/device.c	(Arbeitskopie)
@@ -233,9 +233,10 @@
             return -EINVAL;
     }
 
-    /* Sanity check: any close handler? */
-    if (NO_HANDLER(device->ops, close)) {
-        xnlogerr("RTDM: no close handler\n");
+    /* Sanity check: non-RT close handler?
+     * (Always required for forced cleanup) */
+    if (!device->ops.close_nrt) {
+        xnlogerr("RTDM: no non-RT close handler\n");
         return -EINVAL;
     }
 


--------------060901060507030701030504--

--------------enigB7E5FA88F2166E4E73A57550
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDsJJBniDOoMHTA+kRAjhRAKCEOKimB093hrkN9Ppbe0VnzJlYMgCfffpo
Reyvxib/UkXd8fl1XifA8H8=
=GR+H
-----END PGP SIGNATURE-----

--------------enigB7E5FA88F2166E4E73A57550--

