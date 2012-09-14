Message-ID: <5053613C.2030301@xenomai.org>
Date: Fri, 14 Sep 2012 18:54:20 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5053404B.9000006@iit.it> <5053493D.3040000@xenomai.org>
	<5053502C.2000900@iit.it>
In-Reply-To: <5053502C.2000900@iit.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] segfault using rt_printf service
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Alessio Margan @ IIT" <alessio.margan@iit.it>
Cc: xenomai <xenomai@xenomai.org>

On 09/14/2012 05:41 PM, Alessio Margan @ IIT wrote:
> On 09/14/2012 05:11 PM, Gilles Chanteperdrix wrote:
>> On 09/14/2012 04:33 PM, Alessio Margan @ IIT wrote:
>>> Hi all,
>>>
>>> I'm switching from xenomai 2.5.6 to 2.6.1 using
>>> adeos-ipipe-2.6.38.8-x86-2.11-01.patch
>>> In this test I have 2 threads :
>>> - rx_udp receive udp packets from dsp boards at 1kHz
>>> - boards_test send udp packets at 1kHz
>>>
>>> I got segfault in printer_loop thread, the point is that if I change env
>>> var RT_PRINT_PERIOD to about 10 or 1000 (default is 100 ms) I do not
>>> have segfault.
>>>
>>> Any suggestion ?
>>>
>>> Program received signal SIGSEGV, Segmentation fault.
>>> [Switching to Thread 0xb7d1ab70 (LWP 5998)]
>>> 0xb7d7cb0c in fwrite () from /lib/i686/cmov/libc.so.6
>>> (gdb) bt
>>> #0  0xb7d7cb0c in fwrite () from /lib/i686/cmov/libc.so.6
>>> #1  0xb7fccbf9 in print_buffers () from /usr/xenomai/lib/libxenomai.so.0
>>> #2  0xb7fcd867 in printer_loop () from /usr/xenomai/lib/libxenomai.so.0
>>> #3  0xb7fb5955 in start_thread () from /lib/i686/cmov/libpthread.so.0
>>> #4  0xb7dec5ee in clone () from /lib/i686/cmov/libc.so.6
>> Since you seem to be able to catch the error with gdb, maybe try and
>> understand the reason for the segfault? The first, quick check, is to
>> type "info register", type cat /proc/pid/maps in another terminal, and
>> check that the stack pointer is in a valid mapping, to check if we do
>> not have a stack overflow.
>>
>> If you fail to find the error, please try and reduce the test program to
>> a simple test case, as simple as needed for the bug to happen and post
>> it on this mailing list, this would allow us to reproduce the issue.
>>
> 
> Thanks ...
> 
> try to learn how to read debug info ...
> here is what I got
> 
> Program received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 0xb7d1ab70 (LWP 1789)]
> 0xb7d7cb0c in fwrite () from /lib/i686/cmov/libc.so.6
> (gdb) info register
> esp            0xb7d1a23c    0xb7d1a23c
> (...)
> b7d14000-b7d1b000 rw-p 00000000 00:00 0
> (...)

So, the stack pointer seems to be in a valid writable mapping, so, valid
for a stack. You can look elsewhere (check the arguments passed to
fwrite for instance, but please send a mail when you have found
something, not at every step).

-- 
					    Gilles.

