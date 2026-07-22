Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5D6404BE9
	for <xenomai@lists.linux.dev>; Wed, 22 Jul 2026 11:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784720770; cv=none; b=cb4SF/QrCmsUr1UoDXvpcRAhm+6nCGJ949ldHhWY8Pxqw+3L9+Qm8LTmZOKhDZU+u+FLkOyLHtLL/mAe/dogH1DnV4SBeJTma+dnm8NDqAbb+o0IdLt3pBgf2hm4SLJHBcPRVCKvoRrlBHvL112Bdk4X1cI0YM1TnVzU9AxwayU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784720770; c=relaxed/simple;
	bh=p/iEpT0+ucIXx3EfwJYgOB7Blgf9Ex1M1zlOBtM/b+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y0d/mb/gBA5t5gXTuYFpEQD1OCGDJquo4Ft775jsOe+AHnGQEV7nygZLxetI8Bc9TEOX0Pf64elISnO7TjU2EpzFLhgAGiO942j8VJZYST7ra7aHuSV4aun5x94PIS3xKhkUv4cL6w2y9XY+kNvwg+uF1nOLdYr9g1BOWe1FT1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOwNCgPp; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOwNCgPp"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49547fc63a0so27706475e9.2
        for <xenomai@lists.linux.dev>; Wed, 22 Jul 2026 04:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784720766; x=1785325566; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KYhG5UMPHXJexwkmZI+iuqe2Wqo9hjMXY3/6U8e7hVo=;
        b=mOwNCgPpPaT4ECBrsMwOG54+/wY5SPfV6h5+8Mzi1WnSJqMvdsKXr7JuJqi0F85GxZ
         2Kmx8BK10O3pSJbGB6CXdwpg4Lh8DBNEBYlPbCUk4MAPFxmzGA99g9gbehBOHgVyEUdy
         iBqBUwLoc4IL+mBG+aN3eackySNGKyym25u8FH5A7LQZ6TAedKTOnLqpmmNMgL+CE9Tm
         qvBzCujHtuAfT9I4KOOimp5IvYzz1eTBW8pOw6yEB3vTyomRkepJA9Yxgxs8zsnvY7tm
         WW6ZY1kSoQTbalIqytmeSefBRJCwTdsiLBfnzk0ZV1pFmF79CcUClIcmOLYC+YdJu7gj
         1pbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784720766; x=1785325566;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KYhG5UMPHXJexwkmZI+iuqe2Wqo9hjMXY3/6U8e7hVo=;
        b=ivHPp9xGm940aGeRBZ45D3TxvPttgqTLi2OHTUkXxhOmwqd6M8Zo/g/axSIcqTrDpG
         AdyAg7np47VAOAA4kgVfo1EJDqkUbprdFm4fHWivKTshjyPerjBYpGC+uPwpl2U+rW84
         veP9qYHEEw7NYicbeP+KfJ0TDYUHRom4vufCnNOKo02JqTRKW0tFUBtbY9tF1D0e5fRv
         I1ZTJoUSZCENskg0mNxf1duIHIlFXQvNY0m4wVqLJL/51nl4e2sOO2rXasD6fy9F6o7F
         lvWilwZnVlRMKVhifDk+MoN9ePlohXfR56Re6bm5K0JqqT9EPZ0wRS4w7MaWP/OizoLr
         x1zQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrfq4hiY204rZhtH3S+3kRii1HdTGYowE5BsPk0Ud4ZDE7WBwftNgsyxg36sjG4g0AUyAqYvpbB@lists.linux.dev
X-Gm-Message-State: AOJu0Yy3Fm7auvEaSiU0MrFb4zzxq4mRPg4bAjOiUhurZKUMSoMEUzIH
	+GMYnZKCEJ/oz+Wbn7vIgkzrMtdVi5r8LNbE0cKEX8CXbNnyfZkg23rNrWzqfZVV
X-Gm-Gg: AR+sD12rFOrI9mbrqXc+nvarOJrCWMbBTGIYkEp8JAelXyFeLEuwAnFPaP3EscHfnaM
	WrxTPUJDotyCZXTCB43l9okF1Q6ospjtcBkwPcHRmqXaYUPWpn6ABpYMOQujOtgbYqY8ZlkAYHm
	pzTN0M83DQlX+sdBBFVM7Z7ESnqZA2cSK/zBkQzEhTUKIGinpQzKgXhOn7ikau3ozmqL6fLOMq1
	99B6z0JAYlVKYNLv4JeB5Ulyxz93QW6QhfKAnbpDRpeBx3YfVERrw8votywt1SYbuPoWIuKX9rz
	A+lySCuN97X9VDSBBIoYVCfxiGAIYbtVWYXVL0VCKs7HJ2m+ayh6MUHFbblDzf9jn7zTbVAW4IB
	PHOvzThInh+F8eK0AnMNaVeORZm2K/zBOvkEMmJLB8HkHNLQ/YFMoBaVFP2Pz+vaC8QWpoJFOph
	fSt3TyQWpW3w==
X-Received: by 2002:a05:600c:4a1a:b0:495:39aa:1359 with SMTP id 5b1f17b1804b1-4954a3d0d92mr152292935e9.3.1784720765606;
        Wed, 22 Jul 2026 04:46:05 -0700 (PDT)
Received: from [192.168.1.3] ([213.55.168.64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a500dbfsm59690885e9.6.2026.07.22.04.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 04:46:04 -0700 (PDT)
Message-ID: <6bc537bd-47d2-4f3f-985b-a75c7b6d0e26@gmail.com>
Date: Wed, 22 Jul 2026 13:46:03 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] libevl: Add debian package config
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev,
 rpm@xenomai.org
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
References: <20260717205820.8359-1-hannes.diethelm@gmail.com>
 <60f4470e-cdb7-40a7-a73a-9bb6d4a10ebd@siemens.com>
 <2d7c3324-28f6-444e-a8a0-a028368804b6@gmail.com>
 <ab53bde9-f1eb-4a03-b545-78501a25cd1b@siemens.com>
From: Hannes Diethelm <hannes.diethelm@gmail.com>
Content-Language: en-US
In-Reply-To: <ab53bde9-f1eb-4a03-b545-78501a25cd1b@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 21.07.26 um 12:37 schrieb Jan Kiszka:
> On 21.07.26 00:22, Hannes Diethelm wrote:
>> Am 20.07.26 um 16:30 schrieb Jan Kiszka:
>>> Hi Hannes,
>>>
>>> thanks for carrying this over.
>>
>> Thanks for all the feedback.
>>
>>>
>>> On 17.07.26 22:58, Hannes Diethelm wrote:
>>>> This patch adds a debian package config that allows to build a deb's
>>>> using dpkg-buildpackage -b -uc.
>>>>
>>>> The packages are libevl / libevl-test similar to[1]. However, latmus
>>>> is placed in libevl. One might not need the tests but still want to
>>>> use latmus.
>>>
>>> For the purpose of tuning the core, or what is the reasoning here?
>>
>> Yes exactly. One might need latmus but won't care about the tests.
>>
>> Based on the comment from Florian, it would probably make more sense to
>> create more packages:
>>
>> - libevl (only library)
>> - libevl-bin (evl / latmus / oob-* tidbits)
>> - libevl-test (tests)
>> - libevl-dev (headers / libevl.a)
>>
> 
> Alternatively, maybe there is a way to split off the tuning feature from
> latmus tool, like we have with autotune in xenomai3.

latmus is not that big, 56k. If you are really tight on space on an embedded
system, I guess using Debian packages is anyway not the way to go.

The actual sizes in k are, queried by dpkg-deb -f
libevl_59-2_amd64.deb              522
libevl-dbgsym_59-2_amd64.deb       336
libevl-test_59-2_amd64.deb        1484
libevl-test-dbgsym_59-2_amd64.deb 1618

With the proposed structure, it would be:
libevl_59-3_amd64.deb               90
libevl-dbgsym_59-3_amd64.deb       110
libevl-bin_59-3_amd64.deb          212
libevl-bin-dbgsym_59-3_amd64.deb   234
libevl-dev_59-3_amd64.deb          196
libevl-test_59-3_amd64.deb        1484
libevl-test-dbgsym_59-3_amd64.deb 1618

Other packages have similar structures, to name a few:
liblapack-dev - Library of linear algebra routines 3 - static version
liblapack-doc - Library of linear algebra routines 3 - documentation
liblapack-test - Library of linear algebra routines 3 - testing programs
liblapack3 - Library of linear algebra routines 3 - shared version

libbpf-tools - tools for BPF Compiler Collection based on libbpf (BTF and CO-RE)
libbpf-dev - eBPF helper library (development files)
libbpf1 - eBPF helper library (shared library)

libcap-dev - POSIX 1003.1e capabilities (development)
libcap2 - POSIX 1003.1e capabilities (library)
libcap2-bin - POSIX 1003.1e capabilities (utilities)

That matches well with:
libevl - libevl library (shared library)
libevl-bin - libevl tools
libevl-dev - libevl library (development files)
libevl-test - libevl test suite

Only difference: Many libs have a stuffix number for the major version
to be able to install more than one. I think this is not needed for libevl.

Is this fine? I have to do a few checks if all files are in the correct package
before I submit a patch v2.

Also the ptrace-sync test / non-root latmus is still open.

> 
>>>
>>>>
>>>> Additionally, libevl installs /usr/lib/udev/rules.d/90-libevl.rules
>>>> which sets all evl
>>>> device files to group evl, g+rw. libevl.postinst adds this group and
>>>> triggers an udev reload.
>>>>
>>>> This allows to use libevl without root. However, using SCHED_FIFO still
>>>> needs either root or setcap cap_sys_nice+ep and possibly some other
>>>> tweaks.
>>>> Some tests and my application work with cap_sys_nice+ep. However, for
>>>> example latmus fails
>>>> due to unknown reasons. The debian packages sets no capabilities but
>>>> this could be added
>>>> if desired.
>>>>
>>>> Caveats:
>>>>
>>>> The test ptrace-sync fails with <timeout waiting for gdb>. dh_strip -
>>>> Xptrace-sync from[1]
>>>> does not help and it is not needed: When libevl-test-dbgsym is
>>>> installed, the symbols are
>>>> available but the test still fails. With dh_strip -Xptrace-sync, the
>>>> symbols are not found:
>>>> warning: could not find '.gnu_debugaltlink' file for /usr/libexec/
>>>> evl/tests/ptrace-sync
>>>
>>> But the package built by xenomai-images does not have this problem and
>>> runs the ptrace test successfully. Already dug into the key differences?
>>
>> Not yet. Might be just a different gdb version or path issue. I am using
>> Debian Trixie.
>>
>> Is there a way to download this images? I've seen there is a way to
>> build them locally, i can also try this.
>>
> 
> We do not ship pre-built images, you would have to build your own image
> here.
> 
>>>
>>>>
>>>> If linux-evl is also built and installed as a debian package, linux-
>>>> libc-dev can not be
>>>> installed due to /usr/include/evl/*-abi.h are both installed by
>>>> libevl and linux-libc-dev
>>>> from the kernel build. However, installing linux-libc-dev from debian
>>>> trixie works fine.
>>>
>>> This looks wrong: The kernel is providing us with a different UAPI, thus
>>> also needs to deliver an alternative linux-libc-dev package. It should
>>> be the role of libevl to deliver those headers as it has no knowledge
>>> about the actual kernel in use here. That's why xenomai-images is
>>> generating a new linux-libc-dev and is not relying on libevl here.
>>>
>>
>> Yes, Philippe sent me the hint with the -Dinstall-uapi=false switch,
>> thanks.
>>
>> One remaining issue is the versioning / dependency's. For now, to keep
>> it simple, I just used the libevl tag
>> as the version. And it doesn't recommend a xenomai4 kernel.
>>
>> For now, the packages are:
>> libevl_59_amd64.deb
>> libevl-test_59_amd64.deb dep libevl >= 59
>> linux-image-6.12.90-cip24-xenomai4-r59_6.12.90-3_amd64.deb (Withouth
>> PREEMT_RT)
>> linux-image-6.12.90-cip24-xenomai4-r59-rt_6.12.90-3_amd64.deb (With
>> PREEMT_RT)
>>
>> I am working here [1] on creating Debian xenomai4 packages for linuxcnc.
>> Not perfect but does the job. It's still WIP
>> but a few people got this already working without knowledge how to build
>> kernels.
>> I did not yet push the latest version and I have to change from pushing
>> the binary's to github releases.
>>
>> With the uapi installed with linux-libc-dev, libevl has to depend on the
>> right linux-libc-dev.
>>
>> Version 59 is not really correct. The kernel has EVL ABI 45. Libevl has
>> API 36, needs API >= 45.
>> For kernel dependency's, the ABI version is important, right?
>>
>> For libevl, it could be either the API = 36 / dso_version = 8.0.0 /
>> version = 0.59.
>>
>> Variant with API/ABI as version:
>> - libevl 36 recommends linux-image-xenomai4 >= 45 or linux-image-
>> xenomai4-rt >= 45
>> - libevl-bin 36 dep libevl >= 36
>> - libevl-test 36 dep libevl >= 36
>> - libevl-dev 36 dep libevl >= 36 linux-libc-dev >= 1:45
>>
>> Dependency packages, needed to convert the ABI versioning into kernel
>> versioning:
>> - linux-image-xenomai4 45 dep linux-image-6.12.90-cip24-xenomai4-45 or
>> other kernel versions
>> - linux-image-xenomai4-rt 45 dep linux-image-6.12.90-cip24-xenomai4-
>> rt-45 or other kernel versions
>> - linux-libc-dev 1:45 dep linux-libc-dev-xenomai4-45
>>
>> Kernel packages:
>> - linux-image-6.12.90-cip24-xenomai4-45 6.12.90
>> - linux-image-6.12.90-cip24-xenomai4-rt-45 6.12.90
>> - linux-libc-dev-xenomai4-45 6.12.90
>>
>> To create a linux-libc-dev-xenomai4-45 package, I would have to add a
>> patch for linux-evl, the standard
>> kernel debian package system doesn't support custom names for linux-
>> libc-dev. But this should be not to
>> complicated.
>>
>> It's the first Debian package I am working on that's not only for me. I
>> have to read a bit more in the
>> doc's how this dependency's are normally created properly.
>>
>> Also linux-libc-dev 1:45 is a bit dirty: Using the epoch to replace the
>> standard linux-libc-dev by a dependency
>> package that will not be replaced by the latest stock one. It should
>> work tough.
>>
>> Alternatives:
>> -Install the abi with libevl
>> -Create a linux-libc-dev-xenomai4 package from linux-evl and depend on
>> that / remove the evl headers from linux-libc-dev
>>   so linux-libc-dev stock can be installed together with linux-libc-dev-
>> xenomai4. I compared the content, most evl related files
>>   are new, only fnctl.h has
>>   #define O_OOB        010000000000
>>   added. However, I don't see any usage in libevl. So this should work.
>> -Leave the dependency's on the kernel packages away and solve this by
>> documentation
>>   However, you would have to place a hold on linux-libc-dev so it doesn't
>> get replaced as soon as your OS has a newer kernel.
>>
>> Do you have other ideas how to solve the version / dependency's / linux-
>> libc-dev issue?
>>
>> For now I named the kernel packages -xenomai4 but I am thinking about
>> changing to -evl or xenomai-evl. What is more appropriate?
> 
> The topic is complicated because neither Debian nor other packaging
> systems I know allow to express this two-dimensional version dependency
> (>= ABI version X, latest kernel Y). If you encode the ABI into the
> package version as well, you are folding that version matrix into a
> single version number (>= abi-X-kernel-Y, or >= kernel-Y-ABI-X) - none
> is perfect.

Yes, that's an issue. But for EVL you need only the ABI version, the
kernel version does not really matter. You can solve this by
creating dependency packages:

libevl 36 depens linux-image-xenomai4 >= 45
linux-image-xenomai4 45 depends linux-image-6.12.90-cip24-xenomai4-45 ...
linux-image-6.12.90-cip24-xenomai4-45 6.12.90

But I think this just gets to complicated for this application.

Proposal: Leave the dependency on linux-image-evl and linux-libc-dev out
in libevl and add documentation in [1] how to build and install
libevl / linuxevl the Debian way.

Only disadvantage: libevl-dev will fail compiling if you don't install
the correct linux-libc-dev or update it later back to vanilla.

Alternative: I can create a patch for linux-evl so the resulting
package changes from linux-libc-dev to linux-libc-evl-dev with the Provides
Conflicts and Replaces fields.

The libevl Build-Depends could then also depend on linux-libc-evl-dev. However,
there is now easy way to depend on a specific ABI.

Looks like this does the job for the renamed package:
diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index fb686fd3266f..5e95dad9de57 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -149,7 +149,7 @@ case "${package}" in
  	install_linux_image_dbg "${package}";;
  linux-image-*|user-mode-linux-*)
  	install_linux_image "${package}";;
-linux-libc-dev)
+linux-libc-evl-dev)
  	install_libc_headers "${package}";;
  linux-headers-*)
  	install_kernel_headers "${package}";;
diff --git a/scripts/package/debian/rules b/scripts/package/debian/rules
index 2b3f9a0bd6c4..a7c50812c2a0 100755
--- a/scripts/package/debian/rules
+++ b/scripts/package/debian/rules
@@ -27,12 +27,12 @@ make-opts = ARCH=$(ARCH) KERNELRELEASE=$(KERNELRELEASE) \
      $(addprefix KBUILD_BUILD_VERSION=,$(revision)) \
      $(addprefix CROSS_COMPILE=,$(CROSS_COMPILE))
  
-binary-targets := $(addprefix binary-, image image-dbg headers libc-dev)
+binary-targets := $(addprefix binary-, image image-dbg headers libc-evl-dev)
  
  all-packages = $(shell dh_listpackages)
  image-package = $(filter linux-image-% user-%, $(filter-out %-dbg, $(all-packages)))
  image-dbg-package = $(filter %-dbg, $(all-packages))
-libc-dev-package = $(filter linux-libc-dev, $(all-packages))
+libc-evl-dev-package = $(filter linux-libc-evl-dev, $(all-packages))
  headers-package = $(filter linux-headers-%, $(all-packages))
  
  mk-files = $(patsubst binary-%,debian/%.files,$1)
diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index fc3b7fa709fc..1f42dadfdfc6 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -215,11 +215,13 @@ EOF
  if [ "${SRCARCH}" != um ]; then
  cat <<EOF >> debian/control
  
-Package: linux-libc-dev
+Package: linux-libc-evl-dev
  Section: devel
-Provides: linux-kernel-headers
+Provides: linux-kernel-headers, linux-libc-dev
+Conflicts: linux-libc-dev
+Replaces: linux-libc-dev
  Architecture: $debarch
-Description: Linux support headers for userspace development
+Description: Linux / evl support headers for userspace development
   This package provides userspaces headers from the Linux kernel.  These headers
   are used by the installed headers for GNU glibc and other system libraries.
  Multi-Arch: same

If you think this is a good solution, I can provide a proper patch.

> 
> If your target audience for those packages primarily consists of
> beginners, it will be best to model it via a lock-step between libevl
> and some kernel package that carries a specific ABI version in its name
> (linux-image-evlX_kernel-ver-Y etc.). This implies creating a
> linux-libc-dev flavor as well (linux-libc-dev-evlX or so). That package
> should carry Provides:, Conflicts:, and Replaces: for linux-libc-dev in
> its metadata.

For my audience, I think the best is to have a fixed package set
and fixed dependency's. So it is tested together, works together
and generates dependency errors if you install something else.

I can easily keep a patch on my side that adds the needed fields
/ creates a linux-libc-evl-dev while upstream libevl doesn't have
this dependency's.

Thanks for the hint with Provides / Replaces.

> 
> We side-step all these issues in xenomai-images by generating and
> installing a set of custom packages in a curated environment where
> upstream will not be able to replace the self-build xenomai packages
> (preferences are set accordingly for local repo with those packages).

Yes, with images it is easy, you can also just use make install and
build a new image when something has to change.

> 
> Jan
> 

[1] https://v4.xenomai.org/core/build-steps/index.html
