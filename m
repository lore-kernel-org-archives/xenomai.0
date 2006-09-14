Subject: RE: [Xenomai-help] premetion
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <9D98C51005D80D43A19A3DF329A61D69515631@domain.hid>
References: <9D98C51005D80D43A19A3DF329A61D69515631@domain.hid>
Content-Type: text/plain
Date: Thu, 14 Sep 2006 14:42:22 +0200
Message-Id: <1158237742.5040.89.camel@domain.hid>
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
To: Nilanjan Roychowdhury <Nilanjan.Roychowdhury@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2006-09-14 at 17:55 +0530, Nilanjan Roychowdhury wrote:
> I am confused. Do you mean any thread created in user space with
> rt_task_create is a secondary mode thread even if it never makes any
> Linux calls.

No, such task would always start in primary mode. The sentence "by
secondary mode threads, we really mean Xenomai-enabled user-space
threads" should be interpreted in the context of the question it answers
to. The bottom line is that regular Linux threads (i.e. non-Xenomai) can
only compete for the CPU with Xenomai threads in secondary mode
depending on their priority level, but threads in primary mode always
have precedence over the regular Linux threads.

> -Nilanjan
> 
> -----Original Message-----
> From: Philippe Gerum [mailto:rpm@xenomai.org] 
> Sent: Thursday, September 14, 2006 5:48 PM
> To: Nilanjan Roychowdhury
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] premetion
> 
> On Thu, 2006-09-14 at 17:37 +0530, Nilanjan Roychowdhury wrote:
> > Can a normal Linux thread ( pthread with priority 90) can preempt any
> > user space XENOMAI thread with priority (85). If the XENOMAI thread is
> > running in primary domain ???
> 
> No, only if the latter runs in secondary mode.
> https://mail.gna.org/public/xenomai-help/2006-08/msg00196.html
> 
> 
> > 
> > 
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



