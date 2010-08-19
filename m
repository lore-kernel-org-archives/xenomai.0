Message-ID: <4C6D9B61.2020108@domain.hid>
Date: Thu, 19 Aug 2010 14:00:17 -0700
From: Bob Feretich <bob.feretich@domain.hid>
MIME-Version: 1.0
References: <mailman.53.1282212027.5136.xenomai@xenomai.org>
In-Reply-To: <mailman.53.1282212027.5136.xenomai@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: xenomai@xenomai.org, ramon costa <ramoncostacastello@domain.hid>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

  I haven't tried to implement the below yet, but it seems that it 
should work...

One of the drivers that I am creating requires OMAP3 Neon processing 
(hard SIMD floating point). In a standard Linux environment the Neon 
code would be executed in the driver's "back end" tasklet. I plan to 
implement this "back end" code as a Xenomai RT user task. That moves the 
Neon code execution from the RTDM interrupt context to the Xenomai user 
context. I believe that I read that the Xenomai user context supports 
hard floating point in versions of Linux newer than 2.6.30. Do I 
understand correctly?

I also plan to isolate the Neon code to a separately compiled module 
that uses hard floating point and static libraries. I'm planning this 
because I may need to use a different compiler to generate good Neon 
code and I want to prevent library conflicts. I have used the Angstrom 
(glibc) supplied compiler to build my entire Linux system, including 
Xenomai and my drivers. My Angstrom compiled "back end" task (a RT user 
task) will call the Neon module. I expect that the Neon module will make 
very little use of library functions, so compiling statically should not 
increase its size significantly.

In the worst case, I can  just have the Angstrom compiler link the Neon 
module's assembly file into the "back end" task. I have already verified 
that this module contains Neon instructions rather than calls to 
floating point library functions.

I don't know if this approach will work for your application, but you 
may want to consider it.

Regards,
Bob Feretich

On 8/19/2010 3:00 AM, xenomai-help-request@domain.hid wrote:
> Date: Thu, 19 Aug 2010 11:13:35 +0200
> From: Gilles Chanteperdrix<gilles.chanteperdrix@xenomai.org>
> Subject: Re: [Xenomai-help] using floating point in rtdm
> To: ramon costa<ramoncostacastello@domain.hid>
> Cc: Xenomai help<xenomai@xenomai.org>
> Message-ID:<4C6CF5BF.3060405@domain.hid>
> Content-Type: text/plain; charset=UTF-8
>
> ramon costa wrote:
>> Hi,
>>
>> I would like to use floating point arithmetics (double, ..) and operations
>> (sin, cos) inside a rtdm task.
>> How should I do this ?
> You should not.
>
> If you really want to, you have two solutions:
> - let the kernel compile your module as is, this will generated
> "soft-float" code, which means that the operations will be done in
> software. Your module will contain undefined references to functions
> actually implemented in libgcc. So, you will have to extract the needed
> .o from libgcc.a and put them in your module.
> - try and use "hardware" floating points. This means that you will have
> to change the kernel build system to allow compiling hardware floating
> points in kernel space. Here again, your module will contain undefined
> references, but that will be undefined references to the libm functions
> (such as sin, cos). So, you will have to compile the libm as a kernel
> module. You will also have to patch RTDM to allow setting the XNFPU bit
> to RTDM threads, and also note that you will be only able to use FPU
> from such threads (and particularily, not from module initialization and
> cleanup code).
>
> If you decide to go either way, no code helping doing this will ever be
> merged into Xenomai, so you will have to maintain your own version of
> Xenomai.
> ... snipped...

