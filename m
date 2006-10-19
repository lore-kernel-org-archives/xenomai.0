Subject: Re: [Xenomai-core] [PATCH] fixing __xn_put_user and __xn_get_user
	for PowerPC
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4537DF47.8040800@domain.hid>
References: <4537DF47.8040800@domain.hid>
Content-Type: text/plain
Date: Thu, 19 Oct 2006 22:58:40 +0200
Message-Id: <1161291521.4959.98.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Thu, 2006-10-19 at 22:25 +0200, Wolfgang Grandegger wrote:
> Hello,
> 
> the attached patch fixes the problem described in the mail 
> https://mail.gna.org/public/xenomai-core/2006-10/msg00037.html. Here is 
> the ChangeLog entry:
> 
>        * include/asm-powerpc/wrappers.h, include/asm-powerpc/syscall.h:
>        Since Linux 2.4.15, __put_user and __get_user call migth_sleep.
>        To avoid that, wrapper functions have been added.
> 

Merged, thanks.

> Wolfgang.
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



