Message-ID: <461B5C2C.3000500@domain.hid>
Date: Tue, 10 Apr 2007 11:43:08 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <460C60E9.6010307@domain.hid> <E1HYHba-0000MO-IC@mailer.emlix.com>
	<4615323A.9020108@domain.hid> <E1HbAvE-0007tY-D2@domain.hid>
In-Reply-To: <E1HbAvE-0007tY-D2@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig20A15F941BC6F01D05B17311"
Sender: jan.kiszka@domain.hid
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
To: Sebastian Smolorz <ssm@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig20A15F941BC6F01D05B17311
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Sebastian Smolorz wrote:
> Jan Kiszka wrote:
>> Sebastian Smolorz wrote:
>>> Jan Kiszka wrote:
>>>> So, unless we find some reason why we _must_ modify user's iovec, ei=
ther
>>>> for send or receive, I would say: kill the user copy-back and work i=
n
>>>> both case (kernel / user space caller) on the local copy of iovec (i=
f we
>>>> still need to modify it all then).
>>> Attached is a patch which leaves the caller's iovec unmodified. It
>>> compiles successfully (not tested further).
>>>
>>>
>>>
>>> ---------------------------------------------------------------------=
---
>>>
>>> Index: ChangeLog
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> --- ChangeLog	(Revision 2348)
>>> +++ ChangeLog	(Arbeitskopie)
>>> @@ -1,3 +1,8 @@
>>> +2007-04-02  Sebastian Smolorz <ssm@domain.hid>
>>> +
>>> +	* ksrc/drivers/can/rtcan_raw.c (rtcan_raw_recvmsg, rtcan_raw_sendms=
g):
>>> +	Remove modification of caller's original iovec.
>>> +
>>>  2007-03-31  Philippe Gerum  <rpm@xenomai.org>
>>>
>>>  	* include/nucleus/queue.h (moveq): Fix source tail pointer.
>>> Index: ksrc/drivers/can/rtcan_raw.c
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> --- ksrc/drivers/can/rtcan_raw.c	(Revision 2348)
>>> +++ ksrc/drivers/can/rtcan_raw.c	(Arbeitskopie)
>>> @@ -731,13 +731,6 @@ ssize_t rtcan_raw_recvmsg(struct rtdm_de
>>>          if (rtdm_copy_to_user(user_info, iov->iov_base, &frame,
>>>  			      sizeof(can_frame_t)))
>>>              return -EFAULT;
>>> -        /* Adjust iovec in the common way */
>>> -        iov->iov_base +=3D sizeof(can_frame_t);
>>> -        iov->iov_len -=3D sizeof(can_frame_t);
>>> -        /* ... and copy it, too. */
>>> -        if (rtdm_copy_to_user(user_info, msg->msg_iov, iov,
>>> -			      sizeof(struct iovec)))
>>> -            return -EFAULT;
>>>
>>>          /* Copy timestamp if existent and wanted */
>>>          if (msg->msg_controllen) {
>>> @@ -762,9 +755,6 @@ ssize_t rtcan_raw_recvmsg(struct rtdm_de
>>>
>>>          /* Copy CAN frame */
>>>          memcpy(iov->iov_base, &frame, sizeof(can_frame_t));
>>> -        /* Adjust iovec in the common way */
>>> -        iov->iov_base +=3D sizeof(can_frame_t);
>>> -        iov->iov_len -=3D sizeof(can_frame_t);
>>>
>>>          /* Copy timestamp if existent and wanted */
>>>          if (msg->msg_controllen) {
>>> @@ -878,16 +868,6 @@ ssize_t rtcan_raw_sendmsg(struct rtdm_de
>>>          frame =3D &frame_buf;
>>>      }
>>>
>>> -    /* Adjust iovec in the common way */
>>> -    iov->iov_base +=3D sizeof(can_frame_t);
>>> -    iov->iov_len -=3D sizeof(can_frame_t);
>>> -    /* ... and copy it back to userspace if necessary */
>>> -    if (user_info) {
>>> -        if (rtdm_copy_to_user(user_info, msg->msg_iov, iov,
>>> -			      sizeof(struct iovec)))
>>> -            return -EFAULT;
>>> -    }
>>> -
>>>      /* At last, we've got the frame ... */
>>>
>>>      /* Check if DLC between 0 and 15 */
>> Basic ACK (as still no one came up remarking we actually need the upda=
te
>> of iovec).
>>
>> I would just always use struct iovec iov_buf for the internal handling=
,
>> means always copy the original (also from in-kernel users) and simply
>> kill the struct iovec *iov indirection.
>=20
> IMHO this is not necessary because the original iovec is not modified=20
> unexpectedly even if it resides in kernel space.
>=20

It as almost noise, my idea was just to save the additional indirections
(iov->xxx vs. iov_buf.xxx) for the succeeding accesses.


--------------enig20A15F941BC6F01D05B17311
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGG1wsniDOoMHTA+kRAgkGAJ9QgVSLiUqIVuwN/Dw6m9aQmyxAuwCdEDq2
CjUHPR+sQLKi1KcMW8vYh7g=
=1kwc
-----END PGP SIGNATURE-----

--------------enig20A15F941BC6F01D05B17311--

