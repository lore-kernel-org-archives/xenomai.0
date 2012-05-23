Message-ID: <4FBCB64E.6090209@xenomai.org>
Date: Wed, 23 May 2012 12:05:02 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4FBCB442.5030208@wanadoo.fr>
In-Reply-To: <4FBCB442.5030208@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] iMX6 support
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

On 05/23/2012 11:56 AM, Thierry Bultel wrote:
> Hi,
> 
> We are looking in a replacement solution for our obsolete 
> pentium-Celeron calculator.
> For many reasons, we would like to switch to the ARM architecture.
> The aimed CPU is the iMX6 Quadcore.
> 
> Freescale provides a patched 2.6.35 and 2.6.38 kernel that do not have 
> all the peripherals (the CAN seems to be missing)
> and Emtrion, a CPU module manufacturer, say they provide the additional 
> patches to have the complete BSP.
> It is likely a 2.6.35 only, though.

Xenomai for mx6q does not exist for linux 2.6.35. It only exists for
freescale branch for 2.6.38, or 3.0, as a separate set of patches to
apply before and after the Adeos patches for the vanilla kernel. For
further details, see ksrc/arch/arm/patches/README in xenomai 2.6 sources.

Furthermore, we have some stability issues with Xenomai for mx6q with
3.0, the issues looking a lot like an issue with cache. We would ned to
recheck 2.6.38 to see if it had the same issues, but I would bet it does.

-- 
					    Gilles.

