Message-ID: <506FFDDC.60104@xenomai.org>
Date: Sat, 06 Oct 2012 11:46:04 +0200
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
In-Reply-To: <5afa3b9a7c7daf116f8284b4f255227e.squirrel@mail.emacinc.com>
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
To: wwarren@emacinc.com
Cc: xenomai@xenomai.org

On 10/06/2012 06:29 AM, Wayne Warren wrote:

> Gilles,
> 
> I should have mentioned this earlier... I did as you mentioned in one of
> your previous e-mails and added DEBUG_LL_OMAP3(3, am3517evm) after finding
> that this string corresponds to the processor id passed to the linux
> kernel from u-boot (unless I am misunderstanding how that works). This
> applies to all the kernels I built and tested as described in my previous
> two e-mails.
> 
> Thanks for your patience, and sorry for the confusion!


Ok, but for some reason, that is probably what is not working. Are you
sure that:
- the am3517 uart has the same address and registers as an omap3 uart?
- that the serial console is on UART3 ?
- the uart registers range is mapped where the code in debug-macro.S
expects it?

I never had to debug this, but if I had to, I would try to find what are
the values used by the decompressor for the uart physical and virutal
addresses and check whether the virtual adress is really mapped.

If your kernel does not start with CONFIG_IPIPE, earlyprintk does not
work, and you do not have a JTAG probe, you can try toggling some GPIOs
to light some LEDS.

-- 
                                                                Gilles.

