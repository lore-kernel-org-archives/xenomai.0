Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E12E57333
	for <xenomai@lists.linux.dev>; Sun, 28 Jul 2024 16:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722185606; cv=none; b=sX6nsVB9mjLseZI1jc4fTiuXPT0gDVCEHB15C9AUtnyrFPM3ZUSusCIrj/yB/SzUAXO2MNRwtkLL1eEA4bpXwIo12U7jQ2OyiqCdJNk6bLertuWeHup4UdTdsFwtVCIJrU15f8U1umDRMgY8eZIuprGWQ9NZEgvnZaeC25rlI/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722185606; c=relaxed/simple;
	bh=x7M+hanijsYI0f/CxAeVFP6SwyVhctyfK9iMGHlnOow=;
	h=From:To:Cc:Subject:References:Date:Message-ID:MIME-Version:
	 Content-Type; b=YWpD6d25rZJyvvu6fw8rhL/n1bYi+KRt/q5TAhr/6MxNOtzlWQRPO6xFTnsDeEXducmrR6Mx2SCAyzBoufxTmNXOIqGi1pAsvLF/tT1JlDQA+C/eRiumLszgyxodeuhtKF01+OSO0tvB0a7/6qoYWS+I4AtcUHyVi3MByGo3u+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42812945633so10543115e9.0
        for <xenomai@lists.linux.dev>; Sun, 28 Jul 2024 09:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722185602; x=1722790402;
        h=mime-version:message-id:date:user-agent:references:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MU6/c99tX3kWrsuNd5v6bGRIE+GxVyrMC20VR8mGItc=;
        b=rw5WX3nz1R1kzhd95irYWNUYBrvlXbL4KCmL5gPofSsN2rwjOWLKcO336LOK2B9RDX
         yRHdG/7Qqaa3Xkfm+1QVmcdfmhlv0lDqmzfGGRksP+A+qnVsQrsaVIE+Qb6A9z9rjQ/n
         wgRZyZdvCUnMcA/SnVVAL60eGHiEZe0kf0XDrbKdJm25ZXrO8vwVZ59/pQiOqjd/H4kM
         NYY4R1xaQ2eJqw3TD6vMMUXdZIEuQG98xp0o9SaYvtW1tbk3pbDXzxLjqIzUY4/5b923
         bQqLYe8NeKwYc7zg8+hQzk8XPINz2EW+WqoGx92O05ihqs3MYEgI280HBGFL1M05Db3q
         Z7Rg==
X-Forwarded-Encrypted: i=1; AJvYcCWJ7x3+46RrrcQY3Trh1+D7UIuBMs/8JnitdRDjXnVoqYSt3ZzTxxJPbkgPe+RCkmKZw4lcEesPcUw4qEKA2H1FcYnoLR944Q==
X-Gm-Message-State: AOJu0YxlP8/7qkzZOO96mW7+Q9jIGzxi5dXK0n/sLwXJBQ6XajLdo3ZK
	wjARdqtImIXrag70sUSwzLsVRpAi8yTvep8h7q4BrRqjr7rZoxOGRI6b0g==
X-Google-Smtp-Source: AGHT+IEUcfTyZSoQy0irgg1o6aJvtCprG0uqU7HFRoF0kFs6vwkFAXBwk9juknEKGac9cajshLllhQ==
X-Received: by 2002:a05:600c:4f07:b0:428:14b6:ce32 with SMTP id 5b1f17b1804b1-42814b6cf86mr36099755e9.9.1722185602221;
        Sun, 28 Jul 2024 09:53:22 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280ca10aa6sm99023215e9.26.2024.07.28.09.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 09:53:21 -0700 (PDT)
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: "Nechita, Ionut" <ionut.nechita@intel.com>,  "xenomai@lists.linux.dev"
 <xenomai@lists.linux.dev>
Subject: Re: FAIL Kernel v6.10-evl-rebase - EVL: In function
 'do_sysvec_inband': error: duplicate case value
References: <PH0PR11MB59493E21636F9CA955E2DE8BF4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
	<87wmnmq8v9.fsf@xenomai.org>
	<PH0PR11MB59491C18ADB51F5FEAEF4B3FF4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
	<PH0PR11MB59490B50D2D2717B8155EFCDF4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
	<87h6eprhbg.fsf@xenomai.org>
	<PH0PR11MB5949B24CB222FBB2D387BF24F4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
	<87cypdr5fm.fsf@xenomai.org>
	<PH0PR11MB5949453FBEBCA4520CAF80A2F4B42@PH0PR11MB5949.namprd11.prod.outlook.com>
	<PH0PR11MB5949D5E4DC2C8DF215617B6CF4B42@PH0PR11MB5949.namprd11.prod.outlook.com>
	<87cyn03qxx.fsf@xenomai.org>
	<7edb3e30ad2fa511a189cf6262c5c7fa997d074f.camel@siemens.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Sun, 28 Jul 2024 18:53:21 +0200
Message-ID: <8734nt31by.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Fri, 2024-07-26 at 21:15 +0200, Philippe Gerum wrote:
>> "Nechita, Ionut" <ionut.nechita@intel.com> writes:
>> 
>> > Hi Xenomai Kernel Team,
>> > 
>> > I notice today one issue when compiling latest version, v6.10-evl-rebase.
>> > 
>> > > > > error: duplicate case value
>> >   160 |         case HYPERVISOR_CALLBACK_VECTOR:
>> > 
>> > # make -j208 bindeb-pkg  LOCALVERSION="-1-lowlatency-evl" ARCH=x86_64
>> >   GEN     debian
>> > Using default distribution of 'unstable' in the changelog
>> > Install lsb-release or set $KDEB_CHANGELOG_DIST explicitly
>> > dpkg-buildpackage --build=binary --no-pre-clean --unsigned-changes -R'make -f debian/rules' -j1 -a$(cat debian/arch)
>> > dpkg-buildpackage: info: source package linux-upstream
>> > dpkg-buildpackage: info: source version 6.10.0-g9ba4271318cf-4
>> > dpkg-buildpackage: info: source distribution unstable
>> > dpkg-buildpackage: info: source changed by root <root@0296de802d65>
>> > dpkg-buildpackage: info: host architecture amd64
>> >  dpkg-source --before-build .
>> >  make -f debian/rules binary
>> > #
>> > # No change to .config
>> > #
>> > mkdir -p /srv/tmpfs-disk1/build/linux-evl/tools/objtool && make O=/srv/tmpfs-disk1/build/linux-evl subdir=tools/objtool --no-print-directory -C objtool
>> >   INSTALL libsubcmd_headers
>> >   CALL    scripts/checksyscalls.sh
>> >   UPD     init/utsversion-tmp.h
>> >   CC      init/version.o
>> >   AR      init/built-in.a
>> >   CHK     kernel/kheaders_data.tar.xz
>> >   CC      arch/x86/kernel/irq_pipeline.o
>> > arch/x86/kernel/irq_pipeline.c: In function 'do_sysvec_inband':
>> > arch/x86/kernel/irq_pipeline.c:160:9: error: duplicate case value
>> >   160 |         case HYPERVISOR_CALLBACK_VECTOR:
>> >       |         ^~~~
>> > arch/x86/kernel/irq_pipeline.c:154:9: note: previously used here
>> >   154 |         case HYPERVISOR_CALLBACK_VECTOR:
>> >       |         ^~~~
>> > make[7]: *** [scripts/Makefile.build:244: arch/x86/kernel/irq_pipeline.o] Error 1
>> > make[7]: *** Waiting for unfinished jobs....
>> > make[6]: *** [scripts/Makefile.build:485: arch/x86/kernel] Error 2
>> > make[5]: *** [scripts/Makefile.build:485: arch/x86] Error 2
>> > make[5]: *** Waiting for unfinished jobs....
>> > make[4]: *** [Makefile:1934: .] Error 2
>> > make[3]: *** [debian/rules:74: build-arch] Error 2
>> > dpkg-buildpackage: error: make -f debian/rules binary subprocess returned exit status 2
>> > make[2]: *** [scripts/Makefile.package:121: bindeb-pkg] Error 2
>> > make[1]: *** [/srv/tmpfs-disk1/build/linux-evl/Makefile:1555: bindeb-pkg] Error 2
>> > make: *** [Makefile:240: __sub-make] Error 2
>> > 
>> > 
>> > BR,
>> > Ionut Nechita
>> 
>> Mm, do_sysvec_inband() is wrong when it comes to dealing with
>> HYPERVISOR_CALLBACK_VECTOR. We need a global pointer to the
>> hypervisor-specific handler, that would be set up by the guest init code
>> which traps the vector. We cannot ask do_sysvec_inband() to figure out
>> this information, it depends on which hypervisor trapped that vector in
>> the first place.
>
> Exactly. It was me duplicating the "wrong" ACRN implementation while
> introducing the async page fault handling for KVM.
>

Strictly speaking, the bug was there prior to that addition, the async
pf patch only revealed it (I'm hereby claiming authorship of that bug! :)

> I think there is no way to look at the IDT and check which gate was
> loaded by the hypervisor guest code.
>
> I haven't checked yet if that would work, but at least the KVM
> implementation enables a static branch (kvm_async_pf_enabled) when
> loading the IDT gate. Maybe we can check if this one is active. If so,
> it's KVM we are running on.

kvm_async_pf_enabled seems to be controlled by a paravirt capability
flag. Would we receive significant information from
kvm_arch_para_features() <- cpuid_eax() in case KVM is not there?

>
> There seems no such static branch for the ACRN code...
>>

IIUC, we cannot have more than a single guest allowed to hook that
vector anyway, so could we just track who's doing that in the places
where this vector is trapped, e.g. by setting up some global function
pointer referring to the proper handler which do_sysvec_inband() would
call upon HYPERVISOR_CALLBACK_VECTOR event?

-- 
Philippe.
