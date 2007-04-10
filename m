From: Sebastian Smolorz <ssm@domain.hid>
Date: Tue, 10 Apr 2007 09:37:47 +0200
References: <460C60E9.6010307@domain.hid> <E1HYHba-0000MO-IC@mailer.emlix.com>
	<4615323A.9020108@domain.hid>
In-Reply-To: <4615323A.9020108@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1HbAvE-0007tY-D2@domain.hid>
Subject: Re: [Xenomai-core] iovec overwriting by CAN stack
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

Jan Kiszka wrote:
> Sebastian Smolorz wrote:
> > Jan Kiszka wrote:
> >>
> >> So, unless we find some reason why we _must_ modify user's iovec, either
> >> for send or receive, I would say: kill the user copy-back and work in
> >> both case (kernel / user space caller) on the local copy of iovec (if we
> >> still need to modify it all then).
> >
> > Attached is a patch which leaves the caller's iovec unmodified. It
> > compiles successfully (not tested further).
> >
> >
> >
> > ------------------------------------------------------------------------
> >
> > Index: ChangeLog
> > ===================================================================
> > --- ChangeLog	(Revision 2348)
> > +++ ChangeLog	(Arbeitskopie)
> > @@ -1,3 +1,8 @@
> > +2007-04-02  Sebastian Smolorz <ssm@domain.hid>
> > +
> > +	* ksrc/drivers/can/rtcan_raw.c (rtcan_raw_recvmsg, rtcan_raw_sendmsg):
> > +	Remove modification of caller's original iovec.
> > +
> >  2007-03-31  Philippe Gerum  <rpm@xenomai.org>
> >
> >  	* include/nucleus/queue.h (moveq): Fix source tail pointer.
> > Index: ksrc/drivers/can/rtcan_raw.c
> > ===================================================================
> > --- ksrc/drivers/can/rtcan_raw.c	(Revision 2348)
> > +++ ksrc/drivers/can/rtcan_raw.c	(Arbeitskopie)
> > @@ -731,13 +731,6 @@ ssize_t rtcan_raw_recvmsg(struct rtdm_de
> >          if (rtdm_copy_to_user(user_info, iov->iov_base, &frame,
> >  			      sizeof(can_frame_t)))
> >              return -EFAULT;
> > -        /* Adjust iovec in the common way */
> > -        iov->iov_base += sizeof(can_frame_t);
> > -        iov->iov_len -= sizeof(can_frame_t);
> > -        /* ... and copy it, too. */
> > -        if (rtdm_copy_to_user(user_info, msg->msg_iov, iov,
> > -			      sizeof(struct iovec)))
> > -            return -EFAULT;
> >
> >          /* Copy timestamp if existent and wanted */
> >          if (msg->msg_controllen) {
> > @@ -762,9 +755,6 @@ ssize_t rtcan_raw_recvmsg(struct rtdm_de
> >
> >          /* Copy CAN frame */
> >          memcpy(iov->iov_base, &frame, sizeof(can_frame_t));
> > -        /* Adjust iovec in the common way */
> > -        iov->iov_base += sizeof(can_frame_t);
> > -        iov->iov_len -= sizeof(can_frame_t);
> >
> >          /* Copy timestamp if existent and wanted */
> >          if (msg->msg_controllen) {
> > @@ -878,16 +868,6 @@ ssize_t rtcan_raw_sendmsg(struct rtdm_de
> >          frame = &frame_buf;
> >      }
> >
> > -    /* Adjust iovec in the common way */
> > -    iov->iov_base += sizeof(can_frame_t);
> > -    iov->iov_len -= sizeof(can_frame_t);
> > -    /* ... and copy it back to userspace if necessary */
> > -    if (user_info) {
> > -        if (rtdm_copy_to_user(user_info, msg->msg_iov, iov,
> > -			      sizeof(struct iovec)))
> > -            return -EFAULT;
> > -    }
> > -
> >      /* At last, we've got the frame ... */
> >
> >      /* Check if DLC between 0 and 15 */
>
> Basic ACK (as still no one came up remarking we actually need the update
> of iovec).
>
> I would just always use struct iovec iov_buf for the internal handling,
> means always copy the original (also from in-kernel users) and simply
> kill the struct iovec *iov indirection.

IMHO this is not necessary because the original iovec is not modified 
unexpectedly even if it resides in kernel space.

-- 
Sebastian

