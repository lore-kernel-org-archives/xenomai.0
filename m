Subject: Re: [PATCH v2 10/10] travis: append i-pipe arm-v4.20.7 and arm-v5.0
 to the matrix
References: <20190306175331.25444-1-roman.stratiienko@globallogic.com>
 <20190306175331.25444-10-roman.stratiienko@globallogic.com>
 <327870d1-b146-e392-7993-6ebb8876c975@siemens.com>
 <CAODwZ7u6JBGjVcJFqM3oF51h4yGA6q7XGYZ4LO=c-buPARbdZA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8a5dbb6d-5a74-860a-f81e-8ddd41d5e270@siemens.com>
Date: Tue, 19 Mar 2019 19:18:27 +0100
MIME-Version: 1.0
In-Reply-To: <CAODwZ7u6JBGjVcJFqM3oF51h4yGA6q7XGYZ4LO=c-buPARbdZA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Roman Stratiienko <roman.stratiienko@globallogic.com>
Cc: xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>

On 19.03.19 18:43, Roman Stratiienko wrote:
> Some point about repository-based checking VS patch based.
> CI is very useful for checking regressions caused by particuar commits. But when 
> mixing repositories we risk to get interferentions between them.
> So it might be better to have separate CI for each ipipe repository.

We need both in the end. But for stable I-pipe baselines, we could simply add 
"latest tag" mode to the CI system, besides "latest branch head". Both could 
pull from the same git repos.

Note that I also do not want to continuously tune the CI script because we 
released a new stable kernel patch somewhere.

Jan

> 
> вт, 19 мар. 2019 г., 16:56 Jan Kiszka <jan.kiszka@siemens.com 
> <mailto:jan.kiszka@siemens.com>>:
> 
>     On 06.03.19 18:53, roman.stratiienko--- via Xenomai wrote:
>      > From: Roman Stratiienko <roman.stratiienko@globallogic.com
>     <mailto:roman.stratiienko@globallogic.com>>
>      >
>      > Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com
>     <mailto:roman.stratiienko@globallogic.com>>
>      > ---
>      >   .travis.yml | 10 ++++++++++
>      >   1 file changed, 10 insertions(+)
>      >
>      > diff --git a/.travis.yml b/.travis.yml
>      > index 24889ca5f..ab23b745d 100644
>      > --- a/.travis.yml
>      > +++ b/.travis.yml
>      > @@ -46,6 +46,16 @@ script:
>      >
>      >   matrix:
>      >     include:
>      > +    - env:
>      > +      - ARCH: arm
>      > +        KERNEL_VERSION: 5.0
>      > +        KERNEL_DEFCONFIG: multi_v7_defconfig
>      > +        IPIPE_URL:
>     https://github.com/devel-opi/linux-ipipe-arm-porting/releases/download/v5.0-draft1/ipipe-arm-v5.0-draft.patch
>      > +    - env:
>      > +      - ARCH: arm
>      > +        KERNEL_VERSION: 4.20.7
>      > +        KERNEL_DEFCONFIG: multi_v7_defconfig
>      > +        IPIPE_URL:
>     https://github.com/devel-opi/linux-ipipe-arm-porting/releases/download/draft-v4.20.7/0001-Draft-version-of-ipipe-arm-ported-on-v4.20.7.patch
>      >       - env:
>      >         - ARCH: arm
>      >           KERNEL_VERSION: 4.14.85
>      >
> 
>     This one should come it via upstream ipipe. In fact, we should drop the
>     patch-based kernel setup, replacing it with git branches. That will also allow
>     including arm64 into the matrix, where we lack a patch release for the only
>     supported kernel version: 4.14.
> 
>     Applied all other 9 patches in this series to next now.
> 
>     Thanks,
>     Jan
> 
>     -- 
>     Siemens AG, Corporate Technology, CT RDA IOT SES-DE
>     Corporate Competence Center Embedded Linux
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

