Subject: Re: [Xenomai-help] [Fwd: Performance decrease]
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <17655.18827.661904.949733@domain.hid>
References: <1156941389.4323.17.camel@domain.hid> <1156942089.4323.29.camel@domain.hid>
	<17655.18827.661904.949733@domain.hid>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 09:13:15 +0200
Message-Id: <1157094795.4322.9.camel@domain.hid>
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
Cc: xenomai@xenomai.org

On Thu, 2006-08-31 at 22:41 +0200, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>  > On Wed, 2006-08-30 at 14:36 +0200, Philippe Gerum wrote:
>  > > -------- Forwarded Message --------
>  > > > From: Daniel Schnell <danielsch@domain.hid>
>  > > > To: xenomai-help <xenomai@xenomai.org>
>  > > > Subject: Performance decrease
>  > > > Date: Wed, 30 Aug 2006 11:58:25 -0000
>  > > > 
>  > > > Hi,
>  > > > 
>  > > >  
>  > > > 
>  > > > I have made some CPU throughput tests with/without "Nucleus options->pervasive real-time support in user-space" 
>  > >  enabled/disabled. And the performance dicrease in using that option is for my processor (MPC5200, 400 MHz) about 10%.
>  > 
>  > There is an impact induced by activating the user-space support, since
>  > all system calls are filtered through Xenomai; some work is currently
>  > undergoing to reduce this overhead, so that only system calls issued by
>  > Xenomai shadows would be intercepted. This said, out of curiosity, how
>  > do you measure those 10% on your board?
> 
> Just being curious: how will you achieve this ? You will make the
> function used to dispatch system calls a per-thread pointer ?
> 

Syscalls are just another form of exceptions, so the change will need to
affect all event notifications. A per-thread pointer is an opion
provided there is also a mean to install the callback address, so we
would also need to intercept the Linux task creation event. Another
option would be to define an event filtering routine at domain level,
which gets called before the event is pipelined. The latter is a simple
and straightforward approach which does not change much of the existing
infrastructure, but to remain fast and efficient, the filter should be
defined for the domain which notifies events, and not for the domains
which get notified, and this would be quite restrictive Adeos-wise, even
if this would solve the root issue, Xenomai-wise. To sum up and answer
to your initial question: well, I don't know yet.

-- 
Philippe.



