Message-ID: <521784AE.4090802@gmail.com>
Date: Fri, 23 Aug 2013 17:50:06 +0200
From: Sagar Behere <sagar.behere@gmail.com>
MIME-Version: 1.0
References: <52152657.4090600@gmail.com> <521527D7.1060600@xenomai.org>
In-Reply-To: <521527D7.1060600@xenomai.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] ipipe patch for 3.6.0 arm?
Reply-To: sagar.behere@gmail.com
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 08/21/2013 10:49 PM, Gilles Chanteperdrix wrote:
> On 08/21/2013 10:43 PM, Sagar Behere wrote:
>> Hello,
>>
>> I wish to run xenomai on a gumstix duovero (OMAP4430-based). A kernel
>> supporting the duovero is supposedly under development in the omap-3.6
>> branch of Steve Sakoman's repo
>>
>> http://git.sakoman.com/git/gitweb.cgi?p=linux.git;a=shortlog;h=refs/heads/omap-3.6
>>
>> However, I don't see an ipipe patch for 3.6.0 in
>> http://download.gna.org/adeos/patches/v3.x/arm/older/
>>
>> So how does one go about using xenomai with a 3.6.0 kernel?
>
> You have two choices:
> 1- port the I-pipe patch to the target kernel
> 2- back/forward port the board specific changes to a kernel which has an
> I-pipe patch.

Hmm, I noticed tags for v3.9.4 and v3.10-rc2 at

http://git.xenomai.org/?p=ipipe.git;a=summary

I also noticed in the toplevel Makefile of the ipipe-next branch that 
the version was 3.9.4

So I followed choice 2 you suggested and forward ported the board 
specific changes to both 3.9.x and 3.10.x kernels.

However, it seems after checking out the v3.10-rc2 tag that it doesn't 
have xenomai specific stuff ?!

So I checked out ipipe-next, which seemed to have xenomai specific 
stuff. I then applied all my board specific changes to the ipipe-next 
code, used the prepare-kernel.sh script from the xenomai-2.6 master and 
tried to compile. However compilation errors come up like

-----
arch/arm/mach-omap2/io.c: In function ‘omap3_init_early’:
arch/arm/mach-omap2/io.c:472: error: expected expression before ‘<<’ token
arch/arm/mach-omap2/io.c:477: error: expected expression before ‘==’ token
arch/arm/mach-omap2/io.c:479: error: expected expression before ‘>>’ token
-----

I have not touched those files.. so is it that the ipipe-next branch is 
not usable or  something?

What would you advice me to do now?

Thanks in advance,
Sagar

