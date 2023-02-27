Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B667EF
	for <xenomai@lists.linux.dev>; Mon, 27 Feb 2023 08:24:46 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230227082437093c2b82430f4c55f7
        for <xenomai@lists.linux.dev>;
        Mon, 27 Feb 2023 09:24:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=mlp0phWc9sCn2uXl/HmCFLZQXymOZ7jPqRDYzw1O/6U=;
 b=QoxhFDkgeFMtp+2hrVQitLJL70OwZU7g3NGh3iY/WbVq6zOIm+V5w1+4wUSsfuFD4g3JhZ
 a9Aq/Fx1EmE6SQEs0Z3ryPpujeqfQi01Z25zUz6qIBN7uPPnmX3OvBzc5ZUxxdTGoT+R9VNq
 wRb85RBxyHbR1MMQPIbynAzHDz3OE=;
Message-ID: <9349e7a3cb3f7ce92f7c6947323fe2d7919352e1.camel@siemens.com>
Subject: Re: xenomai 3.2 compile failure : cobalt_lookup_vdso
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: C Smith <csmithquestions@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev
Date: Mon, 27 Feb 2023 09:24:35 +0100
In-Reply-To: <CA+K1mPF8G3c0V4Y7co=y9SGdjTy_R_d9Up=9bj7c6Nz2XEXp-g@mail.gmail.com>
References: 
	<CA+K1mPGxOi=GFfDbE+nq99HsMWEe0+Q37bw=X=UHjqb-yNfj9A@mail.gmail.com>
	 <39ce5d58-ddcf-de33-32fb-eda57a5d128b@siemens.com>
	 <CA+K1mPF8G3c0V4Y7co=y9SGdjTy_R_d9Up=9bj7c6Nz2XEXp-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Sun, 2023-02-26 at 23:27 -0800, C Smith wrote:
> On Sun, Feb 26, 2023 at 10:54=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens.c=
om> wrote:
> >=20
> > On 27.02.23 02:26, C Smith wrote:
> > > I am unable to compile xeno 3.2 after patching and booting kernel
> > > 5.4.228 successfully.
> > >=20
> > > I had done: git checkout origin/stable/v3.2.x
> > > Kernel is patched like this:
> > > [root@host linux]# ../xenomai/scripts/prepare-kernel.sh --arch=3Dx86_=
32
> > > --ipipe=3D../ipipe-core-5.4.228-x86-12.patch

Is arch=3D really correct? We're talking about compat applications (so 32
bit applications on a 64 bit kernel), right? In that case I would
expect --arch=3Dx86_64.

> > > I am compiling xenomai for 32 bit apps, so maybe that is unique. Here
> > > are the configure options:
> > > ./configure --enable-smp --enable-registry --enable-debug=3Dsymbols
> > > --enable-shared --host=3Di686-linux CFLAGS=3D"-m32 -D_FILE_OFFSET_BIT=
S=3D64"
> > > LDFLAGS=3D-m32 host_alias=3Di686-linux
> > >=20
> >=20
> > Not really:
> > https://source.denx.de/Xenomai/xenomai-images/-/commit/ed48e736f4b3f96c=
73cb676f793f768a921d0624
> >=20
> > But we don't think have the registry enabled. Maybe worth to change tha=
t
> > (debian/rules).
> >=20
> > > The failure I got is as follows:
> > > ...Making all in regd
> > > make[3]: Entering directory '/usr/src/xenomai-git-master/lib/copperpl=
ate/regd'
> > >  CC       regd.o
> > >  CC       fs-common.o
> > >  CC       fs-cobalt.o
> > >  CCLD     sysregd
> > > ../../../lib/cobalt/.libs/libcobalt.so: undefined reference to
> > > `cobalt_lookup_vdso'
> > > collect2: error: ld returned 1 exit status
> > >=20
> > > I got the same problem when trying to compile 64 bit, with:
> > > ./configure --enable-smp --enable-registry --enable-debug=3Dsymbols
> > > --enable-shared
> > > But I actually need to compile for a large suite of legacy 32 bit app=
s.
> > >=20
> >=20
> > Can't reproduces. What is your build environment (compiler versions,
> > host and target distro)? which revision of stable/v3.2.x are you
> > building (though I'm not aware of any related changes)?
>=20
> I'm on RHEL8.5
> gcc version 8.5.0 20210514 (Red Hat 8.5.0-4) (GCC)
> I got the linux 5.4.228 from kernel.org
>=20
> I'm using the latest from the 3.2 stable branch this way:
> I did a 'git pull' inside a git clone and got a bunch of deltas
> I did:
>   git checkout origin/stable/v3.2.x
> This is what branch I'm on now:
> [root@host xenomai-git-master]# git branch
> * (HEAD detached at origin/stable/v3.2.x)
>   master
>=20
> git log shows:
> commit 62edc8a277d811bf35acea1784d561c45bf592c8 (HEAD, origin/stable/v3.2=
.x)
> Author: Florian Bezdeka <florian.bezdeka@siemens.com>
> Date:   Thu Feb 16 00:02:54 2023 +0100
>     testsuite/smokey/sched-quota: Allow building with gcc 12
> So thats the latest commit on this branch, right ?
>=20
> > Also check what happens to cobalt_lookup_vdso in libcobalt.so. In my
> > side, readelf -a lists it. Check if lib/cobalt/parse_vdso.c is built an=
d
> > included in your case.
>=20
> parse_vdso.c didnt build into a .o file but I think it is linked into lib=
cobalt
> [root@host cobalt]# ls -l |grep vdso
> -rw-r--r-- 1 root   sstorage  7240 Feb 25 23:56 parse_vdso.c
> looking at Makefile.am:
> libcobalt_la_SOURCES =3D          \
>         attr.c                  \
>         clock.c                 \
>         cond.c                  \
>         current.c               \
>         init.c                  \
>         internal.c              \
>         mq.c                    \
>         mutex.c                 \
>         parse_vdso.c            \
>         printf.c                \
> ...
>=20
> [root@host xenomai-git-master]# readelf -a
> ./lib/cobalt/.libs/libcobalt.so |grep vdso
> 00024f88  00026306 R_386_GLOB_DAT    00025ac8   cobalt_vdso
> 00024fa0  0001f306 R_386_GLOB_DAT    000255fc   __cobalt_vdso_gettime
> 000254bc  00009707 R_386_JUMP_SLOT   00000000   cobalt_lookup_vdso
>    151: 00000000     0 NOTYPE  GLOBAL DEFAULT  UND cobalt_lookup_vdso
>    499: 000255fc     4 OBJECT  GLOBAL DEFAULT   23 __cobalt_vdso_gettime
>    611: 00025ac8     4 OBJECT  GLOBAL DEFAULT   24 cobalt_vdso
>    453: 00025ac8     4 OBJECT  GLOBAL DEFAULT   24 cobalt_vdso
>    507: 000255fc     4 OBJECT  GLOBAL DEFAULT   23 __cobalt_vdso_gettime
>    903: 00000000     0 NOTYPE  GLOBAL DEFAULT  UND cobalt_lookup_vdso
>=20
> > > I can send my kernel .config if you want it.
> >=20
> > The kernel config plays no role here.
> > Jan
>=20
> Well, I untarred the xeno 3.2.1 package from xenomai.org and that
> compiles fine, no errors - so that's good.
>=20
> But the git stable branch above won't compile - and I thought I needed
> to be on that branch because I want Florian's latest compat patches.
>=20
> -C Smith
>=20

