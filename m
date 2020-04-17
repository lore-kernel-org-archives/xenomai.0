MIME-Version: 1.0
References: <20200416194437.24985-1-nolange79@gmail.com>
 <566551a9-24bb-9001-ef52-228604f758c3@siemens.com>
In-Reply-To: <566551a9-24bb-9001-ef52-228604f758c3@siemens.com>
From: Norbert Lange <nolange79@gmail.com>
Date: Fri, 17 Apr 2020 10:39:55 +0200
Message-ID: <CADYdroMF=nat_XVJerbLv6G7wqPLZ429Aqy9gDEHzhBqDrjAKw@mail.gmail.com>
Subject: Re: [PATCH] cobalt: allow to compile without __USE_LARGEFILE64
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

True, rolled a v2 after reading up a bit.
The new check was ultimately copied over from musl, should suit some
additional cases.
(I guess I wasn't running into it till now, as I mostly use _GNU_SOURCE)

Norbert

Am Fr., 17. Apr. 2020 um 08:10 Uhr schrieb Jan Kiszka <jan.kiszka@siemens.com>:
>
> On 16.04.20 21:44, Norbert Lange via Xenomai wrote:
> > A header uses the off64_t which is only conditionally available,
> > causing compile failures.
> > The macro might be necessary to compile cobalt libraries,
> > but should not be needed for software depending on them.
> >
> > Signed-off-by: Norbert Lange <nolange79@gmail.com>
> > ---
> >   include/cobalt/sys/mman.h | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/include/cobalt/sys/mman.h b/include/cobalt/sys/mman.h
> > index 1c47777a2..9428c4cec 100644
> > --- a/include/cobalt/sys/mman.h
> > +++ b/include/cobalt/sys/mman.h
> > @@ -31,8 +31,10 @@ extern "C" {
> >   COBALT_DECL(void *, mmap(void *addr, size_t length, int prot, int flags,
> >                        int fd, off_t offset));
> >
> > +#ifdef __USE_LARGEFILE64
>
> Good catch, but I think this should be _LARGEFILE64_SOURCE instead.
>
> Jan
>
> >   COBALT_DECL(void *, mmap64(void *addr, size_t length, int prot, int flags,
> >                          int fd, off64_t offset));
> > +#endif
> >
> >   #ifdef __cplusplus
> >   }
> >
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux

