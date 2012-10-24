Message-ID: <50883517.8050709@xenomai.org>
Date: Wed, 24 Oct 2012 20:36:07 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1349212116.21898.108.camel@ENG-09-LX.emacinc.com>	
	<506E9510.7090105@xenomai.org>	
	<1349462858.26881.43.camel@ENG-09-LX.emacinc.com>	
	<506F402A.9030102@xenomai.org>	
	<1349473634.26881.221.camel@ENG-09-LX.emacinc.com>	
	<506F6283.2040901@xenomai.org>	
	<5afa3b9a7c7daf116f8284b4f255227e.squirrel@mail.emacinc.com>	
	<506FFDDC.60104@xenomai.org>	
	<1349816136.25350.426.camel@ENG-09-LX.emacinc.com>	
	<50749349.5070900@xenomai.org>	
	<1350681759.1282.88.camel@ENG-09-LX.emacinc.com>	
	<5081FF74.4010109@xenomai.org>	
	<1350933768.17153.16.camel@ENG-09-LX.emacinc.com>	
	<50859D99.5040009@xenomai.org>	
	<1350934476.17153.20.camel@ENG-09-LX.emacinc.com>	
	<5085B6BC.8060906@xenomai.org>	
	<1351006344.2975.60.camel@ENG-09-LX.emacinc.com>	
	<5086FA29.6010008@xenomai.org>	
	<1351099930.25888.286.camel@ENG-09-LX.emacinc.com>	
	<50882782.50003@xenomai.org>	
	<1351101328.25888.330.camel@ENG-09-LX.emacinc.com>	
	<50882DD0.3030902@xenomai.org>
	<1351103161.25888.344.camel@ENG-09-LX.emacinc.com>
In-Reply-To: <1351103161.25888.344.camel@ENG-09-LX.emacinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Adeos I-Pipe patch problem on vendor-specific kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wayne Warren <wwarren@emacinc.com>
Cc: xenomai@xenomai.org

On 10/24/2012 08:26 PM, Wayne Warren wrote:
>   
>>>
>>> So it looks like maybe __ipipe_tsc_get is working as expected? 
>>
>> Yes, the debugger can not know what is at 0xffff0f40 because the code
>> copied there is not known at compilation (though you can run disass
>> *0xffff0f40, this should work). __ipipe_tsc_register does copy the
>> actual code, but before __ipipe_tsc_register copies the code, the code
>> there simply returns r0 and r1 set to 0.
>>
>> You should try and put a breakpoint at 0xffff040 to see what address is
>> invalid. Maybe the counter virtual address is invalid, or the access to
>> the timer register because the timer is not enabled yet at hardware level.
>>
> 
> disass *0xffff0f40 did not work, "No function contains specified
> address."

Sorry, it is disass /r 0xffff0f20,+0x60

For instance, I have, in user-space, with the I-pipe core for Linux 3.4
on omap3 (where __ipipe_tsc_get shifted a bit), but it should work the
same for the kernel:

(gdb) disass /r 0xffff0ee0,+0x60
Dump of assembler code from 0xffff0ee0 to 0xffff0f40:
   0xffff0ee0:   3b 48 8f 8c    stchi   8, cr4, [pc], {59}      ; 0x3b
   0xffff0ee4:   ec 01 00 00    andeq   r0, r0, r12, ror #3
   0xffff0ee8:   00 00 00 00    andeq   r0, r0, r0
   0xffff0eec:   00 00 00 00    andeq   r0, r0, r0
   0xffff0ef0:   00 00 00 00    andeq   r0, r0, r0
   0xffff0ef4:   00 00 00 00    andeq   r0, r0, r0
   0xffff0ef8:   00 00 00 00    andeq   r0, r0, r0
   0xffff0efc:   28 20 03 fb    blx     0xb8fa6
   0xffff0f00:   0c 00 1f e5    ldr     r0, [pc, #-12]  ; 0xffff0efc
   0xffff0f04:   dc 22 4f e1    ldrd    r2, [pc, #-44]  ; 0xffff0ee0
   0xffff0f08:   00 00 90 e5    ldr     r0, [r0]
   0xffff0f0c:   00 00 52 e1    cmp     r2, r0
   0xffff0f10:   00 10 a3 e2    adc     r1, r3, #0
   0xffff0f14:   1e ff 2f e1    bx      lr
   0xffff0f18:   00 f0 20 e3    nop     {0}
   0xffff0f1c:   00 f0 20 e3    nop     {0}
   0xffff0f20:   00 00 00 00    andeq   r0, r0, r0
   0xffff0f24:   00 00 00 00    andeq   r0, r0, r0
   0xffff0f28:   00 00 00 00    andeq   r0, r0, r0
   0xffff0f2c:   00 00 00 00    andeq   r0, r0, r0
   0xffff0f30:   00 00 00 00    andeq   r0, r0, r0
   0xffff0f34:   00 00 00 00    andeq   r0, r0, r0
   0xffff0f38:   00 00 00 00    andeq   r0, r0, r0
   0xffff0f3c:   00 00 00 00    andeq   r0, r0, r0

The range from 0xffff0ee0 to 0xffff0ef8 is really data, not code.
The hardware timer virtual address is at 0xffff0efc, so it is
0xfb032028
The 64 bits value at 0xffff0ee0 is where __ipipe_tsc_update stored the
value of __ipipe_tsc_get when it was last called.


> 
> So in other words, you are saying that if __ipipe_tsc_register had not
> registered the code, the exception would not occur because it would
> simply set r0 and r1 to 0 then return to the calling function? Just want
> to be certain I understand...
> 
> I did try to put a breakpoint at 0xffff040 (but I think you meant
> 0xfff0f040, i tried both) but then I get "Warning: Cannot insert
> breakpoint 10. Error accessing memory address 0xffff040: Unknown error".

That is where you need *, so, try break *0xffff0f40, yes 0xffff040 was a
typo.

> 
>>>                       
>>>>
>>>> Or apply the following patch:
>>>> http://git.xenomai.org/?p=ipipe-gch.git;a=commitdiff;h=42dd9056983cb6f65b6a336363f2f08f4426625a;hp=3b51cebda0b0d0123cb61b6ec07ecb62f293a528
>>>
>>> I will try this out, thanks!
>>
>> It will probably not fix this issue, but it is better to start from that
>> code anyway.
>>
> 
> Okay, just to be clear are you suggesting that we start all over with
> this patch, merge in the TI changes and our own code, and begin
> debugging again from there?

No, the patch should not have any dependency, so, you should be able to
apply it without any problem.

-- 
					    Gilles.

