Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02324659
	for <xenomai@lists.linux.dev>; Mon, 27 Feb 2023 07:27:42 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id d30so21770664eda.4
        for <xenomai@lists.linux.dev>; Sun, 26 Feb 2023 23:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tibCdHWc4jgPDBVr626lraeLNqASJN3iEkNZlXbhhdo=;
        b=Q+xlDZIB2sT6XyE+PKrY/bQPySX7qVjbBIBOignPqZpTevAA1YunbjMHuYrrkaD0Vz
         Tj8y/Kj/6reQ34UtKINzhQFWpx3gmfcAbT9k7jLOEUCF074cdtqUdDLxCE3+bNZfVxDg
         gNgmd8eMAvaHUA2PWel3XUPar0Z1lTXuFTct5CXilUw3S7IbQ6PQfz9x1/4k2R6K2tHG
         g+sMquYn/JfQla5OT3ICP5D+miwL2g7znaviHXaNED/3d2gcGI/4uvhpk824qDVDZWcW
         x3iIIp6FFh+V9FpVYmJpkO0eTL5bcrZQbtP6dLxD2CWcjezZi+m+n68CVcRDXZakfeHY
         Y3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tibCdHWc4jgPDBVr626lraeLNqASJN3iEkNZlXbhhdo=;
        b=W3bxNT1c2gwSzCjAybEowVdTEbjgCFBu0FAQLNzVyVjX3NZm1zZRkzbqbD6/thtrg/
         BmsFn9y5NlaH5Oi9ztxXFI7Joo+cIAUnSrGOZ+o/haqM5nvYg2LAfe5MA5Cenl3UfLl4
         /O7f9TEjwmxhW6uKNQL82aU4sJUBTd5e/CGVi6810LGJwLscn2J8lL/zgUP0enFv+RpO
         p40AkZaZ5SEa/S2vgE18/2OsI+/qP4d6uN4JfU6BmbbxPSt9O7r8EpOqg/8qkCp/AhBr
         5iOyM6tyxvaMb15a4e9Yx9wuu2legExrr7Za7ryoqaD1URwg62o3mFab/mgAMMOeZAc3
         ojdg==
X-Gm-Message-State: AO0yUKUpcqZorsjfHAlUlWwIGyNopYd8m+xg+4QYQjMA2VWRkdjGuGcn
	NbvIT+CY1xWmpXQFCAJ9IV2rC7XW1i/komLPuOwopxvfywg=
X-Google-Smtp-Source: AK7set89A1Hge0KTtUHWc2K5LNSKlHPIgLhkeiz5NwGb4j98zXGLTcgwxaZ4brN45+vcdUSid/CCthKojdHOuZrQ9gE=
X-Received: by 2002:a50:aa9e:0:b0:4ac:bb4e:c38c with SMTP id
 q30-20020a50aa9e000000b004acbb4ec38cmr11621182edc.0.1677482860957; Sun, 26
 Feb 2023 23:27:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CA+K1mPGxOi=GFfDbE+nq99HsMWEe0+Q37bw=X=UHjqb-yNfj9A@mail.gmail.com>
 <39ce5d58-ddcf-de33-32fb-eda57a5d128b@siemens.com>
In-Reply-To: <39ce5d58-ddcf-de33-32fb-eda57a5d128b@siemens.com>
From: C Smith <csmithquestions@gmail.com>
Date: Sun, 26 Feb 2023 23:27:29 -0800
Message-ID: <CA+K1mPF8G3c0V4Y7co=y9SGdjTy_R_d9Up=9bj7c6Nz2XEXp-g@mail.gmail.com>
Subject: Re: xenomai 3.2 compile failure : cobalt_lookup_vdso
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 26, 2023 at 10:54=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens.com=
> wrote:
>
> On 27.02.23 02:26, C Smith wrote:
> > I am unable to compile xeno 3.2 after patching and booting kernel
> > 5.4.228 successfully.
> >
> > I had done: git checkout origin/stable/v3.2.x
> > Kernel is patched like this:
> > [root@host linux]# ../xenomai/scripts/prepare-kernel.sh --arch=3Dx86_32
> > --ipipe=3D../ipipe-core-5.4.228-x86-12.patch
> > I am compiling xenomai for 32 bit apps, so maybe that is unique. Here
> > are the configure options:
> > ./configure --enable-smp --enable-registry --enable-debug=3Dsymbols
> > --enable-shared --host=3Di686-linux CFLAGS=3D"-m32 -D_FILE_OFFSET_BITS=
=3D64"
> > LDFLAGS=3D-m32 host_alias=3Di686-linux
> >
>
> Not really:
> https://source.denx.de/Xenomai/xenomai-images/-/commit/ed48e736f4b3f96c73=
cb676f793f768a921d0624
>
> But we don't think have the registry enabled. Maybe worth to change that
> (debian/rules).
>
> > The failure I got is as follows:
> > ...Making all in regd
> > make[3]: Entering directory '/usr/src/xenomai-git-master/lib/copperplat=
e/regd'
> >  CC       regd.o
> >  CC       fs-common.o
> >  CC       fs-cobalt.o
> >  CCLD     sysregd
> > ../../../lib/cobalt/.libs/libcobalt.so: undefined reference to
> > `cobalt_lookup_vdso'
> > collect2: error: ld returned 1 exit status
> >
> > I got the same problem when trying to compile 64 bit, with:
> > ./configure --enable-smp --enable-registry --enable-debug=3Dsymbols
> > --enable-shared
> > But I actually need to compile for a large suite of legacy 32 bit apps.
> >
>
> Can't reproduces. What is your build environment (compiler versions,
> host and target distro)? which revision of stable/v3.2.x are you
> building (though I'm not aware of any related changes)?

I'm on RHEL8.5
gcc version 8.5.0 20210514 (Red Hat 8.5.0-4) (GCC)
I got the linux 5.4.228 from kernel.org

I'm using the latest from the 3.2 stable branch this way:
I did a 'git pull' inside a git clone and got a bunch of deltas
I did:
  git checkout origin/stable/v3.2.x
This is what branch I'm on now:
[root@host xenomai-git-master]# git branch
* (HEAD detached at origin/stable/v3.2.x)
  master

git log shows:
commit 62edc8a277d811bf35acea1784d561c45bf592c8 (HEAD, origin/stable/v3.2.x=
)
Author: Florian Bezdeka <florian.bezdeka@siemens.com>
Date:   Thu Feb 16 00:02:54 2023 +0100
    testsuite/smokey/sched-quota: Allow building with gcc 12
So thats the latest commit on this branch, right ?

> Also check what happens to cobalt_lookup_vdso in libcobalt.so. In my
> side, readelf -a lists it. Check if lib/cobalt/parse_vdso.c is built and
> included in your case.

parse_vdso.c didnt build into a .o file but I think it is linked into libco=
balt
[root@host cobalt]# ls -l |grep vdso
-rw-r--r-- 1 root   sstorage  7240 Feb 25 23:56 parse_vdso.c
looking at Makefile.am:
libcobalt_la_SOURCES =3D          \
        attr.c                  \
        clock.c                 \
        cond.c                  \
        current.c               \
        init.c                  \
        internal.c              \
        mq.c                    \
        mutex.c                 \
        parse_vdso.c            \
        printf.c                \
...

[root@host xenomai-git-master]# readelf -a
./lib/cobalt/.libs/libcobalt.so |grep vdso
00024f88  00026306 R_386_GLOB_DAT    00025ac8   cobalt_vdso
00024fa0  0001f306 R_386_GLOB_DAT    000255fc   __cobalt_vdso_gettime
000254bc  00009707 R_386_JUMP_SLOT   00000000   cobalt_lookup_vdso
   151: 00000000     0 NOTYPE  GLOBAL DEFAULT  UND cobalt_lookup_vdso
   499: 000255fc     4 OBJECT  GLOBAL DEFAULT   23 __cobalt_vdso_gettime
   611: 00025ac8     4 OBJECT  GLOBAL DEFAULT   24 cobalt_vdso
   453: 00025ac8     4 OBJECT  GLOBAL DEFAULT   24 cobalt_vdso
   507: 000255fc     4 OBJECT  GLOBAL DEFAULT   23 __cobalt_vdso_gettime
   903: 00000000     0 NOTYPE  GLOBAL DEFAULT  UND cobalt_lookup_vdso

> > I can send my kernel .config if you want it.
>
> The kernel config plays no role here.
> Jan

Well, I untarred the xeno 3.2.1 package from xenomai.org and that
compiles fine, no errors - so that's good.

But the git stable branch above won't compile - and I thought I needed
to be on that branch because I want Florian's latest compat patches.

-C Smith
