Subject: Re: [Xenomai-help] What
	returns	rt_task_self	in	relation	to	rt_task_create
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45648B19.70800@domain.hid>
References: <20403318.1164195534169.JavaMail.ngmail@domain.hid>
	<45643CC4.1000201@domain.hid> <1164199940.5006.270.camel@domain.hid>
	<45644D39.10007@domain.hid> <1164204035.5006.305.camel@domain.hid>
	<456458BC.2060407@domain.hid> <1164205345.5006.329.camel@domain.hid>
	<45647C2B.1070208@domain.hid> <1164214987.5006.390.camel@domain.hid>
	<45648B19.70800@domain.hid>
Content-Type: text/plain
Date: Wed, 22 Nov 2006 19:33:01 +0100
Message-Id: <1164220382.5006.415.camel@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

On Wed, 2006-11-22 at 18:38 +0100, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
> > On Wed, 2006-11-22 at 17:34 +0100, Gilles Chanteperdrix wrote:
> > 
> >>Philippe Gerum wrote:
> >>
> >>>On Wed, 2006-11-22 at 15:03 +0100, Gilles Chanteperdrix wrote:
> >>>
> >>>
> >>>>Philippe Gerum wrote:
> >>>>
> >>>>
> >>>>>On Wed, 2006-11-22 at 14:14 +0100, Jan Kiszka wrote:
> >>>>>We could add that, and the same stuff upon return from the task body
> >>>>>inside the trampoline call, but the only way to solve this with no leak
> >>>>>would be to call the nucleus at each invocation, and not use any cached
> >>>>>descriptor here. Since TLS requires to be operated by the owning task,
> >>>>>there is no point in trying to have a deleted task clean those up
> >>>>>thoroughly.
> >>>>>
> >>>>
> >>>>When creating a TLS key, you can specify a cleanup function that get
> >>>>called when a thread exits (or is canceled).
> >>>>
> >>>
> >>>
> >>>Actually, there are spots where the nucleus forces do_exit() over the
> >>>caller, and specifically, when we zap a shadow from the Xenomai context,
> >>>then perform a tail scheduling for this zombie over the incoming Linux
> >>>context. In such situation, the user-space would not even be informed of
> >>>what's been going on, so the cleanup routine would be useless.
> >>
> >>IIRC, rt_task_delete calls pthread_cancel,
> > 
> > 
> > Not in the case of self deletion, it seems.
> 
> Is there any reason not to use pthread_exit for self deletion ?
> 

I don't see any.

-- 
Philippe.



