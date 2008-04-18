Message-ID: <2ff1a98a0804180748o4dc88c91of90e8e26c36d32ed@domain.hid>
Date: Fri, 18 Apr 2008 16:48:07 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <d6c8ef150804180733k3e2b2bc0p1255b84e16062f05@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d6c8ef150804180733k3e2b2bc0p1255b84e16062f05@domain.hid>
Subject: Re: [Xenomai-help] Handling interrupt - jitter
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

On Fri, Apr 18, 2008 at 4:33 PM, Bosko Radivojevic
<bosko.radivojevic@domain.hid> wrote:
> Hi,
>
>  I'm having (from my perspective) too big jitter on handling
>  interrupts. System is: ARM9, AT91SAM9260, Kernel 2.6.20.21, Adeos
>  1.8-03, Xenomai-2.4.2, interrupt is generated every 1ms, externally.

It's funny to notice how much you asked for the 2.6.24 patch for
actually not using it.

>  Interrupt source (ET1200) is connected to IRQ1 pin (PC15). I'm using
>  native skin from user space. Usually, handler 'reacts' after ~110us,
>  but, worst case delay is around 250us! Is this performance
>  normal/expected on my platform? Why the difference is so huge?

>
>  Is there anything I can do to get better results (with this hw:)?

250 us is the user-space dispatch latency you obtain with the
"latency" test on a properly loaded target. It is the time for a
user-space context switch with a full cache flush. To reduce this
latency you have to:
- handle interrupts in kernel space, so that you will be limited by
interrupt latency, not user-space scheduling latency
- use trunk so that user-space context switches involving real-time
threads do not happen with hardware interrupts off.

-- 
 Gilles

