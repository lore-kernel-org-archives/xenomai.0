Message-ID: <521527D7.1060600@xenomai.org>
Date: Wed, 21 Aug 2013 22:49:27 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <52152657.4090600@gmail.com>
In-Reply-To: <52152657.4090600@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ipipe patch for 3.6.0 arm?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: sagar.behere@gmail.com
Cc: xenomai@xenomai.org

On 08/21/2013 10:43 PM, Sagar Behere wrote:
> Hello,
> 
> I wish to run xenomai on a gumstix duovero (OMAP4430-based). A kernel 
> supporting the duovero is supposedly under development in the omap-3.6 
> branch of Steve Sakoman's repo
> 
> http://git.sakoman.com/git/gitweb.cgi?p=linux.git;a=shortlog;h=refs/heads/omap-3.6
> 
> However, I don't see an ipipe patch for 3.6.0 in
> http://download.gna.org/adeos/patches/v3.x/arm/older/
> 
> So how does one go about using xenomai with a 3.6.0 kernel?

You have two choices:
1- port the I-pipe patch to the target kernel
2- back/forward port the board specific changes to a kernel which has an
I-pipe patch.

Usually 2 is easier.

-- 
                                                                Gilles.

