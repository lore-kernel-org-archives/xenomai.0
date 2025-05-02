Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4235818E3F
	for <xenomai@lists.linux.dev>; Fri,  2 May 2025 14:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746196342; cv=none; b=oN/dEIq44XQMorwQCsFcPCqUVy4BV9rP4ifLCRclUj1C/aCI7uLnVnLWn0rvfgz98aX85UTrj9C82TPUIZeaJfIDD5fdyow+1TFV7eBzN9QJyd4Ihb6Z0qY/cMqmSQGd5c36wOJfIWv4qhWs/Rm2yqoFDKymWqglKavCF2im16k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746196342; c=relaxed/simple;
	bh=VglJTP8HbLXdUvkYsb0ilsEsrkC7RNQ4vBHV/Rg0BpE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SpEV1rAtKXUJ1AF5D9K/qXS9lIvMcZyMtfoosUmM6Bx8MXR3pWN+jq+V+0vkKHb0dbSYLEA6Tmljrnwgxn/3XxDtw6uKt4OAEWqgPFDrTnk6ucnu3wmGTflj2pN6+DQm8knBFNozptP3liCuiNt7MqznP7WvH4yz04STNtgRoNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=JJWlyy7j; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="JJWlyy7j"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20250502143208b68d03587749cb12fa
        for <xenomai@lists.linux.dev>;
        Fri, 02 May 2025 16:32:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=RJeEWwBgfmp1bLtiPOoXMkwKm3XLGKW8eWDoCoPJ2LQ=;
 b=JJWlyy7jbOE9KouE6eXcZwsQY77ihcNyLbBxkYN1rsoY+lPXi6h3mo1nx+ZQ4gjisg1sxL
 RLj5tZ11JxF4JQEWdAuUAR8pBsdElnPXO2IR8ZG4LFnbSQHg53y0zMWpJKwbdK63FKSOLUMH
 rb/jYih0Z3FjbyOqAqLnM45LOmdiIpbsdvQsBUpEq23uildZiPZl3Wjs2ZcTE1kkEkRbLogm
 xYoWdg00l+eLfy5Nf+WKWyKmp4Y3naoMcK4cu7mmsAxDOHMJBuzUDOKsz+QI4amdLUga7EpQ
 nWh5c7NAWoLr/nzMdRUX6RYD749vtpe9nqQdQGxxgd+76/umSHnU4tnw==;
Message-ID: <e563d0af246befb712d4f73eae5a2082a227be62.camel@siemens.com>
Subject: Re: Build error of kernel/xenomai/debug.c
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: "Qiao, Wei" <wei.qiao@intel.com>, "Kiszka, Jan"
 <jan.kiszka@siemens.com>,  "xenomai@lists.linux.dev"	
 <xenomai@lists.linux.dev>
Cc: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "Pirou, Florent"
	 <florent.pirou@intel.com>
Date: Fri, 02 May 2025 16:32:07 +0200
In-Reply-To: <IA1PR11MB651316E6F7BEB7A74C0F4B788C8D2@IA1PR11MB6513.namprd11.prod.outlook.com>
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

Hi Wei,

could you please use a mail client with proper quotation style? It's
quite hard to distinguish between my and your part of the conversation.

On Fri, 2025-05-02 at 14:13 +0000, Qiao, Wei wrote:
>=20
> -----Original Message-----
> From: Florian Bezdeka <florian.bezdeka@siemens.com>=20
> Sent: Friday, May 2, 2025 4:50 PM
> To: Qiao, Wei <wei.qiao@intel.com>; Kiszka, Jan <jan.kiszka@siemens.com>;=
 xenomai@lists.linux.dev
> Cc: Chen, Hongzhan <hongzhan.chen@intel.com>; Pirou, Florent <florent.pir=
ou@intel.com>
> Subject: Re: Build error of kernel/xenomai/debug.c
>=20
> Hi all,
>=20
> On Wed, 2025-04-30 at 23:46 +0000, Qiao, Wei wrote:
> > 1. install ubuntu:=20
> > https://releases.ubuntu.com/noble/ubuntu-24.04.2-desktop-amd64.iso
> > 2. git clone https://source.denx.de/Xenomai/linux-dovetail.git xenomai
>=20
> You're cloning dovetail into a folder called xenomai. Confusing...
> A: Folder name is not important; I can use any name, it's not related to =
the build error.

Sure, it's not related to the build error, but when you write later
something like "cd xenomai" everyone is expecting to enter the xenomai
source directory.

>=20
> > 3. cd xenomai
> > 4. checkout to v6.12.19-dovetail1-rebase.
> > 5. git revert 7add30c335bc6 "arm64: vDSO: export user-visible MMIO cloc=
ksources"     # to fix build error.
>=20
> Which build failure exactly? That should be clearly addressed as well.
> But: You're building for x86 below, why do you need to revert a patch tar=
geting the arm64 architecture? That doesn't make sense to me.
> A: yes, the reverted patch is related to arm64,  this is because our CI t=
est must pass=20
> 	make ARCH=3Darm64 allyesconfig
>  v6.12.19-dovetail1-rebase have so much arm64 related patch, I merged all=
 the branch . Anyway, if I only cherry-pick x86 related patches, the same b=
uild error is seen too.
>=20

I can't really follow here. You are generating a kernel (build)
configuration for arm64 here, but later you try to build for x86. That
will simply not work. Build failures expected.

In addition "allyesconfig" is for sure not on our radar. We try to
build realtime kernels, so with very minimal and machine specific
footprint (normally). So yes, there might be a combination that simply
does not work / build. Up to now you did not provide any concrete build
failure from that part. If you do so, we will investigate.

The "I merged all the branch" also confuses me. I can only help with
the upstream tree. If you now (partially) merge the dovetail
implementation into into something I/we don't know: You are on your
own.

> >=20
> > 6. git clone https://gitlab.com/Xenomai/xenomai-hacker-space.git=20
> > hacker_space 7. checkout to v3.3 8. add below 2 patches to avoid build=
=20
> > error.
>=20
> Again: Which build error are you trying to fix? In addition you get somet=
hing labeled with Xenomai 3.3 but the content is actually different. Confus=
ing.
>=20
> > 	9831a21b7 (HEAD -> 3.3) Account for moved unaligned.h in 6.12
> A: you can do a simple test.

What test should I do?

>=20
> Unknown commit hash. I think you mean b01dfd6dffb6 which is already part =
of the stable/v3.3.x branch. So just move to the 3.3.1 release and you are =
fine.
>=20
> > 	a16643571 netstack: rtcfg: fix dynamic debug
>=20
> Unknown commit hash. Could not find a "replacement".
> A: you can ignore this patch.
>=20
> > 	3e1576f8a (tag: v3.3) config: Bump version number
>=20
> > 9. ./scripts/prepare-kernel.sh --linux=3D~/work/xenomai --dovetail=3D=
=20
> > --arch=3Dx86
>=20
> I think --dovetail parameter can be removed.=20
> A: I tried to move this parameter, the build error is seen too.
>                  from kernel/xenomai/debug.c:23:
> In function =E2=80=98strcpy=E2=80=99,
>     inlined from =E2=80=98hash_symbol=E2=80=99 at kernel/xenomai/debug.c:=
94:2:
> ./include/linux/fortify-string.h:787:17: error: call to =E2=80=98__write_=
overflow=E2=80=99 declared with attribute error: detected write beyond si  =
          ze of object (1st parameter)
>   787 |                 __write_overflow();
>       |                 ^~~~~~~~~~~~~~~~~~
> make[7]: *** [scripts/Makefile.build:229: kernel/xenomai/debug.o] Error 1

As you confirmed now that removing --dovetail has no impact you can
remove it. It's not needed.=20

Again, you are building for x86 now - the make command is still missing
so I'm assuming that as you prepared for x86 above - on a kernel that
was configured for arm64. That might have an impact on effective
compiler settings. Might be the root cause...

>=20
> >=20
> > 10. back to folder xenomai
>=20
> ... which means go back to the dovetail tree ...
> A: Yes.
>=20
> > with default sourcelist.
>=20
> What do you mean with "default sourcelist"?=20
> -> A: You can ignore this,  for the compiler/toolchain, I just installed =
the ubuntu, and run=20
> apt install make gcc flex bison.
>=20
> > apt install make
> > apt install gcc
> > and install other necessary tool such as flex/ bison.
> >=20
> > then, build with CONFIG_XENO_OPT_DEBUG=3Dy
> >=20
>=20
> As reported in the last mail: I tried that with a Ubuntu container, so ex=
actly the same compiler/toolchain and the build was successful.
> A: did you open configure with CONFIG_XENO_OPT_DEBUG?

Yes, that option is enabled. I double checked that with some
#error magic in the affected file.

>=20
>=20
> Best regards,
> Florian
>=20
> > -----Original Message-----
> > From: Florian Bezdeka <florian.bezdeka@siemens.com>
> > Sent: Wednesday, April 30, 2025 5:57 PM
> > To: Qiao, Wei <wei.qiao@intel.com>; Kiszka, Jan=20
> > <jan.kiszka@siemens.com>; xenomai@lists.linux.dev
> > Cc: Chen, Hongzhan <hongzhan.chen@intel.com>; Pirou, Florent=20
> > <florent.pirou@intel.com>
> > Subject: Re: Build error of kernel/xenomai/debug.c
> >=20
> > On Tue, 2025-04-22 at 08:00 +0000, Qiao, Wei wrote:
> > > My ubuntu version is PRETTY_NAME=3D"Ubuntu 24.04.2 LTS"
> > > gcc (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0 the default gcc version.
> >=20
> > As that topic came up in the community call today again, I tried that e=
xact compiler version inside a ubuntu:24.04 podman environment. It's buildi=
ng fine.
> >=20
> > Please double check your environment. Maybe there is a CFLAGS variable =
(or a similar variable) with different compiler options involved?
> >=20
> > Best regards,
> > Florian
> >=20
> > >=20
> > > -----Original Message-----
> > > From: Florian Bezdeka <florian.bezdeka@siemens.com>
> > > Sent: Monday, April 21, 2025 5:45 PM
> > > To: Qiao, Wei <wei.qiao@intel.com>; Kiszka, Jan=20
> > > <jan.kiszka@siemens.com>; xenomai@lists.linux.dev
> > > Cc: Chen, Hongzhan <hongzhan.chen@intel.com>; Pirou, Florent=20
> > > <florent.pirou@intel.com>
> > > Subject: Re: Build error of kernel/xenomai/debug.c
> > >=20
> > > On 21.04.25 02:08, Qiao, Wei wrote:
> > > > Gcc verison:
> > > > qiaowei@wqiao2:~$ gcc --version
> > > > gcc (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0
> > > >=20
> > > > Kernel:=20
> > > > v6.12.19-dovetail1-rebase
> > > >=20
> > > > https://gitlab.com/Xenomai/xenomai-hacker-space.git
> > > > tag: v3.3
> > >=20
> > > I tried the following build configurations, all worked:
> > >=20
> > > - gcc (GCC) 15.0.1 20250329 (Red Hat 15.0.1-0)
> > > - gcc (GCC) 14.2.1 20250110 (Red Hat 14.2.1-7)
> > > - gcc (Debian 12.2.0-14) 12.2.0
> > > - gcc (Debian 10.4.0-7) 10.4.0
> > >=20
> > > The default gcc version of Ubuntu 24.04 - as provided by the gcc=20
> > > package
> > > - is 13.2.0-7ubuntu1. Seems you installed the gcc-13 package for some=
 reason.
> > >=20
> > > What happens if you switch back to the default compiler, does that wo=
rk?
> > >=20
> > > I can't tell why, but gcc 13.2 seems unable to derive the object size=
...
> > >=20
> > > As Jan mentioned the quick fix I posted is kind of an overkill.
> > >=20
> > > As I don't have an Ubuntu system at hand and all tries to reproduce o=
n Debian and Fedora failed so far and in addition a lot of different compil=
er versions are working fine: No further investigations will follow on my e=
nd.
> > >=20
> > > >=20
> > > > -----Original Message-----
> > > > From: Florian Bezdeka <florian.bezdeka@siemens.com>
> > > > Sent: Monday, April 21, 2025 5:47 AM
> > > > To: Qiao, Wei <wei.qiao@intel.com>; Kiszka, Jan=20
> > > > <jan.kiszka@siemens.com>; xenomai@lists.linux.dev
> > > > Cc: Chen, Hongzhan <hongzhan.chen@intel.com>; Pirou, Florent=20
> > > > <florent.pirou@intel.com>
> > > > Subject: Re: Build error of kernel/xenomai/debug.c
> > > >=20
> > > > On 18.04.25 07:51, Qiao, Wei wrote:
> > > > > Test pass.
> > > > > The system can boot up and work well.
> > > >=20
> > > > Which xenomai/compiler/kernel combination are you trying to build?
> > > >=20
> > > > I tried to reproduce with gcc 15 - the latest gcc release - but it =
is still building fine.
> > > >=20
> > > > You mentioned Ubuntu 24.04, which should ship gcc 10.5, which shoul=
d be fine as well.
> > > >=20
> > > > >=20
> > > > > -----Original Message-----
> > > > > From: Jan Kiszka <jan.kiszka@siemens.com>
> > > > > Sent: Thursday, April 17, 2025 4:59 PM
> > > > > To: Bezdeka, Florian <florian.bezdeka@siemens.com>; Qiao, Wei=20
> > > > > <wei.qiao@intel.com>; xenomai@lists.linux.dev
> > > > > Cc: Chen, Hongzhan <hongzhan.chen@intel.com>; Pirou, Florent=20
> > > > > <florent.pirou@intel.com>
> > > > > Subject: Re: Build error of kernel/xenomai/debug.c
> > > > >=20
> > > > > On 17.04.25 10:43, Florian Bezdeka wrote:
> > > > > > On Thu, 2025-04-17 at 08:15 +0000, Qiao, Wei wrote:
> > > > > > > Hi All,
> > > > > > >=20
> > > > > > > If we build the kernel in ubuntu 24.04, there is build error:
> > > > > > >=20
> > > > > > > from kernel/xenomai/debug.c:23:
> > > > > > > In function 'strcpy',
> > > > > > >     inlined from 'hash_symbol' at kernel/xenomai/debug.c:94:2=
:
> > > > > > > ./include/linux/fortify-string.h:787:17: error: call to '__wr=
ite_overflow' declared with attribute error: detected write beyond size of =
object (1st parameter)
> > > > > > >   787 |                 __write_overflow();
> > > > > > >       |                 ^~~~~~~~~~~~~~~~~~
> > > > > > >=20
> > > > > > > This is because new gcc version has stricter FORTIFY_SOURCE( =
=3D3 is =E2=80=8Cstricter=E2=80=8C than =3D2). Please help to fix, thanks.
> > > > > >=20
> > > > > > That is the flexible array story...
> > > > > >=20
> > > > > > You could try something like below (completely untested) and=
=20
> > > > > > report back if it works:
> > > > > >=20
> > > > > > diff --git a/kernel/cobalt/debug.c b/kernel/cobalt/debug.c=20
> > > > > > index
> > > > > > 25b194c26..d048dc757 100644
> > > > > > --- a/kernel/cobalt/debug.c
> > > > > > +++ b/kernel/cobalt/debug.c
> > > > > > @@ -47,7 +47,8 @@ EXPORT_SYMBOL_GPL(cobalt_debug_vfroot);
> > > > > > =20
> > > > > >  struct hashed_symbol {
> > > > > >  	struct hashed_symbol *next;
> > > > > > -	char symbol[];
> > > > > > +	size_t size;
> > > > > > +	char symbol[] __counted_by(size);
> > > > > >  };
> > > > > > =20
> > > > > >  static struct hashed_symbol *symbol_jhash[SYMBOL_HSLOTS]; @@
> > > > > > -91,6
> > > > > > +92,7 @@ static const char *hash_symbol(const char *symbol)
> > > > > >  		goto out;
> > > > > >  	}
> > > > > > =20
> > > > > > +	p->size =3D len + 1;
> > > > > >  	strcpy(p->symbol, symbol);
> > > > > >  	p->next =3D *h;
> > > > > >  	*h =3D p;
> > > > > >=20
> > > > >=20
> > > > > A bit of overkill, given that allocation and access of according =
size happens within the same function. No smarter way to tell the compiler =
to stay away here?
> > > > >=20
> > > > > Jan
> > > > >=20
> > > > > --
> > > > > Siemens AG, Foundational Technologies Linux Expert Center
> >=20
>=20

