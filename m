MIME-Version: 1.0
In-Reply-To: <53FF5B81.7030408@xenomai.org>
References: <CACreCV+9seA7yp8gmjvOb6CQ7-Fbt-HyQ6YAoB_dqtmqmyvy7Q@mail.gmail.com>
 <53FDFD27.2010207@xenomai.org>
 <CACreCV+cQTO-5iFCCvC15VxNzXuvKkLN+_gUTex-r3Y1cByUkw@mail.gmail.com>
 <53FF33CE.10303@xenomai.org> <D024AFFD.53F9%donald.poole@swri.org>
 <CACreCV+8qTgd6y0UuRmMQEhX_mM4PfxP2yjANerZ07SmwkmkEg@mail.gmail.com>
 <53FF5B81.7030408@xenomai.org>
Date: Fri, 29 Aug 2014 01:05:17 +0800
Message-ID: <CACreCVJ+2nEakHkkZgL=c+u7rW8S2tY-3qTWyw=AtkCH39n=rw@mail.gmail.com>
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

On Fri, Aug 29, 2014 at 12:40 AM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On 08/28/2014 06:34 PM, GP Orcullo wrote:
>> So far it passes all the regression tests except for the switchtest.
>
> What error do you get with switchtest ? If pthread_create fails with
> resource unavailable error, see:
>
> http://xenomai.org/troubleshooting-a-dual-kernel-configuration/#pthread_create_Resource_temporarily_unavailable
>
> If this is another error, please post the error message and kernel log here.
>
> --
>                                                                 Gilles.

Running "switchtest rtk0" fails with "Xenomai: suspending kernel
thread f00bb710 ('rtk1/0') at 0xc0020c8c after exception #0x0"

The address is traced to the I-pipe timer interrupt call-back. I think
I maybe missing some spinlocks somewhere.

- Gemi

