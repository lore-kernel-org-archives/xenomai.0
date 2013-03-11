Message-ID: <513E5AB9.3060203@crubille.lautre.net>
Date: Mon, 11 Mar 2013 23:29:13 +0100
From: Paul <paul@crubille.lautre.net>
MIME-Version: 1.0
References: <512BFD9E.5010501@crubille.lautre.net>
	<512BE5A2.3090505@xenomai.org>
	<513DA0B5.5060304@crubille.lautre.net>
	<513D8C24.4010009@xenomai.org>
In-Reply-To: <513D8C24.4010009@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Linux port to ARM Allwinner A13
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hello Gilles,

On 11/03/2013 08:47, Gilles Chanteperdrix wrote:
> On 03/11/2013 10:15 AM, Paul wrote:
>
>> Hello,
>>
>> Here are pre and post patch for xenomai on sun5i (allwinner A13). It
>> should work for sun4i (allwinner A10) too, but is not tested for this
>>   proc.
>>
>> The tested kernels are
>>
>> wget
>> https://github.com/linux-sunxi/linux-sunxi/archive/sunxi-v3.4.24-r1.tar.gz
>>
>>
>
> and
>
>> wget
>> https://github.com/linux-sunxi/linux-sunxi/archive/sunxi-v3.4.24-r2.tar.gz
>
>
>
> Fine,
>
>
> but the pre patch touches a lot of things which I believe it
> should not be touching, like entry.S.
>
> Is it because your patch is based on 3.2.24 and not 3.2.21? If that is
> the case, the post patch should undo the changes made by the pre patch.

The patch is based on 3.4.24 and the ipipe patch is noted to be a 3.4.6, 
but there is no such kernel for the sunxi.
So most of the patch fail are from the different linux version but 
curiously, vfp/entry.S are differents in the sunxi3.4.24 and in the 
vanill3.4.24..

>
> The coding style you use is not really the kernel coding style, see:
> Documentation/CodingStyle
OK, I would do it.
>
> For sunxi_enable_irqdesc/sunxi_disable_irqdesc, you could use a switch
> case, or even better, define a macro SW_INT_SRCPRIO_REG(n) that gives
> the address of the nth register, and avoid the ifs completely.
strange, but i copy/paste this part of code from the sunxi part (and 
found that bad):
My first idea was to mask, shift and use the result as index in a 
register index.
To stay close to the actual style, ok to use switch (it is not a so 
performance critical part).
>
> You do not need to manually call enable_irqdesc for the timer irq, it
> should be called automatically. Maybe your problem is that your
> "pic_muter_init" function is called too late, if that is the case, you
> should call it in the function which declares the Linux timer, this one
> should be called early enough.
I add this in an attempt to solve a problem which have nothing to do 
with it, and it stay here.
To be removed.
>
> ipipe_ns_delay is ugly, you  can probably get away much more simply with
> ipipe_tsc_get, or can not you simply wait for a PLL lock bit or
> somehting? If you want to maintain ipipe_ns_delay, plase call it
> ipipe_mach_something, and fix the coding style.
I dont know about ipipe_tsc_get, so i will test with it.
>
> Please avoid dead code, and C++ comments. And the cartouches.


FROM THE FOLLOWING MAIL:
> Also, you seem to have duplicated the timer code, this should not be
> needed, right?
The initialisation is very close, but i think the linux-sunxi 
timer_set_mode is broken.




