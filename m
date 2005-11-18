Message-ID: <437DB5EA.6060201@domain.hid>
Date: Fri, 18 Nov 2005 12:07:22 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [pipe.c] hairy synchronization -> "flush the output
	queue upon closure"
References: <OF6B03266F.E2C02C00-ONC12570BD.00393A33-C12570BD.003ADFA5@domain.hid>
In-Reply-To: <OF6B03266F.E2C02C00-ONC12570BD.00393A33-C12570BD.003ADFA5@domain.hid>
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
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

Dmitry Adamushko wrote:
> Philippe Gerum <rpm@xenomai.org> wrote on 18.11.2005 11:14:26:
> 
>  > > ...
>  > >
>  > > it looks like we can't make the whole xnpipe_release() atomic 
> because of
>  > > PREEMPT_RT + wake_up_interruptible_all() things, right? Or no.
>  >
>  > You must _never_ _ever_ reschedule with the nucleus lock held; this
>  > is a major cause of
>  > jittery I recently stumbled upon that was induced by
>  > xnpipe_read_wait() at that time. So
>  > indeed, xnpipe_release() cannot be made atomic this way under a
>  > fully preemptible kernel.
> 
> Yep.
> 
> Now keeping in mind the observation I have made yesterday, it looks 
> like, in fact, there is no need in wake_up_*(readers) call in 
> file_operations::release(). There is nobody to be woken up at the time 
> when release() is called:
> 
> 1) The reference counter of "file" object is 0, i.e. there are no 
> readers since read() increases a counter before getting blocked.
> 
> 2) noone else can use anew that "file" object since close() does the 
> following:
> 
> filp = files->fd[fd];
> if (!filp)
> goto out_unlock;
> files->fd[fd] = NULL; <--- it's invalid from now on
> 
> so it's not possible that some new readers may occur when a counter == 0.
> 

Ack.

> Hm.. but we still have fasync_helper(-1,file,0,&state->asyncq); which is 
> about sending a signal and that's perfectly valid (a file::counter is 
> not involved here). And that call may lead to re-scheduling (linux 
> re-scheduling of course) so we can't put it in a blocked section.
> 
> So the best way I see is to have something like():
> 
> xnpipe_drop_user_conn()
> {
> xnlock_get_irqsave(&nklock,s);
> 
> while ((holder = getq(&state->outq)) != NULL)
>               
>  state->output_handler(minor,link2mh(holder),-EPIPE,state->cookie);
>            }
> 
>        while ((holder = getq(&state->inq)) != NULL)
>            {
>            if (state->input_handler != NULL)
>               
>  state->input_handler(minor,link2mh(holder),-EPIPE,state->cookie);
>            else if (state->alloc_handler == NULL)
>                xnfree(link2mh(holder));
>            }
> 
> __clrbits(state->status,XNPIPE_USER_CONN);
> 
> xnlock_put_irqrestore(&nklock,s);
> }
> 
> and call it everywhere instead of clrbits(state->status,XNPIPE_USER_CONN);
> 
> This way we may be sure there are no pending messages left.
> 
>

Sounds consistent, since USER_CONN flag is semantically bound to the active/inactive state 
of the associated data queues anyway.

>  > --
>  >
>  > Philippe.
> 
> ---
> 
> Dmitry
> 


-- 

Philippe.

