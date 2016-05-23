Date: Mon, 23 May 2016 11:37:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160523093718.GA27631@hermes.click-hack.org>
References: <20160502192504.GL2055@csclub.uwaterloo.ca>
 <b1a516a1-6798-b2d1-ccb6-3197c5eac17d@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1a516a1-6798-b2d1-ccb6-3197c5eac17d@xenomai.org>
Subject: Re: [Xenomai] [PATCH] arm/ipipe: pinctrl-single: Fix build failure
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Mon, May 23, 2016 at 11:12:22AM +0200, Philippe Gerum wrote:
> On 05/02/2016 09:25 PM, Lennart Sorensen wrote:
> > arm/ipipe: pinctrl-single: Fix build failure
> > 
> > A ; was lost when adding IPIPE support to the pinctrl-single.c which is
> > only seen when building with IPIPE disabled.
> 
> Merged, thanks.

I was wondering: do we have to have the #ifdef, does not that kernel
have ipipe_raw_spinlock_t ? I wanted to have a look before answering.

-- 
					    Gilles.
https://click-hack.org

