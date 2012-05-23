Message-ID: <4FBD105E.7070204@xenomai.org>
Date: Wed, 23 May 2012 18:29:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <623784B6C75D274389918D358E89E8BB0B7FD420@OPTELIAN5.optelian.local>
In-Reply-To: <623784B6C75D274389918D358E89E8BB0B7FD420@OPTELIAN5.optelian.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] MDIO on Freescale MX35.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Chris Stone <chris.stone@optelian.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/23/2012 05:43 PM, Chris Stone wrote:
> I am using Xenomai 2.6.0. We wish to run Xenomai on two different
> target boards, one uses the Freescale MPC8378 CPU, which is powerpc,
> the other uses the Freescale MX35 which is arm11. This is for real
> products that are under development, so there are some factors that
> affect our choices. For instance, to simplify maintenance of these
> cards for many years to come, we want to use the same kernel version
> on the MPC8378 as we do on the MX35. For this reason, we chose to use
> kernel 3.0.13, because there are Adeos patches against kernel 3.0.13
> for both arm and powerpc. However, I know that the Adeos patches and
> kernel 3.0.13 are not really supported by Xenomai 2.6.0 because they
> are only in the Git tree and not in the official tarball download.
> Nonetheless, the powerpc target has been running with no problem for
> some time now, and the card is actually in product verification now,
> which means that testing has not discovered any problems with Xenomai
> 2.6.0 on that target. I am now attempting bring Xenomai up on the
> mx35 card.
> 
> I am using the adeos patch adeos-ipipe-3.0.13-arm-1.18.08.patch. I
> tried following the README for the MXC, but the Freescale IMX git has
> no tag rel_imx_3.0.15_12.03.00. The denx tree has the tag, but the
> mxc patches as described in the README do not apply without errors.
> Even after fixing the patch rejects, I ended up with compilation
> errors, so I lost confidence in that approach.

This should not happen. This combination has been extensively tested on
imx51, imx53 and imx6. It should compile and you should get no rejects.
I will look into it.

> So, I applied the
> adeos-ipipe-3.0.13-arm-1.18.08.patch to the kernel.org 3.0.13 kernel,
> without the pre and post patches, which went without error. The
> kernel boots, and many things work, but the FEC Ethernet is broken
> with an MDIO read timeout.

Do you also get the MDIO timeout without the I-pipe and Xenomai patches?
If no, try applying the patch but not enabling CONFIG_IPIPE, then
enabling CONFIG_IPIPE without CONFIG_XENOMAI.

-- 
					    Gilles.

