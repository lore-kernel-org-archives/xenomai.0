Message-ID: <5587C510.10306@siemens.com>
Date: Mon, 22 Jun 2015 10:19:28 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <E1Z6JYL-0001WU-7T@sd-51317.xenomai.org>
 <f7e5785057e2a9f6fe8374e56cd44d47.squirrel@sourcetrek.com>
In-Reply-To: <f7e5785057e2a9f6fe8374e56cd44d47.squirrel@sourcetrek.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : cobalt/kernel: Fix mode of
 mayday syscall
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

On 2015-06-20 16:41, Gilles Chanteperdrix wrote:
> 
> git repository hosting wrote:
>> Module: xenomai-jki
>> Branch: for-forge
>> Commit: c806b60eaf505aafd4dbeeaf59cd3fc6d68703fa
>> URL:
>> http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=c806b60eaf505aafd4dbeeaf59cd3fc6d68703fa
>>
>> Author: Jan Kiszka <jan.kiszka@siemens.com>
>> Date:   Fri Jun 19 15:59:15 2015 +0200
>>
>> cobalt/kernel: Fix mode of mayday syscall
>>
>> The oneway mode meant norestart, thus return -EINTR instead of retrying
>> the syscall after signal processing. But this caused damaged to the
>> register state of the mayday-interrupted thread, most visible on x86-64
>> where RAX is holding the RIP.
> 
> And this can not be fixed, because ?

There are probably more ways to fix it. One I played with as well was
manipulating the mayday page's stack from the kernel, thus its return
address (in the hope it would fix the backtrace too, but it didn't).

But this patch is obsolete if the mayday simplification patch pushed
yesterday can be merged for all archs.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

