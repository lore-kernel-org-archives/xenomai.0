References: <CAJqUr7ybpmgOev-iPaQ-iMEAF8SBocn54vyYSbLcm9spMY=FBg@mail.gmail.com>
 <55DC76C7.5040606@xenomai.org>
 <CAJqUr7xc4C97XpP31tK7HLj03k=_FUQQFmX_38Bm8ejNUYBo2A@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <55DCB5A8.8020503@siemens.com>
Date: Tue, 25 Aug 2015 20:36:24 +0200
MIME-Version: 1.0
In-Reply-To: <CAJqUr7xc4C97XpP31tK7HLj03k=_FUQQFmX_38Bm8ejNUYBo2A@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai/ipipe arm64 port
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Don Mahurin <don@mperpetuo.com>, Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 2015-08-25 20:05, Don Mahurin wrote:
>>> Smokey tests:
>>>
>>> 3.10/rc6 smokey tests all pass
>>> 3.14/rc6 smokey tests all pass
>>> 3.14/rc7 smokey tests sched-quota and sched-tp fail
>>>
>>
>> This is likely because -rc7 has added checks to sched-* tests which have
>> time-dependent results, so they may not match the expected value in a
>> qemu-based execution.
>>
> 
> Would it be worthwhile to optionally disable the time-dependent nature of
> the tests, just for use in quick/automated emulator testing?
> 

I was wondering the same recently because tests also break in KVM on
x86, my preferred target for ad-hoc tests.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

