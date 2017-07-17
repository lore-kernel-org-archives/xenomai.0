References: <9cf742c9-4fa9-a236-a941-3b2565ce1e28@siemens.com>
 <fc678dc4-244a-0c28-465b-38b0bcae1152@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b067a021-97ee-dc20-30b4-41b0603429fa@siemens.com>
Date: Mon, 17 Jul 2017 16:26:10 +0200
MIME-Version: 1.0
In-Reply-To: <fc678dc4-244a-0c28-465b-38b0bcae1152@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PULL] next: Fixes for pthread_mutex_trylock
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2017-07-17 15:41, Philippe Gerum wrote:
> On 07/14/2017 09:10 PM, Jan Kiszka wrote:
>> The following changes since commit 5bd2093981417bf21d958c4a639837ed0963838a:
>>
>>   lib/cobalt: init: hint about failure due to disabled core (2017-06-03 18:10:25 +0200)
>>
>> are available in the git repository at:
>>
>>   git://git.xenomai.org/xenomai-jki.git 51a01ff89b8d0b2160675ec03db7f92562ff0af8
>>
>> for you to fetch changes up to 51a01ff89b8d0b2160675ec03db7f92562ff0af8:
>>
>>   cobalt: Fix slow-path of mutex_trylock in kernel (2017-07-14 20:58:38 +0200)
>>
>> At least patch 3 should go to stable as well. I tried to look for
>> potential issues in stable, ie. without prio-ceiling, /wrt patch 5 as
>> well but I didn't find anything obvious.
>>
>> Patch 1 is off-topic, but I ran into again while using syscall(invalid)
>> to trigger a mode switch.
>>
>> Jan
>>
>> ----------------------------------------------------------------
>> Jan Kiszka (5):
>>       cobalt/kernel: Handle bogus fastcall syscalls gracefully
> 
> This one does not look good. There is no way to receive KEVENT_PROPAGATE
> when calling the head stage handler from a fastcall hook, since the
> latter only receives foreign (e.g. Cobalt's) syscalls. This case would
> be a kernel bug - there is no code handling such propagation in the
> inner syscall trampoline code.
> 
> Did you actually observe this case?

Just call syscall(0x1111).

> 
>>       smokey: Add test cases for trylock on ceiling mutexes
>>       cobalt: Fix mutex_trylock slow-path in userspace
>>       cobalt: Align structure of mutex_trylock with mutex_timedlock
>>       cobalt: Fix slow-path of mutex_trylock in kernel
>>
> 
> Merged, thanks. I picked #3 and merged it to stable as suggested.
> 

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

