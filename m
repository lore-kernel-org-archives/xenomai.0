Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF26917E9
	for <xenomai@lists.linux.dev>; Fri, 26 Jul 2024 19:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722021347; cv=none; b=TlcRlimkYmwRf/5xl+5m8EeonuFxsWzEmluJF4OUdQxmY6hzERTaMYpCAFIxs7hH0feIlmfcFyVmvefa/MnExautB5UO2rIegYDRRE0Knki1k/XZKxJF0WX2tgGrDOPPN4FkWEu1yYRGaz/gHkNVrVmYAOQCcrQpcxh6Q4JQeR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722021347; c=relaxed/simple;
	bh=zEsstxtT1h06e5Lsfko+c57ffF8BuFZyCw01sP0XXUo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eYAa6NoSNaGu4yP98fCxzMsKSeRcBmAwzp/o7bZAmguXvJWb9MoZfiGA+jD+T/vQxYiN3kCuKSCgJysPsMZuOZMlyQ37ZOdk81vdYCUU5/KoIuwhfFUzNDQeW5GbohqN4n4lVrCfOH6XR++VzGWCgAgrUQ3mLs9u4KPnki7k6Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-59589a9be92so3139704a12.2
        for <xenomai@lists.linux.dev>; Fri, 26 Jul 2024 12:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722021344; x=1722626144;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOuoNFUYgsOuul6UjjdDnaMYUQGTZXG2149nuhBfOMI=;
        b=NspaMsfRZ5knvHIVAgRqDhGTKpY04y/bb/GEdfBs1SRJzcLD2a/Siu50GdRdEdTu+z
         FqYDYBo5xse90WBOIUYZOTTrbZ7myGh0WlHDYWGyP5kSXf4Mfzmo3fOA/ySSNxizUu2O
         WjvNt4lGv3OLNJF31fwaTO5MmFgKmtvt4Iq/+0wpHxza5ednoZOl2e4lwdsIy+swmkrI
         02mXY6gIgMCAMIS8Smq/oGVbCFrE/uCotYEgVgLFtkBEhfWz4i4hePILcTNuRcdUx48r
         ZOkUpW25GBFaJyAjffSks4ok67ueoRbe+em6k9FB/byMQFkKATJEHEk1+gNo9eDizzt7
         uaeQ==
X-Gm-Message-State: AOJu0YzWKa54c0YcW4I2I2rdYcr/XURFJDnIDNMEMePYNdyHlRNxcsV5
	H6IaMr3/hAGaveAsXUk03nAj3GpN3Rcz/N38AtkwEM1yabp0X/OngQaD3A==
X-Google-Smtp-Source: AGHT+IH2nrBLWfHcFaTmxjBURzD7NT3SsqtQinzwJuKLgomUFOLVaK9YkYh8amhX+B2HXYy+KPhlNA==
X-Received: by 2002:a17:907:6d18:b0:a7a:9d70:82b9 with SMTP id a640c23a62f3a-a7d3fff8f47mr32397866b.17.1722021343838;
        Fri, 26 Jul 2024 12:15:43 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad416basm206868266b.104.2024.07.26.12.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:15:43 -0700 (PDT)
From: Philippe Gerum <rpm@xenomai.org>
To: "Nechita, Ionut" <ionut.nechita@intel.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: FAIL Kernel v6.10-evl-rebase - EVL: In function
 'do_sysvec_inband': error: duplicate case value
In-Reply-To: <PH0PR11MB5949D5E4DC2C8DF215617B6CF4B42@PH0PR11MB5949.namprd11.prod.outlook.com>
	(Ionut Nechita's message of "Fri, 26 Jul 2024 10:40:12 +0000")
References: <PH0PR11MB59493E21636F9CA955E2DE8BF4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
	<87wmnmq8v9.fsf@xenomai.org>
	<PH0PR11MB59491C18ADB51F5FEAEF4B3FF4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
	<PH0PR11MB59490B50D2D2717B8155EFCDF4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
	<87h6eprhbg.fsf@xenomai.org>
	<PH0PR11MB5949B24CB222FBB2D387BF24F4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
	<87cypdr5fm.fsf@xenomai.org>
	<PH0PR11MB5949453FBEBCA4520CAF80A2F4B42@PH0PR11MB5949.namprd11.prod.outlook.com>
	<PH0PR11MB5949D5E4DC2C8DF215617B6CF4B42@PH0PR11MB5949.namprd11.prod.outlook.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Fri, 26 Jul 2024 21:15:38 +0200
Message-ID: <87cyn03qxx.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

"Nechita, Ionut" <ionut.nechita@intel.com> writes:

> Hi Xenomai Kernel Team,
>
> I notice today one issue when compiling latest version, v6.10-evl-rebase.
>
>>>> error: duplicate case value
>   160 |         case HYPERVISOR_CALLBACK_VECTOR:
>
> # make -j208 bindeb-pkg  LOCALVERSION="-1-lowlatency-evl" ARCH=x86_64
>   GEN     debian
> Using default distribution of 'unstable' in the changelog
> Install lsb-release or set $KDEB_CHANGELOG_DIST explicitly
> dpkg-buildpackage --build=binary --no-pre-clean --unsigned-changes -R'make -f debian/rules' -j1 -a$(cat debian/arch)
> dpkg-buildpackage: info: source package linux-upstream
> dpkg-buildpackage: info: source version 6.10.0-g9ba4271318cf-4
> dpkg-buildpackage: info: source distribution unstable
> dpkg-buildpackage: info: source changed by root <root@0296de802d65>
> dpkg-buildpackage: info: host architecture amd64
>  dpkg-source --before-build .
>  make -f debian/rules binary
> #
> # No change to .config
> #
> mkdir -p /srv/tmpfs-disk1/build/linux-evl/tools/objtool && make O=/srv/tmpfs-disk1/build/linux-evl subdir=tools/objtool --no-print-directory -C objtool
>   INSTALL libsubcmd_headers
>   CALL    scripts/checksyscalls.sh
>   UPD     init/utsversion-tmp.h
>   CC      init/version.o
>   AR      init/built-in.a
>   CHK     kernel/kheaders_data.tar.xz
>   CC      arch/x86/kernel/irq_pipeline.o
> arch/x86/kernel/irq_pipeline.c: In function 'do_sysvec_inband':
> arch/x86/kernel/irq_pipeline.c:160:9: error: duplicate case value
>   160 |         case HYPERVISOR_CALLBACK_VECTOR:
>       |         ^~~~
> arch/x86/kernel/irq_pipeline.c:154:9: note: previously used here
>   154 |         case HYPERVISOR_CALLBACK_VECTOR:
>       |         ^~~~
> make[7]: *** [scripts/Makefile.build:244: arch/x86/kernel/irq_pipeline.o] Error 1
> make[7]: *** Waiting for unfinished jobs....
> make[6]: *** [scripts/Makefile.build:485: arch/x86/kernel] Error 2
> make[5]: *** [scripts/Makefile.build:485: arch/x86] Error 2
> make[5]: *** Waiting for unfinished jobs....
> make[4]: *** [Makefile:1934: .] Error 2
> make[3]: *** [debian/rules:74: build-arch] Error 2
> dpkg-buildpackage: error: make -f debian/rules binary subprocess returned exit status 2
> make[2]: *** [scripts/Makefile.package:121: bindeb-pkg] Error 2
> make[1]: *** [/srv/tmpfs-disk1/build/linux-evl/Makefile:1555: bindeb-pkg] Error 2
> make: *** [Makefile:240: __sub-make] Error 2
>
>
> BR,
> Ionut Nechita

Mm, do_sysvec_inband() is wrong when it comes to dealing with
HYPERVISOR_CALLBACK_VECTOR. We need a global pointer to the
hypervisor-specific handler, that would be set up by the guest init code
which traps the vector. We cannot ask do_sysvec_inband() to figure out
this information, it depends on which hypervisor trapped that vector in
the first place.

-- 
Philippe.
