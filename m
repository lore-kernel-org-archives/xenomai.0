MIME-Version: 1.0
References: <CAOuPNLg60S+am654fq55vTMoFV1=PfMp3as5MZtt5BHUacFRBQ@mail.gmail.com>
 <2ee8fa04-7ad4-58d5-603b-1d41ad2533ec@siemens.com>
 <CAOuPNLiE-Fy3LJrozgsLE9ga0ibC+GOSHO6ciJppU_bnZtbx0g@mail.gmail.com>
 <73a5c9f6-5014-5113-1ddd-2fcf974273bb@siemens.com>
 <CAOuPNLjuB53ovnEBijNSqrgsKYcSGjLM-L=J4mfbRogwo_5kVA@mail.gmail.com>
 <CAOuPNLh2C8b1KC5D6+Lws_1UA0o0Sp_BaPb3mUTyebUPq_EduA@mail.gmail.com>
 <CAOuPNLiCfmUrDMWyX=N37hVJTBDEqwOtoOr1srf-55ks1qms+w@mail.gmail.com>
 <513744ad-f8fe-d54e-0618-fad492ed5bff@siemens.com>
 <5f46f00c-f09b-7439-93cf-4ff2a0343974@siemens.com>
 <6da8a3e2-7a76-afb2-c46c-7c173a8e444c@siemens.com>
 <CAOuPNLhYPGrP5s0y6e9HFUVrg2aDochOxF_fMkbjTmYnEvPOQQ@mail.gmail.com>
In-Reply-To: <CAOuPNLhYPGrP5s0y6e9HFUVrg2aDochOxF_fMkbjTmYnEvPOQQ@mail.gmail.com>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Tue, 26 Jun 2018 16:38:53 +0530
Message-ID: <CAOuPNLjXN531P13WddSAQ-ZmnNOF_EQ4R+3eZ09VtG5zNvUH0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] Kernel oops during rtnet loopback usage on x86_64
	(e1000e)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Dear Jan,

Till now I haven't had any success for running my rtnet demo test
either or x86 or arm.
I even upgraded to xenomai-next (both kernel and user space) but still no luck.

Now even the "loopback" test is not working on xenomai-next.

Can you confirm, if any of the below rtnet test works for you with
Kernel 4.9 and xenomai-next.
- xenomai-3-next/testsuite/smokey/net_udp
- url = https://git.code.sf.net/p/rtnet/code  => examples/generic/
- Or a simple UDP client/server program, compiled with xenomai posix skin

I already tried with "nosmap" but there are no response coming (I am
getting no prints on console, but client is terminated).
If there is any work around to make rtnet works, please let me know.


Thanks,
Pintu

On Mon, Jun 25, 2018 at 6:26 PM Pintu Kumar <pintu.ping@gmail.com> wrote:
>
> > As a workaround, run the kernel with nosmap.
> OK, I guessed it correctly and tried with kernel commandline "nosmap".
> Because it works normally on virtual box.
>
> With "nosmap" I don't see any kernel oops, but there are no prints either.
> I mean in my rtnet-server/client, I have given some print statement.
> But I am not seeing those print statement coming on the console now.
> The print statements are coming for normal "xeno_task" application.
>
> Is there any clue for this ?
>
>
> Thanks,
> Pintu
>
>
>
>
>
> On Thu, Jun 21, 2018 at 8:27 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >
> > On 2018-06-21 15:41, Jan Kiszka wrote:
> > > On 2018-06-21 13:55, Jan Kiszka wrote:
> > >> On 2018-06-21 13:20, Pintu Kumar wrote:
> > >>> Dear Jan, Greg,
> > >>>
> > >>> Is there any pointer about this issue?
> > >>> This is blocking my next work..
> > >>
> > >> Does this solve the issue AND still generate valid UDP checksums (please
> > >> check with wireshark or against a normal networking stack?
> > >>
> > >> diff --git a/kernel/drivers/net/stack/ipv4/udp/udp.c b/kernel/drivers/net/stack/ipv4/udp/udp.c
> > >> index 8e80d3e0b..bb0b0fc12 100644
> > >> --- a/kernel/drivers/net/stack/ipv4/udp/udp.c
> > >> +++ b/kernel/drivers/net/stack/ipv4/udp/udp.c
> > >> @@ -556,18 +556,17 @@ static int rt_udp_getfrag(const void *p, unsigned char *to,
> > >>      if (offset)
> > >>          return rtnet_read_from_iov(ufh->fd, ufh->iov, ufh->iovlen, to, fraglen);
> > >>
> > >> -    /* Checksum of the complete data part of the UDP message: */
> > >> -    for (i = 0; i < ufh->iovlen; i++) {
> > >> -            ufh->wcheck = csum_partial(ufh->iov[i].iov_base, ufh->iov[i].iov_len,
> > >> -                                       ufh->wcheck);
> > >> -    }
> > >> -
> > >>      ret = rtnet_read_from_iov(ufh->fd, ufh->iov, ufh->iovlen,
> > >>                            to + sizeof(struct udphdr),
> > >>                            fraglen - sizeof(struct udphdr));
> > >>      if (ret)
> > >>          return ret;
> > >>
> > >> +    /* Checksum of the complete data part of the UDP message: */
> > >> +    ufh->wcheck = csum_partial(to + sizeof(struct udphdr),
> > >> +                           fraglen - sizeof(struct udphdr),
> > >> +                           ufh->wcheck);
> > >> +
> > >>      /* Checksum of the udp header: */
> > >>      ufh->wcheck = csum_partial((unsigned char *)ufh,
> > >>                             sizeof(struct udphdr), ufh->wcheck);
> > >>
> > >
> > > This was definitely wrong. Here is another try:
> > >
> > > diff --git a/kernel/drivers/net/stack/ipv4/udp/udp.c b/kernel/drivers/net/stack/ipv4/udp/udp.c
> > > index 8e80d3e0b..6cf1d369e 100644
> > > --- a/kernel/drivers/net/stack/ipv4/udp/udp.c
> > > +++ b/kernel/drivers/net/stack/ipv4/udp/udp.c
> > > @@ -549,6 +549,7 @@ static int rt_udp_getfrag(const void *p, unsigned char *to,
> > >                            unsigned int offset, unsigned int fraglen)
> > >  {
> > >      struct udpfakehdr *ufh = (struct udpfakehdr *)p;
> > > +    unsigned int datalen = 0;
> > >      int i, ret;
> > >
> > >
> > > @@ -556,18 +557,18 @@ static int rt_udp_getfrag(const void *p, unsigned char *to,
> > >      if (offset)
> > >           return rtnet_read_from_iov(ufh->fd, ufh->iov, ufh->iovlen, to, fraglen);
> > >
> > > -    /* Checksum of the complete data part of the UDP message: */
> > > -    for (i = 0; i < ufh->iovlen; i++) {
> > > -            ufh->wcheck = csum_partial(ufh->iov[i].iov_base, ufh->iov[i].iov_len,
> > > -                                       ufh->wcheck);
> > > -    }
> > > -
> > >      ret = rtnet_read_from_iov(ufh->fd, ufh->iov, ufh->iovlen,
> > >                             to + sizeof(struct udphdr),
> > >                             fraglen - sizeof(struct udphdr));
> > >      if (ret)
> > >           return ret;
> > >
> > > +    /* Checksum of the complete data part of the UDP message: */
> > > +    for (i = 0; i < ufh->iovlen; i++)
> > > +         datalen += ufh->iov[i].iov_len;
> > > +    ufh->wcheck = csum_partial(to + sizeof(struct udphdr), datalen,
> > > +                            ufh->wcheck);
> > > +
> > >      /* Checksum of the udp header: */
> > >      ufh->wcheck = csum_partial((unsigned char *)ufh,
> > >                              sizeof(struct udphdr), ufh->wcheck);
> > >
> >
> > OK, this won't work either if fraglen < datalen. We have to rework this
> > more fundamentally.
> >
> > As a workaround, run the kernel with nosmap.
> >
> > Jan

