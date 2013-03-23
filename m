Message-ID: <514DD505.2040306@xenomai.org>
Date: Sat, 23 Mar 2013 17:15:01 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <OFFC519FEC.3D6ECA30-ON85257B37.00588608-85257B37.0058860B@aanddtech.com>
In-Reply-To: <OFFC519FEC.3D6ECA30-ON85257B37.00588608-85257B37.0058860B@aanddtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] (no subject)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: mfornero@aanddtech.com
Cc: xenomai@xenomai.org

On 03/23/2013 05:06 PM, mfornero@aanddtech.com wrote:

>>> Is there a new ADEOS patch for ARM in the works ? I am interested to know
>>> what kernel version is targeted if that decision has been made.
> 
>> 3.8. It currently works on at91s, but not yet on omap. We will probably
>> need to run tests on the imxs, as a lot of things have changed between
>> 3.5 and 3.8.
> 
> Hi Gilles,


Hi,

your mail agent is not correctly configured, it sent the mail with an
empty suject, and without the "In-Reply-To, or References" headers set.
Please fix this. Your lines are also too long.

> 
> Is there a public git tree with this work-in-progress? I couldn't pinpoint a 
> specific one on git.xenomai.org or git.denx.de that was ARM/3.8 based


It is ipipe-gch.git, but the work in progress is not currently pushed
there, because I need to be able to rebase.

> 
> The Xilinx -next tree for Zynq looks like it's based on 3.8, so a 3.8 ipipe would
> likely be much easier for me than attempting to back port all of the important patches.
> 
> On a related note, is there something I can do to help prevent the Zynq ipipe port from
> bit-rotting? Even in 3.8, mainline is still missing a lot of the necessary code for Zynq,
> so I assume I'd need a pre- and post- patch. Could you elaborate on what these would entail?


The pre- and post- patches allow a SOC-specific port on a vendor branch
to only contain SOC-specific changes, and not the core of the I-pipe
changes, allowing to update the I-pipe patch without updating the
SOC-specifc port. The pre and post patches are artificial, generated
with differences between specific trees, they do not need to reflect the
way you maintaint the SOC-specific I-pipe for the vendor branch.

Regards.

-- 
                                                                Gilles.

