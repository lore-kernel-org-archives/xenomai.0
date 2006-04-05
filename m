Message-ID: <4433B83A.20409@domain.hid>
Date: Wed, 05 Apr 2006 14:29:46 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Frozen timer IRQ
References: <4432E540.1010108@domain.hid>
	<17459.46030.997560.684058@domain.hid>
In-Reply-To: <17459.46030.997560.684058@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Hi,
>  > 
>  > my colleagues and I need some hint where to continue our search for the
>  > cause of a weird cleanup issue:
>  > 
>  > An application of our robotics framework sometimes terminates (though
>  > successfully) in a way that the system timer IRQ no longer arrives
>  > afterwards or no re-program takes place anymore. All other Linux IRQs
>  > are fine (Ethernet, keyboard, etc.). I cannot provide an easy test case
>  > yet as besides the framework some expensive gyroscope and the 16550A
>  > driver are involved.
> 
> I observed a similar issue when xnpod_stop_timer was called when
> shutting down the posix skin. I assumed that the problem was that
> xnpod_shutdown already called xnpod_stop_timer, so xnpod_stop_timer (and
> in particular xnarch_stop_timer) ended up being called twice.
> 

The XNTIMED bit from the pod's status is checked to trap multiple 
invocations, so this should not -normally- cause any issue.

-- 

Philippe.

