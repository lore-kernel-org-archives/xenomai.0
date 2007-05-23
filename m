Message-ID: <46540F47.9060907@domain.hid>
Date: Wed, 23 May 2007 11:54:15 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <20070522145243.94232353428@domain.hid>	
	<1179907535.6119.14.camel@domain.hid>	
	<4653FAE0.90707@domain.hid>	
	<1179908851.6119.21.camel@domain.hid>	
	<465404D4.5010309@domain.hid>
	<1179912486.6119.32.camel@domain.hid>
In-Reply-To: <1179912486.6119.32.camel@domain.hid>
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
> On Wed, 2007-05-23 at 11:09 +0200, Wolfgang Grandegger wrote:
>> Peter Feuerer wrote:
>>> On Wed, 2007-05-23 at 10:27 +0200, Wolfgang Grandegger wrote:
>>>> Peter Feuerer wrote:
>>>>> Hi,
>>>>>
>>>>> History:
>>>>> https://mail.gna.org/public/xenomai-help/2007-05/msg00260.html
>>>>>
>>>>>> Please see FAQ 14.1.4. ELDK Include Files Missing
>>>>>> http://www.denx.de/wiki/view/DULG/ELDKIncludeFilesMissing
>>>>> After doing this workaround, I'm able to compile the userspace part of
>>>>> Xenomai, but now I can't compile any little kernelmodule using the
>>>>> xenomai api. I attached the Makefile and the sourcecode of my little
>>>>> example.
>>>>>
>>>>> When trying to compile it cannot find headers like asm/param.h or
>>>>> asm/types.h (because they are not in krnsrc/include/asm-ppc/ and the
>>>>> workaround just added the userspace/libc headers). I guess there must be
>>>>> something wrong with the Makefile, but I cannot find the problem.
>>>> Just add ARCH=ppc to you make command.
>>> ARCH=ppc is already set as environment variable, nevertheless I tried to
>>> compile it using "make ARCH=ppc" and to add it to Makefile's make line.
>>> Still the same Problem.
>> Hm, it works for me. You moved around header files in your kernel 
>> include path. Have you already cleaned up? And add V=1 to the make 
>> command to check the compile command.
> 
> This is a complete new installation of denx ELDK 4.1 and a complete
> fresh kernel, just patched with the adeos patch and compiled, no hacks,
> or workarounds here. I sent the log how I installed everything some
> emails ago.
> 
> Got it, the V=1 told me to make a "make oldconfig && make prepare" in
> the kernel src then I was able to compile it. What ever that made, it
> made it working.

Good, it makes some required header files.

Wolfgang.


