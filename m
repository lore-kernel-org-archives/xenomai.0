Message-ID: <511E2846.8040206@xenomai.org>
Date: Fri, 15 Feb 2013 13:21:26 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <511B94E4.2070708@mediso.hu> <511B9901.7040104@xenomai.org>
	<511BB60E.7090900@mediso.hu> <511BCA3E.4050705@xenomai.org>
	<511C989C.7070700@mediso.hu>
In-Reply-To: <511C989C.7070700@mediso.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Floating point operations in kernel on powerpc
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Norbert Bukuli <norbert.bukuli@mediso.hu>
Cc: xenomai@xenomai.org

On 02/14/2013 08:56 AM, Norbert Bukuli wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Dear Mr Gerum,
>
> let me respond your letter below.
>
> On 2013-02-13 18:15, Philippe Gerum wrote:
>> On 02/13/2013 04:49 PM, Norbert Bukuli wrote:
>>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>>>
>>> Dear Mr Gerum,
>>>
>>> thank you for your kind answer. As you can see in the example
>>> code I do not call explicitly either _savefpr_XX or
>>> rthal_save_fpu and their restore counterparts. I only do some
>>> floating point operations in a Xenomai domain kernel thread.
>>> However the linker misses the routines mentioned earlier. Are
>>> there linker flags to change this behaviour? One important note,
>>> in the kernel configuration the hardware FPU support is switched
>>> on. (CONFIG_XENO_HW_FPU=y)
>>
>> -msoft-float with hw FPU looks suspicious.
> - -msoft-float is defined by the kernel's make system, but if you read
> the line further you can see, that I set the -mhard-float compiler flag.
>
> I don't understand why you
>> mention C runtime libraries when building kernel modules either.
> It is probably my bad english, sorry for that.
> I mentioned the c runtime library, because there is a file a kernel
> source: arch/powerpc/lib/crtsavres.S
> One can see in this file: "Based on gcc/config/rs6000/crtsavres.asm
> from gcc".
>
>> Building with eldk 5.2.1 for fpu-enabled 6xx cores can be done
>> with
>> eldk-5.2.1/powerpc/sysroots/i686-eldk-linux/usr/bin/powerpc-linux/powerpc-linux-gcc
>>
>>
> from a stock eldk install.
> I use eldk-switch for set the environmental variables corresponding to
> the ELDK toolchain, and I use exactly the same compiler:
> $ eldk-switch -r 5.2.1 powerpc
> $ which powerpc-linux-gcc
> /opt/eldk-5.2.1/powerpc/sysroots/i686-eldk-linux/usr/bin/powerpc-linux/powerpc-linux-gcc
>
>>
>> Actually, running fpu code in kernel space is a bad idea in the
>> first place. Xenomai supports this for desperate situations when
>> porting relic code absolutely requires it, but this is clearly
>> something that should be avoided. You should really consider moving
>> all that stuff to userland if the situation is not that desperate.
>>
>
> Yes, I know, that is what we are working on. As I wrote it in my first
> letter, we should port our application to Xenomai and run it in userspace.
>

No, this does not look like so, which is exactly what makes your 
questions quite confusing. You talk about porting to userland, and keep 
building kernel modules, which does not make much sense.

Meanwhile, I tried your test project, and successfully compiled it, 
which was expected reading the code:

{rpm@cobalt} make ARCH=powerpc CROSS_COMPILE=powerpc-linux- 
KSRC=$HOME/git/ipipe modules
make -C /home/rpm/git/ipipe M=/home/rpm/foo/4951215 modules
make[1]: Entering directory `/home/rpm/git/ipipe'
   CC [M]  /home/rpm/foo/4951215/fpu_test.o
In file included from /home/rpm/foo/4951215/fpu_test.c:4:0:
include/xenomai/native/task.h: In function 'rt_task_spawn':
include/xenomai/native/task.h:319:5: warning: 'rt_task_create' is 
deprecated (declared at include/xenomai/native/task.h:252) 
[-Wdeprecated-declarations]
/home/rpm/foo/4951215/fpu_test.c: In function 'fpu_test_init':
/home/rpm/foo/4951215/fpu_test.c:28:2: warning: 'rt_task_create' is 
deprecated (declared at include/xenomai/native/task.h:252) 
[-Wdeprecated-declarations]
   Building modules, stage 2.
   MODPOST 1 modules
   CC      /home/rpm/foo/4951215/fpu_test.mod.o
   LD [M]  /home/rpm/foo/4951215/fpu_test.ko
make[1]: Leaving directory `/home/rpm/git/ipipe'

So, as a matter of fact, I don't know where the problem could be, since 
I see no code those helpers could be referenced from.

-- 
Philippe.

