References: <DB5PR06MB1287CCF7EAF55DA6F95ED4A68F9D0@DB5PR06MB1287.eurprd06.prod.outlook.com>
 <20160405070232.GI20399@hermes.click-hack.org>
 <AM3PR06MB1282EDA8459215FC1B64D3118F900@AM3PR06MB1282.eurprd06.prod.outlook.com>
 <57069F3E.3070309@xenomai.org>
 <DB5PR06MB128755E41DF13905760BB2438F620@DB5PR06MB1287.eurprd06.prod.outlook.com>
 <571DF3C0.7050502@xenomai.org> <571DF45B.7070703@xenomai.org>
 <DB5PR06MB1287AAAB54A1ED746511CF628F630@DB5PR06MB1287.eurprd06.prod.outlook.com>
 <5727A7D2.1060006@xenomai.org>
 <DB5PR06MB1287CBD05BE361F39DC849998F7A0@DB5PR06MB1287.eurprd06.prod.outlook.com>
 <DB5PR06MB1287E096DFFD94FCD30043BB8F720@DB5PR06MB1287.eurprd06.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <b69845b5-5988-6f4b-ed98-c3af0e5b4058@xenomai.org>
Date: Mon, 23 May 2016 11:14:39 +0200
MIME-Version: 1.0
In-Reply-To: <DB5PR06MB1287E096DFFD94FCD30043BB8F720@DB5PR06MB1287.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Mixing Posix RT APIs and vxWorks APIs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Alex Plits <alex_plits@radwin.com>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/11/2016 08:59 AM, Alex Plits wrote:
>> sched_get_priority_min(SCHED_FIFO)      = 1
>> sched_get_priority_max(SCHED_FIFO)      = 99
>> mmap2(NULL, 65536, PROT_READ|PROT_WRITE,
>> MAP_PRIVATE|MAP_ANONYMOUS|MAP_STACK, -1, 0) = 0xb6aa2000
>> mprotect(0xb6aa2000, 4096, PROT_NONE)   = 0
>> clone(child_stack=0xb6ab10e8,
>> flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THRE
>> AD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHIL
>> D_CLEARTID, parent_tidptr=0xb6ab1588, tls=0xb6ab1950,
>> child_tidptr=0xb6ab1588) = 1954
>> clock_gettime(CLOCK_REALTIME, {1462279873, 555642310}) = 0
>> gettimeofday({1462279873, 556216}, NULL) = 0
>> futex(0xbebf3b78, FUTEX_WAIT_PRIVATE, 0, {4, 443784000}) = 0
>> futex(0xb6ab1588, FUTEX_WAIT, 1954, NULLsender is up
>> send msg
>> <unfinished ...>
>> +++ killed by SIGSEGV +++
>> Segmentation fault
>>
>>
>> Thanks,
>> Alex Plits.
>>
> [Alex Plits] 
> Sorry to nag - 
> Any input on this issue?
> 

Nothing obvious here. Could you try strace -f, so that spawned threads
are straced a well?

-- 
Philippe.

