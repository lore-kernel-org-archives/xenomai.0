MIME-Version: 1.0
In-Reply-To: <abaf774b0908030135ubddd66ek3591f0ad110e0e5c@domain.hid>
References: <abaf774b0907290133j6c2ec456s7be6c65de6993e3f@domain.hid>
	<4A7023F4.5090103@domain.hid>
	<abaf774b0908030135ubddd66ek3591f0ad110e0e5c@domain.hid>
Date: Mon, 3 Aug 2009 16:19:37 +0100
Message-ID: <abaf774b0908030819l724f619at46b940eea7af6e18@domain.hid>
From: Steve <sbxenomai@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Setup LTTng with Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

On 03/08/2009, Steve <sbxenomai@domain.hid> wrote:
> On 29/07/2009, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>> Steve wrote:
>>> Hi,
>>>
>>> I've been looking into using LTTng with Xenomai and each time I try to
>>> find more information I find a different post with new links to
>>> various patches and websites.  The most recently dated information
>>> that I have found is 24th Feb 2009:
>>>
>>> https://mail.gna.org/public/adeos-main/2009-02/msg00031.html
>>>
>>> Is this the latest info, and is 'git.kiszka.org' the best source for
>>> LTTng - Adeos combinations?
>>
>> For x86? Yes, for sure. :)
>>
>> Just note that I haven't updated my lttng tree with latest ipipe fixes
>> for 2.6.29 yet. So I would recommend to merge/cherry-pick the changes
>> found in queues/2.6.29-noarch and queues/2.6.29-x86 into your lttng
>> clone.
>>
>>>
>>> Also, I have tried to apply the Xenomai patch given by the link in the
>>> above post, the one at:
>>>
>>> http://permalink.gmane.org/gmane.linux.real-time.xenomai.devel/6009
>>>
>>> However, this does not work on my copy of Xenomai (2.4.8) - which
>>> version of Xenomai was the patch designed for, and is there a more
>>> recent patch for 2.4.8 (or am I doing something wrong)?
>>
>> That patch was written against the 2.5 development tree. You likely have
>> to resolve the conflicts manually and furthermore fix remaining
>> trace_mark invocations that changed between 2.4 and 2.5.
>>
>>>
>>> Finally, once I have the linux kernel tree with lttng and adeos (from
>>> kiszka.org), and the patched Xenomai (using the patch from gmane.org),
>>> I assume that I then prepare the kernel using Xenomai in the normal
>>> fashion (omitting the adeos patch because it is already applied), and
>>
>> Yep.
>>
>>> then I can configure and compile the kernel as normal.  Is this
>>> correct?
>>
>> Yep. Just additionally enabled the LTTng support in the kernel config.
>>
>>>
>>> Thanks in advance for any help that you can give,
>>>
>>> Steve
>>
>> Jan
>>
>> --
>> Siemens AG, Corporate Technology, CT SE 2
>> Corporate Competence Center Embedded Linux
>>
>
> As a test I grabbed lttng-ipipe-2.6.28-x86-2.2-06.patch snapshot from
> git.kiszka.org, and the Xenomai 2.5-rc2 tar (which already has the
> patch from gmane.org applied).  I then prepared the kernel in the
> snapshot with Xenomai 2.5-rc2, and updated the kernel .config file to
> enable LTTng, plus some other options that allowed it to boot (my
> computer needed some kernel modules that Jan's computer obviously does
> not).
>
> After booting into the new kernel I deleted, rebuild and reinstalled
> the /usr/xenomai files, and then rebuilt my code.  I have since
> encountered a problem when running the code that may be caused by
> differences between 2.4.8 and 2.5-rc2, so I would like to know if this
> is the case:
>
> The program first loads various modules using dlopen, and during this
> process the following error is thrown:
>
> librtdm.so.1: shared object cannot be dlopen()ed
>
> After some investigation I tried reconfiguring the /usr/xenomai files
> by calling:
>
> xenomai-src-dir/configure --enable-dlopen-skins
>
> When I ran the program again I got a glibc error after the program had
> finished the loading / opening process and should have been waiting
> for input:
>
> *** glibc detected *** ProgramName: double free or corruption
> (fasttop): 0x080517f8 ***
> ======= Backtrace: =========
> /lib/tls/i686/cmov/libc.so.6[0xb7a91a85]
> /lib/tls/i686/cmov/libc.so.6(cfree+0x90) [0xb7a954f0]
> /usr/lib/libstdc++.so.6(_ZdlPv+0x21) [0xb7c5cb11]
> ProgramName[0x8049e73]
> /lib/tls/i686/cmov/libc.so.6(__libc_start_main+0xe0) [0xb7a3c450]
> ProgramName(__gxx_personality_v0+0xbd) [0x80498a1]
>
> Any ideas as to why this is happening?
>
> Steve
>

On further inspection it appears that the glibc detected error is
caused by entry into a usually unreachable section of code, which I
had not realised was faulty and have now fixed.  This faulty
code was reached was due to sem_wait() failing (with an EPERM error)
where it has not failed before, so I am now investigating this.

