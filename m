Message-ID: <4EAAF731.4020409@domain.hid>
Date: Fri, 28 Oct 2011 20:40:49 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <loom.20111028T160712-174@domain.hid>
	<4EAABB40.5050107@domain.hid> <4EAAD83D.3020503@domain.hid>
In-Reply-To: <4EAAD83D.3020503@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] twl4030-irq takes 50%cpu constantly on omap3
 gumstix overo
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: manfred@domain.hid
Cc: xenomai@xenomai.org

On 10/28/2011 06:28 PM, Manfred Quack wrote:
> However: is there a "clean" or "simple" way to apply the adeos-patches
> to the omap3-<>-kernels?

I do not think so. The only answer is: get the omap changes merged into
the mainline kernel, and use the mainline kernel. Because from a
maintenance point of view, maintaining one patch for each version of the
kernel is enough work to want and avoid maintaining versions for several
vendor-specific trees.

That said, if there are not many differences:
- we can arrange for the hunks to apply to both branches (we do this for
the at91 patch);
- we can provide two patches, a pre-patch applied before the adeos patch
(basically reverting all the changes causing conflicts), and a
post-patch applied after the adeos patch solving the conflicts (we did
this for instance for the imx kernel for 2.6.38)

I do not want to do this work for the omap branch, but if someone
provides the patches, we could find a way to make them available in the
tree, making it clear that it is not patches that we validated (for
instance creating a "contrib" directory). I am afraid, however, that
such patches would bitrot rapidly.

-- 
					    Gilles.

