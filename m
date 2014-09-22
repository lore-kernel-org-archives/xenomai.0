Message-ID: <54206D56.7040509@xenomai.org>
Date: Mon, 22 Sep 2014 20:41:26 +0200
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

As a general rule, turning debug options off to make bugs disappear is
not really a good option, the sooner you catch a bug the better. Anyway,
ipipe_pin_range_globally probably has never been used with 3 level page
tables, which are enabled by LPAIE. In order to see if this is the only
problem, you can try and return at the beginning of
ipipe_pin_range_globally. You will not be able to run xenomai correctly
with this, but if the system boots normally, it means that indeed, like
you think, the problem is in that function.

-- 
                                                                Gilles.

