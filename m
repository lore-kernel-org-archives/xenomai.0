Subject: Re: [Xenomai-help] sem_timedwait return value
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45708CA5.8040004@domain.hid>
References: <45708CA5.8040004@domain.hid>
Content-Type: text/plain
Date: Sat, 02 Dec 2006 00:00:31 +0100
Message-Id: <1165014031.4952.188.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Webb <jeff.webb@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2006-12-01 at 14:12 -0600, Jeff Webb wrote:
> In my userspace POSIX program, I get a '-1' return value from sem_timedwait, even when the function succeeds.  When the function succeeds, errno is '-1' as well.  I am using this workaround at the moment:
> 
>       result = sem_timedwait(&cas_sem, &wake_time);
>       if (result < 0 && errno > 0) /* errno > 0 to work around xenomai bug */
>         {
>           print_msg(WARN_MSG, "sem_wait returned with error code %d\n",
>                     errno);
>           continue;
>         }
> 
> I am using xenomai 2.2.4, but I think the problem exists in other branches as well.  I believe the attached patch against the trunk should fix the problem.  Do you agree?
> 

Oops, yes. This bug belongs to me. Applied, thanks.

> Thanks,
> 
> Jeff
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



