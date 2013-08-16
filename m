Message-ID: <520E0820.5090600@siemens.com>
Date: Fri, 16 Aug 2013 13:08:16 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <1376425460-5853-1-git-send-email-manuel.h87@gmail.com>
	<1376425460-5853-2-git-send-email-manuel.h87@gmail.com>
In-Reply-To: <1376425460-5853-2-git-send-email-manuel.h87@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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

On 2013-08-13 22:24, Manuel Huber wrote:
> From: Manuel Huber <Manuel.h87@gmail.com>
> 
> Whenever a new control message is put into msg_control buffer
> the actual address and the space left is saved to msg_control
> and msg_controllen. This allows adding messages as long as
> there is enough space left in the user-supplied buffer. Both
> fields have to be fixed again before passing them to the user
> by copying the original starting address of the buffer to
> msg_control and saving the actual amount of bytes written to
> the buffer to msg_controllen.
> 
> * Explicit use of __xn_put_user rather then __xn_copy_to_user
> * Don't write back msg->msg_namelen
> ---
>  ksrc/skins/rtdm/syscall.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/ksrc/skins/rtdm/syscall.c b/ksrc/skins/rtdm/syscall.c
> index 0ff5d40..7dd20e3 100644
> --- a/ksrc/skins/rtdm/syscall.c
> +++ b/ksrc/skins/rtdm/syscall.c
> @@ -79,22 +79,31 @@ static int sys_rtdm_recvmsg(struct pt_regs *regs)
>  {
>  	struct task_struct *p = current;
>  	struct msghdr krnl_msg;
> +	void *cmsg_control;
> +	struct msghdr __user *usr_msg;
>  	int ret;
>  
> -	if (unlikely(!access_wok(__xn_reg_arg2(regs),
> +	usr_msg = (void __user *)__xn_reg_arg2(regs);
> +
> +	if (unlikely(!access_wok((void __user *)usr_msg,
>  				 sizeof(krnl_msg)) ||
>  		     __xn_copy_from_user(&krnl_msg,
> -					 (void __user *)__xn_reg_arg2(regs),
> +					 (void __user *)usr_msg,
>  					 sizeof(krnl_msg))))
>  		return -EFAULT;
>  
> +	cmsg_control = krnl_msg.msg_control;
> +
>  	ret = __rt_dev_recvmsg(p, __xn_reg_arg1(regs), &krnl_msg,
>  			       __xn_reg_arg3(regs));
>  	if (unlikely(ret < 0))
>  		return ret;
>  
> -	if (unlikely(__xn_copy_to_user((void __user *)__xn_reg_arg2(regs),
> -				       &krnl_msg, sizeof(krnl_msg))))
> +	if (unlikely(__xn_put_user((typeof(krnl_msg.msg_controllen))(
> +					   krnl_msg.msg_control - cmsg_control),

This still lacks documentation in rtdm_recvmsg_handler_t that
msg_control is supposed to be moved forward by the driver when control
data is written to user space.

Also, you should update existing users of this interface in Xenomai,
i.e. the CAN layer.

> +				   (void __user *)&usr_msg->msg_controllen) ||
> +		     __xn_put_user(krnl_msg.msg_flags,
> +				   (void __user *)&(usr_msg->msg_flags))))
>  		return -EFAULT;
>  
>  	return ret;
> 

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

