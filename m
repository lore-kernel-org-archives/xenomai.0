Message-ID: <4F0F3A3D.0@domain.hid>
Date: Thu, 12 Jan 2012 20:53:33 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F0F1E23.5060400@domain.hid> <4F0F2A00.4040508@domain.hid>
	<4F0F364C.8000607@domain.hid>
In-Reply-To: <4F0F364C.8000607@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Omap3630, rtserial, xeno_16550A: crash on insmod
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Manfred <manfred@domain.hid>
Cc: xenomai@xenomai.org

On 01/12/2012 08:36 PM, Manfred wrote:
> Ok, so this is my first attempt on trying to debug a kernel module,   so 
> please bear with me:
> First, I repeated what I did before: 
> 
> 1.) setserial /dev/ttyS0 uart none 
> 
> 2.)modprobe xeno_16550A mem=0x4806a000 irq=72 baud_base=3000000 
> 
> 3.) dmesg->error message with: 
> 
> Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa06a002 
> 
> Obtain Address-offset Ad1=0xfa06a002 
> 
> 4.) get address-offset Ad0 from less /proc/modules: 
> 
> xeno_16550A 14280 1 - Loading 0xbf104000 
> 
> 5.) obtain Ad2=Ad1+Ad0 (google says: 0xbf104000 + 0xfa06a002 = 
> 0x1B916E002)

The adress of the fault instruction is the value of the PC register,
quoting my previous mail:

>> check what happens at bf0f0170

-- 
					    Gilles.

