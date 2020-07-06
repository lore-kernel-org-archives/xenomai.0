MIME-Version: 1.0
References: <16c407c9-8ed4-4b43-b38b-aac8a270e686@gmail.com>
In-Reply-To: <16c407c9-8ed4-4b43-b38b-aac8a270e686@gmail.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Mon, 6 Jul 2020 19:49:16 -0400
Message-ID: <CALLqZ8RXOhONVAti+XyW6dRSCWYcnLnyG1=fYyXQgU+k7RPWAA@mail.gmail.com>
Subject: Re: xenomai 3.1/ipipe-core-4.19.128-cip28-arm-10.patch
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Robert Berger <xenomai.list@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon., Jul. 6, 2020, 7:29 p.m. Robert Berger via Xenomai <
xenomai@xenomai.org> wrote:

> Hi,
>
> Now I am a bit puzzled ;)
>
> I rebuilt the rootfs against 4.14.x kernel headers, at least so I think ;)
>
> bitbake -s | grep headers
> linux-libc-headers                                   :4.19-r0
>
> nativesdk-linux-libc-headers                         :4.19-r0
>
> ... but still get the same syscall error:
>
> root@multi-v7-ml:~# /usr/bin/smokey --run=16
> [  448.996933] [Xenomai] bad syscall <0x197>
> posix_mutex OK
> root@multi-v7-ml:~#
>
> 0x197 is not present in a 4.19 kernel, so the error makes sense, but who
> calls it? It looks like something in the posix_mutex test triggers it.
>
> Regards,
>
> Robert
>
Hi,
  I'll take a look this week with a build I've been testing the ipipe with.

Greg

>
