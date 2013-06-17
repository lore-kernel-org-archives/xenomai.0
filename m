Message-ID: <51BE9E2C.9090204@web.de>
Date: Mon, 17 Jun 2013 07:27:08 +0200
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <51BE2859.8000307@gmail.com>
In-Reply-To: <51BE2859.8000307@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] rtdm: minimal patch for sys_rtdm_recvmsg
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

On 2013-06-16 23:04, Manuel Huber wrote:
> Hello!
> =

> I plan to add a minor change to RTnet which allows to get reception
> timestamps through recvmsg:
> =

> SO_TIMESTAMPNS patch:
> http://sourceforge.net/mailarchive/forum.php?thread_name=3D51BAB330.70500=
%40web.de&forum_name=3Drtnet-developers
> <http://sourceforge.net/mailarchive/forum.php?thread_name=3D51BAB330.7050=
0%40web.de&forum_name=3Drtnet-developers>
> =

> =

> Current implementation (of RTDM) in RTAI and Xenomai doesn't fix the
> msg_control and msg_controllen field in struct msghdr. I believe, it
> should be done similar to the linux kernel:
> =

> 1. User specifies how much space has been allocated for control messages
>    - msg_control is set to starting address of buffer
>    - msg_controllen is set to the size of the buffer
> 2. User calls recvmsg
> 3. Control messages are tried to be inserted by some kernel code
> 4. msg_control is set to the next free byte, msg_controllen is updated to
>    the actual space left in the buffer.
> 5. Before copying the struct to the user, msg_control has to be reset to
>    the actual starting address and msg_controllen has to be set to the
>    number of bytes written to the control message buffer rather than the
>    space left.
> 6. Back to user space.
> =

> Current implementation could cause problems: Control messages are
> currently not used but the msg_controllen field inidicates that control
> messages have been written to the buffer; I'm not sure that this is a
> violation of some standard, but at least it's different from the linux
> kernel implementation!
> =

> The patch has been tested on 3.5.7 kernel and is based on SHA
> 69f6cb5ec287afff5ab197528d9eb1177f6de6d6
> (http://git.xenomai.org/xenomai-jki.git) and should work as expected.
> =

> =

> Best Regards
> =

> Manuel
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: Xenomai-0001-rtdm-Fix-msghdr-struct-cmsg-in-sys_rtdm_recvmsg.patch
> Type: text/x-patch
> Size: 1722 bytes
> Desc: not available
> URL:
> <http://www.xenomai.org/pipermail/xenomai/attachments/20130616/18f43ac0/a=
ttachment.bin>
> =


Please post patches inline, makes reviewing easier. The explanatory
part, like above, can be put after the "---" so that it won't show up in
the commit log.

> From 79872fff7bf6536007e1a09c353c4194b0def57c Mon Sep 17 00:00:00 2001
> From: Manuel Huber <Manuel.h87@gmail.com>
> Date: Fri, 14 Jun 2013 10:39:50 +0200
> Subject: [PATCH] rtdm: Fix msghdr struct (cmsg) in sys_rtdm_recvmsg
> =

> Whenever a new control message is put into msg_control buffer
> the actual address and the space left is saved to msg_control
> and msg_controllen. This allows adding messages as long as
> there is enough space left in the user-supplied buffer. Both
> fields have to be fixed again before passing them to the user
> by copying the original starting address of the buffer to
> msg_control and saving the actual amount of bytes written to
> the buffer to msg_controllen.
> ---
>  ksrc/skins/rtdm/syscall.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> =

> diff --git a/ksrc/skins/rtdm/syscall.c b/ksrc/skins/rtdm/syscall.c
> index 0ff5d40..e5d9ae0 100644
> --- a/ksrc/skins/rtdm/syscall.c
> +++ b/ksrc/skins/rtdm/syscall.c
> @@ -79,6 +79,7 @@ static int sys_rtdm_recvmsg(struct pt_regs *regs)
>  {
>  	struct task_struct *p =3D current;
>  	struct msghdr krnl_msg;
> +	void *cmsg_control;
>  	int ret;
>  =

>  	if (unlikely(!access_wok(__xn_reg_arg2(regs),
> @@ -88,11 +89,17 @@ static int sys_rtdm_recvmsg(struct pt_regs *regs)
>  					 sizeof(krnl_msg))))
>  		return -EFAULT;
>  =

> +	cmsg_control =3D krnl_msg.msg_control;
> +
>  	ret =3D __rt_dev_recvmsg(p, __xn_reg_arg1(regs), &krnl_msg,
>  			       __xn_reg_arg3(regs));
>  	if (unlikely(ret < 0))
>  		return ret;
>  =

> +	krnl_msg.msg_controllen =3D (__kernel_size_t)(krnl_msg.msg_control -
> +						    cmsg_control);

So this creates an API between the RTDM core and the driver implementing
msg_control support. Should be documented then (rtdm_recvmsg_handler_t).

> +	krnl_msg.msg_control =3D cmsg_control;
> +
>  	if (unlikely(__xn_copy_to_user((void __user *)__xn_reg_arg2(regs),
>  				       &krnl_msg, sizeof(krnl_msg))))

Let's just only copy back what can change, msg_flags and msg_controllen,
just like the kernel does.

Jan

>  		return -EFAULT;
> -- =

> 1.7.0.4


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130617/dd73cdf=
f/attachment.pgp>
