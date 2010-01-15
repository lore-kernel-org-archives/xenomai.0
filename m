Message-ID: <4B5038D3.2040203@domain.hid>
Date: Fri, 15 Jan 2010 10:43:47 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <b88603c31001150110h29380b4bnecbff46fa5d5d69b@domain.hid>
In-Reply-To: <b88603c31001150110h29380b4bnecbff46fa5d5d69b@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] IRQ handler argument corrupt when shared
 interrupts are enabled (Xenomai 2.4.10)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henri Roosen <henriroosen@domain.hid>
Cc: xenomai@xenomai.org

Henri Roosen wrote:
> Xenomai 2.4.10:
> 
> IRQ handler argument is not the same as the argument I provided when
> registering the IRQ handler. Problem only occurs when shared interrupt
> support is enabled in the kernel config. NOTE: even though the
> registered IRQ handler not a shared interrupt handler (flags = 0).

What API are you referring to, RTDM, native, or nucleus? What's your arch?

> 
> The problem is not reproducable on Xenomai 2.5.0.
> 
> So I was looking for the fix code in the 2.5.0 but couldn't find it.
> Is this a know problem that has only been fixed on 2.5.0, or does the
> bug just not show in 2.5.0? Could someone point out which commit on
> 2.5.0 fixes the problem?

I don't recall such a problem or any potential fix ATM.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

