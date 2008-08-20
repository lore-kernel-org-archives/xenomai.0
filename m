Message-ID: <48AC6BA0.9010306@domain.hid>
Date: Wed, 20 Aug 2008 21:08:16 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <406CC9939904F143B9D42CEEA3E56E56431F57@domain.hid>
	<48AAF55E.9000206@domain.hid>
	<406CC9939904F143B9D42CEEA3E56E56431FCD@oab1mx1.oneaccess.intra>
	<48ABEF11.6060307@domain.hid>
	<406CC9939904F143B9D42CEEA3E56E56432116@domain.hid>
In-Reply-To: <406CC9939904F143B9D42CEEA3E56E56432116@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] uClinux write to pipe returning -ENOMEM
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
To: Filip Van Rillaer <Filip.VanRillaer@domain.hid>
Cc: xenomai@xenomai.org

Filip Van Rillaer wrote:
> Hello,
> 
> Thank you for your work-around.
> Though I have some problems with the implementation:
> pipe_i_handler (Xenomai side) does not know when the xnpipe_write got
> errno=ENOMEM (the pipe_i_handler is I think even not called in case
> ENOMEM is returned).  So there is I think with the current Xenomai
> implementation no way for the pipe_i_handler to correctly fill in the
> value of buffer_filled_up_p.  This would mean that my writer-thread
> 'userland' would have to set this 'variable'.
> Then I was thinking about moving the <<rt_sem_p(&bsync, TM_INFINITE)>>
> to the writer-thread when errno-ENOMEM is returned, but that would
> require that the writer-thread has to bind the semaphore that was
> created in another program.  This is probably possible via the Xenomai
> registry.
> 

Commit #4114 provides P_EVENT_NOBUF (formerly P_EVENT_FULL).

-- 
Philippe.

