Message-ID: <50406421.6040804@xenomai.org>
Date: Fri, 31 Aug 2012 09:13:37 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50405C4F.5030301@ebus.com>
In-Reply-To: <50405C4F.5030301@ebus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Upgrading to Xenomai 2.6.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Doug Brunner <dbrunner@ebus.com>
Cc: xenomai@xenomai.org

On 08/31/2012 08:40 AM, Doug Brunner wrote:

> I've been having a very hard time with the upgrade from Xenomai 2.6.0 to 
> 2.6.1--hoping someone might have a suggestion for me. My thinking was 
> that, to get the most possible bug fixes, I should also upgrade to the 
> latest kernel for which there is a stable I-pipe patch, which appears to 
> be 3.2.21 from examining the list of available patches distributed with 
> Xenomai.
> 
> Unfortunately, 3.2.21 (even unmodified, using a vanilla Debian kernel 
> config, set for 586 cpu type) will not boot on my target platform 
> (Winsystems PPM-LX800-G, which has a Geode LX800 CPU). It immediately 
> resets after "Loading initial ramdisk", without even any early printk 
> output. I have no idea what could be causing that :(
> 
> I can't use CONFIG_MGEODE_LX because I get the following error building 
> with the I-pipe patch:
> 
> arch/x86/lib/mmx_32.c: In function '_mmx_memcpy':
> arch/x86/lib/mmx_32.c:33: error: 'ipipe_root_domain_p' undeclared (first 
> use in this function)
> arch/x86/lib/mmx_32.c:33: error: (Each undeclared identifier is reported 
> only once
> arch/x86/lib/mmx_32.c:33: error: for each function it appears in.)
> 
> and including <linux/ipipe.h> in mmx_32.c does not help.
> 
> I did see an email on the list suggesting that 3.4 is now supported, but 
> if it is still in git and not released I'm guessing it hasn't undergone 
> much testing yet. For a production environment, would I be better off 
> just using 2.6.38.8?
> 
> I'd really like to get 2.6.1 running so I can see if it fixes the kernel 
> oops I reported a few months ago.


You probably know that, but any version of Xenomai is supposed to work
with any I-pipe patch released before.

But we should also try to get 3.2 working for Geode. 3.4 probably has
the same issues as 3.2. ipipe_root_domain_p has been replaced with
ipipe_root_p in the new I-pipe core patches. I have a geode here, I will
try, please post your kernel configuration so that I can try and
reproduce the issue you have.

-- 
                                                                Gilles.

