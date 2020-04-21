Subject: Re: FAILURE run_gdb:287: checking expression "primary_mode", expected
 "$", found "N"
References: <20200131152713.1811748-1-rpm@xenomai.org>
 <0c811fd4-dc46-0bce-99b3-64c150725d3d@siemens.com>
 <230535ea0245408dbd941bc26c4f6df9@intel.com>
 <bbab7ccf-0f5e-617a-2d94-afc79f2d7efa@siemens.com>
 <CALLqZ8Qk-BEuYjYtRpqkTVT5N9iWJHpU=3n109jCMCy4Yd_8TA@mail.gmail.com>
 <20200201112301.5d3146d9@md1za8fc.ad001.siemens.net>
 <20200420221850.xjzzrpdfoherz6hm@altlinux.org>
 <20200421002728.wugbqtzibmbuqyzk@altlinux.org>
 <20200421024337.hfwqgnf4y5dkuvss@altlinux.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <3a385296-1538-3aee-e240-15604fbe9677@siemens.com>
Date: Tue, 21 Apr 2020 07:10:55 +0200
MIME-Version: 1.0
In-Reply-To: <20200421024337.hfwqgnf4y5dkuvss@altlinux.org>
Content-Type: text/plain; charset=koi8-r; format=flowed
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
To: Xenomai <xenomai@xenomai.org>

On 21.04.20 04:43, Vitaly Chikunov via Xenomai wrote:
> Jan,
> 
> On Tue, Apr 21, 2020 at 03:27:29AM +0300, Vitaly Chikunov via Xenomai wrote:
>> On Tue, Apr 21, 2020 at 01:18:50AM +0300, Vitaly Chikunov via Xenomai wrote:
>>>
>>> I try ipipe-core-4.19.114-cip24-x86-12 + xenomai-3.1 patches.
>>> But how to interpret this test result?
>>>
>>>    4.19.114-xenomai-alt1.cip24.12:~# xeno-test -k
>>>    Started child 6707: /bin/bash /usr/lib/xenomai/xeno-test-run-wrapper /usr/bin/xeno-test -k
>>>    ++ echo 0
>>>    ++ testdir=/usr/lib/xenomai
>>>    ++ /usr/lib/xenomai/smokey --run --keep-going random_alloc_rounds=64 pattern_check_rounds=64
>>>    arith OK
>>>    bufp OK
>>>    cpu_affinity skipped (no kernel support)
>>>    fpu_stress OK
>>>    FAILURE run_gdb:287: checking expression "primary_mode", expected "$", found "N"
>>>    child 6707 returned: exited with status 1
>>>    4.19.114-xenomai-alt1.cip24.12:~#
>>
>> 1. I think I found what is the problem.
>> Symbol `breakpoint_target' is defined static, so it requires debuginfo
>> to work just after binary load in gdb. Otherwise, there is error which
>> is unhandled by gdb smoke tester:
>>
>>    4.19.114-xenomai-alt1.cip24.12:~# /usr/lib/xenomai/smokey --run random_alloc_rounds=64 pattern_check_rounds=64 --run=gdb --trace=99 --verbose=99
>>    ...
>>    Reading symbols from /usr/lib/xenomai/smokey...
>>    Missing separate debuginfo for /usr/lib/xenomai/smokey
>>    Try to install the hash file /usr/lib/debug/.build-id/ec/389866caa99a27f87698250ed8fda4264c093b.debug
>>    (No debugging symbols found in /usr/lib/xenomai/smokey)
>>    (gdb) Function "breakpoint_target" not defined.
>>    Make breakpoint pending on future shared library load? (y or [n]) [answered N; input not from terminal]
>>    (gdb) Starting program: /usr/lib/xenomai/smokey --run=4 run_target
>>    [Thread debugging using libthread_db enabled]
>>    Using host libthread_db library "/lib64/libthread_db.so.1".
>>    [New Thread 0x7ffff7b0e700 (LWP 8170)]
>>    Missing separate debuginfo for /lib64/libgcc_s.so.1
>>    Try to install the hash file /usr/lib/debug/.build-id/d4/1518ee215314a1877b0d17f0ccddfc33582503.debug
>>    [New Thread 0x7ffff71d8700 (LWP 8171)]
>>    [Thread 0x7ffff71d8700 (LWP 8171) exited]
>>    gdb OK
>>    [Thread 0x7ffff7d90740 (LWP 8166) exited]
>>    [Inferior 1 (process 8166) exited normally]
>>    (gdb) resume in primary
>>    The program is not being run.
>>    FAILURE run_gdb:287: checking expression "primary_mode", expected "$", found "N"
>>
>> As you can see it does not find `breakpoint_target' on `b
>> breakpoint_target'. If debuiginfo is installed test will pass.
>>
>> I recommend removing `static' from `breakpoint_target' definition, so
>> that symbol is exported without need of debuginfo.
> 
> It turned out that removing `static' was not enough to pass binary
> stripping. I will investigate better solution further.

Stripping must not happen - how did you build things? On debian, we have 
"dh_strip -s --exclude=smokey" in the rules to ensure that smokey keeps 
its debuginfos.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

