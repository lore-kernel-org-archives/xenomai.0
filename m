Message-ID: <4E8B263E.4070300@domain.hid>
Date: Tue, 04 Oct 2011 17:29:02 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4E8981F9.9090105@domain.hid>
	<4E89AA0F.8020104@domain.hid>	<4E89D5E7.8050106@domain.hid>
	<4E8AED21.7010709@domain.hid>
	<loom.20111004T165835-555@domain.hid>
In-Reply-To: <loom.20111004T165835-555@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] SIGILL when calling pthread_cleanup_push()
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Michael Bernhard <michael.bernhard@domain.hid>
Cc: xenomai@xenomai.org

On 10/04/2011 05:14 PM, Michael Bernhard wrote:
> Gilles Chanteperdrix <gilles.chanteperdrix <at> xenomai.org> writes:
>>
>> On 10/03/2011 05:33 PM, Gilles Chanteperdrix wrote:
>>> On 10/03/2011 02:26 PM, Gilles Chanteperdrix wrote:
>>>> Ok. Thanks for testing xenomai 2.6 by the way. I will try the test
>>>> program on an ARMv5 I have tonight. However, could you tell us a bit
>>>> more about your setup? What toolchain do you use? What threading library?
> We use codesourcery toolchain arm-2010.09. The rootfs was built using PTXdist.
> I think, but have to verify, that NPTL is used as threading library.
> 
>>> And also: is your libc built with iwmmxt support?
> I don't know, but will find out.
> 
>> I can not reproduce this issue on another armv5 I have, but it does not
>> support iwmmxt. So, in order to see if the problem you have comes from
>> iwmmxt, you should try and build a root filesystem with a soft-float
>> toolchain, such as, for instance, the codesourcery toolchain.
>>
>> Currently, iwmmxt floats are not supported with Xenomai, so, if you want
>> to get them working, something will have to be done.
> In the example I gave, no floats were used. Does Xenomai needs to support iwmmxt
> floats also in this case? And would compiling the application with -msoft-float
> do the trick?
> 
> ATM, I'm busy with other things but have time to investigate tomorrow evening. 

The bug happens inside sigsetjmp, which is a routine saving the current
context. So, if the libc is compiled with iwmmmxt support, and more
importantly, if the kernel is compiled with iwmmxt support, sigsetjmp
probably saves the floating point registers.

So another simple thing to try is to disable iwmmxt support in kernel
configuration.

-- 
					    Gilles.

