Subject: Re: [PATCH] travis: add checkpatch analysis
References: <20190319142822.31027-1-roman.stratiienko@globallogic.com>
 <bec61ef6-33ff-7caf-2af5-114c4b7c4c18@siemens.com>
 <CAODwZ7u-SvQrBySZyRiBAuCo985j-cbD=xJG=MJyitCsdcpWgA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <86594aed-6ffd-9c46-ac16-74a84a0cbdc0@siemens.com>
Date: Tue, 19 Mar 2019 19:15:29 +0100
MIME-Version: 1.0
In-Reply-To: <CAODwZ7u-SvQrBySZyRiBAuCo985j-cbD=xJG=MJyitCsdcpWgA@mail.gmail.com>
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
Cc: xenomai@xenomai.org

On 19.03.19 15:59, Roman Stratiienko wrote:
> Currently I see a lot of checkpatch warnings, that can not be fixed in xenomai 
> project.
> But checkpatch errors usually could be fixed, so we should try I think.
> 

I don't disagree on the general goal of clean coding style. I just don't want to 
open too many fronts at the same time. If the checker nags us with reports that 
no one reads in the end, that will not help. And we know that there corners like 
rtnet which needs more than some smaller tweaks (and will currently only 
generate errors unless you break the pre-existing style).

If we should agree on using automated style checking, I would then redefine the 
range to master..next, because that is what we are currently adding.

Jan

> 
> On Tue, Mar 19, 2019 at 4:45 PM Jan Kiszka <jan.kiszka@siemens.com 
> <mailto:jan.kiszka@siemens.com>> wrote:
> 
>     On 19.03.19 15:28, roman.stratiienko--- via Xenomai wrote:
>      > From: Roman Stratiienko <roman.stratiienko@globallogic.com
>     <mailto:roman.stratiienko@globallogic.com>>
>      >
>      > Check last 10 commits with checkpatch.pl <http://checkpatch.pl> before build
>      >
>      > Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com
>     <mailto:roman.stratiienko@globallogic.com>>
>      > ---
>      >   .travis.yml | 1 +
>      >   1 file changed, 1 insertion(+)
>      >
>      > diff --git a/.travis.yml b/.travis.yml
>      > index 0cd9e571f..6fb604bf2 100644
>      > --- a/.travis.yml
>      > +++ b/.travis.yml
>      > @@ -78,6 +78,7 @@ before_script:
>      >     - popd
>      >
>      >   script:
>      > +  - ${KDIR}/scripts/checkpatch.pl <http://checkpatch.pl> --git HEAD~10..HEAD
>      >     - scripts/prepare-kernel.sh --ipipe=/tmp/ipipe.patch --arch=${ARCH}
>     --linux=${KDIR}
>      >     - pushd ${KDIR}
>      >     - make -j $(nproc) olddefconfig
>      >
> 
>     Hmm, not convinced about enforced checking. That will fail the build, even if
>     there might be a legitimate reason for some exception, no?
> 
> 
> 
> 
> 
> 
>     Jan
> 
>     -- 
>     Siemens AG, Corporate Technology, CT RDA IOT SES-DE
>     Corporate Competence Center Embedded Linux
> 
> 
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

