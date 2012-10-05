Message-ID: <506F402A.9030102@xenomai.org>
Date: Fri, 05 Oct 2012 22:16:42 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1349212116.21898.108.camel@ENG-09-LX.emacinc.com>	
	<506B5D6B.80005@xenomai.org> <506B5E0E.5050900@xenomai.org>	
	<1349369822.3775.107.camel@ENG-09-LX.emacinc.com>	
	<506DC2DA.5000105@xenomai.org> <506E9510.7090105@xenomai.org>
	<1349462858.26881.43.camel@ENG-09-LX.emacinc.com>
In-Reply-To: <1349462858.26881.43.camel@ENG-09-LX.emacinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Adeos I-Pipe patch problem on vendor-specific kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wayne Warren <wwarren@emacinc.com>
Cc: xenomai@xenomai.org

On 10/05/2012 08:47 PM, Wayne Warren wrote:

> Cool,
> 
> First off, thanks again for the help and...my wiki account does not seem
> to have edit privileges on the page I was referring to in my previous
> e-mail.


That should be fixed by that.

> 
> Second, I have confirmed that the TI code we originally modified for our
> product does boot. However! Whenever I pass in
> "earlyprink=ttyO2,115200n8" the kernel seems to hang. Adding this
> parameter seems to be the only difference between the kernel that boots
> properly and the one that does not in this branch. 


That is what I told you: you should validate earlyprintk, starting by
validating printascii alone, that is, compile a kernel with
CONFIG_DEBUG_LL, without CONFIG_EARLY_PRINTK, and add a call to
printascii somewhere in the boot process, not in vprintk implementation.

earlyprintk is a module parameter with no argument: what uart is used by
printascii is determined, as I also told you, by the code in
arch/arm/plat-omap/include/plat/uncompress.h, it is not a dynamic parameter.

-- 
                                                                Gilles.

