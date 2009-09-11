From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1252601385.28464.29.camel@domain.hid>
References: <1252532920.10115.9.camel@domain.hid>  <4AA82D6E.8070909@domain.hid>
	<1252601385.28464.29.camel@domain.hid>
Content-Type: text/plain
Date: Fri, 11 Sep 2009 09:46:00 +0200
Message-Id: <1252655160.2820.242.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] nucleus/pipe.c patch: check for lingering close
 at xnpipe_connect()
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Andreas Glatz <andreasglatz@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

On Thu, 2009-09-10 at 12:49 -0400, Andreas Glatz wrote:
> Hi,
> 
> 
> > 
> > Whenever possible, please post patches inline (I had to manually copy it
> > to allow commenting).
> 
> Sure, no problem.
> 
> 
> > 
> > You cannot bluntly call release() here. You may not run in Linux context
> > while that handler demands this. 
> 
> It's also called in xnpipe_disconnect() (if I follow 'goto cleanup' and
> the user-space isn't connected). So is there a different policy here?
> I mean should xnpipe_connect() just be called from rt context whereas
> xnpipe_disconnect() has to be called from non-rt context?
> 
> 
> > Moreover, releasing the state is the
> > job of the NRT user that opened it and obviously still has a hand on it.
> 
> Yeah, that's the tricky part. I left that part out yet ...
> 
> > 
> > (And the locking is imbalanced here, but that is shadowed by the other
> > flaws.)
> 
> Agree.
> 
> If we had that new pipe behaviour it could significantly 
> speed-up debugging for us because we wouldn't have to stop (and
> eventually start) all NRT applications before restarting the RT
> application.
> 
> Thanks for commenting on my quick and dirty patch. I think, now
> I know where to continue.
> 

Allowing the RT side to be re-opened multiple times won't fly, I'm
afraid. The reason we have the linger-on-close behavior is to prevent
the NRT side to refer to stale memory whenever the RT side preempts and
disconnects. Excluding RT from preempting the write/read calls could
cause high latencies (NRT may sleep anyway, so locking would not even be
a safe option there).

Maybe you should move the RT_PIPE descriptor in a separate, standalone
module from your driver to keep the connection alive, and ignore the
-EBUSY status upon failed attempt to connect to the same minor from your
driver? That descriptor is shareable in kernel space so there is no
restriction in using it from another module, and this would allow your
driver module to be unloaded without actually tearing down the data
channel with your userland app.

> Andreas
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



