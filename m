Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0207156C63
	for <xenomai@lists.linux.dev>; Fri,  2 May 2025 14:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746197789; cv=none; b=WTXW6nXNCj8064NmxdgTBgbMav64HXRKPFMn+NG++CPVIvz3d7lCbcObC9Nhe0BvVQf8nzMEL1v0JADjNMiBpDkRC9u25TK4cQqR0X361kMI0y9Bppz44ZcJpPdqWLphLTeF7IdA5YVE21D7K29fUAR0z5ULiZMJQ/KW7E8Urd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746197789; c=relaxed/simple;
	bh=Yx9dPignCMBnnytH01IKTVmos5tALTPXJaFoNwT51jY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g9pQIM3fNNlSmjuZ3JjtJyjwc0ndSw9LB42Hqs9KVUeUJiZ5sAF0f2eoPK6YFICv0dfq33OErT5oY+pAvtfsafcWOr70GH6Tf5vIN0dJZQ54O362njsvPCX5u14JoasGXevqF8m0fDYzsD3gBfAD1RsEkN6i7M/6GfFKAqHKfGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=LZn3hwqN; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="LZn3hwqN"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20250502144614b81f67e95bfb6e747b
        for <xenomai@lists.linux.dev>;
        Fri, 02 May 2025 16:46:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=hdkpnLUyvfDh2IcmHpqPDiQNCrj7+6C353zoyP1onK0=;
 b=LZn3hwqNoBbqeayaGCs5QVlm2Ui3ng9R7lPTZ/lDuF+Glzc19E3Ai+Ce+tZh7XSyeflkxq
 is3Fuy9Wb96KGBV/suwYCyi9hzVPf1ha4RNRsh8BndzgJpUoEdhtVyU65TK14+GhK2zW1cvz
 r9K+4gaVvt0ug49uCIeQNLX9kH6RwQRvAZC3zzqfSwrV5mtkPnaIayEvZol/09GaMcJdcxL+
 eAtjBF8+fS6D3QVQWvxrsh8R5byoj6mSi8pHe3zObOYzLhvjBRAEtfS1npkPGT1gVhMZGOcI
 aHqECv4bq4mZVrsIDUcFrHBAcH1IrXinNgVQgPXIEtfXBB8QfP6gn3Ag==;
Message-ID: <3e2befa5334ed02df3f27a2948ebd1b6816bb890.camel@siemens.com>
Subject: Re: Build error of kernel/xenomai/debug.c
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: "Qiao, Wei" <wei.qiao@intel.com>, "Kiszka, Jan"
 <jan.kiszka@siemens.com>,  "xenomai@lists.linux.dev"	
 <xenomai@lists.linux.dev>
Cc: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "Pirou, Florent"
	 <florent.pirou@intel.com>
Date: Fri, 02 May 2025 16:46:13 +0200
In-Reply-To: <e563d0af246befb712d4f73eae5a2082a227be62.camel@siemens.com>
References: 
	<IA1PR11MB6513EB0131E06C8CC865E8EF8CBC2@IA1PR11MB6513.namprd11.prod.outlook.com>
				 <72c2c5cb18b635f1145c35b6592c661cf55aeb0f.camel@siemens.com>
				 <370f022e-d5e3-46f1-a19f-5448afeebb61@siemens.com>
				 <IA1PR11MB6513A045F8ECB1186B65DA9A8CBF2@IA1PR11MB6513.namprd11.prod.outlook.com>
				 <4342e7e1-a7d4-431c-8fcc-f7731d3938d9@siemens.com>
				 <IA1PR11MB6513FC978522428982B0A30A8CB82@IA1PR11MB6513.namprd11.prod.outlook.com>
				 <4abe85c4-1457-4137-9e54-ea1a8aa534d4@siemens.com>
				 <IA1PR11MB651388E02D8925FB8EA908CE8CBB2@IA1PR11MB6513.namprd11.prod.outlook.com>
			 <298a2bdeb3a4a15ccfbac1e7a37c68c8833a2fa3.camel@siemens.com>
			 <IA1PR11MB6513BD2200559301D475BFF38C832@IA1PR11MB6513.namprd11.prod.outlook.com>
		 <94f042f26c53e61be69d2a373487ca947c87f464.camel@siemens.com>
		 <IA1PR11MB651316E6F7BEB7A74C0F4B788C8D2@IA1PR11MB6513.namprd11.prod.outlook.com>
	 <e563d0af246befb712d4f73eae5a2082a227be62.camel@siemens.com>
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

On Fri, 2025-05-02 at 16:32 +0200, Florian Bezdeka wrote:
> Hi Wei,
>=20
> could you please use a mail client with proper quotation style? It's
> quite hard to distinguish between my and your part of the conversation.
>=20
> On Fri, 2025-05-02 at 14:13 +0000, Qiao, Wei wrote:
> >=20
> > -----Original Message-----
> > From: Florian Bezdeka <florian.bezdeka@siemens.com>=20
> > Sent: Friday, May 2, 2025 4:50 PM
> > To: Qiao, Wei <wei.qiao@intel.com>; Kiszka, Jan <jan.kiszka@siemens.com=
>; xenomai@lists.linux.dev
> > Cc: Chen, Hongzhan <hongzhan.chen@intel.com>; Pirou, Florent <florent.p=
irou@intel.com>
> > Subject: Re: Build error of kernel/xenomai/debug.c
> >=20
> > Hi all,
> >=20
> > On Wed, 2025-04-30 at 23:46 +0000, Qiao, Wei wrote:
> > > 1. install ubuntu:=20
> > > https://releases.ubuntu.com/noble/ubuntu-24.04.2-desktop-amd64.iso
> > > 2. git clone https://source.denx.de/Xenomai/linux-dovetail.git xenoma=
i
> >=20
> > You're cloning dovetail into a folder called xenomai. Confusing...
> > A: Folder name is not important; I can use any name, it's not related t=
o the build error.
>=20
> Sure, it's not related to the build error, but when you write later
> something like "cd xenomai" everyone is expecting to enter the xenomai
> source directory.
>=20
> >=20
> > > 3. cd xenomai
> > > 4. checkout to v6.12.19-dovetail1-rebase.
> > > 5. git revert 7add30c335bc6 "arm64: vDSO: export user-visible MMIO cl=
ocksources"     # to fix build error.
> >=20
> > Which build failure exactly? That should be clearly addressed as well.
> > But: You're building for x86 below, why do you need to revert a patch t=
argeting the arm64 architecture? That doesn't make sense to me.
> > A: yes, the reverted patch is related to arm64,  this is because our CI=
 test must pass=20
> > 	make ARCH=3Darm64 allyesconfig
> >  v6.12.19-dovetail1-rebase have so much arm64 related patch, I merged a=
ll the branch . Anyway, if I only cherry-pick x86 related patches, the same=
 build error is seen too.
> >=20
>=20
> I can't really follow here. You are generating a kernel (build)
> configuration for arm64 here, but later you try to build for x86. That
> will simply not work. Build failures expected.
>=20
> In addition "allyesconfig" is for sure not on our radar. We try to
> build realtime kernels, so with very minimal and machine specific
> footprint (normally). So yes, there might be a combination that simply
> does not work / build. Up to now you did not provide any concrete build
> failure from that part. If you do so, we will investigate.
>=20
> The "I merged all the branch" also confuses me. I can only help with
> the upstream tree. If you now (partially) merge the dovetail
> implementation into into something I/we don't know: You are on your
> own.
>=20
> > >=20
> > > 6. git clone https://gitlab.com/Xenomai/xenomai-hacker-space.git=20
> > > hacker_space 7. checkout to v3.3 8. add below 2 patches to avoid buil=
d=20
> > > error.
> >=20
> > Again: Which build error are you trying to fix? In addition you get som=
ething labeled with Xenomai 3.3 but the content is actually different. Conf=
using.
> >=20
> > > 	9831a21b7 (HEAD -> 3.3) Account for moved unaligned.h in 6.12
> > A: you can do a simple test.
>=20
> What test should I do?
>=20
> >=20
> > Unknown commit hash. I think you mean b01dfd6dffb6 which is already par=
t of the stable/v3.3.x branch. So just move to the 3.3.1 release and you ar=
e fine.
> >=20
> > > 	a16643571 netstack: rtcfg: fix dynamic debug
> >=20
> > Unknown commit hash. Could not find a "replacement".
> > A: you can ignore this patch.
> >=20
> > > 	3e1576f8a (tag: v3.3) config: Bump version number
> >=20
> > > 9. ./scripts/prepare-kernel.sh --linux=3D~/work/xenomai --dovetail=3D=
=20
> > > --arch=3Dx86
> >=20
> > I think --dovetail parameter can be removed.=20
> > A: I tried to move this parameter, the build error is seen too.
> >                  from kernel/xenomai/debug.c:23:
> > In function =E2=80=98strcpy=E2=80=99,
> >     inlined from =E2=80=98hash_symbol=E2=80=99 at kernel/xenomai/debug.=
c:94:2:
> > ./include/linux/fortify-string.h:787:17: error: call to =E2=80=98__writ=
e_overflow=E2=80=99 declared with attribute error: detected write beyond si=
            ze of object (1st parameter)
> >   787 |                 __write_overflow();
> >       |                 ^~~~~~~~~~~~~~~~~~
> > make[7]: *** [scripts/Makefile.build:229: kernel/xenomai/debug.o] Error=
 1
>=20
> As you confirmed now that removing --dovetail has no impact you can
> remove it. It's not needed.=20
>=20
> Again, you are building for x86 now - the make command is still missing
> so I'm assuming that as you prepared for x86 above - on a kernel that
> was configured for arm64. That might have an impact on effective
> compiler settings. Might be the root cause...
>=20
> >=20
> > >=20
> > > 10. back to folder xenomai
> >=20
> > ... which means go back to the dovetail tree ...
> > A: Yes.
> >=20
> > > with default sourcelist.
> >=20
> > What do you mean with "default sourcelist"?=20
> > -> A: You can ignore this,  for the compiler/toolchain, I just installe=
d the ubuntu, and run=20
> > apt install make gcc flex bison.
> >=20
> > > apt install make
> > > apt install gcc
> > > and install other necessary tool such as flex/ bison.
> > >=20
> > > then, build with CONFIG_XENO_OPT_DEBUG=3Dy
> > >=20
> >=20
> > As reported in the last mail: I tried that with a Ubuntu container, so =
exactly the same compiler/toolchain and the build was successful.
> > A: did you open configure with CONFIG_XENO_OPT_DEBUG?
>=20
> Yes, that option is enabled. I double checked that with some
> #error magic in the affected file.

Just realized that there is another problem in your build process. I'm
even more confused now, because all Xenomai specific options should be
wiped out at your "make allyesconfig" step:

1) prepare dovetail sources for the target architecture by using the
prepare-kernel.sh script from Xenomai sources with --arch properly set

2) do the kernel configuration step (make allyesconfig in your case)

3) start the dovetail build

Seems that you flipped steps 1 and 2.

