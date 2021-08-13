MIME-Version: 1.0
References: <20210813081254.1904938-1-fontaine.fabrice@gmail.com>
 <86057dfa-d2ed-1932-db29-4608edb08865@siemens.com>
 <CAPi7W82Y3abvah-T05oFF16GB4KzFm7=zmc594h5YWyDpRsn9Q@mail.gmail.com>
 <e09595f5-1932-c2ff-5ba4-30a3d2a54373@siemens.com>
In-Reply-To: <e09595f5-1932-c2ff-5ba4-30a3d2a54373@siemens.com>
From: Fabrice Fontaine <fontaine.fabrice@gmail.com>
Date: Fri, 13 Aug 2021 17:05:27 +0200
Message-ID: <CAPi7W80uH1gobppRNC9+9DBSx1FGL=vLGZJOjT8xK66cvxLeBw@mail.gmail.com>
Subject: Re: [PATCH] Add --disable-{demo,testsuite} options
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

Le ven. 13 ao=C3=BBt 2021 =C3=A0 16:29, Jan Kiszka <jan.kiszka@siemens.com>=
 a =C3=A9crit :
>
> On 13.08.21 15:17, Fabrice Fontaine wrote:
> > Le ven. 13 ao=C3=BBt 2021 =C3=A0 10:54, Jan Kiszka <jan.kiszka@siemens.=
com> a =C3=A9crit :
> >>
> >> On 13.08.21 10:12, Fabrice Fontaine via Xenomai wrote:
> >>> Allow the user to disable demo and testsuite to avoid the following
> >>> build failures on arc and riscv32:
> >>
> >> Are you working on ports to those archs? Or is xenomai userland just
> >> prematurely built for those in buildroot?
> > No, I'm not working on ports to those archs. I just sent this patch to
> > fix buidlroot autobuilder failures. I'm not even an expert in xenomai.
> > In buildroot, we allow to build xenomai userland on all architectures.
> > The only requirement on the toolchain is that it must have threads,
> > sync and must be uclibc or glibc:
> > https://git.buildroot.net/buildroot/commit/package/xenomai/Config.in?id=
=3Dc35f157486431eafdb8d3583fc52d8ce4c784cf3.
> > In cobalt core, we're restricting the architectures to x86, powerpc and=
 ARM.
>
> Ah, ok, these are mercury userland builds. Makes more sense now.
>
> >>
> >>>
> >>> latency.c: In function 'display':
> >>> latency.c:326:21: error: format '%ld' expects argument of type 'long =
int', but argument 2 has type 'time_t' {aka 'long long int'} [-Werror=3Dfor=
mat=3D]
> >>>   326 |         ("RTT|  %.2ld:%.2ld:%.2ld  (%s, %Ld us period, "
> >>>       |                 ~~~~^
> >>>       |                     |
> >>>       |                     long int
> >>>       |                 %.2lld
> >>>   327 |          "priority %d)\n", dt / 3600,
> >>>       |                            ~~~~~~~~~
> >>>       |                               |
> >>>       |                               time_t {aka long long int}
> >>>
> >>> altency.c: In function =E2=80=98display=E2=80=99:
> >>> altency.c:262:21: error: format =E2=80=98%ld=E2=80=99 expects argumen=
t of type =E2=80=98long int=E2=80=99, but argument 2 has type =E2=80=98time=
_t=E2=80=99 {aka =E2=80=98long long int=E2=80=99} [-Werror=3Dformat=3D]
> >>>   262 |         ("RTT|  %.2ld:%.2ld:%.2ld  (%s, %Ld us period, "
> >>>       |                 ~~~~^
> >>>       |                     |
> >>>       |                     long int
> >>>       |                 %.2lld
> >>>   263 |          "priority %d)\n", dt / 3600,
> >>>       |                            ~~~~~~~~~
> >>>       |                               |
> >>>       |                               time_t {aka long long int}
> >>>
> >>
> >> How about fixing those issues instead?
> > Indeed, fixing those issues would be great. I'll let you handle that.
>
> I wouldn't mind getting patches as well. ;)
>
> > However, I also think that disabling demo and testsuite is a nice
> > addition as it will decrease compile time and save disk space.
>
> I don't disagree. I just don't like merging a feature with the argument
> "this works around a bug". If you resend with adjusted reasoning, I'm
> fine with merging the functional changes.
OK, I sent a new patch set.
>
> But then I would still not use that to address the above errors...
>
> Jan
>
> --
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux
Best Regards,

Fabrice

