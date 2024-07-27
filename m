Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1364517164C
	for <xenomai@lists.linux.dev>; Sat, 27 Jul 2024 14:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722089483; cv=none; b=aWrfG3qhMFe18pTjtwimfB0nxSmjBVGZSb+wZBdHob6XZROtRo2vQCXaMG2ms0QW00aJ5KBJfcc2dZihb9dbgE+46q6CYM3HfPWUmK2PXKRwG5USt4QTjXUC1vkwwZLuKDchMAZnrZl8dpjDyPEZyI0ohy0vjpYoeMPyXImL9MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722089483; c=relaxed/simple;
	bh=6r0ilhDpOuDKA1vJQXuTHq88v+U8NjHqL+52C1Z3psE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PM5Qzm7X7QhB83rOTq9W+Fjw6t+AQTsC55bYqpTv7qwnT3TBfhqjNZjBaOmfODxAC/PNRWiJQYUrtd+N+rYnTDugMYZGYuSkSiFfjTNyPYa8yP14JM/akdJJRZWqoMB1NHJC3Akq6zKrdQ6V0+6FKy8M5NfPuf7Sf+1zRl4rIqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=VleyVWhZ; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="VleyVWhZ"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240727083038d78f0f90aa49866650
        for <xenomai@lists.linux.dev>;
        Sat, 27 Jul 2024 10:30:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=I/K5gT+2jxVnbM+LAj5GoNY3Sc/AJdl5+skSpoa6g94=;
 b=VleyVWhZ3+Mcc5FpaGBCFgyMbWc8KnnPgGqW4Pa7eMNIHlnlA7pnR3zhBSRmvkU2CYTqn8
 sCK1ikOeLAcRvODnXzN5H1u5KvmJJ28nhqoSKEDLlOQZ6pBUPSz6qL07sPc0XXWc9lOS12P7
 rLjqz5Wq9fmudlH/z4+hIqWM4FzGvZxzaQB5QR3oLwmvO0Cf6wkRo6zRMAQO+FXeKuLRGF5R
 KdMMbmPeGMm1peSzh2i0V96mB98niPMmcuhYGrqt1oZ0ls/0xp3fdas31h3oyb70W1bJBreA
 MJFlwPlxht/C7vAO7VwlQLmv6iU9eDu4A/zlAHSmFcuAtiMNl3Yg/ZUw==;
Message-ID: <7edb3e30ad2fa511a189cf6262c5c7fa997d074f.camel@siemens.com>
Subject: Re: FAIL Kernel v6.10-evl-rebase - EVL: In function
 'do_sysvec_inband': error: duplicate case value
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>, "Nechita, Ionut"
 <ionut.nechita@intel.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Date: Sat, 27 Jul 2024 10:30:36 +0200
In-Reply-To: <87cyn03qxx.fsf@xenomai.org>
References: 
	<PH0PR11MB59493E21636F9CA955E2DE8BF4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
	 <87wmnmq8v9.fsf@xenomai.org>
	 <PH0PR11MB59491C18ADB51F5FEAEF4B3FF4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
	 <PH0PR11MB59490B50D2D2717B8155EFCDF4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
	 <87h6eprhbg.fsf@xenomai.org>
	 <PH0PR11MB5949B24CB222FBB2D387BF24F4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
	 <87cypdr5fm.fsf@xenomai.org>
	 <PH0PR11MB5949453FBEBCA4520CAF80A2F4B42@PH0PR11MB5949.namprd11.prod.outlook.com>
	 <PH0PR11MB5949D5E4DC2C8DF215617B6CF4B42@PH0PR11MB5949.namprd11.prod.outlook.com>
	 <87cyn03qxx.fsf@xenomai.org>
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

On Fri, 2024-07-26 at 21:15 +0200, Philippe Gerum wrote:
> "Nechita, Ionut" <ionut.nechita@intel.com> writes:
>=20
> > Hi Xenomai Kernel Team,
> >=20
> > I notice today one issue when compiling latest version, v6.10-evl-rebas=
e.
> >=20
> > > > > error: duplicate case value
> >   160 |         case HYPERVISOR_CALLBACK_VECTOR:
> >=20
> > # make -j208 bindeb-pkg  LOCALVERSION=3D"-1-lowlatency-evl" ARCH=3Dx86_=
64
> >   GEN     debian
> > Using default distribution of 'unstable' in the changelog
> > Install lsb-release or set $KDEB_CHANGELOG_DIST explicitly
> > dpkg-buildpackage --build=3Dbinary --no-pre-clean --unsigned-changes -R=
'make -f debian/rules' -j1 -a$(cat debian/arch)
> > dpkg-buildpackage: info: source package linux-upstream
> > dpkg-buildpackage: info: source version 6.10.0-g9ba4271318cf-4
> > dpkg-buildpackage: info: source distribution unstable
> > dpkg-buildpackage: info: source changed by root <root@0296de802d65>
> > dpkg-buildpackage: info: host architecture amd64
> >  dpkg-source --before-build .
> >  make -f debian/rules binary
> > #
> > # No change to .config
> > #
> > mkdir -p /srv/tmpfs-disk1/build/linux-evl/tools/objtool && make O=3D/sr=
v/tmpfs-disk1/build/linux-evl subdir=3Dtools/objtool --no-print-directory -=
C objtool
> >   INSTALL libsubcmd_headers
> >   CALL    scripts/checksyscalls.sh
> >   UPD     init/utsversion-tmp.h
> >   CC      init/version.o
> >   AR      init/built-in.a
> >   CHK     kernel/kheaders_data.tar.xz
> >   CC      arch/x86/kernel/irq_pipeline.o
> > arch/x86/kernel/irq_pipeline.c: In function 'do_sysvec_inband':
> > arch/x86/kernel/irq_pipeline.c:160:9: error: duplicate case value
> >   160 |         case HYPERVISOR_CALLBACK_VECTOR:
> >       |         ^~~~
> > arch/x86/kernel/irq_pipeline.c:154:9: note: previously used here
> >   154 |         case HYPERVISOR_CALLBACK_VECTOR:
> >       |         ^~~~
> > make[7]: *** [scripts/Makefile.build:244: arch/x86/kernel/irq_pipeline.=
o] Error 1
> > make[7]: *** Waiting for unfinished jobs....
> > make[6]: *** [scripts/Makefile.build:485: arch/x86/kernel] Error 2
> > make[5]: *** [scripts/Makefile.build:485: arch/x86] Error 2
> > make[5]: *** Waiting for unfinished jobs....
> > make[4]: *** [Makefile:1934: .] Error 2
> > make[3]: *** [debian/rules:74: build-arch] Error 2
> > dpkg-buildpackage: error: make -f debian/rules binary subprocess return=
ed exit status 2
> > make[2]: *** [scripts/Makefile.package:121: bindeb-pkg] Error 2
> > make[1]: *** [/srv/tmpfs-disk1/build/linux-evl/Makefile:1555: bindeb-pk=
g] Error 2
> > make: *** [Makefile:240: __sub-make] Error 2
> >=20
> >=20
> > BR,
> > Ionut Nechita
>=20
> Mm, do_sysvec_inband() is wrong when it comes to dealing with
> HYPERVISOR_CALLBACK_VECTOR. We need a global pointer to the
> hypervisor-specific handler, that would be set up by the guest init code
> which traps the vector. We cannot ask do_sysvec_inband() to figure out
> this information, it depends on which hypervisor trapped that vector in
> the first place.

Exactly. It was me duplicating the "wrong" ACRN implementation while
introducing the async page fault handling for KVM.

I think there is no way to look at the IDT and check which gate was
loaded by the hypervisor guest code.

I haven't checked yet if that would work, but at least the KVM
implementation enables a static branch (kvm_async_pf_enabled) when
loading the IDT gate. Maybe we can check if this one is active. If so,
it's KVM we are running on.

There seems no such static branch for the ACRN code...
>=20

