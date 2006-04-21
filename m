Message-ID: <44489D3B.9010200@domain.hid>
Date: Fri, 21 Apr 2006 10:52:11 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] Check for NPTL and factor user-space skins
	initialization.
References: <17476.64062.107556.216362@domain.hid>	<4444FF94.7050209@domain.hid>	<17477.247.209915.347304@domain.hid>	<44450481.3070102@domain.hid>
	<17477.6782.665009.909109@domain.hid>
In-Reply-To: <17477.6782.665009.909109@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>  > Gilles Chanteperdrix wrote:
>  > > Philippe Gerum wrote:
>  > >  > 
>  > >  > -ENOPARSE here. Which code is expected to call xeno_mlock_alert_end()?
>  > > 
>  > > pthread_set_mode_np and rt_task_set_mode. Sorry.
>  > 
>  > The issue I see doing so, is that you are going to trigger a SIGXCPU 
>  > right after setting the XNTRAPSW bit for the current thread, as a result 
>  > of calling sigaction and friends. This is why I used a plain and dumb 
>  > memory flag instead, the logic being:
>  > 
>  > - first, trap SIGXCPU in the library ctor to detect the lack of process 
>  > memory locking when mapping a shadow thread, and emit an explanatory 
>  > message when caught.
>  > 
>  > - as soon as a thread succeeds in setting modes (set_mode_np and 
>  > friends), then we know that a previous shadow mapping for the current 
>  > Linux task has succeeded, otherwise the nucleus would not have been able 
>  > to carry out the set_mode request. In such a case, make sure to cause 
>  > our internal SIGXCPU handler to switch to the default behaviour, in case 
>  > we did set the WARNSW bit for the current thread successfully. In all 
>  > other cases, either the user has set its own SIGXCPU handler overriding 
>  > our internal one, and we have no part in the play, or she did not and we 
>  > won't spuriously emit the "missing mlock" message.
> 
> Ok. Another try.
> 

Looks good. Merged, thanks.

-- 

Philippe.

