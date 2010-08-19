Message-ID: <4C6CF5BF.3060405@domain.hid>
Date: Thu, 19 Aug 2010 11:13:35 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTi=dpYJNx+UzbjLy6Jpky2sscccUoVS5VZCAKMUv@domain.hid>
In-Reply-To: <AANLkTi=dpYJNx+UzbjLy6Jpky2sscccUoVS5VZCAKMUv@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] using floating point in rtdm
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: ramon costa <ramoncostacastello@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

ramon costa wrote:
> Hi,
> 
> I would like to use floating point arithmetics (double, ..) and operations
> (sin, cos) inside a rtdm task.
> How should I do this ?

You should not.

If you really want to, you have two solutions:
- let the kernel compile your module as is, this will generated
"soft-float" code, which means that the operations will be done in
software. Your module will contain undefined references to functions
actually implemented in libgcc. So, you will have to extract the needed
.o from libgcc.a and put them in your module.
- try and use "hardware" floating points. This means that you will have
to change the kernel build system to allow compiling hardware floating
points in kernel space. Here again, your module will contain undefined
references, but that will be undefined references to the libm functions
(such as sin, cos). So, you will have to compile the libm as a kernel
module. You will also have to patch RTDM to allow setting the XNFPU bit
to RTDM threads, and also note that you will be only able to use FPU
from such threads (and particularily, not from module initialization and
cleanup code).

If you decide to go either way, no code helping doing this will ever be
merged into Xenomai, so you will have to maintain your own version of
Xenomai.

> 
> Can anyone provide and example (Makefile+code) or point me to one ?

I am afraid nobody every did something like this because this is not
worth it.

-- 
					    Gilles.

