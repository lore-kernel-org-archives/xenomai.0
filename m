Message-ID: <54F56C9C.6080507@siemens.com>
Date: Tue, 03 Mar 2015 09:11:08 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <54EEF08B.6040905@triphase.com>
 <20150226102010.GA24003@hermes.click-hack.org>
 <54EF0790.3040607@triphase.com> <54F07AC2.6000902@triphase.com>
 <54F0D46F.1070006@siemens.com>
In-Reply-To: <54F0D46F.1070006@siemens.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xeno3_rc3 - Watchdog detected hard LOCKUP
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Niels Wellens <niels.wellens@triphase.com>, xenomai@xenomai.org

On 2015-02-27 21:32, Jan Kiszka wrote:
> On 2015-02-27 15:10, Niels Wellens wrote:
>>
>>>
>>>>> Hi,
>>>>>
>>>>> Yesterday I installed a Core-i7 based pc (4770 CPU - C226 chipset) with
>>>>> software configuration:
>>>>> - Debian Jessie RC1
>>>>> - kernel 3.16.0-rc7 (.config in attachment)
>>>> Well, please try again with a kernel which is a real release and not
>>>> a release candidate, to rule out any mainline kernel issue.
>>>> -- 
>>>>                         Gilles.
>>>
>>> Thanks Gilles, sorry I overlooked the fact that I was using an rc. The
>>> system is now up and running with an ipipe patched 3.16.0 kernel, I
>>> will let you know if I experience the same issues with this kernel.
>>> -- 
>>> Niels
>>
>> Hi,
>>
>> I experience the same kind of lockup with the ipipe patched 3.16.0
>> kernel (used repo:
>> git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git).
>> I first thought the problem was solved but after more than 20 hours of
>> operation (latency test + dohell load) it occurred again. This afternoon
>> it occurred again after 1 hour of operation (syslog + config file used
>> during kernel build in attachement).
>>
>> Any advice on what to test/change next?
> 
> Your machine gets stuck on a spinlock involved in page allocations, it
> seems. We need to find out who's holding it and why he's not releasing
> it anymore. I'll try to reproduce the issue with your config next week.
> 
> If you want to collect further data: CONFIG_FRAME_POINTER may give
> better backtraces. You could also try to send a <break>l
> (show-backtrace-all-active-cpus) via the serial console to the system.
> Maybe we can get a better pictures that way.

Another thing to try out: Is the bug reproducible for you with otherwise
identical setup when using a recent 3.14 ipipe patch?

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

