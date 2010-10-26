Message-ID: <4CC6BCBB.8020902@domain.hid>
Date: Tue, 26 Oct 2010 13:34:19 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTimeLKjkOf-y-Jb89EQrbWYjxAbmNf-QqUWXd+tP@mail.gmail.com>
	<AANLkTi=y8ix9REzUeCU+adyKTE=C-M=P_gFTtjVDO+rw@domain.hid>
In-Reply-To: <AANLkTi=y8ix9REzUeCU+adyKTE=C-M=P_gFTtjVDO+rw@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Possible memory leak in psos skin message queue
 handling
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: ronny meeus <ronny.meeus@domain.hid>
Cc: Xenomai-help@domain.hid

ronny meeus wrote:
> Hello
> 
> I did some further debugging on the problem described below and I made
> some progress.
> At creation time of the message queue using:
> q_create("TEST",0,Q_NOLIMIT|Q_PRIOR,&qid);
> a chunk of message buffers (64) is allocated and added to the free
> message list of the queue (queue->freeq).
> Once the message queue is deleted, the messages are added into the
> global psosmbufq.
> During the q_create/q_delete loop, the memory pool get depleted since
> the number of messages in the psosmbufq keeps on increasing all the time.
> 
> In my opinion if the Q_PRIBUF is not set during queue creation, the
> "psosmbufq" has to be used to allocate/release from/to.
> This also implies that the local freeq in the queue object is not used
> in this mode anymore.
> Each time a message needs to be send, in function get_mbuf it is simply
> taken from the psosmbufq. In case this would be empty, a feed_pool
> operation is called on it.
> 
> static psosmbuf_t *get_mbuf(psosqueue_t *queue, u_long msglen)
> {
>     psosmbuf_t *mbuf = NULL;
> 
>     if (testbits(queue->synchbase.status, Q_NOCACHE)) {
>         mbuf =
>             (psosmbuf_t *) xnmalloc(sizeof(*mbuf) + msglen -
>                         sizeof(mbuf->data));
> 
>         if (mbuf)
>             inith(&mbuf->link);
>     } else {
>         xnholder_t *holder = NULL;
>         if (testbits(queue->synchbase.status, Q_SHAREDINIT)) {
>             holder = getq(&psosmbufq);
>             if (!holder) {
>                 feed_pool(&psoschunkq,
> &psosmbufq,PSOS_QUEUE_MIN_ALLOC,queue->maxlen);
>                 holder = getq(&psosmbufq);
>             }
>         } else {
>             holder = getq(&queue->freeq);
>             if (!holder && testbits(queue->synchbase.status, Q_INFINITE)) {
>                 feed_pool(&queue->chunkq,&queue->freeq,
> PSOS_QUEUE_MIN_ALLOC,queue->maxlen);
>                 holder = getq(&queue->freeq);
>             }   
>         }
>         if (holder)
>             mbuf = link2psosmbuf(holder);
>     }
>     return mbuf;
> }
> 
> I have adapted the code accordingly and rerun my tests. Now it runs forever.
> (Of course I also did changes in the code to create and delete a queue.)
> 
> Now the question is: Is my understanding correct? If it is, the flag
> Q_SHAREDINIT would be better renamed to Q_SHAREDMSGS.
> 
> Please share your thoughts.

A patch would be better than some fancy HTML colouring, if you intend
your fix to be reviewed/integrated.

-- 
                                                                Gilles.

