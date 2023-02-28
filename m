Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3CE9443
	for <xenomai@lists.linux.dev>; Tue, 28 Feb 2023 17:41:51 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id cq23so43452887edb.1
        for <xenomai@lists.linux.dev>; Tue, 28 Feb 2023 09:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677606110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fE5N6Ry/f9dHyy+GGWKqxv9IML4MilMlzB18mYPn1A=;
        b=l4iU16IN+KlBbS5/JdduUiqx1OMmSqwHsKtlkqlx6IzFEvRcoFSH0ijlZTe8OW9J9P
         IQcwmEEzQDLXXakXNTxGaVt4xUveSpHjRMExniDe/SvWdJ3NakwiN/4Pynt4rx983Mtj
         KMqdx5i1N+1ls1Mx7AFPOgqPfzChHSNHNtnPF9RM7RmyIJbACWeQLlxBOVi68XJF6M5O
         y/O31lbIAgeNbBqzTElZ5Tt/i4utkSc64bY0RW1Thws0GINsPNwMO9ezKZGJIYGykH4+
         npj42F2pM0V4tZzuzmp/ZqgPXsm/gnqxQlG5X2TmfabuqQbLm4RzIaDPTpbMNEfIJzlc
         Uw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677606110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fE5N6Ry/f9dHyy+GGWKqxv9IML4MilMlzB18mYPn1A=;
        b=ySB+6A7q5b62ZfOzhO1kbQZ4S+p04U8TEMMnEU93lTBI9rZlpkaQ3ya9sz5ErmL24x
         G8foxZsoxtxJ1T+jxdesgYtBYUNo0mb6YrDbKVNCTyNb7xdn+hM1q5v3yj/s6HxJceQw
         +K7xxRDZyfvX1Q5I8w/hiwQ8oWgPct/Yk3Esv5tKFPrF5PYlDsYCKuijisjYgUKlmIbF
         y9jf1HnRqlKgDdea00URR+2FG1nc49cnv1lMaNk8d/SwRjUKWVdgDpaehtMytPPuENyO
         fw4gc0shGwZgNMyU5i9Jh9lm4+SEQ0BM0DQ4eHkLYOFd9KoT/ecgqdUfvh9hHRq/Zanu
         w4Fg==
X-Gm-Message-State: AO0yUKW6T/5n0YFYpqjwXqe6ZY3zJal2ePollKbzaQ8SgOPF7ITlZ3ou
	iiaLG3hT0K/VNV78841DRg6nNOdoDrqCE0u1yCwo0ua3Qk0=
X-Google-Smtp-Source: AK7set8XpL0rqYT1ik8XOkSdlqO2D2UfQgzxrzDbCHotXyybfv0eWFRfP2XYkSUXdy8T0Y63UHOzZrzlwE+YkndGgTs=
X-Received: by 2002:a17:907:c004:b0:8af:2ad8:3453 with SMTP id
 ss4-20020a170907c00400b008af2ad83453mr8829193ejc.6.1677606109956; Tue, 28 Feb
 2023 09:41:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CA+K1mPGxOi=GFfDbE+nq99HsMWEe0+Q37bw=X=UHjqb-yNfj9A@mail.gmail.com>
 <39ce5d58-ddcf-de33-32fb-eda57a5d128b@siemens.com> <CA+K1mPF8G3c0V4Y7co=y9SGdjTy_R_d9Up=9bj7c6Nz2XEXp-g@mail.gmail.com>
 <0dea24a1-0943-d9ed-1f9f-c535e5a526ba@siemens.com> <d58eb804-dcbf-5fe2-182b-878b4fd987c3@siemens.com>
 <CA+K1mPGGw1iJaCh_L0hRVNFcw-J4O8L-V2wMybnTZQh5EjqNMQ@mail.gmail.com>
 <8fb9cff1-7ef4-715d-0db6-3b15ffa728b1@siemens.com> <CA+K1mPFkq-JD_+M8JzCEp+n5aPjgWGu2D6h9uZc=UNd8q6uqHQ@mail.gmail.com>
 <58bb082d-fb06-c69f-8b67-3e9a045f0a3f@siemens.com>
In-Reply-To: <58bb082d-fb06-c69f-8b67-3e9a045f0a3f@siemens.com>
From: C Smith <csmithquestions@gmail.com>
Date: Tue, 28 Feb 2023 09:41:38 -0800
Message-ID: <CA+K1mPE+8V=k9+JE8yM9tD5T1B_2ZbWHUgVD9TO-D2Gie+SfOQ@mail.gmail.com>
Subject: Re: xenomai 3.2 compile failure : cobalt_lookup_vdso
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 27, 2023 at 9:11=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:
>
> On 27.02.23 20:54, C Smith wrote:
> > On Mon, Feb 27, 2023 at 10:21=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens=
.com> wrote:
> >>
> >> On 27.02.23 19:02, C Smith wrote:
> >>> On Mon, Feb 27, 2023 at 2:30=E2=80=AFAM Jan Kiszka <jan.kiszka@siemen=
s.com> wrote:
> >>>>
> >>>> On 27.02.23 10:45, Jan Kiszka wrote:
> >>>>> On 27.02.23 08:27, C Smith wrote:
> >>>>>> On Sun, Feb 26, 2023 at 10:54=E2=80=AFPM Jan Kiszka <jan.kiszka@si=
emens.com> wrote:
> >>>>>>>
> >>>>>>> On 27.02.23 02:26, C Smith wrote:
> >>>>>>>> I am unable to compile xeno 3.2 after patching and booting kerne=
l
> >>>>>>>> 5.4.228 successfully.
> >>>>>>>>
> >>>>>>>> I had done: git checkout origin/stable/v3.2.x
> >>>>>>>> Kernel is patched like this:
> >>>>>>>> [root@host linux]# ../xenomai/scripts/prepare-kernel.sh --arch=
=3Dx86_32
> >>>>>>>> --ipipe=3D../ipipe-core-5.4.228-x86-12.patch
> >>>>>>>> I am compiling xenomai for 32 bit apps, so maybe that is unique.=
 Here
> >>>>>>>> are the configure options:
> >>>>>>>> ./configure --enable-smp --enable-registry --enable-debug=3Dsymb=
ols
> >>>>>>>> --enable-shared --host=3Di686-linux CFLAGS=3D"-m32 -D_FILE_OFFSE=
T_BITS=3D64"
> >>>>>>>> LDFLAGS=3D-m32 host_alias=3Di686-linux
> >>>>>>>>
> >>>>>>>
> >>>>>>> Not really:
> >>>>>>> https://source.denx.de/Xenomai/xenomai-images/-/commit/ed48e736f4=
b3f96c73cb676f793f768a921d0624
> >>>>>>>
> >>>>>>> But we don't think have the registry enabled. Maybe worth to chan=
ge that
> >>>>>>> (debian/rules).
> >>>>>>>
> >>>>>>>> The failure I got is as follows:
> >>>>>>>> ...Making all in regd
> >>>>>>>> make[3]: Entering directory '/usr/src/xenomai-git-master/lib/cop=
perplate/regd'
> >>>>>>>>  CC       regd.o
> >>>>>>>>  CC       fs-common.o
> >>>>>>>>  CC       fs-cobalt.o
> >>>>>>>>  CCLD     sysregd
> >>>>>>>> ../../../lib/cobalt/.libs/libcobalt.so: undefined reference to
> >>>>>>>> `cobalt_lookup_vdso'
> >>>>>>>> collect2: error: ld returned 1 exit status
> >>>>>>>>
> >>>>>>>> I got the same problem when trying to compile 64 bit, with:
> >>>>>>>> ./configure --enable-smp --enable-registry --enable-debug=3Dsymb=
ols
> >>>>>>>> --enable-shared
> >>>>>>>> But I actually need to compile for a large suite of legacy 32 bi=
t apps.
> >>>>>>>>
> >>>>>>>
> >>>>>>> Can't reproduces. What is your build environment (compiler versio=
ns,
> >>>>>>> host and target distro)? which revision of stable/v3.2.x are you
> >>>>>>> building (though I'm not aware of any related changes)?
> >>>>>>
> >>>>>> I'm on RHEL8.5
> >>>>>> gcc version 8.5.0 20210514 (Red Hat 8.5.0-4) (GCC)
> >>>>>> I got the linux 5.4.228 from kernel.org
> >>>>>>
> >>>>>> I'm using the latest from the 3.2 stable branch this way:
> >>>>>> I did a 'git pull' inside a git clone and got a bunch of deltas
> >>>>>> I did:
> >>>>>>   git checkout origin/stable/v3.2.x
> >>>>>> This is what branch I'm on now:
> >>>>>> [root@host xenomai-git-master]# git branch
> >>>>>> * (HEAD detached at origin/stable/v3.2.x)
> >>>>>>   master
> >>>>>>
> >>>>>> git log shows:
> >>>>>> commit 62edc8a277d811bf35acea1784d561c45bf592c8 (HEAD, origin/stab=
le/v3.2.x)
> >>>>>> Author: Florian Bezdeka <florian.bezdeka@siemens.com>
> >>>>>> Date:   Thu Feb 16 00:02:54 2023 +0100
> >>>>>>     testsuite/smokey/sched-quota: Allow building with gcc 12
> >>>>>> So thats the latest commit on this branch, right ?
> >>>>>>
> >>>>>>> Also check what happens to cobalt_lookup_vdso in libcobalt.so. In=
 my
> >>>>>>> side, readelf -a lists it. Check if lib/cobalt/parse_vdso.c is bu=
ilt and
> >>>>>>> included in your case.
> >>>>>>
> >>>>>> parse_vdso.c didnt build into a .o file but I think it is linked i=
nto libcobalt
> >>>>>> [root@host cobalt]# ls -l |grep vdso
> >>>>>> -rw-r--r-- 1 root   sstorage  7240 Feb 25 23:56 parse_vdso.c
> >>>>>> looking at Makefile.am:
> >>>>>> libcobalt_la_SOURCES =3D          \
> >>>>>>         attr.c                  \
> >>>>>>         clock.c                 \
> >>>>>>         cond.c                  \
> >>>>>>         current.c               \
> >>>>>>         init.c                  \
> >>>>>>         internal.c              \
> >>>>>>         mq.c                    \
> >>>>>>         mutex.c                 \
> >>>>>>         parse_vdso.c            \
> >>>>>>         printf.c                \
> >>>>>> ...
> >>>>>>
> >>>>>> [root@host xenomai-git-master]# readelf -a
> >>>>>> ./lib/cobalt/.libs/libcobalt.so |grep vdso
> >>>>>> 00024f88  00026306 R_386_GLOB_DAT    00025ac8   cobalt_vdso
> >>>>>> 00024fa0  0001f306 R_386_GLOB_DAT    000255fc   __cobalt_vdso_gett=
ime
> >>>>>> 000254bc  00009707 R_386_JUMP_SLOT   00000000   cobalt_lookup_vdso
> >>>>>>    151: 00000000     0 NOTYPE  GLOBAL DEFAULT  UND cobalt_lookup_v=
dso
> >>>>>>    499: 000255fc     4 OBJECT  GLOBAL DEFAULT   23 __cobalt_vdso_g=
ettime
> >>>>>>    611: 00025ac8     4 OBJECT  GLOBAL DEFAULT   24 cobalt_vdso
> >>>>>>    453: 00025ac8     4 OBJECT  GLOBAL DEFAULT   24 cobalt_vdso
> >>>>>>    507: 000255fc     4 OBJECT  GLOBAL DEFAULT   23 __cobalt_vdso_g=
ettime
> >>>>>>    903: 00000000     0 NOTYPE  GLOBAL DEFAULT  UND cobalt_lookup_v=
dso
> >>>>>>
> >>>>>>>> I can send my kernel .config if you want it.
> >>>>>>>
> >>>>>>> The kernel config plays no role here.
> >>>>>>> Jan
> >>>>>>
> >>>>>> Well, I untarred the xeno 3.2.1 package from xenomai.org and that
> >>>>>> compiles fine, no errors - so that's good.
> >>>>>>
> >>>>>> But the git stable branch above won't compile - and I thought I ne=
eded
> >>>>>> to be on that branch because I want Florian's latest compat patche=
s.
> >>>>>>
> >>>>>
> >>>>> That's weird, given:
> >>>>>
> >>>>> # git diff --stat v3.2.1..stable/v3.2.x lib/ configure.ac include/
> >>>>>  include/boilerplate/atomic.h                      |  2 +-
> >>>>>  include/boilerplate/debug.h                       |  3 ++-
> >>>>>  include/boilerplate/libc.h                        |  4 ++--
> >>>>>  include/cobalt/kernel/assert.h                    |  2 --
> >>>>>  include/cobalt/kernel/dovetail/pipeline/clock.h   |  5 +----
> >>>>>  include/cobalt/kernel/dovetail/pipeline/trace.h   | 26 ++++++-----=
------------
> >>>>>  include/cobalt/kernel/rtdm/fd.h                   | 16 +++++++++++=
+++
> >>>>>  include/cobalt/uapi/kernel/synch.h                |  4 ++--
> >>>>>  include/copperplate/clockobj.h                    |  2 +-
> >>>>>  include/rtdm/uapi/testing.h                       | 14 +++++++++++=
+
> >>>>>  lib/cobalt/arch/x86/include/asm/xenomai/syscall.h |  6 +++---
> >>>>>  lib/copperplate/threadobj.c                       | 11 ++++++++++
> >>>>>  12 files changed, 59 insertions(+), 36 deletions(-)
> >>>>>
> >>>>> Please test if a checkout of v3.2.1 is also unaffected, and then do=
 some
> >>>>> bisecting. I'll see if I can find a RHEL 8.5-like container image
> >>>>> somewhere.
> >>>>
> >>>> Tested in redhat/ubi8:8.6-990 (with fuse-libs/devel from centos, did=
n't
> >>>> find it in the RHEL repos) and only with 64 bit (didn't find the i68=
6
> >>>> wrappers for gcc), but hat worked fine.
> >>>>
> >>>> There must be something else different on your side to trigger this.
> >>>>
> >>>> Jan
> >>>
> >>> Some progress, I got further.  But still another build problem below.=
..
> >>> First I did:
> >>> git reset --hard
> >>> git clean -d -f
> >>> I'm still on the stable branch:
> >>> [root@rhelG xenomai-git-master]# git status
> >>> HEAD detached at origin/stable/v3.2.x
> >>> And 'git diff' returns nothing , indicating I made no changes.
> >>>
> >>> then I did this again:
> >>
> >> Please run scripts/bootstrap first, just to be sure configure and
> >> makefiles are up-to-date.
> >>
> >> Jan
> >>
> >>> ./configure --host=3Di686-linux CFLAGS=3D"-m32 -D_FILE_OFFSET_BITS=3D=
64"
> >>> LDFLAGS=3D-m32 host_alias=3Di686-linux
> >>> To Florians question: I got that configure line from Jan a year ago
> >>> and I've been using it successfully since then. I think 'i686-linux'
> >>> is appropriate as I want to generate 32 bit libraries to link my 32
> >>> bit apps against.
> >>>
> >>> Then I did: make
> >>> libcobalt linked ok! No more  missing cobalt_lookup_vdso, but then th=
e
> >>> build stalls here:
> >>> ...
> >>>   CC       libtrank_la-posix.lo
> >>>   CC       libtrank_la-native.lo
> >>>   CCLD     libtrank.la
> >>> make[2]: Leaving directory '/usr/src/xenomai-git-master/lib/trank'
> >>> make[2]: Entering directory '/usr/src/xenomai-git-master/lib'
> >>> make[2]: Nothing to be done for 'all-am'.
> >>> make[2]: Leaving directory '/usr/src/xenomai-git-master/lib'
> >>> make[1]: Leaving directory '/usr/src/xenomai-git-master/lib'
> >>> Making all in config
> >>> make[1]: Entering directory '/usr/src/xenomai-git-master/config'
> >>> make[1]: Nothing to be done for 'all'.
> >>> make[1]: Leaving directory '/usr/src/xenomai-git-master/config'
> >>> Making all in include
> >>> make[1]: Entering directory '/usr/src/xenomai-git-master/include'
> >>> make  all-recursive
> >>> make[2]: Entering directory '/usr/src/xenomai-git-master/include'
> >>> Making all in boilerplate
> >>> make[3]: Entering directory '/usr/src/xenomai-git-master/include/boil=
erplate'
> >>> make[3]: Nothing to be done for 'all'.
> >>> make[3]: Leaving directory '/usr/src/xenomai-git-master/include/boile=
rplate'
> >>> Making all in copperplate
> >>> make[3]: Entering directory '/usr/src/xenomai-git-master/include/copp=
erplate'
> >>> make[3]: *** No rule to make target 'wrappers.h', needed by 'all-am'.=
  Stop.
> >>> make[3]: Leaving directory '/usr/src/xenomai-git-master/include/coppe=
rplate'
> >>>
> >>> Incidentally I already did a 'make install' after building xeno 3.2.1
> >>> from the official tarball, so /usr/xenomai is in good order.
> >>> How do I get past this wrappers.h problem ?
> >>>
> >>> thanks   -C Smith
> >
> > OK, I did:
> > make clean
> > git clean -d -f
> > ./configure...
> > make
> > and the compile finally succeeded in its entirety.
> > Perhaps this git sandbox was used previously and the sources were
> > bootstrapped against an older version of code.
> >
> > Is it possible that the Makefiles could clean things up better during
> > a 'make distclean', and then in the absence of any bootstrapping the
> > user could be warned that bootstrapping is required?
>
> I the absence of bootstrapping, there are no configure and makefiles at a=
ll.
> Jan

Right. But analyzing what happened: make bootstrap was run long before
git pull, then after pulling recent sources the sandbox wouldn't
compile anymore. So some mechanism to get the sources out of that
state would be valuable.  scripts/bootstrap is bespoke and unknown to
developers, 'make distclean' is universally known.

Right now make distclean already deletes the top level Makefile but
that is not sufficient because configure regenerates it, allowing the
build to fail again.

So how about if Make distclean deletes the configure script? It would
also print a warning telling the developer to 'make bootstrap'. Of
course, once they do that, the sources will build successfully.

-C Smith
