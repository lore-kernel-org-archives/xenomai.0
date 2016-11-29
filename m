MIME-Version: 1.0
In-Reply-To: <6e508282-b45c-95a8-4b6c-126193de0776@xenomai.org>
References: <baed9085e48cc80764b7.1480335483@devws148.be.alcatel-lucent.com>
 <6e508282-b45c-95a8-4b6c-126193de0776@xenomai.org>
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Tue, 29 Nov 2016 07:14:31 +0100
Message-ID: <CAMJ=MEedWXfZmuVeveXYNRMnc+yReM9wSpM-yodjyWkqOpeu=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] [PATCH] Add support for mips/mips64 in configure.ac
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Mon, Nov 28, 2016 at 4:51 PM, Philippe Gerum <rpm@xenomai.org> wrote:

> On 11/28/2016 01:18 PM, Ronny Meeus wrote:
> > This patch adds support for mips/mips64 in configure.ac.
> > It has been tested on Mercury only.
> >
> > diff --git a/configure.ac b/configure.ac
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -135,6 +135,10 @@ case "$build_for" in
> >       XENO_TARGET_ARCH=blackfin
> >       CONFIG_XENO_DEFAULT_PERIOD=100000
> >       ;;
> > + mips-*|mips64-*)
> > +     XENO_TARGET_ARCH=mips
> > +     CONFIG_XENO_DEFAULT_PERIOD=100000
> > +     ;;
> >   arm*-*)
> >       XENO_TARGET_ARCH=arm
> >       CONFIG_XENO_DEFAULT_PERIOD=1000000
> >
>
> Thanks. The same issue was discussed for aarch64 a few weeks ago:
> http://xenomai.org/pipermail/xenomai/2016-November/036871.html
>
> A more general fix is to not restrict the set of CPU architectures when
> building for Mercury. This patch should help:
> https://git.xenomai.org/xenomai-3.git/commit/?h=stable-3.0.x&id=
> 18493575967fe969768674096f88b63d71e032e1
>
>
Philippe

Patch is also working well.
Thanks.

Ronny


> --
> Philippe.
>
