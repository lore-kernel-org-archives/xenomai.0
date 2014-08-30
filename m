MIME-Version: 1.0
In-Reply-To: <5401357D.8060400@xenomai.org>
References: <CACreCV+9seA7yp8gmjvOb6CQ7-Fbt-HyQ6YAoB_dqtmqmyvy7Q@mail.gmail.com>
 <53FDFD27.2010207@xenomai.org>
 <CACreCV+cQTO-5iFCCvC15VxNzXuvKkLN+_gUTex-r3Y1cByUkw@mail.gmail.com>
 <53FF33CE.10303@xenomai.org> <D024AFFD.53F9%donald.poole@swri.org>
 <CACreCV+8qTgd6y0UuRmMQEhX_mM4PfxP2yjANerZ07SmwkmkEg@mail.gmail.com>
 <53FF5B81.7030408@xenomai.org>
 <CACreCVJ+2nEakHkkZgL=c+u7rW8S2tY-3qTWyw=AtkCH39n=rw@mail.gmail.com>
 <53FF7649.30907@xenomai.org>
 <CACreCVKEyocU22ns2dURJxB-=mhTPqtEw62oEOo+edB4ZLDK9w@mail.gmail.com>
 <5401357D.8060400@xenomai.org>
Date: Sat, 30 Aug 2014 10:40:29 +0800
Message-ID: <CACreCVJu5wNzYnyfw2_1KO9-3Zc=iHup+U08+CKXHOou=ePgMw@mail.gmail.com>
From: GP Orcullo <kinsamanka@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] ODROID-U3 porting problems
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Aug 30, 2014 9:22 AM, "Gilles Chanteperdrix" <
gilles.chanteperdrix@xenomai.org> wrote:
>
> On 08/30/2014 02:17 AM, GP Orcullo wrote:
> > static void mct_tick_ack(void)
> > {
> >         struct mct_clock_event_device *mevt =
this_cpu_ptr(&percpu_mct_tick);
>
> You have to use __this_cpu_ptr instead of this_cpu_ptr here.
>
> --
>                                                                 Gilles.

Thanks!

Problem solved.

Next step is to upgrade to a newer kernel.

Cheers,

Gemi
