MIME-Version: 1.0
Sender: mfornero@gmail.com
In-Reply-To: <20141201152921.GI23220@hermes>
References: <CAPozGf=zAFgV=fbinambu1_xEiR3qD7Affppw-i6ZbD4nvJsRw@mail.gmail.com>
 <20141128111325.GD5069@hermes>
 <CAPozGf=6OQBChvSAfypNH7KpAReg+u6PS3dhEJDtVZ-jrnW7bg@mail.gmail.com>
 <CAPozGfkxmv+7=Q3LXAmOv_eTPZ08XV3SO9SETPomSAs+bbxV0A@mail.gmail.com>
 <CAPozGfk9LizYFbCRKUDS1-mhX+bw3fOpgqzwF6AcH64Pspw4Gg@mail.gmail.com>
 <20141128182141.GB4817@hermes>
 <CAPozGfk-okS5TDn-zPua3uvHkcppm3CpnqAKXYs6-VWVPb4cpg@mail.gmail.com>
 <20141201143957.GH23220@hermes>
 <CAPozGf=ijSmQoUXRf7aG56G47N2DZbHyiL+1nHDEWvmZdhhcYw@mail.gmail.com>
 <20141201152921.GI23220@hermes>
Date: Mon, 1 Dec 2014 15:30:14 -0600
Message-ID: <CADVgf9n1X48fb6Zh2Q9qEthTjzM+HM8Wia_gsEe70fHDS2psKw@mail.gmail.com>
From: Matthew Fornero <mfornero.lists@gmail.com>
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
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Dec 1, 2014 at 9:29 AM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On Mon, Dec 01, 2014 at 04:26:47PM +0100, John Sini wrote:
>> On Mon, Dec 1, 2014 at 3:39 PM, Gilles Chanteperdrix <
>> gilles.chanteperdrix@xenomai.org> wrote:
>>
>> > On Mon, Dec 01, 2014 at 03:35:51PM +0100, John Sini wrote:
>> > >  Hi,
>> > >
>> > >
>> > > Thank you for your reply. I have disabled lockdep by disabling following
>> > > two options in Kernel configuration :Lock debugging:prove locking
>> > > correctness and  Lock debugging: detect incorrect freeing of live locks.
>> > > The problem that i am facing now is:
>> >
>> > Does the exact same .config file work on an unpatched kernel?
>> >
>> > Just checked and I got the same error.
>
> So, before trying and compiling Xenomai with a configuration file,
> please try and get a working configuration for your kernel, without
> Xenomai patch applied.
>
> Also, since the Zynq patch is provided by a third party, and not
> part of the patches supported by the mainline I-pipe patch, I do not
> even compile test this patch, so have no working configuration to
> propose.
>
> Maybe the people having proposed the patch could also propose a
> working kernel configuration?


Here's the defconfig I generally used for Xenomai / Zynq:

https://github.com/mfornero/linux/blob/zynq-ipipe-3.8/arch/arm/configs/xenomai_zynq_defconfig

And for reference, here's the git tree the patch was generated from
(note that this tree contains an old ipipe version)

https://github.com/mfornero/linux/tree/zynq-ipipe-3.8

Hoping to get some time to update the Zynq port to the latest Xilinx /
ipipe stuff (ideally something closer to mainline) in the near future.

-Matt

