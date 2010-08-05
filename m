Message-ID: <4C5B09A2.8050607@domain.hid>
Date: Thu, 05 Aug 2010 11:57:38 -0700
From: Bob Feretich <bob.feretich@domain.hid>
MIME-Version: 1.0
References: <4C5A26C4.3050702@domain.hid> <4C5A631B.1040604@domain.hid>
In-Reply-To: <4C5A631B.1040604@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RTDM driver structure
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

  Comments inline...

On 8/5/2010 12:07 AM, Gilles Chanteperdrix wrote:
>
> Another remark: Xenomai uses, as, a system timer, a timer in one-shot
> mode (same as Linux so-called "high resolution timers"), so, if you
> program several periodic software timers, Xenomai timer subsystem will
> arrange for your timer callbacks to be called at the right time, so it
> looks like you will not gain much by using several hardware timers. If
> you fear that Xenomai timing subsystem will not scale well with many
> timers, you can enable the heap-based or wheel-based timer management.
The GPTimers that I am using have special hardware that drives pins on 
the chip. They can be programmed to create waveforms of specific pulse 
width and period and auto-restart so that the pulse train is continuous. 
Software only gets involved when the pulse width or period needs to be 
changed.  If I used the Xenomai timer, software (to change the state of 
a GPIO pin) would be invoked every time any of these signals needed to 
transition.

Using the hardware timers for the generation pulse trains of fixed pulse 
width and period takes zero CPU cycles.

Regards,
Bob


