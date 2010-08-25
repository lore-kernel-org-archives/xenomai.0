From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <AANLkTikXsjX5oRTUYR3Tg_ew9-VEFVMiyTnFUGWRq9Sm@domain.hid>
References: <AANLkTikXsjX5oRTUYR3Tg_ew9-VEFVMiyTnFUGWRq9Sm@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 25 Aug 2010 11:53:20 +0200
Message-ID: <1282730000.1709.49.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Page-fault, switch to secondary mode
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bharath Achuta Bhat <baambekar@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2010-08-25 at 11:12 +0200, Bharath Achuta Bhat wrote:
> Hello Xenomai experts,
> 
> 
> I am running a xenomai-2.5.1 patched kernel (v 2.6.30.3) with ipipe
> version 2.7-06.
> The target is powerpc (MPC8533E).
> My application is switching to the secondary mode (I guess because of
> a page-fault) when ntohl() is called.
> This is a libc function and I am wondering why only this function
> (ntohl()) is causing a page-fault.

What memory are you reading from / writing to in the statement involving
ntohl()? Is this plain RAM, or mapped I/O memory?

> 
> 
> Here is how the application looks like
> 
> 
> main ()
> {
> ...
> ...
> /* Avoids memory swapping for this program */
> mlockall(MCL_CURRENT | MCL_FUTURE);
> 
> 
> ......
> ......
> /* signal handlers */
> .....
> .....
> /* create communication pipes */
> rt_pipe_create(&tPipe1, .....
> rt_pipe_create(&tPipe2,.......
> 
> 
> /* create RT tasks */
> rt_task_create(&tTask1,.....
> rt_task_create(&tTask2,......
> ...........
> ..........
> 
> 
> /* start the RT tasks */
> rt_task_start(&tTask1,.....
> ..............
> ..............
> 
> 
> /* turn the current thread into RT function */
> ret = rt_task_shadow(NULL, "RT main function", 1, T_SUSP);
> 
> 
> ....
> ....
> 
> 
> }
> 
> 
> One of the rt tasks created calls ntohl() and switches to secondary
> mode.
> Is there a way to avoid it ? 
> 
> 
> -- 
> Thanks and regards
> Bharath
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



