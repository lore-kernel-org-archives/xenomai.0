MIME-Version: 1.0
References: <20190319142822.31027-1-roman.stratiienko@globallogic.com>
 <bec61ef6-33ff-7caf-2af5-114c4b7c4c18@siemens.com>
 <CAODwZ7u-SvQrBySZyRiBAuCo985j-cbD=xJG=MJyitCsdcpWgA@mail.gmail.com>
 <86594aed-6ffd-9c46-ac16-74a84a0cbdc0@siemens.com>
In-Reply-To: <86594aed-6ffd-9c46-ac16-74a84a0cbdc0@siemens.com>
From: Roman Stratiienko <roman.stratiienko@globallogic.com>
Date: Fri, 22 Mar 2019 21:45:44 +0200
Message-ID: <CAODwZ7uY3eQ1n3pMdbXzAjVjiB8Esr=HF_j2WD1pb--snPzmtg@mail.gmail.com>
Subject: Re: [PATCH] travis: add checkpatch analysis
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
Cc: xenomai@xenomai.org

Thank you for feedback. After testing of this patch I faced some challenges=
:

1. checkpatch.pl from kernel tree always different. Old kernel checkpatch
doesn't support git option. So we need to find a way to use ommon utility
for all kernel or just enable checkpatch only on most recent kernel
2. Even if there is no checkpatch errors, but warnings still present, exit
code will be false. And I can't find command line option to override it.
3. Getting delta commits in master..next range isn't a trivial task. Travis
clone only single branch with - - depth=3D50 option. Unshallowing entire
repository will take some amount of time, that will slow down build process
and it is not what me want from CI system.



=D0=B2=D1=82, 19 =D0=BC=D0=B0=D1=80. 2019 =D0=B3., 20:15 Jan Kiszka <jan.ki=
szka@siemens.com>:

> On 19.03.19 15:59, Roman Stratiienko wrote:
> > Currently I see a lot of checkpatch warnings, that can not be fixed in
> xenomai
> > project.
> > But checkpatch errors usually could be fixed, so we should try I think.
> >
>
> I don't disagree on the general goal of clean coding style. I just don't
> want to
> open too many fronts at the same time. If the checker nags us with report=
s
> that
> no one reads in the end, that will not help. And we know that there
> corners like
> rtnet which needs more than some smaller tweaks (and will currently only
> generate errors unless you break the pre-existing style).
>
> If we should agree on using automated style checking, I would then
> redefine the
> range to master..next, because that is what we are currently adding.
>
> Jan
>
> >
> > On Tue, Mar 19, 2019 at 4:45 PM Jan Kiszka <jan.kiszka@siemens.com
> > <mailto:jan.kiszka@siemens.com>> wrote:
> >
> >     On 19.03.19 15:28, roman.stratiienko--- via Xenomai wrote:
> >      > From: Roman Stratiienko <roman.stratiienko@globallogic.com
> >     <mailto:roman.stratiienko@globallogic.com>>
> >      >
> >      > Check last 10 commits with checkpatch.pl <http://checkpatch.pl>
> before build
> >      >
> >      > Signed-off-by: Roman Stratiienko <
> roman.stratiienko@globallogic.com
> >     <mailto:roman.stratiienko@globallogic.com>>
> >      > ---
> >      >   .travis.yml | 1 +
> >      >   1 file changed, 1 insertion(+)
> >      >
> >      > diff --git a/.travis.yml b/.travis.yml
> >      > index 0cd9e571f..6fb604bf2 100644
> >      > --- a/.travis.yml
> >      > +++ b/.travis.yml
> >      > @@ -78,6 +78,7 @@ before_script:
> >      >     - popd
> >      >
> >      >   script:
> >      > +  - ${KDIR}/scripts/checkpatch.pl <http://checkpatch.pl> --git
> HEAD~10..HEAD
> >      >     - scripts/prepare-kernel.sh --ipipe=3D/tmp/ipipe.patch
> --arch=3D${ARCH}
> >     --linux=3D${KDIR}
> >      >     - pushd ${KDIR}
> >      >     - make -j $(nproc) olddefconfig
> >      >
> >
> >     Hmm, not convinced about enforced checking. That will fail the
> build, even if
> >     there might be a legitimate reason for some exception, no?
> >
> >
> >
> >
> >
> >
> >     Jan
> >
> >     --
> >     Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> >     Corporate Competence Center Embedded Linux
> >
> >
> >
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
>
