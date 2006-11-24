Message-ID: <4566C5AF.7030107@domain.hid>
Date: Fri, 24 Nov 2006 11:13:03 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] Adeos support for 2.6.18 merged PowerPC
	architecture.
References: <20061124105346.e442448d.benjamin.zores@domain.hid>
In-Reply-To: <20061124105346.e442448d.benjamin.zores@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Benjamin Zores <benjamin.zores@domain.hid>
Cc: xenomai@xenomai.org

Benjamin Zores wrote:
> Hi,
> 
> I've downloaded latest Adeos/Ipipe patch for PPC and unfortunately this
> latest doesn't (yet) support the ARCH=powerpc architecture from kernel
> but only the PPC one.

Yes, the PowerPC tree is not yet supported.

> I've tried porting the changes to support the PPC_MERGE and be able to
> still use Xenomai on 2.6.18 with ARCH=powerpc.

Nice.

> Attached is a patch that has to be applied after regular adeos-2.6.18-ppc
> patch to extends supports for PowerPC.
> Please consider it for review only right now as it might not yet compiles to the
> end (i'm facing problems with includes inter-race which required me to change
> the radix-tree.h header file which is something i don't want to).

You might have realized my hack to get ride of radix-tree.h for the ppc 
tree.

> I also have problems booting my latest kernel with this patch on
> (but booting regular 2.6.18 in merged PowerPC architecture already is a hassle atm)
> and I'd like you to help me know whether it cames from my patch's content or not.

What defconfig do you use? Unfortunately I do not have a board by hand 
supported by the PowerPC tree.

> FYI, I've tried to port all Adeos architecture dependant parts but i only focused
> on PPC32 (PPC64 support might be in but i won't test on it). I'm also trying to boot an MPC8349 chip but i don't think I'll have to address anything with it as it used to work with Xenomai on 2.6.14.
> 
> Thanks for the review,

I will have a look a.s.s.p.

Wolfgang.


