Message-ID: <514F8392.6080201@xenomai.org>
Date: Sun, 24 Mar 2013 23:52:02 +0100
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
> 
> Is there a public git tree with this work-in-progress? I couldn't pinpoint a 
> specific one on git.xenomai.org or git.denx.de that was ARM/3.8 based
> 
> The Xilinx -next tree for Zynq looks like it's based on 3.8, so a 3.8 ipipe would
> likely be much easier for me than attempting to back port all of the important patches.
> 
> On a related note, is there something I can do to help prevent the Zynq ipipe port from
> bit-rotting? Even in 3.8, mainline is still missing a lot of the necessary code for Zynq,
> so I assume I'd need a pre- and post- patch. Could you elaborate on what these would entail?


Hi,

You can have a look at the "next" branch in the ipipe-gch git
repository, it is work in progress, but currently boot on at91, omap3
and omap4 (cortex A9 SMP, like Zynq). The solution currently used to
allow the I-pipe working with IRQDOMAINS is not very satisfactory and
should be improved in next versions.

Regards.

-- 
                                                                Gilles.

