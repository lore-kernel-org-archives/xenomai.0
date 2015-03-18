MIME-Version: 1.0
Sender: had2006@gmail.com
In-Reply-To: <20150318072126.GH16113@hermes.click-hack.org>
References: <87992833e1e7483097a81f9a55c800a6@MUC-S-EX13B.advaoptical.com>
 <20150318072126.GH16113@hermes.click-hack.org>
Date: Wed, 18 Mar 2015 11:20:42 +0000
Message-ID: <CAKk99t0AS_3-Bk8vC9zMV9ExPNcECsnX_GQ5EE1Uf4B_tQYBxw@mail.gmail.com>
From: Helder Daniel <hdaniel@ualg.pt>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] version connection between xenomai, ipipe and kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sagi Maimon <SMaimon@advaoptical.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 18 March 2015 at 07:21, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> >
> > 2) When I choose a xenomai version, How can I find the kernel
> > versions it supports?
>
> Look at the latest I-pipe patch it contains.
>
>
>
Let's say you want to install the latest stable version (2.6.4 at the time
of this writing). In version 3 the patches are in a different folder but
the principle is the same (I'll address this in the end).

So you can download version 2.6.4 source from:

http://download.gna.org/xenomai/stable/latest/

After uncompressing package: xenomai-2.6.4.tar.bz2
to root sources folder xenomai-2.6.4

You will find the patches organized by architecture, so at:

xenomai-2.6.4\ksrc\arch\

there are folders for each supported architecture: arm, balckfin, ..., x86,
...

Let's say you are looking for a patch for intel x86 architecture. You will
find it at:

xenomai-2.6.4\ksrc\arch\x86\patches

Inside this folder you will find 3 patches, the ones available for this
version:

ipipe-core-3.8.13-x86-4.patch
ipipe-core-3.10.32-x86-4.patch
ipipe-core-3.14.17-x86-4.patch

The patch name specifies the kernel version in the code between core- and
-x86:

ipipe-core-xx.yy.zz-x86-4.patch

So xx.yy.zz is the kernel version number.
So in this folder we have patches for Linux vanilla kernels:

3.8.13, 3.10.32 and 3.14.17

Note: If version number is only composed by xx.yy it refers to kernel
version: xx.yy[.0]

You can notice that in the patch file name, after the x-86 and before the
dot there is another number.-4 for these 3 patches
This has nothing to do with the kernel version. It is the patch version,
which is 4 for all these 3 patches.

For version 3 of Xenomai the principle is the same, but the patches are
stored in a folder with a different path. For version 3.0-rc3 they are at:

/usr/src/xenomai-3.0-rc3/kernel/cobalt/arch/

for intel x86:

/usr/src/xenomai-3.0-rc3/kernel/cobalt/arch/x86/patches/


-- 
Helder
