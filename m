Message-ID: <51388DD2.2020805@mitrol.it>
Date: Thu, 07 Mar 2013 13:53:38 +0100
From: Paolo Minazzi <Paolo.Minazzi@mitrol.it>
MIME-Version: 1.0
References: <51372B12.2030400@mitrol.it> <51373149.4050700@xenomai.org>
	<5137370B.2050402@mitrol.it> <51373841.70704@xenomai.org>
	<51385910.80203@mitrol.it> <51388A3A.2090004@xenomai.org>
In-Reply-To: <51388A3A.2090004@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Sporadic problem : rt_task_sleep locked after
	debugging
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Il 07/03/2013 13.38, Gilles Chanteperdrix ha scritto:
> On 03/07/2013 10:08 AM, Paolo Minazzi wrote:
>
>> Il 06/03/2013 13.36, Gilles Chanteperdrix ha scritto:
>>> On 03/06/2013 01:31 PM, Paolo Minazzi wrote:
>>>
>>>> Il 06/03/2013 13.06, Gilles Chanteperdrix ha scritto:
>>>>> On 03/06/2013 12:40 PM, Paolo Minazzi wrote:
>>>>>
>>>>>> I can generate the problem only debugging with gdb, otherwise there is
>>>>>> no problem.
>>>>>>
>>>>>> Can you help me to undertand what happen ?
>>>>>> Have you got an idea ? do you need other information ?
>>>>> In case it is something which was fixed since Xenomai 2.5.6, could you
>>>>> try Xenomai 2.6.2.1?
>>>>>
>>>> I have not done the port.
>>>> This work is done by an external firm.
>>>> I know well enough the linux kernel, but very very little the xenomai
>>>> internals.
>>> You can use Xenomai 2.6.2.1 with the same version of the I-pipe kernel,
>>> and the I-pipe kernel is the only thing which needs to be ported.
>>>
>>>> I could try ... but it is not easy ....
>>> It should be as easy as:
>>> - keep your kernel patched with the I-pipe patch
>>> - download the newest version of Xenomai, that is 2.6.2.1
>>> - follow the installation instructions, here:
>>> http://www.xenomai.org/documentation/xenomai-2.6/html/README.INSTALL/
>>>
>>>> The problem appear only using gdb .... any ideas ?
>>> Could be the timer programmed for a too short delay, could be something
>>> we already fixed, could be a new bug... Really, testing rapidly the last
>>> version will make us win a lot of time if this is an issue already fixed.
>>>
>>>
>> I Gilles,
>> I have ported to 2.6.1 without problems.
>> To 2.6.2 and 2.6.2.1 I need to add a gcc built-in. My compiler is
>
> pass --with-atomic-ops=ad-hoc to configure script, this will avoid the
> builtins.
>
>> gcc-4.3.2 and does not have some built-in atomic function.
>> After this I need to change the switch.S because my assembler cannot
>
> switch.S has been compiling for ages, way before gcc 4.4. Could you show
> me the warning you get?
>
>> compile it. Maybe a newer compiler (gcc>= 4.4) could solve all these
>> problems, but for me this is not a valid solution because other
>> developers of us use a cygwin compiler. We should built a new cygwin
>> compiler ... the libs will be different and so I will have problem with
>> shared libraries .... too complex to solve a sporadic bug using gdb ....
>> I can try to see the 2.6.1.
>
> The idea of asking you to try 2.6.2.1 is not to ask you to switch to it,
> but simply to do a quick test to see if you can reproduce the issue.
>
>

   CC      drivers/xenomai/testing/switchtest.o
   CC      drivers/xenomai/testing/timerbench.o
   LD      drivers/xenomai/testing/xeno_timerbench.o
   LD      drivers/xenomai/testing/xeno_switchtest.o
   LD      drivers/xenomai/testing/built-in.o
   LD      drivers/xenomai/built-in.o
   LD      drivers/built-in.o
   CC      arch/arm/xenomai/hal.o
   AS      arch/arm/xenomai/switch.o
/home/axel/MarvellEnv/BuildLinux/linux-2.6.31.8/arch/arm/xenomai/switch.S: 
Assembler messages:
/home/axel/MarvellEnv/BuildLinux/linux-2.6.31.8/arch/arm/xenomai/switch.S:156: 
Error: bad instruction `arm( stmia ip!,{r4-sl,fp,sp,lr})'
/home/axel/MarvellEnv/BuildLinux/linux-2.6.31.8/arch/arm/xenomai/switch.S:157: 
Error: bad instruction `thumb( stmia ip!,{r4-sl,fp})'
/home/axel/MarvellEnv/BuildLinux/linux-2.6.31.8/arch/arm/xenomai/switch.S:158: 
Error: bad instruction `thumb( str sp,[ip],#4)'
/home/axel/MarvellEnv/BuildLinux/linux-2.6.31.8/arch/arm/xenomai/switch.S:159: 
Error: bad instruction `thumb( str lr,[ip],#4)'
/home/axel/MarvellEnv/BuildLinux/linux-2.6.31.8/arch/arm/xenomai/switch.S:170: 
Error: bad instruction `arm( add r4,r2,#28)'
/home/axel/MarvellEnv/BuildLinux/linux-2.6.31.8/arch/arm/xenomai/switch.S:171: 
Error: bad instruction `arm( ldmia r4,{r4-sl,fp,sp,pc})'
/home/axel/MarvellEnv/BuildLinux/linux-2.6.31.8/arch/arm/xenomai/switch.S:172: 
Error: bad instruction `thumb( add ip,r2,#28)'
/home/axel/MarvellEnv/BuildLinux/linux-2.6.31.8/arch/arm/xenomai/switch.S:173: 
Error: bad instruction `thumb( ldmia ip!,{r4-sl,fp})'
/home/axel/MarvellEnv/BuildLinux/linux-2.6.31.8/arch/arm/xenomai/switch.S:174: 
Error: bad instruction `thumb( ldr sp,[ip],#4)'
/home/axel/MarvellEnv/BuildLinux/linux-2.6.31.8/arch/arm/xenomai/switch.S:175: 
Error: bad instruction `thumb( ldr pc,[ip])'
make[2]: *** [arch/arm/xenomai/switch.o] Error 1
make[1]: *** [arch/arm/xenomai] Error 2
make: *** [sub-make] Error 2



**************************************
arm-mv5sft-linux-gnueabi-gcc -v
**************************************
Using built-in specs.
Target: arm-mv5sft-linux-gnueabi
Configured with: /home/seugene/sdk/targets/src/gcc-4.3.2/configure 
--build=i486-build_pc-linux-gnu --host=i486-build_pc-linux-gnu 
--target=arm-mv5sft-linux-gnueabi 
--prefix=/home/seugene/sdk/targets/arm-mv5sft-linux-gnueabi/cross 
--with-sysroot=/home/seugene/sdk/targets/arm-mv5sft-linux-gnueabi/cross/arm-mv5sft-linux-gnueabi//sys-root 
--enable-languages=c,c++,fortran,java --disable-multilib 
--with-arch=armv5te --with-float=soft 
--with-gmp=/home/seugene/sdk/targets/arm-mv5sft-linux-gnueabi/cross 
--with-mpfr=/home/seugene/sdk/targets/arm-mv5sft-linux-gnueabi/cross 
--with-pkgversion=sdk3.2rc1-ct-ng-1.4.1 --disable-sjlj-exceptions 
--enable-__cxa_atexit 
--with-local-prefix=/home/seugene/sdk/targets/arm-mv5sft-linux-gnueabi/cross/arm-mv5sft-linux-gnueabi//sys-root 
--disable-nls --enable-threads=posix --enable-symvers=gnu --enable-c99
--enable-long-long --enable-target-optspace
Thread model: posix
gcc version 4.3.2 (sdk3.2rc1-ct-ng-1.4.1)


**************************************
arm-mv5sft-linux-gnueabi-as -v
**************************************
GNU assembler version 2.18.50 (arm-mv5sft-linux-gnueabi) using BFD 
version (GNU Binutils) 2.18.50.20080215

Thanks
Paolo


