Message-ID: <4653064D.40402@domain.hid>
Date: Tue, 22 May 2007 17:03:41 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <1179838106.6050.46.camel@domain.hid>	
	<4652F58D.2070305@domain.hid>
	<1179844918.6050.64.camel@domain.hid>
In-Reply-To: <1179844918.6050.64.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] ppc crosscompilation, missing headers
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Feuerer <peter.feuerer@domain.hid>
Cc: xenomai@xenomai.org

Peter Feuerer wrote:
> Hi Wolfgang,
> 
> On Tue, 2007-05-22 at 15:52 +0200, Wolfgang Grandegger wrote:
>> Hm, ppc_8xx is not the right tool-chain for this board. Please use 
>> ppc_6xx instead.
> 
> Yes, you are right, i was using the wrong one. Now I installed the
> toolchain for 6xx and use the env-variable:
> export CROSS_COMPILE=ppc_82xx-
> 
> - kernel compiled as before and is booting (again configured with the
> xenomai prepare script and the adeos patch)
> 
> But when compiling xenomai, still the same issue.
> 
>>> ./configure -host=ppc-linux
>>>
>>> But the make fails because of missing headers:
>>> [..]
>>>  error: asm/errno.h: No such file or directory
>>> [..]
>>>  error: asm/param.h: No such file or directory
>>> [..]
>>>
>>> I took a look at the kernel/include/asm-ppc/ folder and actually these
>>> headers are missing. But they do exist for the "powerpc" architecture.
>>> So I just copied all missing headers from asm-powerpc/ to asm-ppc/ to
>>> try if the xenomai userspace things can be compiled. It worked. But I
>>> think that is not the way it has to be done.
>> Of course not and I'm also surprised that it fixed your problem.
> 
>>> Does anybody know why these headers are missing in asm-ppc? Do I have to
>>> install some kind of BSP-kernel-patch for my specific board? Why are
>>> these headers available for powerpc?
>> No, when compiling for "ppc", the include files in "asm-powerpc" are 
>> included as well.
> 
> it does not seem like that :-(
> 
>>> And btw, maybe someone of you knows, why are there 2 architectures for
>>> the powerpc architecture in the kernel tree?
>> Traditionally, there was the "arch/ppc" tree for 32-bit PowerPC and 
>> "arch/ppc64" for 64-bit PowerPC. Both are merged already since a while 
>> into the new tree "arch/powerpc" ... and the old trees will become 
>> obsolete sooner than later.
> 
> Thanks for this information having ppc and powerpc is little confusing.
> 
>> Concerning your problem, I'm unable to reproduce it on my setup. What 
>> exact version of the ELDK do you use.
> 
> I'm using the ELDK 4.1 Toolchain (ppc-2007-01-19.iso) 

OK, in the meantime I know that the problem is known with ELDK 4.x as 
described http://www.denx.de/wiki/view/DULG/ELDKIncludeFilesMissing.

Wolfgang.


