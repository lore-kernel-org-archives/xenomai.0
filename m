Date: Fri, 4 Mar 2011 09:11:21 +0100
From: Richard Cochran <richardcochran@domain.hid>
Message-ID: <20110304081121.GA12640@domain.hid>
References: <20110302151603.GA14557@domain.hid>
	<4D6E61B6.906@domain.hid> <4D6E8A06.9060508@domain.hid>
	<20110303072147.GA4353@domain.hid>
	<1299137548.2072.3.camel@domain.hid> <4D6F88D6.4010105@domain.hid>
	<4D6F89C8.9060005@domain.hid> <1299156880.2072.6.camel@domain.hid>
	<4D702802.5080001@domain.hid> <1299225060.2107.20.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1299225060.2107.20.camel@domain.hid>
Subject: Re: [Xenomai-help] Stuck MSI in normal Linux driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>

On Fri, Mar 04, 2011 at 08:51:00AM +0100, Philippe Gerum wrote:
> 
> I'm not saying this would be impossible to enable MSIs there, I'm just
> saying that so far: nobody cared. Terrae incognitae.

I care!

When the first MSI interrupt from my PCIe card should arrive, running
on a P2020RBD, the machine locks up. My BDI shows me that both cores
are going round in circles.

* core 1
  __ipipe_check_percpu_access ()  at kernel/ipipe/core.c:2067
  ipipe_suspend_domain ()         at kernel/ipipe/core.c:826
  __ipipe_check_percpu_access ()  at arch/powerpc/include/asm/ipipe_hwirq.h:57
  ipipe_suspend_domain ()         at kernel/ipipe/core.c:860
  cpu_idle ()                     at arch/powerpc/kernel/idle.c:64
  ipipe_suspend_domain ()         at arch/powerpc/include/asm/ipipe_hwirq.h:57

* core 2
  ipipe_suspend_domain ()         at kernel/ipipe/core.c:858
  cpu_idle ()                     at arch/powerpc/kernel/idle.c:64
  ipipe_suspend_domain ()         at arch/powerpc/include/asm/ipipe_hwirq.h:57

Any thoughts?

Thanks,

Richard

