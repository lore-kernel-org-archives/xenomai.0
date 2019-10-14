Subject: Re: running xenomai through scan-build or: some 100 issues with
 static code analysis
References: <CADYdroOdDNumXRbjFu20UpJkHH8S7W0xMHRzRpiWpk+_0PZHJw@mail.gmail.com>
 <fd1615a6-2dbd-2b4a-a057-80cab4f8e245@siemens.com>
 <VI1PR05MB5917DBA01B2CC40352EDCFA2F6900@VI1PR05MB5917.eurprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c8a653c4-0e8c-a3f9-42c5-f3caa5640a79@siemens.com>
Date: Mon, 14 Oct 2019 12:08:49 +0200
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB5917DBA01B2CC40352EDCFA2F6900@VI1PR05MB5917.eurprd05.prod.outlook.com>
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
To: Lange Norbert <norbert.lange@andritz.com>, Xenomai <xenomai@xenomai.org>

Readding the list.

On 14.10.19 11:36, Lange Norbert wrote:
>> -----Original Message-----
>> From: Xenomai <xenomai-bounces@xenomai.org> On Behalf Of Jan Kiszka
>> via Xenomai
>> Sent: Montag, 14. Oktober 2019 08:26
>> To: Norbert Lange <nolange79@gmail.com>; Xenomai
>> <xenomai@xenomai.org>
>> Subject: Re: running xenomai through scan-build or: some 100 issues with
>> static code analysis
>>
>> NON-ANDRITZ SOURCE: BE CAUTIOUS WITH CONTENT, LINKS OR
>> ATTACHMENTS.
>>
>>
>> On 13.10.19 21:49, Norbert Lange via Xenomai wrote:
>>> Hello,
>>>
>>> I did run some static analysis tools over xenomai 3.1rc2 userspace
>>> libraries, and there seems to be alot of real issues.
>>>
>>> The tools are clangs builtin statical analysis and clang-tidy,
>>> naturally there is some overlap in the reports.
>>> clang-tidy would need to be configured to fit Xenomai's practices
>>> (there is a ton of configurable checks), so this is more of an example.
>>> The other, clang's statical analysis is more relevant as there are
>>> very few false positives.
>>>
>>> Additionally to the checks, there is a directory failures, files that
>>> cant be built with clang. Even if no one ships Xenomai built by that
>>> compiler, fixing those should help, for being able to run those tools
>>> and several IDE's and Editors already use clangd for code competition etc.
>>>
>>> I'd hope that such reports could be incorporated into the CI builds.
>>> running the analysis on cross-builds is alot more daunting, but on
>>> native builds its rather easy.
>>
>> This is generally a valuable thing. Unfortunately, it starts with some more
>> work: modelling of functions and syscalls that clang has no insight into and,
>> thus, throws false-positives around them. Quickly browsing through the
>> report, I only saw one real finding so far, and that was a harmless "assigned
>> but never used" warning. But I'm sure that there are a few more severe
>> issues in that haystack.
> 
> Did you look only at the tidy-report? The other, website based report has tons of valid issues,
> and clang models POSIX/GNU functions - that’s enough for most of the code.

No, I didn't look at the tidy reports, the other ones instead. And a lot
of those I checked (might not have been representative) stumbled over
the unknown behavior of Xenomai systems - naturally. Some may have also
stumbled over missing noreturn annotations. Others simply because the
graph didn't get that a path was not taken with the assumed input
values. All normal for static analysis.

> 
> eg.:
> 
> utils/analogy/calibration_ni_m.c: use after free (your error() macro is broken).

A nice example for improper modeling of clang: error[_at_line] will
never return when passed a non-zero status.

The error macro is still wrong because it assumes that this will only
happen for status < 0.

> lib/copperplate/heapobj-heapmem.c: heapobj_init_array_private with size=0 has undefined behavior
> 
> Every report I looked at seemed valid, those that are questionable, like heapobj_init_array_private
> Are questionable because it's not clear if this function is allowed to be called with size=0.
> Means it's questionable for everyone reading the code, and something an analyzer should throw up.
> Its either a bug or some annotation would help (__builtin_expect(size != 0, 1) or assert(size != 0)).
> 

This one indeed requires a closer look and likely proper error handline
for size == 0.

>>
>> I was already considering to enable Coverity via our CI. It generally works, it
>> has proven to find real issues without too much modelling effort (though this
>> case may be different because of all the custom syscalls), but since Synopsis
>> bought it, the availability and quality of their public OSS service massively
>> degraded.
>>
>> So, looking into clang might be a more reliable alternative. I'm open for
>> patches that pave the way. For CI, we may need a more recent source than
>> clang-6 because that is what Travis provides us ATM.
> 
> I dont have any experience with travis, but can't you just tell you want a recent Ubuntu/Debian?

We cannot easily change that, there are only pre-defined Ubuntu images
available. At most we can try a dist-upgrade during the test, but that
may prolong the setup time too much.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

