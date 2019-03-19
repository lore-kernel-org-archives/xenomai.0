MIME-Version: 1.0
References: <20190306175331.25444-1-roman.stratiienko@globallogic.com>
 <20190306175331.25444-10-roman.stratiienko@globallogic.com>
 <327870d1-b146-e392-7993-6ebb8876c975@siemens.com>
In-Reply-To: <327870d1-b146-e392-7993-6ebb8876c975@siemens.com>
From: Roman Stratiienko <roman.stratiienko@globallogic.com>
Date: Tue, 19 Mar 2019 19:43:30 +0200
Message-ID: <CAODwZ7u6JBGjVcJFqM3oF51h4yGA6q7XGYZ4LO=c-buPARbdZA@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] travis: append i-pipe arm-v4.20.7 and arm-v5.0
 to the matrix
Content-Type: text/plain; charset="UTF-8"
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
Cc: xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>

Some point about repository-based checking VS patch based.
CI is very useful for checking regressions caused by particuar commits. But
when mixing repositories we risk to get interferentions between them.
So it might be better to have separate CI for each ipipe repository.

=D0=B2=D1=82, 19 =D0=BC=D0=B0=D1=80. 2019 =D0=B3., 16:56 Jan Kiszka <jan.ki=
szka@siemens.com>:

> On 06.03.19 18:53, roman.stratiienko--- via Xenomai wrote:
> > From: Roman Stratiienko <roman.stratiienko@globallogic.com>
> >
> > Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
> > ---
> >   .travis.yml | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> >
> > diff --git a/.travis.yml b/.travis.yml
> > index 24889ca5f..ab23b745d 100644
> > --- a/.travis.yml
> > +++ b/.travis.yml
> > @@ -46,6 +46,16 @@ script:
> >
> >   matrix:
> >     include:
> > +    - env:
> > +      - ARCH: arm
> > +        KERNEL_VERSION: 5.0
> > +        KERNEL_DEFCONFIG: multi_v7_defconfig
> > +        IPIPE_URL:
> https://github.com/devel-opi/linux-ipipe-arm-porting/releases/download/v5=
.0-draft1/ipipe-arm-v5.0-draft.patch
> > +    - env:
> > +      - ARCH: arm
> > +        KERNEL_VERSION: 4.20.7
> > +        KERNEL_DEFCONFIG: multi_v7_defconfig
> > +        IPIPE_URL:
> https://github.com/devel-opi/linux-ipipe-arm-porting/releases/download/dr=
aft-v4.20.7/0001-Draft-version-of-ipipe-arm-ported-on-v4.20.7.patch
> >       - env:
> >         - ARCH: arm
> >           KERNEL_VERSION: 4.14.85
> >
>
> This one should come it via upstream ipipe. In fact, we should drop the
> patch-based kernel setup, replacing it with git branches. That will also
> allow
> including arm64 into the matrix, where we lack a patch release for the
> only
> supported kernel version: 4.14.
>
> Applied all other 9 patches in this series to next now.
>
> Thanks,
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
>
