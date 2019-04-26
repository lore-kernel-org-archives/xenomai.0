Date: Fri, 26 Apr 2019 00:41:31 +0000
From: Jeff Webb <w1@codecraftsmen.org>
Reply-To: Jeff Webb <w1@codecraftsmen.org>
Subject: Re: rt_dev_send() stalls periodic task
Message-ID: <uP-UrQ9gC-ZrtiYkSmIVcqdPqR0-v4i15BtMWVDS5L7TD7anN3VkOfFqcYD6vivC27coyNH37yAAhABS5WxZXQc7-OEbCh_4lTLzdCvaDwQ=@codecraftsmen.org>
In-Reply-To: <965464f8-0976-364d-e07a-a5188b4bdf7b@siemens.com>
References: <teAgyZ99MOeKTG05UuBn4VijhPdYtJNRN66uQyusOJmxjDgqW9fDkKNoil4CPJDiUnKWYQ9P5uk2c652s7XbmYDurUmjOzlZaYqPaVfjfK0=@codecraftsmen.org>
 <965464f8-0976-364d-e07a-a5188b4bdf7b@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Wednesday, April 24, 2019 9:36 AM, Jan Kiszka <jan.kiszka@siemens.com> w=
rote:

> On 24.04.19 15:05, Jeff Webb via Xenomai wrote:
>
> > > The only difference in the serial configuration between that cross-li=
nk.c
> > > app and my app was :
> > > struct rtser_config :
> > > .rx_timeout =3D RTSER_DEF_TIMEOUT // infinite , no stall for
> > > many hours in cross-link.c
> > > versus:
> > > .rx_timeout =3D 500000 // 500us, stalls within an hour in my
> > > app
> > > I don't know why an RX setting affects TX behavior. I also can't use
> > > RTSER_DEF_TIMEOUT in my application or it dies when it starts up - no=
 clue
> > > why. But I did try setting
> > > .rx_timeout =3D 5000000 // 5 ms. my app doesnt stall for several
> > > hours
> >
> > This may not be related, but this jogged my memory about a problem I ha=
d years ago regarding rx/tx timeouts affecting the other operation. I just =
took a look at rt_16550_write(), and I see:
> > rtdm_toseq_init(&timeout_seq, ctx->config.rx_timeout);
> > /* Make write operation atomic. */
> > ret =3D rtdm_mutex_timedlock(&ctx->out_lock, ctx->config.rx_timeout,
> > &timeout_seq);
> > This is the same code as in *_read(). I am wondering if this is a cut a=
nd paste error. It seems like these two lines should use tx_timeout instead=
, but I haven't looked into the code in detail. Maybe this is related, or m=
aybe another bug?
>
> That is a good catch! Copy & paste would be my theory as well... Wanna wr=
ite a
> patch?

I can't test this easily right now, but I'll try to post a patch at least.

-Jeff


