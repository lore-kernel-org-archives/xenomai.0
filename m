Date: Wed, 24 Apr 2019 13:05:46 +0000
From: Jeff Webb <w1@codecraftsmen.org>
Reply-To: Jeff Webb <w1@codecraftsmen.org>
Subject: Re: rt_dev_send() stalls periodic task
Message-ID: <teAgyZ99MOeKTG05UuBn4VijhPdYtJNRN66uQyusOJmxjDgqW9fDkKNoil4CPJDiUnKWYQ9P5uk2c652s7XbmYDurUmjOzlZaYqPaVfjfK0=@codecraftsmen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

> The only difference in the serial configuration between that cross-link.c
> app and my app was :
> struct rtser_config :
>          .rx_timeout        =3D RTSER_DEF_TIMEOUT  // infinite ,  no stal=
l for
> many hours in cross-link.c
> versus:
>          .rx_timeout        =3D 500000   // 500us, stalls within an hour =
in my
> app
> I don't know why an RX setting affects TX behavior. I also can't use
> RTSER_DEF_TIMEOUT in my application or it dies when it starts up - no clu=
e
> why.  But I did try setting
>    .rx_timeout        =3D 5000000   // 5 ms. my app doesnt stall for seve=
ral
> hours

This may not be related, but this jogged my memory about a problem I had ye=
ars ago regarding rx/tx timeouts affecting the other operation.  I just too=
k a look at rt_16550_write(), and I see:

  rtdm_toseq_init(&timeout_seq, ctx->config.rx_timeout);

  /* Make write operation atomic. */
  ret =3D rtdm_mutex_timedlock(&ctx->out_lock, ctx->config.rx_timeout,
     &timeout_seq);

This is the same code as in *_read().  I am wondering if this is a cut and =
paste error.  It seems like these two lines should use tx_timeout instead, =
but I haven't looked into the code in detail.  Maybe this is related, or ma=
ybe another bug?

Thanks,

-Jeff Webb


