Subject: Re: Weird semaphore/timeout behaviour with gdbserver
References: <4c80-60071a00-11-743e7c00@26732586>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <d7a197b2-cf05-1814-3741-a5b163708ca5@siemens.com>
Date: Thu, 21 Jan 2021 22:42:17 +0100
MIME-Version: 1.0
In-Reply-To: <4c80-60071a00-11-743e7c00@26732586>
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
To: =?UTF-8?Q?Fran=c3=a7ois_Legal?= <devel@thom.fr.eu.org>, xenomai@xenomai.org

On 19.01.21 18:41, François Legal via Xenomai wrote:
> Le Vendredi, Janvier 08, 2021 19:35 CET, François Legal via Xenomai <xenomai@xenomai.org> a écrit: 
>  
>> Hello,
>>
>> Working on ARMv7 with linux 4.4 and xenomai 3.1, I get a strange behaviour when using GDB.
>> There seem to be troubles with threads pending on semaphores, which do not wake up when sem is posted nor when the timedwait is over.
>> It does not seem to make a problem with all the semaphores on the software, but at program startup, the behaviour is pretty constant.
>>
>> If I start the same program from shell, thread activation works flawlessly.
>>
>> ANybody can give a hint on this ?
>>
>> Thanks.
>>
>> François
>>
>>
>  
> I've got another case with pulse semaphores with timeout, that outline the same behaviour without gdbserver.
> I've got 2 threads and 2 pulse semaphores. Thread1 (priority 60) successively pends (with 30s timeout) on SEM1 then posts SEM2, while thread2 (priority 52) posts SEM1 then pends (forever) on SEM2. Both semaphores are initialized at 0.
> I can see from debug log that Thread1 pends on SEM1, then thread2 posts SEM1 and pends SEM2, then thread1 posts SEM2, then thread2 posts SEM1 then pends SEM2, then thread1 pends SEM1, then nothing happens anymore. I thought thread1 should be unblocked (either by thread2 posting SEM1, or by the 30s timeout) but that never happens.
> 
> What am I getting wrong here ?
> 

These scenarios are hairy without test cases. Can you derive something
simple, portable from your problems? There is testsuite/smokey/gdb/gdb.c
for full automated tests, but already something we can compile and run
locally here, gdb manually operated, would be fine. It would also allow
to cross-check on x86 and arm64 to see if this is arch-specific.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

