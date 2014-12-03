MIME-Version: 1.0
In-Reply-To: <20141201161549.GA28038@hermes>
References: <20141128111325.GD5069@hermes>
 <CAPozGf=6OQBChvSAfypNH7KpAReg+u6PS3dhEJDtVZ-jrnW7bg@mail.gmail.com>
 <CAPozGfkxmv+7=Q3LXAmOv_eTPZ08XV3SO9SETPomSAs+bbxV0A@mail.gmail.com>
 <CAPozGfk9LizYFbCRKUDS1-mhX+bw3fOpgqzwF6AcH64Pspw4Gg@mail.gmail.com>
 <20141128182141.GB4817@hermes>
 <CAPozGfk-okS5TDn-zPua3uvHkcppm3CpnqAKXYs6-VWVPb4cpg@mail.gmail.com>
 <20141201143957.GH23220@hermes>
 <CAPozGf=ijSmQoUXRf7aG56G47N2DZbHyiL+1nHDEWvmZdhhcYw@mail.gmail.com>
 <20141201152921.GI23220@hermes>
 <CAPozGfndF2nWapRLR+U5MUbieCxS3_oA=62uKXFSMEG0Cue51w@mail.gmail.com>
 <20141201161549.GA28038@hermes>
Date: Wed, 3 Dec 2014 14:32:12 +0100
Message-ID: <CAPozGf=LUUqpgqyH_T6=x0JBW2fm0wFj=m_1Vosec0OawkA4Tw@mail.gmail.com>
From: John Sini <jhnsini@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Section mismatch - Porting Xenomai to
 linux-xlnx-V14.5 zynq SoC
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Mon, Dec 1, 2014 at 5:15 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On Mon, Dec 01, 2014 at 04:45:03PM +0100, John Sini wrote:
> > On Mon, Dec 1, 2014 at 4:29 PM, Gilles Chanteperdrix <
> > gilles.chanteperdrix@xenomai.org> wrote:
> >
> > > On Mon, Dec 01, 2014 at 04:26:47PM +0100, John Sini wrote:
> > > > On Mon, Dec 1, 2014 at 3:39 PM, Gilles Chanteperdrix <
> > > > gilles.chanteperdrix@xenomai.org> wrote:
> > > >
> > > > > On Mon, Dec 01, 2014 at 03:35:51PM +0100, John Sini wrote:
> > > > > >  Hi,
> > > > > >
> > > > > >
> > > > > > Thank you for your reply. I have disabled lockdep by disabling
> > > following
> > > > > > two options in Kernel configuration :Lock debugging:prove locking
> > > > > > correctness and  Lock debugging: detect incorrect freeing of live
> > > locks.
> > > > > > The problem that i am facing now is:
> > > > >
> > > > > Does the exact same .config file work on an unpatched kernel?
> > > > >
> > > > > Just checked and I got the same error.
> > >
> > > So, before trying and compiling Xenomai with a configuration file,
> > > please try and get a working configuration for your kernel, without
> > > Xenomai patch applied.
> > >
> > >   Ok, I will do it.
> >
> >
> > > Also, since the Zynq patch is provided by a third party, and not
> > > part of the patches supported by the mainline I-pipe patch, I do not
> > > even compile test this patch, so have no working configuration to
> > > propose.
> > >
> > > Maybe the people having proposed the patch could also propose a
> > > working kernel configuration? That would be nice.
> >
> >
> >
> >    Can you maybe explain me the errors that *I got i.e. can they be due
> to
> > xenomai(kernel panic)*
>
> I do not know what you are talking about. If the same configuration
> on an unpatched kernel has an issue, then the issue certainly has
> nothing to do with Xenomai, don't you think ?
>
>
  Yeah I do think :) I have just one question concerning this warning that
I still have(I think it's due to Xenomai as it's about ipipe)

WARNING: vmlinux.o(.cpuinit.text+0xdc0): Section mismatch in reference from
the function gt_setup.part.2.constprop.4() to the function
.init.text:__ipipe_tsc_register()
The function __cpuinit gt_setup.part.2.constprop.4() references
a function __init __ipipe_tsc_register().
If __ipipe_tsc_register is only used by gt_setup.part.2.constprop.4 then
annotate __ipipe_tsc_register with a matching annotation.

 - I have already put __init attribute in front of __ipipe_tsc_register
function in ipipe-core-3.8-arm-1.patch. If I put __init attribute in front
of the name of  __cpuinit gt_setup function in the same patch - will that
fix this warning that I have?

Best,
John
