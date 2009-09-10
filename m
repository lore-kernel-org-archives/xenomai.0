From: Andreas Glatz <andreasglatz@domain.hid>
In-Reply-To: <4AA82D6E.8070909@domain.hid>
References: <1252532920.10115.9.camel@domain.hid>  <4AA82D6E.8070909@domain.hid>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 10 Sep 2009 12:49:45 -0400
Message-Id: <1252601385.28464.29.camel@domain.hid>
Mime-Version: 1.0
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Hi,


> 
> Whenever possible, please post patches inline (I had to manually copy it
> to allow commenting).

Sure, no problem.


> 
> You cannot bluntly call release() here. You may not run in Linux context
> while that handler demands this. 

It's also called in xnpipe_disconnect() (if I follow 'goto cleanup' and
the user-space isn't connected). So is there a different policy here?
I mean should xnpipe_connect() just be called from rt context whereas
xnpipe_disconnect() has to be called from non-rt context?


> Moreover, releasing the state is the
> job of the NRT user that opened it and obviously still has a hand on it.

Yeah, that's the tricky part. I left that part out yet ...

> 
> (And the locking is imbalanced here, but that is shadowed by the other
> flaws.)

Agree.

If we had that new pipe behaviour it could significantly 
speed-up debugging for us because we wouldn't have to stop (and
eventually start) all NRT applications before restarting the RT
application.

Thanks for commenting on my quick and dirty patch. I think, now
I know where to continue.

Andreas

