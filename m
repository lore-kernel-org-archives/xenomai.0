From: Sebastian Smolorz <ssm@domain.hid>
Date: Mon, 2 Apr 2007 10:09:33 +0200
References: <460C60E9.6010307@domain.hid> <E1HXGoZ-000163-Vn@domain.hid>
	<460D1BF8.3010904@domain.hid>
In-Reply-To: <460D1BF8.3010904@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_+oLEGtwOSD8mTnA"
Message-Id: <E1HYHba-0000MO-IC@mailer.emlix.com>
Subject: [Xenomai-core] Re: iovec overwriting by CAN stack
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

--Boundary-00=_+oLEGtwOSD8mTnA
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Jan Kiszka wrote:
> Sebastian Smolorz wrote:
> > Jan Kiszka wrote:
> >> Sebastian Smolorz wrote:
> >>> Jan Kiszka wrote:
> >>>> Wolfgang Grandegger wrote:
> >>>>> Jan Kiszka wrote:
> >>>>>> Hi Wolfgang,
> >>>>>>
> >>>>>> it's late, so I may have misread somecode, but don't you "update"
> >>>>>> the iovec descriptors a user passes on send/recvmsg on return
> >>>>>> (namely iovec_len)? I received some complaints about this /wrt to
> >>>>>> in-kernel CAN stack usage.
> >>>>>
> >>>>> It's done here:
> >>>>>
> >>>>> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/can/rt
> >>>>>ca n_ raw.c?v=SVN-trunk#881
> >>>>>
> >>>>> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/can/rt
> >>>>>ca n_ raw.c?v=SVN-trunk#734
> >>>>>
> >>>>>
> >>>>> I may have missed something. What are the real complaints? Is there a
> >>>>> test program?
> >>>>
> >>>> Not yet (will commit the related patch to our RACK likely later
> >>>> today). It's simply sending frames while re-using the msg+iovec
> >>>> structs in a loop.
> >>>>
> >>>>>> I always considered the same well-know behaviour of RTnet a bug, but
> >>>>>> now I found your code is doing this systematically, also for user
> >>>>>> space callers. Is this behaviour undefined or even required
> >>>>>> according POSIX or whatever?
> >>>>>
> >>>>> I don't know, it's Sebastian's Kode.
> >>>>
> >>>> Hmm, hope he will not say that he imitated RTnet...
> >>>
> >>> Rather an imitation of the Linux kernel's behaviour. The
> >>> memcpy_toiovec() and memcpy_fromiovec() functions [1] also modify the
> >>> original iovec.
> >>>
> >>>
> >>> [1] http://lxr.free-electrons.com/source/net/core/iovec.c
> >>
> >> But that's the kernel's private (and user-safe) copy. I failed to find
> >> it writing that back to user space.
> >
> > Hm. Ad hoc, I don't recall why the userspace's iovec is also updated.
> > Perhaps my intention was to make the use of rtcan_raw_sendmsg consistent
> > for kernel and userspace RT-Tasks so that both can rely on finding
> > modified iovecs after calling sendmsg/recvmsg. But I'm not absolutely
> > sure if there isn't a better explanation for this. I will try to find the
> > reason in my backup memory. ;-)
>
> So, unless we find some reason why we _must_ modify user's iovec, either
> for send or receive, I would say: kill the user copy-back and work in
> both case (kernel / user space caller) on the local copy of iovec (if we
> still need to modify it all then).

Attached is a patch which leaves the caller's iovec unmodified. It compiles 
successfully (not tested further).

-- 
Sebastian

--Boundary-00=_+oLEGtwOSD8mTnA
Content-Type: text/x-diff; charset="iso-8859-15"; name="rtcan_iovec.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rtcan_iovec.patch"

Index: ChangeLog
===================================================================
--- ChangeLog	(Revision 2348)
+++ ChangeLog	(Arbeitskopie)
@@ -1,3 +1,8 @@
+2007-04-02  Sebastian Smolorz <ssm@domain.hid>
+
+	* ksrc/drivers/can/rtcan_raw.c (rtcan_raw_recvmsg, rtcan_raw_sendmsg):
+	Remove modification of caller's original iovec.
+
 2007-03-31  Philippe Gerum  <rpm@xenomai.org>
 
 	* include/nucleus/queue.h (moveq): Fix source tail pointer.
Index: ksrc/drivers/can/rtcan_raw.c
===================================================================
--- ksrc/drivers/can/rtcan_raw.c	(Revision 2348)
+++ ksrc/drivers/can/rtcan_raw.c	(Arbeitskopie)
@@ -731,13 +731,6 @@ ssize_t rtcan_raw_recvmsg(struct rtdm_de
         if (rtdm_copy_to_user(user_info, iov->iov_base, &frame,
 			      sizeof(can_frame_t)))
             return -EFAULT;
-        /* Adjust iovec in the common way */
-        iov->iov_base += sizeof(can_frame_t);
-        iov->iov_len -= sizeof(can_frame_t);
-        /* ... and copy it, too. */
-        if (rtdm_copy_to_user(user_info, msg->msg_iov, iov,
-			      sizeof(struct iovec)))
-            return -EFAULT;
 
         /* Copy timestamp if existent and wanted */
         if (msg->msg_controllen) {
@@ -762,9 +755,6 @@ ssize_t rtcan_raw_recvmsg(struct rtdm_de
 
         /* Copy CAN frame */
         memcpy(iov->iov_base, &frame, sizeof(can_frame_t));
-        /* Adjust iovec in the common way */
-        iov->iov_base += sizeof(can_frame_t);
-        iov->iov_len -= sizeof(can_frame_t);
 
         /* Copy timestamp if existent and wanted */
         if (msg->msg_controllen) {
@@ -878,16 +868,6 @@ ssize_t rtcan_raw_sendmsg(struct rtdm_de
         frame = &frame_buf;
     }
 
-    /* Adjust iovec in the common way */
-    iov->iov_base += sizeof(can_frame_t);
-    iov->iov_len -= sizeof(can_frame_t);
-    /* ... and copy it back to userspace if necessary */
-    if (user_info) {
-        if (rtdm_copy_to_user(user_info, msg->msg_iov, iov,
-			      sizeof(struct iovec)))
-            return -EFAULT;
-    }
-
     /* At last, we've got the frame ... */
 
     /* Check if DLC between 0 and 15 */

--Boundary-00=_+oLEGtwOSD8mTnA--

