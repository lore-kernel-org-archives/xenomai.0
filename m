Message-ID: <50375EAC.9000206@xenomai.org>
Date: Fri, 24 Aug 2012 12:59:56 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50375208.5090209@wanadoo.fr>
In-Reply-To: <50375208.5090209@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Availability of ARM adeos patch for 3.5 kernel,
 and RTDM SPI for iMX6 ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Thierry Bultel <thierry.bultel@wanadoo.fr>
Cc: xenomai@xenomai.org

On 08/24/2012 12:06 PM, Thierry Bultel wrote:

> Hi,
> 
> I noticed on git that the latest available patch for ARM is
> ipipe-core-3.2.21-arm-1.patch,
> that I assume, replaces the mxc pre+std+post mecanism, please tell me if
> I am wrong.


The pre+std+post mechanism is used to apply a patch for mainline kernel
to the Freescale linux tree. If you want to use that tree, you always
need that mechanism. ipipe-core-3.2.21-arm-1.patch is a patch for the
mainline kernel.

> 
> I would like to know is there is an estimated date for the availability
> of the patch for the 3.5 kernel ?


Due to lack of time, the next patch will probably be for 3.6. We already
have support for 3.4 kernel, which you can use checking out:
git://git.denx.de/ipipe.git
for the kernel, and
git://git.xenomai.org/xenomai-2.6.git
for xenomai.

Note that 3.4 is probably a good choice as it has been announced that it
will be maintained for one year.

Note that we have some unfinished business on imx6:
- we have some random crashes, which I think are probably solved in 3.4
(and need backporting in 3.2 and 3.0, either way)
- we have some high latencies, I think they may be due to the bug
discovered in this thread:
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-August/113087.html

But I need to spend some time on the actual hardware to validate these
hypotheses.

> 
> My last question is about SPI, will an RTDM driver for the SPI of the
> iMX6 be available ?


Sure, if someone writes it, we will be happy to merge it in xenomai sources.

-- 
                                                                Gilles.

