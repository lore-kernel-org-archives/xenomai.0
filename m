Subject: Re: [Xenomai-help] rt_queue_read switch to secondary mode
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20c1b3220c1b7f.20c1b7f20c1b32@domain.hid>
References: <20c1b3220c1b7f.20c1b7f20c1b32@domain.hid>
Content-Type: text/plain
Date: Fri, 20 Oct 2006 22:59:01 +0200
Message-Id: <1161377941.4988.102.camel@domain.hid>
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
To: sbhuller@domain.hid
Cc: xenomai@xenomai.org

On Fri, 2006-10-20 at 14:50 -0600, Sunny Bhuller wrote:
> Hello,
>   I am new to xenomai and was having a problem with the rt_queue_read call.  I am creating a new RT_TASK from my main program with:
> 
> rt_task_create(&task, NULL, 0 /* default stack size */, 5 /* priority */, T_FPU | T_JOINABLE);
> 
> Once the task has started I switch it to primary mode with:
> 
> rt_task_set_mode(0, T_PRIMARY | T_WARNSW, NULL);

Forcing to primary is useless, every real-time task starts in primary
mode, regardless of the relevant skin.

> 
> Now if I call the rt_queue_read I catch the signal that specifies the system has switched to secondary mode.  Is there something fundamentally wrong with what I am doing?  I can post a more detailed explanation if required, thanks!
> 

There is no reason for rt_queue_read() to move the thread to secondary
mode. You should try running the app over GDB, and inspect the backtrace
when the signal is received; you might discover that some other code
does cause this, or you might discover that we indeed have a bug hiding
somewhere. Posting a simple but complete test code that reproduces the
issue unambiguously would help too.

> -- Sunny
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



