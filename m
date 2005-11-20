Message-ID: <43804DEC.8030805@domain.hid>
Date: Sun, 20 Nov 2005 11:20:28 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [pipe.c] hairy synchronization -> "flush the output
	queue upon closure"
References: <OFCFB2F55F.EFC474AA-ONC12570BD.00453247-C12570BD.0045E0FD@datacon.at>
In-Reply-To: <OFCFB2F55F.EFC474AA-ONC12570BD.00453247-C12570BD.0045E0FD@datacon.at>
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
> Philippe Gerum <rpm@xenomai.org> wrote on 18.11.2005 12:07:22:
> 
>  >
>  > > Hm.. but we still have fasync_helper(-1,file,0,&state->asyncq); 
> which is
>  > > about sending a signal and that's perfectly valid (a file::counter is
>  > > not involved here). And that call may lead to re-scheduling (linux
>  > > re-scheduling of course) so we can't put it in a blocked section.
>  > >
>  > > So the best way I see is to have something like():
>  > >
>  > > xnpipe_drop_user_conn()
>  > > {
>  > > xnlock_get_irqsave(&nklock,s);
>  > >
>  > > while ((holder = getq(&state->outq)) != NULL)
>  > >              
>  > >  state->output_handler(minor,link2mh(holder),-EPIPE,state->cookie);
>  > >            }
>  > >
>  > >        while ((holder = getq(&state->inq)) != NULL)
>  > >            {
>  > >            if (state->input_handler != NULL)
>  > >              
>  > >  state->input_handler(minor,link2mh(holder),-EPIPE,state->cookie);
>  > >            else if (state->alloc_handler == NULL)
>  > >                xnfree(link2mh(holder));
>  > >            }
>  > >
>  > > __clrbits(state->status,XNPIPE_USER_CONN);
>  > >
>  > > xnlock_put_irqrestore(&nklock,s);
>  > > }
>  > >
>  > > and call it everywhere instead of 
> clrbits(state->status,XNPIPE_USER_CONN);
>  > >
>  > > This way we may be sure there are no pending messages left.
>  > >
>  > >
>  >
>  > Sounds consistent, since USER_CONN flag is semantically bound to the
>  > active/inactive state
>  > of the associated data queues anyway.
>  >
> 
> Then a patch is enclosed.
> 

Applied, thanks.

> 
>  > --
>  >
>  > Philippe.
> 
> ---
> 
> Dmitry
> 
> 
> /(See attached file: pipe.cleanup-user-conn.patch)//(See attached file: 
> ChangeLog-diff.patch)/
> 


-- 

Philippe.

