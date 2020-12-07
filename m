Date: Mon, 7 Dec 2020 16:16:51 +0800
From: Fino Meng <fino.meng@linux.intel.com>
Subject: Re: [xenomai patch with kernel 5.4.77] Error building the kernel
Message-ID: <20201207081650.GA11889@linux.intel.com>
References: <CADx0-8DU+evLr-SduY9ru9zKBuhqjYOHPZ=5U4wFnMZAhE5irA@mail.gmail.com>
 <7786a8bf14ab25145e468bba2b567da76e9fd048.camel@siemens.com>
 <CADx0-8C7CW4i+O7g4zAGE0uXtD+bnNr4oR8HF-_tNArpteSDmQ@mail.gmail.com>
 <3afd98886487b064501e173f4e8d811f3f1a61f1.camel@siemens.com>
 <abe234e7-b15d-d257-69bc-c9e1ccd6898a@siemens.com>
 <CADx0-8C=wk6yWgUt63AxSQ1zeFH6syGHV4MNPcstVxDFT6onkQ@mail.gmail.com>
 <6173aab3-3b0f-862b-9e5e-48989f5196b3@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6173aab3-3b0f-862b-9e5e-48989f5196b3@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka via Xenomai <xenomai@xenomai.org>
Cc: xenomai@xenomai.org

On Mon, Dec 07, 2020 at 07:52:45AM +0100, Jan Kiszka via Xenomai wrote:
> On 04.12.20 16:13, Mohamed Irfanulla Mohamed Abdulla wrote:
> > Hi,
> > 
> > Thank you for your reply. I encountered another error.
> > 
> > Kernel: arch/x86/boot/bzImage is ready  (#1)
> > ERROR: "__ipipe_dispatch_irq" [drivers/pinctrl/intel/pinctrl-intel.ko]
> > undefined!
> > make[1]: *** [scripts/Makefile.modpost:94: __modpost] Error 1
> > make: *** [Makefile:1319: modules] Error 2
> > 
> > Is it good to exclude CONFIG_PINCTRL?
> 
> Only if you do not need that. But there might be cases where this cannot
> be off.
> 
> Fino, could you have a look?
> 
> Jan
> 

the error is compiler&&linker cannot find __ipipe_dispatch_irq when
building pinctrl-intel.ko,
change pinctrl-intel.ko to built-in but not module should solve the
issue.

a dirty fix is export this function:
+EXPORT_SYMBOL_GPL(__ipipe_dispatch_irq);

I will try if can give a clean fix of this issue.

BR fino

> > 
> > Thanks,
> > 
> > On Mon, Nov 30, 2020 at 2:27 PM Jan Kiszka <jan.kiszka@siemens.com
> > <mailto:jan.kiszka@siemens.com>> wrote:
> > 
> >     On 30.11.20 13:41, florian.bezdeka--- via Xenomai wrote:
> >     > On Mon, 2020-11-30 at 12:16 +0100, Mohamed Irfanulla Mohamed Abdulla
> >     > wrote:
> >     >> Thank you for your reply. 
> >     >> I find that I use the wrong branch. Could you please suggest a good
> >     >> branch that I can use?
> >     >>
> >     >
> >     > I'm quite new to the Xenomai project, so don't trust me ;-)
> >     >
> >     > The problem you are facing was "fixed" in commit
> >     > 608c23297c4d ("cobalt/x86: Account for FPU changes in kernel 5.2")
> >     > which is part of the "next" branch.
> >     >
> >     > It looks like kernels >= 5.2 are not supported in official releases /
> >     > branches yet.
> > 
> >     Correct. Next 3.1.x release will include that. Until then you need a
> >     version from git.
> > 
> >     Jan
> > 
> >     -- 
> >     Siemens AG, T RDA IOT
> >     Corporate Competence Center Embedded Linux
> > 
> 
> 
> -- 
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux
> 

