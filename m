Subject: RE: [Xenomai-help] What returns rt_task_self in relation
	tort_task_create
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1164204977.5006.322.camel@domain.hid>
References: <DD39B5C3F4963040ADC9768BE7E430CB015D4F9C@is-hdq-exchange.marel.net>
	<1164204977.5006.322.camel@domain.hid>
Content-Type: text/plain
Date: Wed, 22 Nov 2006 15:23:36 +0100
Message-Id: <1164205417.5006.331.camel@domain.hid>
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
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2006-11-22 at 15:16 +0100, Philippe Gerum wrote:
> On Wed, 2006-11-22 at 13:48 +0000, Daniel Schnell wrote:
> > Philippe Gerum wrote:
> > > Use pthread_getspecific() for obtaining back a TLS data previously
> > > defined by pthread_setspecific(), indexed on a TLS key obtained from
> > > pthread_key_create(). Warning: AFAICT, only pthread_getspecific()
> > > refrain from performing any kind of Linux syscall (in the current
> > > NPTL and older LinuxThreads implementation, that is), thus won't
> > > migrate your RT task to secondary mode when called. The two others
> > > could call vanilla kernel services, so you must use them during
> > > non-critical preliminary init steps of your task.       
> > 
> > Does this mean that if you use pthread_getspecific() inside a user-space
> > application you will not switch to secondary mode ?
> 
> Yes.
> 
> >  I was just
> > abandoning using TLS because I could not imagine how the NPTL's
> > functionality can be done without a system call. Is this behaviour
> > something one can rely on in the future ?
> 
> TLS must be stack-based

... or local register-based... as Jan pointed out,

>  and stack-based accesses are thread-private, so
> there is no reason for the kernel to show up here; so there is a good
> chance that this behaviour be kept in later releases, but I'm not
> maintaining the glibc, so I could not swear it.
> 
> In any case, you should check by yourself the behaviour of
> pthread_getspecific(), by arming the T_WARNSW bit using
> rt_task_set_mode(). If the former call switches to secondary mode, you
> would get a SIGXCPU signal. Installing this simple test as some
> preliminary consistency check before your application runs for real
> would prevent any bad surprise after glibc updates.
> 
> > 
> > Is there something similar like TLS inside the native API ?
> > 
> 
> No, basically because it requires to know about the nitty-gritty details
> of the pthread implementation, and this is precisely why we should only
> rely on the regular TLS implementation.
> 
> > 
> > Best regards,
> > 
> > 
> > Daniel.
> > 
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



