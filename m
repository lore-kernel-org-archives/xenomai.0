Message-ID: <5063727D.1070801@xenomai.org>
Date: Wed, 26 Sep 2012 23:24:13 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5062CCB0.7060205@knapp.com> <506321EE.5040907@knapp.com>
In-Reply-To: <506321EE.5040907@knapp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai: native skin init failed, code -19.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Christoph Permes <christoph.permes@knapp.com>
Cc: xenomai@xenomai.org

On 09/26/2012 05:40 PM, Christoph Permes wrote:

> Hi!
> 
> Meanwhile I found out that the problem does not occur when the
> X86_PM_TIMER option is enabled in the kernel.
> 
> Is it OK to enable X86_PM_TIMER? The Xenomai documentation does not
> explicitly say if this option should be enabled or disabled, but I've
> read about some issues on the mailing list where this option caused
> problems.


Hi,

Xenomai will use a timer only if it has not been shutdown by Linux. So,
if enabling the PM_TIMER causes the APIC to be shut down then yes, you
should disable PM_TIMER. Though with CONFIG_SMP, there is one LAPIC
timer whereas there is only one PM_TIMER.

What is the result of cat /proc/timer_list when the APIC was disabled?

Regards.

-- 
                                                                Gilles.

