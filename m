Message-ID: <5310762A.2070003@xenomai.org>
Date: Fri, 28 Feb 2014 12:42:34 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAEbDrgkifqMcqqEqh5hKA90YzFzcyDxLHFC79F8CWvZi5heyWQ@mail.gmail.com>
 <CAEbDrgmLq08Xq5Cgt7oXX3koQDr+HVx_JS-7Nn_pC53rmTTV-g@mail.gmail.com>
 <530FAAE3.6080505@xenomai.org> <201402280112.14374.paul_c@tuxcnc.org>
In-Reply-To: <201402280112.14374.paul_c@tuxcnc.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RaspberryPi kernel 3.8 issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paul <paul_c@tuxcnc.org>
Cc: xenomai@xenomai.org

On 02/28/2014 02:12 AM, Paul wrote:
> On Thursday 27 February 2014, Gilles Chanteperdrix wrote:
>> I am looking at the "post" patch for Raspberry, and I do not see that
>> it touches drivers/irqchip/irq-bcm2835.c
>>
>> Here the calls to handle_IRQ are not replaced with ipipe calls, this
>> can not work.
> 
> It is somewhat confusing that there are two sets of code for the 
> Raspberry Pi chip. bcm2708* is the original code as used by 
> the "official" RPi kernel and is found in the 
> github.com/raspberrypi/linux tree.
> 
> For the mainline kernel, for various reasons, it was decided that the 
> bcm2835 prefix would be used for the RPi SoC - Having two sets of 
> sources for one SoC can be somewhat confusing.
> 
> drivers/irqchip/irq-bcm2835.c doesn't get compiled for the Raspberry Pi 
> kernel - Instead, one should look at arch/arm/mach-bcm2708/armctrl.c

Ok, thanks.

-- 
                                                                Gilles.

