Message-ID: <43767341.10309@domain.hid>
Date: Sat, 12 Nov 2005 23:57:05 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Patch for RTDM recvmsg bug
References: <Pine.GSO.4.58.0511101656220.6569@domain.hid>
In-Reply-To: <Pine.GSO.4.58.0511101656220.6569@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Cc: xenomai@xenomai.org

Sebastian Smolorz wrote:
> Hi,
> 
> here's a patch for a bug in skins/rtdm/syscall.c. The msghdr was not
> copied to user space upon completion of a recvmsg() call if the return
> value was not equal to zero. But recvmsg shall return the length of the
> message in bytes (according to IEEE Std 1003.1).
> 

Applied, thanks.

> I have the permission from Jan to patch his code. ;-)
> 
> 
> Sebastian
> 
> 
> ------------------------------------------------------------------------
> 
> --- xenomai/skins/rtdm/syscall.c	2005-11-10 16:45:24.000000000 +0100
> +++ syscall.c	2005-11-10 16:27:08.000000000 +0100
> @@ -99,7 +99,7 @@ static int sys_rtdm_recvmsg(struct task_
>  
>      ret = _rtdm_recvmsg(curr, __xn_reg_arg1(regs), &krnl_msg,
>                          __xn_reg_arg3(regs));
> -    if (!ret)
> +    if (ret >= 0)
>          __xn_copy_to_user(curr, (void __user *)__xn_reg_arg2(regs), &krnl_msg,
>                            sizeof(krnl_msg));
>  
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 

Philippe.

