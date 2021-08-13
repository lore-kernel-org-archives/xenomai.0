Subject: Re: [PATCH] Add --disable-{demo,testsuite} options
References: <20210813081254.1904938-1-fontaine.fabrice@gmail.com>
 <86057dfa-d2ed-1932-db29-4608edb08865@siemens.com>
 <CAPi7W82Y3abvah-T05oFF16GB4KzFm7=zmc594h5YWyDpRsn9Q@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <e09595f5-1932-c2ff-5ba4-30a3d2a54373@siemens.com>
Date: Fri, 13 Aug 2021 16:29:08 +0200
MIME-Version: 1.0
In-Reply-To: <CAPi7W82Y3abvah-T05oFF16GB4KzFm7=zmc594h5YWyDpRsn9Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Fabrice Fontaine <fontaine.fabrice@gmail.com>
Cc: xenomai@xenomai.org

On 13.08.21 15:17, Fabrice Fontaine wrote:
> Le ven. 13 août 2021 à 10:54, Jan Kiszka <jan.kiszka@siemens.com> a écrit :
>>
>> On 13.08.21 10:12, Fabrice Fontaine via Xenomai wrote:
>>> Allow the user to disable demo and testsuite to avoid the following
>>> build failures on arc and riscv32:
>>
>> Are you working on ports to those archs? Or is xenomai userland just
>> prematurely built for those in buildroot?
> No, I'm not working on ports to those archs. I just sent this patch to
> fix buidlroot autobuilder failures. I'm not even an expert in xenomai.
> In buildroot, we allow to build xenomai userland on all architectures.
> The only requirement on the toolchain is that it must have threads,
> sync and must be uclibc or glibc:
> https://git.buildroot.net/buildroot/commit/package/xenomai/Config.in?id=c35f157486431eafdb8d3583fc52d8ce4c784cf3.
> In cobalt core, we're restricting the architectures to x86, powerpc and ARM.

Ah, ok, these are mercury userland builds. Makes more sense now.

>>
>>>
>>> latency.c: In function 'display':
>>> latency.c:326:21: error: format '%ld' expects argument of type 'long int', but argument 2 has type 'time_t' {aka 'long long int'} [-Werror=format=]
>>>   326 |         ("RTT|  %.2ld:%.2ld:%.2ld  (%s, %Ld us period, "
>>>       |                 ~~~~^
>>>       |                     |
>>>       |                     long int
>>>       |                 %.2lld
>>>   327 |          "priority %d)\n", dt / 3600,
>>>       |                            ~~~~~~~~~
>>>       |                               |
>>>       |                               time_t {aka long long int}
>>>
>>> altency.c: In function ‘display’:
>>> altency.c:262:21: error: format ‘%ld’ expects argument of type ‘long int’, but argument 2 has type ‘time_t’ {aka ‘long long int’} [-Werror=format=]
>>>   262 |         ("RTT|  %.2ld:%.2ld:%.2ld  (%s, %Ld us period, "
>>>       |                 ~~~~^
>>>       |                     |
>>>       |                     long int
>>>       |                 %.2lld
>>>   263 |          "priority %d)\n", dt / 3600,
>>>       |                            ~~~~~~~~~
>>>       |                               |
>>>       |                               time_t {aka long long int}
>>>
>>
>> How about fixing those issues instead?
> Indeed, fixing those issues would be great. I'll let you handle that.

I wouldn't mind getting patches as well. ;)

> However, I also think that disabling demo and testsuite is a nice
> addition as it will decrease compile time and save disk space.

I don't disagree. I just don't like merging a feature with the argument
"this works around a bug". If you resend with adjusted reasoning, I'm
fine with merging the functional changes.

But then I would still not use that to address the above errors...

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

