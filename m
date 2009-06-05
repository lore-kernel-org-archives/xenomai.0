MIME-Version: 1.0
In-Reply-To: <4A28FAD7.3E52.00F8.0@domain.hid>
References: <4A28F029020000F80002DB14@domain.hid>
	<4A28FAD4020000F80002DB27@domain.hid>
	<4A28FAD7.3E52.00F8.0@domain.hid>
Date: Fri, 5 Jun 2009 14:13:39 +0200
Message-ID: <d6c8ef150906050513n444b7a9eo9bb1be1676dd8c4e@domain.hid>
From: Bosko Radivojevic <bosko.radivojevic@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] IRQ-Latency when in idle State on ARM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Karl Tyss <tyss.k@domain.hid>
Cc: xenomai@xenomai.org

Karl,

you can try to boot the kernel with 'nohlt' option.

I had a similar problem - like CPU wasn't running on the same clock
rate. My ISR had two different duration times ~500 and ~800 us, always
with the same code execution path.

The similar behavior I couldn't detect on the vanilla kernel.

Thanks to Gilles, 'nohlt' kernel option helped.

Sincerely,
Bosko

