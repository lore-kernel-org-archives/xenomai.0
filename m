Message-ID: <50F38DD5.5010105@zultron.com>
Date: Sun, 13 Jan 2013 22:47:17 -0600
From: John Morris <john@zultron.com>
MIME-Version: 1.0
References: <50F19CE1.5080106@zultron.com> <50F19DE4.4030805@xenomai.org>
	<50F239E1.40400@zultron.com> <50F2A59D.5050600@xenomai.org>
	<50F30781.3050302@zultron.com> <50F30DE5.7030007@xenomai.org>
In-Reply-To: <50F30DE5.7030007@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] 3.5.7 posix/mprotect failure;
 "I-pipe: could not find timer" fixed!
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 01/13/2013 01:41 PM, Gilles Chanteperdrix wrote:
> On 01/13/2013 08:14 PM, John Morris wrote:
> 
>> Hi Gilles and Jan,
>>
>> Note change of thread subject.  I'm starting to get confused.
>>
>> On 01/13/2013 06:16 AM, Gilles Chanteperdrix wrote:
>>> On 01/13/2013 05:36 AM, John Morris wrote:
>>>
>>>> On 01/12/2013 11:31 AM, Gilles Chanteperdrix wrote:
>>>>> On 01/12/2013 06:26 PM, John Morris wrote:
>>>>>> 1)  Most worrisome is "kernel BUG at mm/mmap.c:2313!   invalid opcode:
>>>>>> 0000 [#2] SMP".  Is this related to HEAPSZ or STACKPOOLSZ?  My mind is
>>>>>> getting foggy about all the things I've seen, but it seems like it was
>>>>>> happening earlier in the tests until these config values were quadrupled.
>>>>>
>>>>>
>>>>> Could you check whether you can reproduce this issue with the I-pipe
>>>>> patch for 3.5.7 ? The next xenomai release will be based on this version
>>>>> on x86 anyway. Branch for-core-3.5.7 in ipipe-gch.git
>>>>
>>>> Different problem; Xenomai wouldn't start:
>>>>
>>>>   I-pipe: could not find timer for cpu #0
>>>>
>>>> dmesg:
>>>> http://www.zultron.com/static/2013/01/xenomai/3.5.7-test/foo-dmesg-3.5.7.log
>>>>
>>>> .config:
>>>> www.zultron.com/static/2013/01/xenomai/3.5.7-test/foo-kernel-3.5.7.config
>>>>
>>>> FYI, I found this same problem on two of my systems while testing your
>>>> Debian packages.  Both AMD Athlon II 64-bit (one single, one dual core).
>>>>  They're about the same generation of motherboards, AM2 or AM2+ socket.
>>>>  One is AMD 770 chipset, the other NVidia GeForce 6100 / nForce 430.
>>>>
>>>> Hardware looks similar to Mariusz's in this post, where he had the same
>>>> problem:
>>>>
>>>> http://www.xenomai.org/pipermail/xenomai/2012-December/027121.html
>>>>
>>>> He's also running AMD 64-bit on a Gigabyte motherboard, but the next
>>>> generation AM3 socket, Phenom CPU, AMD 890 chipset.  I don't have a C1E
>>>> BIOS option on these boards to enable/disable.  These same motherboards
>>>> don't suffer this problem with mainline Xenomai on 3.5.3.
>>>
>>>
>>> If you had the same problem as Marius, you would have seen it with
>>> 3.5.3, and you would get the message in the dmesg about C1E, so, it is
>>> probably something else. 
>>
>> Yes, I'm definitely getting confused.  I did see the same problem with
>> C1E, but only while running your 3.5.7 .debs, and not in the 3.5.7 el6
>> packages that are the main subject of this sub-thread:
>>
>> http://www.zultron.com/static/2013/01/xenomai/3.5.7-deb-gilles/dmesg-3.5.7-deb-gilles.log
> 
> 
> Ah, that is because I rebased the I-pipe tree in between, and at some
> point the code printing the message was wrong (ATOMIC_INIT(0) instead of
> ATOMIC_INIT(-1)). That is my fault then, sorry.
> 
>>
>>> Could you run
>>>
>>> cat /proc/timer_list
>>
>> Back to el6 again, 3.5.7 i-pipe:
>>
>> http://www.zultron.com/static/2013/01/xenomai/3.5.7-test/foo-cat-proc-timer_list-3.5.7-test.log
> 
> 
> The LAPIC is definitely up and running (mode: 3). So, it probably means
> that the erratum detection is not sufficient to decide not to use a
> LAPIC. Checking your logs, we see:
> 
> using AMD E400 aware idle routine
> 
> which means the LAPIC could potentially be unusable, but the idle
> routine also checks for a bit in a K8 specific MSR and prints the message:
> 
> System has AMD C1E enabled
> 
> If this bit is set, and in your case the message is not printed so the
> bit is not set. So, the LAPIC is usable, but due to the changes I made
> to try and print a message in Marius case, I broke the detection in your
> case.
> 
> I have just pushed a rework for this commit in the for-core-3.5.7 branch
> in ipipe-gch git.

And it worked, no more C1E error!  Thanks!

It looks like the AMD-64 AM2/AM2+ socket CPUs were the last generation
without C1E, and the AM3 socket CPUs were the first gen with.

Back to the original problem, the posix/mprotect problem is confirmed to
be in this branch:

  ++ /usr/lib64/xenomai/regression/posix/mprotect
  memory read
  FAILURE: sigdebug_handler triggered, reason 2
  memory write after exec enable

Regression test run:
http://www.zultron.com/static/2013/01/xenomai/3.5.7-test/foo-xeno-regression-test-3.5.7-test.log

Dmesg:
http://www.zultron.com/static/2013/01/xenomai/3.5.7-test/foo-dmesg-3.5.7.log

Kernel .config:
http://www.zultron.com/static/2013/01/xenomai/3.5.7-test/foo-kernel-3.5.7.config.txt

To minimize confusion (esp. my own) and answer Jan's question, this is
Gilles's ipipe-gch/for-core-3.5.7 kernel (20130113git08f0596) with
xenomai master (20130113git210ed428) and standard xenomai kernel options
from the wiki, plus CPUMASK_OFFSTACK of course.

	John

