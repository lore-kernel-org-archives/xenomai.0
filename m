Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA6D79E0
	for <xenomai@lists.linux.dev>; Mon, 27 Feb 2023 18:02:30 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id i34so29309805eda.7
        for <xenomai@lists.linux.dev>; Mon, 27 Feb 2023 10:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQW3iqPJWdyzx0j2g1NViFBe5LB+7H9QgpBDZf7e7hw=;
        b=EumLi1UZfD2t7VUrDmqP577Ox1EJ+B3OjAvdRb7zz3cw7P7RLTc9MAGfY30GedUu3k
         lPJMWn+Hi2G7Eh0BbBGUl3zXbjcEA2WupaFhbmsAM87is4+SLr1pCaom3/RoEMwyxsB6
         3Ny4mTo55J7NrBReFCq0IOvxoqY5s4B+jaK3gwwUdEloJyMbKaXE9mAtJC/BD4ObUXzz
         R3ksB2Y3CjuHMm95qdenjRiEPbI01f7R5YOh3v1Xq2PViCbpjCwhLpYuzq1zGyd9MJlu
         3U+1EtpxtZJ/d+nK2ctYGjDpTOwe6DohyYG2UbsiDYwxWs51DrPX/CTkzN7oqqWVOq8U
         aIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQW3iqPJWdyzx0j2g1NViFBe5LB+7H9QgpBDZf7e7hw=;
        b=cA/HtowqUj8gT2iv2GmLHF2PZsGyWmqIWN2Eq6lnZL12XM0fSBb7Lbk272xdWmbAK5
         v7yK0LBjD3jhXZ/rVumK2NVUdJ2Jd6lmNpTs+KEF1KF3nShpWyKqiBoD0qILgjTgpU7y
         E5J/h+WxhmvJPHoAgdYB99RdZmxYVgZWbs1FVWqZhcTFS2KgOMlGD0juphhde+la7rxo
         Rv5eZ3CTRmJZS3LmdoVYTmBmq4bEumyS4irGH43ecUCE93a0z7VyPnY/wwkyDsULx8kk
         1k2P3utYvcQo698m5Zu1iAUfkmqSg5MSTnRWXu7buK1jhmXisz1so4LSj5zQOTb9xg5A
         Itzg==
X-Gm-Message-State: AO0yUKWBtZeKn74IeZm70N+KNL4mCLSx3QETXkJGVF+U0kJlgFaB4HHL
	82ysfGpzw90BxXq0S0RusCMvKjpPR8CrpuRsjKr6WA3TMVc=
X-Google-Smtp-Source: AK7set9VP33Q9F+XMOHLumX/goThEFeJt2orSYg3ZMcq9Q15vwdpLTGdrzS8orBNhTbZbvI0zdlZ8lCPnlVcTK2gnlk=
X-Received: by 2002:a50:d494:0:b0:4aa:a4f2:ca1a with SMTP id
 s20-20020a50d494000000b004aaa4f2ca1amr263423edi.0.1677520948171; Mon, 27 Feb
 2023 10:02:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CA+K1mPGxOi=GFfDbE+nq99HsMWEe0+Q37bw=X=UHjqb-yNfj9A@mail.gmail.com>
 <39ce5d58-ddcf-de33-32fb-eda57a5d128b@siemens.com> <CA+K1mPF8G3c0V4Y7co=y9SGdjTy_R_d9Up=9bj7c6Nz2XEXp-g@mail.gmail.com>
 <0dea24a1-0943-d9ed-1f9f-c535e5a526ba@siemens.com> <d58eb804-dcbf-5fe2-182b-878b4fd987c3@siemens.com>
In-Reply-To: <d58eb804-dcbf-5fe2-182b-878b4fd987c3@siemens.com>
From: C Smith <csmithquestions@gmail.com>
Date: Mon, 27 Feb 2023 10:02:16 -0800
Message-ID: <CA+K1mPGGw1iJaCh_L0hRVNFcw-J4O8L-V2wMybnTZQh5EjqNMQ@mail.gmail.com>
Subject: Re: xenomai 3.2 compile failure : cobalt_lookup_vdso
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 27, 2023 at 2:30=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:
>
> On 27.02.23 10:45, Jan Kiszka wrote:
> > On 27.02.23 08:27, C Smith wrote:
> >> On Sun, Feb 26, 2023 at 10:54=E2=80=AFPM Jan Kiszka <jan.kiszka@siemen=
s.com> wrote:
> >>>
> >>> On 27.02.23 02:26, C Smith wrote:
> >>>> I am unable to compile xeno 3.2 after patching and booting kernel
> >>>> 5.4.228 successfully.
> >>>>
> >>>> I had done: git checkout origin/stable/v3.2.x
> >>>> Kernel is patched like this:
> >>>> [root@host linux]# ../xenomai/scripts/prepare-kernel.sh --arch=3Dx86=
_32
> >>>> --ipipe=3D../ipipe-core-5.4.228-x86-12.patch
> >>>> I am compiling xenomai for 32 bit apps, so maybe that is unique. Her=
e
> >>>> are the configure options:
> >>>> ./configure --enable-smp --enable-registry --enable-debug=3Dsymbols
> >>>> --enable-shared --host=3Di686-linux CFLAGS=3D"-m32 -D_FILE_OFFSET_BI=
TS=3D64"
> >>>> LDFLAGS=3D-m32 host_alias=3Di686-linux
> >>>>
> >>>
> >>> Not really:
> >>> https://source.denx.de/Xenomai/xenomai-images/-/commit/ed48e736f4b3f9=
6c73cb676f793f768a921d0624
> >>>
> >>> But we don't think have the registry enabled. Maybe worth to change t=
hat
> >>> (debian/rules).
> >>>
> >>>> The failure I got is as follows:
> >>>> ...Making all in regd
> >>>> make[3]: Entering directory '/usr/src/xenomai-git-master/lib/copperp=
late/regd'
> >>>>  CC       regd.o
> >>>>  CC       fs-common.o
> >>>>  CC       fs-cobalt.o
> >>>>  CCLD     sysregd
> >>>> ../../../lib/cobalt/.libs/libcobalt.so: undefined reference to
> >>>> `cobalt_lookup_vdso'
> >>>> collect2: error: ld returned 1 exit status
> >>>>
> >>>> I got the same problem when trying to compile 64 bit, with:
> >>>> ./configure --enable-smp --enable-registry --enable-debug=3Dsymbols
> >>>> --enable-shared
> >>>> But I actually need to compile for a large suite of legacy 32 bit ap=
ps.
> >>>>
> >>>
> >>> Can't reproduces. What is your build environment (compiler versions,
> >>> host and target distro)? which revision of stable/v3.2.x are you
> >>> building (though I'm not aware of any related changes)?
> >>
> >> I'm on RHEL8.5
> >> gcc version 8.5.0 20210514 (Red Hat 8.5.0-4) (GCC)
> >> I got the linux 5.4.228 from kernel.org
> >>
> >> I'm using the latest from the 3.2 stable branch this way:
> >> I did a 'git pull' inside a git clone and got a bunch of deltas
> >> I did:
> >>   git checkout origin/stable/v3.2.x
> >> This is what branch I'm on now:
> >> [root@host xenomai-git-master]# git branch
> >> * (HEAD detached at origin/stable/v3.2.x)
> >>   master
> >>
> >> git log shows:
> >> commit 62edc8a277d811bf35acea1784d561c45bf592c8 (HEAD, origin/stable/v=
3.2.x)
> >> Author: Florian Bezdeka <florian.bezdeka@siemens.com>
> >> Date:   Thu Feb 16 00:02:54 2023 +0100
> >>     testsuite/smokey/sched-quota: Allow building with gcc 12
> >> So thats the latest commit on this branch, right ?
> >>
> >>> Also check what happens to cobalt_lookup_vdso in libcobalt.so. In my
> >>> side, readelf -a lists it. Check if lib/cobalt/parse_vdso.c is built =
and
> >>> included in your case.
> >>
> >> parse_vdso.c didnt build into a .o file but I think it is linked into =
libcobalt
> >> [root@host cobalt]# ls -l |grep vdso
> >> -rw-r--r-- 1 root   sstorage  7240 Feb 25 23:56 parse_vdso.c
> >> looking at Makefile.am:
> >> libcobalt_la_SOURCES =3D          \
> >>         attr.c                  \
> >>         clock.c                 \
> >>         cond.c                  \
> >>         current.c               \
> >>         init.c                  \
> >>         internal.c              \
> >>         mq.c                    \
> >>         mutex.c                 \
> >>         parse_vdso.c            \
> >>         printf.c                \
> >> ...
> >>
> >> [root@host xenomai-git-master]# readelf -a
> >> ./lib/cobalt/.libs/libcobalt.so |grep vdso
> >> 00024f88  00026306 R_386_GLOB_DAT    00025ac8   cobalt_vdso
> >> 00024fa0  0001f306 R_386_GLOB_DAT    000255fc   __cobalt_vdso_gettime
> >> 000254bc  00009707 R_386_JUMP_SLOT   00000000   cobalt_lookup_vdso
> >>    151: 00000000     0 NOTYPE  GLOBAL DEFAULT  UND cobalt_lookup_vdso
> >>    499: 000255fc     4 OBJECT  GLOBAL DEFAULT   23 __cobalt_vdso_getti=
me
> >>    611: 00025ac8     4 OBJECT  GLOBAL DEFAULT   24 cobalt_vdso
> >>    453: 00025ac8     4 OBJECT  GLOBAL DEFAULT   24 cobalt_vdso
> >>    507: 000255fc     4 OBJECT  GLOBAL DEFAULT   23 __cobalt_vdso_getti=
me
> >>    903: 00000000     0 NOTYPE  GLOBAL DEFAULT  UND cobalt_lookup_vdso
> >>
> >>>> I can send my kernel .config if you want it.
> >>>
> >>> The kernel config plays no role here.
> >>> Jan
> >>
> >> Well, I untarred the xeno 3.2.1 package from xenomai.org and that
> >> compiles fine, no errors - so that's good.
> >>
> >> But the git stable branch above won't compile - and I thought I needed
> >> to be on that branch because I want Florian's latest compat patches.
> >>
> >
> > That's weird, given:
> >
> > # git diff --stat v3.2.1..stable/v3.2.x lib/ configure.ac include/
> >  include/boilerplate/atomic.h                      |  2 +-
> >  include/boilerplate/debug.h                       |  3 ++-
> >  include/boilerplate/libc.h                        |  4 ++--
> >  include/cobalt/kernel/assert.h                    |  2 --
> >  include/cobalt/kernel/dovetail/pipeline/clock.h   |  5 +----
> >  include/cobalt/kernel/dovetail/pipeline/trace.h   | 26 ++++++---------=
--------
> >  include/cobalt/kernel/rtdm/fd.h                   | 16 ++++++++++++++
> >  include/cobalt/uapi/kernel/synch.h                |  4 ++--
> >  include/copperplate/clockobj.h                    |  2 +-
> >  include/rtdm/uapi/testing.h                       | 14 ++++++++++++
> >  lib/cobalt/arch/x86/include/asm/xenomai/syscall.h |  6 +++---
> >  lib/copperplate/threadobj.c                       | 11 ++++++++++
> >  12 files changed, 59 insertions(+), 36 deletions(-)
> >
> > Please test if a checkout of v3.2.1 is also unaffected, and then do som=
e
> > bisecting. I'll see if I can find a RHEL 8.5-like container image
> > somewhere.
>
> Tested in redhat/ubi8:8.6-990 (with fuse-libs/devel from centos, didn't
> find it in the RHEL repos) and only with 64 bit (didn't find the i686
> wrappers for gcc), but hat worked fine.
>
> There must be something else different on your side to trigger this.
>
> Jan

Some progress, I got further.  But still another build problem below...
First I did:
git reset --hard
git clean -d -f
I'm still on the stable branch:
[root@rhelG xenomai-git-master]# git status
HEAD detached at origin/stable/v3.2.x
And 'git diff' returns nothing , indicating I made no changes.

then I did this again:
./configure --host=3Di686-linux CFLAGS=3D"-m32 -D_FILE_OFFSET_BITS=3D64"
LDFLAGS=3D-m32 host_alias=3Di686-linux
To Florians question: I got that configure line from Jan a year ago
and I've been using it successfully since then. I think 'i686-linux'
is appropriate as I want to generate 32 bit libraries to link my 32
bit apps against.

Then I did: make
libcobalt linked ok! No more  missing cobalt_lookup_vdso, but then the
build stalls here:
...
  CC       libtrank_la-posix.lo
  CC       libtrank_la-native.lo
  CCLD     libtrank.la
make[2]: Leaving directory '/usr/src/xenomai-git-master/lib/trank'
make[2]: Entering directory '/usr/src/xenomai-git-master/lib'
make[2]: Nothing to be done for 'all-am'.
make[2]: Leaving directory '/usr/src/xenomai-git-master/lib'
make[1]: Leaving directory '/usr/src/xenomai-git-master/lib'
Making all in config
make[1]: Entering directory '/usr/src/xenomai-git-master/config'
make[1]: Nothing to be done for 'all'.
make[1]: Leaving directory '/usr/src/xenomai-git-master/config'
Making all in include
make[1]: Entering directory '/usr/src/xenomai-git-master/include'
make  all-recursive
make[2]: Entering directory '/usr/src/xenomai-git-master/include'
Making all in boilerplate
make[3]: Entering directory '/usr/src/xenomai-git-master/include/boilerplat=
e'
make[3]: Nothing to be done for 'all'.
make[3]: Leaving directory '/usr/src/xenomai-git-master/include/boilerplate=
'
Making all in copperplate
make[3]: Entering directory '/usr/src/xenomai-git-master/include/copperplat=
e'
make[3]: *** No rule to make target 'wrappers.h', needed by 'all-am'.  Stop=
.
make[3]: Leaving directory '/usr/src/xenomai-git-master/include/copperplate=
'

Incidentally I already did a 'make install' after building xeno 3.2.1
from the official tarball, so /usr/xenomai is in good order.
How do I get past this wrappers.h problem ?

thanks   -C Smith
