Message-ID: <2ff1a98a0803210354g40137eeds72eb742142856cd@domain.hid>
Date: Fri, 21 Mar 2008 11:54:42 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <d6c8ef150803210350o3daefc6ra0de77c72c7401b1@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d6c8ef150803180527h71adc568o612fec284f8d096@domain.hid>
	<2ff1a98a0803180723i17d6d6e1p619b9c8948b6e542@domain.hid>
	<d6c8ef150803190410l48c36687odd494d3966407a8@domain.hid>
	<18401.32383.382321.517340@domain.hid>
	<d6c8ef150803210350o3daefc6ra0de77c72c7401b1@domain.hid>
Subject: Re: [Xenomai-help] Handling irq
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bosko Radivojevic <bosko.radivojevic@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Fri, Mar 21, 2008 at 11:50 AM, Bosko Radivojevic
<bosko.radivojevic@domain.hid> wrote:
> I have much better results using rtdm_lock_get_irqsave and
>  rtdm_lock_put_irqrestore. I hope this is the "appropriate method" of
>  doing it :)
>
>  Thanks!

Shutting interrupts off for long periods of time is not a good idea:
- it does not scale well, since it does not work for more than one task;
- it kills the precision of timers by delaying the timer interrupt.
And I am sure we can find many more drawbacks.

-- 
 Gilles

