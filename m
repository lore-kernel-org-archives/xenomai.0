Message-ID: <521091D7.2060308@web.de>
Date: Sun, 18 Aug 2013 11:20:23 +0200
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <1376425460-5853-1-git-send-email-manuel.h87@gmail.com>
	<1376425460-5853-2-git-send-email-manuel.h87@gmail.com>
	<520E0820.5090600@siemens.com> <520F5364.6030507@gmail.com>
In-Reply-To: <520F5364.6030507@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] [PATCH] rtdm: Fix msghdr struct (cmsg) in
	sys_rtdm_recvmsg
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Manuel Huber <manuel.h87@gmail.com>
Cc: xenomai@xenomai.org

On 2013-08-17 12:41, Manuel Huber wrote:
>> This still lacks documentation in rtdm_recvmsg_handler_t that
>> msg_control is supposed to be moved forward by the driver when control
>> data is written to user space.
> Oh, sorry; I forgot to add this....
> Is this description okay:?
> =

>  @param[in,out] msg Message descriptor as passed by the user, automatical=
ly
>  mirrored to safe kernel memory in case of user mode call. If msg_control
>  points to a valid buffer (not NULL) and msg_controllen is > 0, cmsghdr
>  structures can be put into msg_control buffer by driver code. The
>  msg_controllen field has to be decremented accordingly to mirror the
>  actual space left and msg_control shall be incremented to always point
>  to the next free byte.

Decrementing msg_controllen is not part of an interface between core and
driver, is it? Let's keep it straight.

>  If there is insufficient space left, MSG_CTRUNC will be set in msg_flags,

Who will set it, core layer or driver?

>  but the call shall succeed.
>  Before returning, the actual number of bytes written to the msg_control
>  buffer is written to msg_controllen and msg_control is reset to the
> original
>  starting address.

That's confusing. Better state that the core layer will update the
user's msg_controllen field according to the number of bytes the driver
reported to have written (via moving msg_control). This implies that the
user's msg_control field is not updated.

> =

>> Also, you should update existing users
>> of this interface in Xenomai, i.e. the CAN layer.
> Oh, sorry; I just assumed that msg_control has not been used, sorry...
> I checked the drivers and I believe it's only rtcan. There are two
> ways to fix rtcan:
> =

> 1) I can break existing user code by using rt_put_cmsg from my RTnet
> patch (which does the same as put_cmsg from linux kernel) because
> that's how you are supposed to use msg_control buffer (to allow extra
> messages from every layer) and rtcan simply writes the timestamp to
> the buffer (no cmsghdr structure).
> =

> 2) I can just fix current rtcan implementation to work with the
> proposed patch (fixing msg_controllen and msg_control according to the
> protocol in the driver) and not break existing user code but keep
> violating the original protocol (by not using cmsghr).
> =

> 3) 1 + 2: Keep original interface to not break existing user code but
> add a warning when activating RTCAN_RTIOC_TAKE_TIMESTAMP (deprecated
> interface) and implement another interface that complies to the
> protocol and can be used instead (but adds overhead to code compared
> to the current interface...).
> =

> In case 1, 3 I would also like to move rt_put_cmsg to xenomai and
> maybe define SCM_TIMESTAMPNS64 in xenomai and use it in rtcan and
> RTnet to simply copy nanosecs_abs_t (by using rt_put_cmsg). As a
> legacy option I could implement SO_TIMESTAMPNS interface which
> converts nanosecs_abs_t to a timespec struct (as in my RTnet patch
> rt_nanosecs_to_ts ()).
> =

> I would add SCM_TIMESTAMPNS64 (we can rename that...) to rtdm
> header files as a standard option to get timestamps through recvmsg...
> =

> But I can't test rtcan (I think...); Is there someone who can? Change
> 2 is rather simple and should work (without testing) if I'm very
> careful. 1 and especially 3 are bigger changes (maybe 20-30 lines),
> this must be tested;
> =

> I personally like number 3 the most; I would start to implement number
> 2 send the patch and then start developing number 3.
> =

> What do you think?

Starting with option 2 sounds reasonable. We can then discuss
introducing a generic timestamp feature that all RTDM protocol drivers
can implement in the same way while keeping the existing ones of RTCAN
and RTnet for backward compatibility.

Regarding CAN testing: You should be able to work with virtual CAN
adapters, they should also produce timestamps. CC'ing Wolfgang to
confirm this.

Jan


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130818/5e51b83=
5/attachment.pgp>
