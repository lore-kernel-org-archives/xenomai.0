Message-ID: <4C6DC09E.1060107@domain.hid>
Date: Fri, 20 Aug 2010 01:39:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <mailman.53.1282212027.5136.xenomai@xenomai.org>
	<4C6D9B61.2020108@domain.hid>
In-Reply-To: <4C6D9B61.2020108@domain.hid>
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
To: Bob Feretich <bob.feretich@domain.hid>
Cc: xenomai@xenomai.org

Bob Feretich wrote:
>   I haven't tried to implement the below yet, but it seems that it 
> should work...
> 
> One of the drivers that I am creating requires OMAP3 Neon processing 
> (hard SIMD floating point). In a standard Linux environment the Neon 
> code would be executed in the driver's "back end" tasklet. I plan to 
> implement this "back end" code as a Xenomai RT user task. That moves the 
> Neon code execution from the RTDM interrupt context to the Xenomai user 
> context. I believe that I read that the Xenomai user context supports 
> hard floating point in versions of Linux newer than 2.6.30. Do I 
> understand correctly?

Yes, it should work. At least, FPU unit tests + LTP FPU tests seem to
work well together. And in fact, even if FPU is supported for
kernel-space tasks, it is hard to get working for the reasons explained
earlier. With regard to FPU, Xenomai is not very different from Linux:
we encourage people to only use FPU in user-space.

> I also plan to isolate the Neon code to a separately compiled module 
> that uses hard floating point and static libraries. I'm planning this 
> because I may need to use a different compiler to generate good Neon 
> code and I want to prevent library conflicts. I have used the Angstrom 
> (glibc) supplied compiler to build my entire Linux system, including 
> Xenomai and my drivers. My Angstrom compiled "back end" task (a RT user 
> task) will call the Neon module. I expect that the Neon module will make 
> very little use of library functions, so compiling statically should not 
> increase its size significantly.
> 
> In the worst case, I can  just have the Angstrom compiler link the Neon 
> module's assembly file into the "back end" task. I have already verified 
> that this module contains Neon instructions rather than calls to 
> floating point library functions.

In order to mix easily the NEON compiled code with the Armstrong
toolchain code (which, I suppose, is soft-float?), you may want to use
-mfloat-abi=soft. This allows mixing hardware FP code with software FP code.

-- 
					    Gilles.

