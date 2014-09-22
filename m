Message-ID: <54206A49.1070005@xenomai.org>
Date: Mon, 22 Sep 2014 20:28:25 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAFvTJFEsnycSeft7DEeRFXFTXb8E8xLbzFANk2HVt50ikd14gQ@mail.gmail.com>
In-Reply-To: <CAFvTJFEsnycSeft7DEeRFXFTXb8E8xLbzFANk2HVt50ikd14gQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] kernel panic with IPIPE and LPAE on ARM OMAP5 board
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sam Hajian <saeid.hajian@gmail.com>, xenomai@xenomai.org

On 09/22/2014 07:57 PM, Sam Hajian wrote:
> Hi,
> 
> I am using ipipe-3.14 on ARM OMAP5 with dual core Cortex A15. When used
> IPIPE and LPAE turn on in kernel I get kernel exception. This is after
> fixing a compile issue in "arch/arm/mm/fault.c" to include
> "__ipipe_pin_range_globally".
> If not used LPAE all works fine, but I need that for KVM.
> I figured out the initial problems can be resolved if not used
> CONFIG_SLUB_DEBUG in mm/kernel, however I ran into another problem with
> invalid paging request as shown in second log below, which I think is the
> real problem. Any suggestion/help?

Disassemble the code at the address where the error happens, look for
registers values in the oops, and understand why the error happens. Like
you would do for any oops.


-- 
                                                                Gilles.

