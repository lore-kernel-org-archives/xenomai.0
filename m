Message-ID: <464315B1.70504@domain.hid>
Date: Thu, 10 May 2007 14:53:05 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1072004B0EE21141A9DEBA9785A77F14658A70@domain.hid>	<17986.15326.243315.427529@domain.hid>	<1178748178.11688.45.camel@domain.hid>	<17986.20728.617772.991566@domain.hid>	<1178784303.11688.108.camel@domain.hid>
	<4642D901.9050304@domain.hid>	<1178789171.11688.142.camel@domain.hid>
	<4642E706.7000500@domain.hid>	<7289437c0705100441l4f9e8cd9l7e7c447cedd1e5c2@domain.hid>	<46430ADC.2050706@domain.hid>
	<7289437c0705100547q208b9ec0n9600d2b18206bc49@domain.hid>
In-Reply-To: <7289437c0705100547q208b9ec0n9600d2b18206bc49@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem with pthread_setschedparam
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Perrine Martignoni <perrmart@domain.hid>
Cc: xenomai@xenomai.org

Perrine Martignoni wrote:
> I tried to apply the patch xeno-safer-xnfreesafe and enable RPI.
> It doesn't work. I have the same problem :
>  
> 
> pthread_create: failed to allocate TCB
> 
> pthread_create returned 11
> 
> __pthread_shadow: -11
> 
> Xenomai Posix skin init: pthread_setschedparam: Resource temporarily
> unavailable

That's because you also need to apply the patch which replaces xnfree
with xnfreesafe in thread_delete_hook.

The correct way to fix xnfreesafe is still on discussion. Please be
patient, we will release a cumulated patch when the issue is solved.

-- 
                                                 Gilles Chanteperdrix

