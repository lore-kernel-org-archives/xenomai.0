Message-ID: <4FD9CA01.4040104@xenomai.org>
Date: Thu, 14 Jun 2012 13:24:49 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <008b01cd42bb$724478e0$56cd6aa0$@com>
In-Reply-To: <008b01cd42bb$724478e0$56cd6aa0$@com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] adeos-ipipe-3.0.13-arm-1.18-09.patch broken
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: George Pontis <GPontis@z9.com>
Cc: xenomai@xenomai.org

On 06/05/2012 03:35 AM, George Pontis wrote:
> This recently released patch appears to be broken with regard to patching
> arch/arm/mach-at91/at91sam9g45.c.
> 
> The first section of the patch should be applied to around line 32 in
> similar fashion to the patch for the other micros in the family. However, it
> is being applied to an entirely different structure around line 320. The
> resulting file fails to compile. I doctored up this section of the patch so
> it would be applied in the correct place, and the kernel builds. The
> incorrect section of the patch is at line 5146. The following edit can be a
> useful patch to the patch, until officially re-released:

Fixed, thanks. The problem is that I do not compile test at91sam9g45,
apart from this bug, does xenomai work on this processor?

-- 
                                                                Gilles.

