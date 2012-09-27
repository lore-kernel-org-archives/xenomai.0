Message-ID: <50649D48.3090203@xenomai.org>
Date: Thu, 27 Sep 2012 20:39:04 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5063141B.8070107@siemens.com>
	<1348665363-28222-2-git-send-email-wolfgang.mauerer@siemens.com>
In-Reply-To: <1348665363-28222-2-git-send-email-wolfgang.mauerer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH 2/2] Register high-res timer irq for non-ipipe
 timers if necessary
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
Cc: jan.kiszka@siemens.com, xenomai@xenomai.org

On 09/26/2012 03:16 PM, Wolfgang Mauerer wrote:

> If a CPU that is not supported by ipipe, but used by Linux
> shares an IRQ with a timer utilised by ipipe, it must be
> possible to forward IRQs received on behalf of the Linux CPU.
> Based on a patch by Gilles Chanteperdrix.
> 
> Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>


That is much better than the original patch, you are even allowing to
have a mixed HPET/LAPIC timers configuration on x86. I guess you can now
suppress the test hpet_msi_capability_lookup and register an ipipe_timer
for each HPET timer unconditionally.

Regards.

-- 
                                                                Gilles.

