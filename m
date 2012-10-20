Message-ID: <50825FCA.5050401@xenomai.org>
Date: Sat, 20 Oct 2012 10:24:42 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1349212116.21898.108.camel@ENG-09-LX.emacinc.com>	
	<506B5D6B.80005@xenomai.org> <506B5E0E.5050900@xenomai.org>	
	<1349369822.3775.107.camel@ENG-09-LX.emacinc.com>	
	<506DC2DA.5000105@xenomai.org> <506E9510.7090105@xenomai.org>	
	<1349462858.26881.43.camel@ENG-09-LX.emacinc.com>	
	<506F402A.9030102@xenomai.org>	
	<1349473634.26881.221.camel@ENG-09-LX.emacinc.com>	
	<506F6283.2040901@xenomai.org>	
	<5afa3b9a7c7daf116f8284b4f255227e.squirrel@mail.emacinc.com>	
	<506FFDDC.60104@xenomai.org>	
	<1349816136.25350.426.camel@ENG-09-LX.emacinc.com>	
	<50749349.5070900@xenomai.org>
	<1350681759.1282.88.camel@ENG-09-LX.emacinc.com>
In-Reply-To: <1350681759.1282.88.camel@ENG-09-LX.emacinc.com>
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

On 10/19/2012 11:22 PM, Wayne Warren wrote:

> I also now understand why there are no printk messages--since the
> machine_init() has not been called yet, there are no UARTs registered as
> a serial console. The way early_printk works is also a little more clear
> to me, but I do not plan at this time to continue trying to get it to
> work.


By the way, if early_printk does not work, printascii is supposed to
work very early, so the "printascii in printk" trick should work. If it
does not work, it means that printascii does not work, and as I already
said, you can validate printascii separately, on a correctly working
kernel. But JTAG is fine, too...

-- 
                                                                Gilles.

