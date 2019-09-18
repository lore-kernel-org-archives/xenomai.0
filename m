MIME-Version: 1.0
Message-ID: <trinity-23657d39-b349-435d-852d-6986cadb6f8a-1568804658523@3c-app-gmx-bap20>
From: "Sebastian Smolorz" <Sebastian.Smolorz@gmx.de>
Subject: Re: [PATCH] net/tcp: Account for connection teardown handshake
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Sep 2019 13:04:18 +0200
In-Reply-To: <a222a6eb-5b92-fcf1-8643-9299d806024d@siemens.com>
References: <20190917120155.22171-1-sebastian.smolorz@gmx.de>
 <a222a6eb-5b92-fcf1-8643-9299d806024d@siemens.com>
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

On 17.09.19 14:46, Jan Kiszka wrote:
> On 17.09.19 14:01, Sebastian Smolorz wrote:
> > When closing a TCP connection a handshake procedure is executed betwee=
n the
> > peers. The close routine of the rttcp driver did not participate in
> > detecting the end of this handshake but rather waited one second insid=
e
> > a close call unconditionally. Especially when peers are directly conne=
cted
> > this is a waste of time which can hurt a lot in some situations.
> >
> > This patch replaces the msleep(1000) call with a timed wait on a
> > semaphore which gets sigalled when the termination handshake is comple=
te.
> >
> > Signed-off-by: Sebastian Smolorz <sebastian.smolorz@gmx.de>
> > ---
> >   kernel/drivers/net/stack/ipv4/tcp/tcp.c | 29 +++++++++++++++++++++++=
=2D-
> >   1 file changed, 27 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/drivers/net/stack/ipv4/tcp/tcp.c b/kernel/drivers/=
net/stack/ipv4/tcp/tcp.c
> > index 54bafa80f..81089afd1 100644
> > --- a/kernel/drivers/net/stack/ipv4/tcp/tcp.c
> > +++ b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
> > @@ -147,6 +147,9 @@ struct tcp_socket {
> >   	struct rtskb_queue retransmit_queue;
> >   	struct timerwheel_timer timer;
> >
> > +	struct semaphore close_sem;
>
> Sounds rather lake a job for struct completion.

Yes, will change it.

>
> > +	rtdm_nrtsig_t close_sig;
> > +
> >   #ifdef CONFIG_XENO_DRIVERS_NET_RTIPV4_TCP_ERROR_INJECTION
> >   	unsigned int packet_counter;
> >   	unsigned int error_rate;
> > @@ -1042,6 +1045,7 @@ static void rt_tcp_rcv(struct rtskb *skb)
> >   			rt_tcp_send(ts, TCP_FLAG_ACK);
> >   			/* data receiving is not possible anymore */
> >   			rtdm_sem_destroy(&ts->sock.pending_sem);
> > +			rtdm_nrtsig_pend(&ts->close_sig);
> >   			goto feed;
> >   		} else if (ts->tcp_state =3D=3D TCP_FIN_WAIT1) {
> >   			/* Send ACK */
> > @@ -1105,6 +1109,7 @@ static void rt_tcp_rcv(struct rtskb *skb)
> >   			ts->tcp_state =3D TCP_CLOSE;
> >   			rtdm_lock_put_irqrestore(&ts->socket_lock, context);
> >   			/* socket destruction will be done on close() */
> > +			rtdm_nrtsig_pend(&ts->close_sig);
> >   			goto drop;
> >   		} else if (ts->tcp_state =3D=3D TCP_FIN_WAIT1) {
> >   			ts->tcp_state =3D TCP_FIN_WAIT2;
> > @@ -1119,6 +1124,7 @@ static void rt_tcp_rcv(struct rtskb *skb)
> >   			ts->tcp_state =3D TCP_TIME_WAIT;
> >   			rtdm_lock_put_irqrestore(&ts->socket_lock, context);
> >   			/* socket destruction will be done on close() */
> > +			rtdm_nrtsig_pend(&ts->close_sig);
> >   			goto feed;
> >   		}
> >   	}
> > @@ -1190,6 +1196,11 @@ static int rt_tcp_window_send(struct tcp_socket=
 *ts, u32 data_len, u8 *data_ptr)
> >   	return ret;
> >   }
> >
> > +static void rt_tcp_close_signal_handler(rtdm_nrtsig_t *nrtsig, void *=
arg)
> > +{
> > +	up((struct semaphore *)arg);
> > +}
> > +
> >   static int rt_tcp_socket_create(struct tcp_socket *ts)
> >   {
> >   	rtdm_lockctx_t context;
> > @@ -1226,6 +1237,10 @@ static int rt_tcp_socket_create(struct tcp_sock=
et *ts)
> >   	timerwheel_init_timer(&ts->timer, rt_tcp_retransmit_handler, ts);
> >   	rtskb_queue_init(&ts->retransmit_queue);
> >
> > +	sema_init(&ts->close_sem, 0);
> > +	rtdm_nrtsig_init(&ts->close_sig, rt_tcp_close_signal_handler,
> > +			 &ts->close_sem);
> > +
> >   #ifdef CONFIG_XENO_DRIVERS_NET_RTIPV4_TCP_ERROR_INJECTION
> >   	ts->packet_counter =3D counter_start;
> >   	ts->error_rate =3D error_rate;
> > @@ -1237,6 +1252,7 @@ static int rt_tcp_socket_create(struct tcp_socke=
t *ts)
> >   	/* enforce maximum number of TCP sockets */
> >   	if (free_ports =3D=3D 0) {
> >   		rtdm_lock_put_irqrestore(&tcp_socket_base_lock, context);
> > +		rtdm_nrtsig_destroy(&ts->close_sig);
> >   		return -EAGAIN;
> >   	}
> >   	free_ports--;
> > @@ -1338,6 +1354,8 @@ static void rt_tcp_socket_destruct(struct tcp_so=
cket *ts)
> >
> >   	rtdm_event_destroy(&ts->conn_evt);
> >
> > +	rtdm_nrtsig_destroy(&ts->close_sig);
> > +
> >   	/* cleanup already collected fragments */
> >   	rt_ip_frag_invalidate_socket(sock);
> >
> > @@ -1362,6 +1380,7 @@ static void rt_tcp_close(struct rtdm_fd *fd)
> >   	struct rt_tcp_dispatched_packet_send_cmd send_cmd;
> >   	rtdm_lockctx_t context;
> >   	int signal =3D 0;
> > +	int ret;
> >
> >   	rtdm_lock_get_irqsave(&ts->socket_lock, context);
> >
> > @@ -1380,7 +1399,10 @@ static void rt_tcp_close(struct rtdm_fd *fd)
> >   		/* result is ignored */
> >
> >   		/* Give the peer some time to reply to our FIN. */
> > -		msleep(1000);
> > +		ret =3D down_timeout(&ts->close_sem, msecs_to_jiffies(1000));
> > +		if (ret)
> > +			rtdm_printk("rttcp: waiting for FIN-ACK handshake returned %d\n",
> > +				    ret);
>
> Do we consider a timeout to worth a kernel log entry? This could also be=
 caused
> by a lost connection, right?

Yeah, printing this log entry is questionable. My (weak) motivation was to
directly point out to the user that there might be a problem with his
connection. On the other hand, there are enough log entries being printed
in case something weird happens (e.g. missing ACKs). So let's remove this
rtdm_printk() in rt_tcp_close().

>
> And should we make the waiting time configurable?

I already thought about that, too. I think that a module parameter would
suffice. Do you agree or would we want to make that a per-socket option?

>
> >   	} else if (ts->tcp_state =3D=3D TCP_CLOSE_WAIT) {
> >   		/* Send FIN in CLOSE_WAIT */
> >   		send_cmd.ts =3D ts;
> > @@ -1394,7 +1416,10 @@ static void rt_tcp_close(struct rtdm_fd *fd)
> >   		/* result is ignored */
> >
> >   		/* Give the peer some time to reply to our FIN. */
> > -		msleep(1000);
> > +		ret =3D down_timeout(&ts->close_sem, msecs_to_jiffies(1000));
> > +		if (ret)
> > +			rtdm_printk("rttcp: waiting for FIN-ACK handshake returned %d\n",
> > +				    ret);
> >   	} else {
> >   		/*
> >   	  rt_tcp_socket_validate() has not been called at all,
> > --
> > 2.20.1
> >
>
> Jan
>

=2D-
Sebastian


