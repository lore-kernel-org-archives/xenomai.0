Message-ID: <4BA9E7E0.6040206@domain.hid>
Date: Wed, 24 Mar 2010 11:22:24 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4BA8F900.5000602@domain.hid>
	<4BA39C3D.1040802@domain.hid>	<4BA4EF75.7010202@domain.hid>
	<4BA74820.2090401@domain.hid>	<4BA8752E.8090407@domain.hid>
	<4BA8C15E.5050707@domain.hid>	<4BA8F517.3060705@domain.hid>
	<4BA8F732.10206@domain.hid>
	<2d0b8e.10245.1278e1771a8.Coremail.robert165@domain.hid>
In-Reply-To: <2d0b8e.10245.1278e1771a8.Coremail.robert165@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem in irq_handle
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: robert165 <robert165@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>

robert165 wrote:
> Hi Jan, I am new to xenomai, I am writing a gpio driver based on
> your "RTDM skeleton v1.1". There is a problem that when I complied
> and run your skeleton in a at91rm9200 broad with TIMERINT, the output
> is not show one line one second but very fast. The problem is still
> whenever I changed the following codes in demo_interrupt()
> 
> #ifdef TIMERINT if (events > XXX){ 
> rtdm_event_signal(&ctx->irq_event); event=0; } ... events++;
> 
> And, it seems likely in my own irq_handle of a gpio irq. When the irq
> arrive, the irq_handle repeats many times. Should I mask the same irq
> in irq_handle? I did it by write the PIO interrupt mask register, but
> no effect.

Which interrupt is TIMERINT?

-- 
					    Gilles.

