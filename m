Message-ID: <4B8F98CF.4080908@domain.hid>
Date: Thu, 04 Mar 2010 12:26:07 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B8D9711.5090704@domain.hid> <4B8F8E11.9060902@domain.hid>
In-Reply-To: <4B8F8E11.9060902@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [pull request] Fixes and workarounds for the
	cond issues
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "Charlton, John" <john.charlton@domain.hid>, xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> The following changes since commit af93ec87f975b387243127090b578d57922b38dc:
>>   Gilles Chanteperdrix (1):
>>         posix: fix recursive condvar implementation
>>
>> are available in the git repository at:
>>
>>   git://git.xenomai.org/xenomai-jki.git for-upstream
>>
>> These patches pass basic testings, specifically our extended testsuite,
>> but I'm still unhappy with the workaround. Specifically the fact that we
>> lose -EINTR as valid return code for the Native side is fairly annoying.
>>
>> For that reason, I will continue to work out fixed prologue/epilogue
>> syscalls for both skins that up-to-date user space will be able to
>> benefit from (native kernel space part is already done). The majority of
>> users will continue to update kernel and user space synchronously
>> anyway, for the rest we will provide these workarounds here.
> 
> Let us calm down, and avoid pushing changes which are worse than the
> issue they try and correct. I will not publish anything on these issues
> before this week-end. Instead of modifying the mutex-torture unt test, I
> will try and write a condvar-torture unit test, which exhaustively test
> all the return values of pthread_cond_wait/rt_cond_wait, including
> interruption by signals during the cond_wait, and the epilogue.

Fine with me. By then, we may also have feedback from our field tests.
And should have finished writing the new syscall sets.

Will you also split up the torture test to leave the timed mutex test
case in or should I do this?

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

