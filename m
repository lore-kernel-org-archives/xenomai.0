Subject: Re: [PATCH] lib/cobalt: init: do not call pthread_atfork() from
 atfork() handlers
References: <20190503150939.3594-1-rpm@xenomai.org>
 <VI1PR05MB591765785A35FB3685463256F6300@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <6ef3a9cf-cb30-59c4-1983-4475fdc7cd6e@xenomai.org>
 <c0230398-8da5-a0b4-d30c-17e91e2f0cb7@xenomai.org>
 <DB8PR05MB5915F745C3CA952C04179E2EF6080@DB8PR05MB5915.eurprd05.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <69740012-4273-4647-00a2-55fd7ad9468d@xenomai.org>
Date: Tue, 14 May 2019 12:04:48 +0200
MIME-Version: 1.0
In-Reply-To: <DB8PR05MB5915F745C3CA952C04179E2EF6080@DB8PR05MB5915.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 5/14/19 11:53 AM, Lange Norbert wrote:
> (readding ML)
> 
>> -----Original Message-----
>> From: Philippe Gerum <rpm@xenomai.org>
>> Sent: Dienstag, 14. Mai 2019 10:38
>> To: Lange Norbert <norbert.lange@andritz.com>
>> Subject: Re: [PATCH] lib/cobalt: init: do not call pthread_atfork() from
>> atfork() handlers
>>
>> E-MAIL FROM A NON-ANDRITZ SOURCE: AS A SECURITY MEASURE, PLEASE
>> EXERCISE CAUTION WITH E-MAIL CONTENT AND ANY LINKS OR
>> ATTACHMENTS.
>>
>>
>> On 5/14/19 10:35 AM, Philippe Gerum wrote:
>>> On 5/6/19 9:56 AM, Lange Norbert wrote:
>>>> Hello Philippe,
>>>>
>>>> using this patch, smokey's "fork test" alone finishes, but..
>>>> the smokey suite will hang when running that test after the mutex or
>>>> cvars test. Eg.
>>>>
>>>> smokey --run=10,11
>>>> smokey --run=12,11
>>>
>>> I cannot reproduce this with glibc 2.28, and the tip of my
>>> for-upstream tree which includes that fix. Which glibc are you running?
> 
> Glibc 2.28, Xenomai userspace is based on current master branch
> with fix added (tested both with and without our company stuff on top)
> 
>>
>> Is this the sequence which hangs on your end?
>>
>> ~ # smokey --run=13-14
>> posix_cond OK
>> posix_fork OK
>> ~ # smokey --run=15-14
>> posix_mutex OK
>> posix_fork OK
>>
> 
> Yes:
> 
> root@buildroot:~# /usr/xenomai/bin/smokey --run=10
> posix_mutex OK
> root@buildroot:~# /usr/xenomai/bin/smokey --run=11
> posix_fork OK
> root@buildroot:~# /usr/xenomai/bin/smokey --run=10,11
> posix_mutex OK
> 
> When it hangs, this is the stacktrace:
> (switched to crosstool-NG for the toolchain, did not check to enable debuginfo for glibc).
> 
> (gdb) bt
> #0  0x00007f45b4d86feb in ?? () from /lib64/libc.so.6
> #1  0x00007f45b4de8b95 in malloc () from /lib64/libc.so.6
> #2  0x00007f45b4f81a53 in ?? () from /lib64/ld-linux-x86-64.so.2
> #3  0x00007f45b4f83149 in ?? () from /lib64/ld-linux-x86-64.so.2
> #4  0x00007f45b4f8d4cc in ?? () from /lib64/ld-linux-x86-64.so.2
> #5  0x00007f45b4ea7bcf in _dl_catch_exception () from /lib64/libc.so.6

That is a different issue, possibly not directly related. backtrace() is
used over a signal context in the default SIGSHADOW handler libcobalt
installs, which is unsafe since backtrace() calls malloc(). This run
ends up with a recursive call to malloc() which deadlocks on the
internal arena lock. Disabling CONFIG_XENO_OPT_DEBUG_TRACE_RELAX may
paper over the issue.

-- 
Philippe.

