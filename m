Subject: Re: Xeno3-x86: system freezes with SEGFAULT
References: <89a388f9-f30b-59d5-7a6f-e46026793089@tin.it>
 <66468230-c49a-c0e3-2687-90fe6c7d49e7@siemens.com>
From: "Mauro S." <mau.salvi@tin.it>
Message-ID: <29dce262-d3d4-f2e9-38f5-7b872912e367@tin.it>
Date: Fri, 2 Jul 2021 11:25:03 +0200
MIME-Version: 1.0
In-Reply-To: <66468230-c49a-c0e3-2687-90fe6c7d49e7@siemens.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: it-IT
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

Il 01/07/21 08:38, Jan Kiszka ha scritto:
> On 28.06.21 16:33, Mauro S. via Xenomai wrote:
>> Hi all,
>>
>> I'm using Xenomai3 (master branch, commit
>> d98c99798836dd3571144203b51ff787d2108f1b) on a X86_64bit Intel Atom
>> x5-E8000 with 2GB RAM, using kernel from Xenomai repos, in Cobalt
>> coniguration.
>> Just for completeness, I'm using a Yocto built filesystem (but I think
>> it doesn't matter to the issue that I'm going to describe).
>>
>> Consider the simple test program attached: it creates 120 tasks that
>> does nothing than sleep. This test is compiled with the Yocto toolchain
>> using the attached makefile. Toolchain have Xenomai installed in.
>>
>> (By the way, I needed to raise to 2048 the registry slots number in
>> kernel configuration: without raising this, I cannot create more than
>> 110 tasks.)
>>
>> If I kill this program with TERM signal, sighandler does its work and
>> the application exits cleanly.
>>
>> If I kill this application with SEGV signal (no custom sighandler
>> installed), system freezes.
>>
>> If I build this application with 50 tasks, then SEGV does not cause
>> system to freeze.
>>
>> Bisecting the number of tasks, SIGSEGV freezes starts with a number of
>> tasks greater than 85.
>>
>> I enabled watchdog (and almost all of the debug options) in Xenomai
>> section of the kernel configuration, without success.
>>
>> Are there some system limits? I checked under /proc/xenomai but all
>> seems to be OK.
>>
>> Thanks in advance, regards
>>
> 
> Just reproduced over ipipe-core-5.4.124-x86-5: We are running into [1].
> That is an architectural limitation of I-pipe that bit me a couple of
> times in the past as well. You can shift that limit by increasing
> WORKBUF_SIZE [2]. For you test case, using 4K was enough to get over the
> hill. This is rather unhandy, no question.
> 
> The good news is: Dovetail with kernel 5.10+ is not affected by this
> limitation anymore.
> 
> Jan
> 
> [1]
> https://source.denx.de/Xenomai/ipipe-x86/-/blob/ipipe-x86-5.4.y/kernel/ipipe/core.c#L2030
> [2]
> https://source.denx.de/Xenomai/ipipe-x86/-/blob/ipipe-x86-5.4.y/kernel/ipipe/core.c#L74
> 


Hi Jan,

thank you very much for your fast answer and for the patch.

Is there a upper limit on WORKBUF_SIZE value to consider?

Thanks again, regards

-- 
Mauro S.


