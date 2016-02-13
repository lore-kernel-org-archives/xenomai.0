Date: Sat, 13 Feb 2016 13:57:06 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160213125706.GC25062@hermes.click-hack.org>
References: <DUB122-W12189AD8672E553549138CC5DA0@phx.gbl>
 <20160128153712.GB21210@hermes.click-hack.org>
 <BLU436-SMTP183FC8D4819E92CBCF167FF0AA0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BLU436-SMTP183FC8D4819E92CBCF167FF0AA0@phx.gbl>
Subject: Re: [Xenomai] Xenomai on Raspberry Pi 2
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mathieu Rondonneau <mathieu_rondonneau@hotmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Feb 12, 2016 at 07:44:51PM -0800, Mathieu Rondonneau wrote:
> On 16-01-28 07:37 AM, Gilles Chanteperdrix wrote:
> > On Thu, Jan 28, 2016 at 04:19:16PM +0100, Gianmarco Ottavi wrote:
> >> I'm trying to make xenomai works on Pi 2 but i get some building
> >> errors while compiling the kernel. I've looked it up online for
> >> some guide on how to make it works, tried for example
> >> https://github.com/awesomebytes/xenorasp, and seems to work and
> >> boot on Pi b+ but if i try it on Pi 2 it won't boot up(maybe
> >> becasue works only on 3.18 and newer, and xenorasp is on 3.10).The
> >> error i get while compiling for xenomai 3.0 on kernel 3.18
> >> is:"undefined reference to '__ipipe_mach_get_tscinfo' any idea?
> > 
> > The I-pipe patch, on which Xenomai is based, does not support the
> > raspberry pi 2, and can not support it as long as the support is not
> > mainlined. For the time being, you need to apply a supplementary
> > patch which has been published on this mailing list.
> > 
> Hi Gilles,
> 
> can you elaborate "can not support it as long as the support is not
> mainlined".

I mean that the I-pipe patch is made for the mainline kernel. If you
use a vendor fork, then the I-pipe patch usually does not apply and
you need pre and/or post patches.

> 
> What does it take to get it mainlined?

An effort from the Raspberry pi community to mainline their code
instead of using a vendor fork. Note than doing this usually
improves the code quality, because the code gets more reviews.

-- 
					    Gilles.
https://click-hack.org

