MIME-Version: 1.0
In-Reply-To: <CAC66z97mgcrHHecrZtw5LMzLfH4MTFDgaXVFoSSPH264B2s_kA@mail.gmail.com>
References: <CAC66z97Q39YpEQ8aug7DqnCM-+cQ8NRAVgFHLgJamgbqjV4PfA@mail.gmail.com>
 <53564F83.4070401@control.lth.se>
 <A973FC64-9FD8-4892-BF4B-2BBE74942BA3@mah.priv.at>
 <535659BE.4000601@xenomai.org>
 <CAC66z97mgcrHHecrZtw5LMzLfH4MTFDgaXVFoSSPH264B2s_kA@mail.gmail.com>
Date: Wed, 23 Apr 2014 09:39:05 +0200
Message-ID: <CAPRPZsAiRrMkfupwGVyDRAj5i9h_y7rAyReVspWppzrh5cOWpA@mail.gmail.com>
From: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] RTDM: Ethernet driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: yogesh garg <yogesh.garg1983@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

2014-04-23 7:40 GMT+02:00 yogesh garg <yogesh.garg1983@gmail.com>:
> What about license part. I think RTnet is GNU GPL, so I can't use it for
> commercial products.
> Otherwise I need to expose complete source code.

Since you will be basing your driver largely on existing GPL drivers
(quite inevitably), your driver is going to end up being GPL'ed
anyway.

Don't forget that you don't need to expose your application, only
whatever you modified/added to GPL'ed parts. That's not so bad for
getting a working driver framework in return, is it ?

Jeroen.

