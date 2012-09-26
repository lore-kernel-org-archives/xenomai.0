Message-ID: <506321EE.5040907@knapp.com>
Date: Wed, 26 Sep 2012 17:40:30 +0200
From: Christoph Permes <christoph.permes@knapp.com>
MIME-Version: 1.0
References: <5062CCB0.7060205@knapp.com>
In-Reply-To: <5062CCB0.7060205@knapp.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Xenomai: native skin init failed, code -19.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi!

Meanwhile I found out that the problem does not occur when the X86_PM_TIMER option is enabled in the kernel.

Is it OK to enable X86_PM_TIMER? The Xenomai documentation does not explicitly say if this option should be
enabled or disabled, but I've read about some issues on the mailing list where this option caused problems.

Best regards,
  Christoph


On 09/26/2012 11:36 AM, Christoph Permes wrote:
> Hi!
> 
> I am experiencing problems with Xenomai on a Beckhoff C6920 PC.
> 
> Most times Xenomai works correclty, but at random I'm getting the following messages when booting:
> [    0.459466] Xenomai: hal/i386 started.
> [    0.471028] Xenomai: real-time nucleus v2.4.9 (Big Bad Moon) loaded.
> [    0.522072] Xenomai: native skin init failed, code -19.
> [    0.522135] Xenomai: starting POSIX services.
> [    0.572046] Xenomai: POSIX skin init failed, code -19.
> [    0.622037] Xenomai: RTDM skin init failed, code -19.
> 
> So, Xenomai may start correctly many times and than fails to start for 10 times or it fails to
> start every second boot. It's completly random, it may happen on a cold boot or on a reboot.
> 
> It seems to have something to do with the APIC timer, as the kernel also writes this message
> when Xenomai fails to start:
> [    0.290132] APIC timer disabled due to verification failure
> 
> 
> The kernel options listed in the Xenomai installation and troubleshooting guides are already disabled,
> C1E is also disabled in BIOS.
> 
> I have attached the complete kernel log and the kernel configuration to this e-mail.
> 
> The software components I'm using are:
> Linux: 2.6.29.5
> Xenomai: 2.4.9
> Adeos: adeos-ipipe-2.6.29.5-x86-2.4.02
> 
> I know, it's pretty old, but we've been running these versions for almost 3 years on our production system
> on older hardware without any problems. So, maybe there is a simple solution to get rid of this problem.
> 
> 
> Best regarts,
>   Christoph
> 

