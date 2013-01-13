Message-ID: <50F239E1.40400@zultron.com>
Date: Sat, 12 Jan 2013 22:36:49 -0600
From: John Morris <john@zultron.com>
MIME-Version: 1.0
References: <50F19CE1.5080106@zultron.com> <50F19DE4.4030805@xenomai.org>
In-Reply-To: <50F19DE4.4030805@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Kernel OOPS during regression tests
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

On 01/12/2013 11:31 AM, Gilles Chanteperdrix wrote:
> On 01/12/2013 06:26 PM, John Morris wrote:
>> 1)  Most worrisome is "kernel BUG at mm/mmap.c:2313!   invalid opcode:
>> 0000 [#2] SMP".  Is this related to HEAPSZ or STACKPOOLSZ?  My mind is
>> getting foggy about all the things I've seen, but it seems like it was
>> happening earlier in the tests until these config values were quadrupled.
> 
> 
> Could you check whether you can reproduce this issue with the I-pipe
> patch for 3.5.7 ? The next xenomai release will be based on this version
> on x86 anyway. Branch for-core-3.5.7 in ipipe-gch.git

Different problem; Xenomai wouldn't start:

  I-pipe: could not find timer for cpu #0

dmesg:
http://www.zultron.com/static/2013/01/xenomai/3.5.7-test/foo-dmesg-3.5.7.log

.config:
www.zultron.com/static/2013/01/xenomai/3.5.7-test/foo-kernel-3.5.7.config

FYI, I found this same problem on two of my systems while testing your
Debian packages.  Both AMD Athlon II 64-bit (one single, one dual core).
 They're about the same generation of motherboards, AM2 or AM2+ socket.
 One is AMD 770 chipset, the other NVidia GeForce 6100 / nForce 430.

Hardware looks similar to Mariusz's in this post, where he had the same
problem:

http://www.xenomai.org/pipermail/xenomai/2012-December/027121.html

He's also running AMD 64-bit on a Gigabyte motherboard, but the next
generation AM3 socket, Phenom CPU, AMD 890 chipset.  I don't have a C1E
BIOS option on these boards to enable/disable.  These same motherboards
don't suffer this problem with mainline Xenomai on 3.5.3.

>> 2)  posix/mprotect is failing:  "FAILURE: sigdebug_handler triggered,
>> reason 2    memory write after exec enable".
> 
> 
> I guess you need Jan's fixes.

Jan's fix is to turn off CONFIG_TRANSPARENT_HUGEPAGE, right?  I'll
report back after a new 3.5.3 kernel is compiled.

>> 3)  FPU warning:  "fptest.h:24: Warning: Linux is compiled to use FPU in
>> kernel-space.    For this reason, switchtest can not test using FPU in
>> Linux kernel-space."
> 
> 
> Well, the warning says it all.

Sorry, I hit 'send' without Googling first.  So, here you say it's
harmless, is that right?

http://www.xenomai.org/pipermail/xenomai-core/2009-05/msg00011.html

	John

