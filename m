Subject: Re: Smokey GDB test
References: <c6b7686a-f939-1ba2-82ae-fb1942a36cbe@gmail.com>
 <f8474c3d-15bf-87fa-bf88-1a71b80a705a@siemens.com>
 <54427b9c-b8ef-6b8b-fb9f-8d7c10274932@gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <013b3ffa-4805-e266-c2d0-8612111689b3@siemens.com>
Date: Wed, 24 Jul 2019 10:27:59 +0200
MIME-Version: 1.0
In-Reply-To: <54427b9c-b8ef-6b8b-fb9f-8d7c10274932@gmail.com>
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
To: hauptmech <hauptmech@gmail.com>, Xenomai <xenomai@xenomai.org>

On 24.07.19 09:43, hauptmech wrote:
> On 24/07/2019 6:46 PM, Jan Kiszka wrote:
>> On 24.07.19 08:33, hauptmech via Xenomai wrote:
>>> The smokey GDB test was failing for me.
>>>
>>> Xenomai was built with ./configure --enable-smp --enable-pshared on a x86_64
>>> system with cobalt
>>>
>>> GCC version (Ubuntu 7.4.0-lubuntu1~18.04.1) 7.4.0
>>>
>>> GDB version (Ubuntu 8.1-0ubuntu3) 8.1.0.20180409-git
>>>
>>> Running the test by hand I found gdb complaining that it did not know the type
>>> of the expressions.
>>>
>>> Casting the type in the expressions as below fixed things for me:
>>>
>>> diff --git a/testsuite/smokey/gdb/gdb.c b/testsuite/smokey/gdb/gdb.c
>>> index 2fad3da19..538346a04 100644
>>> --- a/testsuite/smokey/gdb/gdb.c
>>> +++ b/testsuite/smokey/gdb/gdb.c
>>> @@ -285,15 +285,15 @@ static int run_gdb(struct smokey_test *t, int argc, char
>>> *const argv[])
>>>
>>>               smokey_trace("resume in primary");
>>>               send_command("c\n", 1);
>>> -            eval_expression("primary_mode", "1");
>>> +            eval_expression("(int)primary_mode", "1");
>>>               send_command("c\n", 1);
>>>
>>>               smokey_trace("synchronous stop");
>>> -            eval_expression("thread_loops==expected_loops", "1");
>>> +            eval_expression("(unsigned long long)thread_loops==(unsigned long
>>> long)expected_loops", "1");
>>>               send_command("c\n", 1);
>>>
>>>               smokey_trace("synchronous continue");
>>> -            eval_expression("thread_loops==expected_loops", "1");
>>> +            eval_expression("(unsigned long long)thread_loops==(unsigned long
>>> long)expected_loops", "1");
>>>
>>>               send_command("q\n", 0);
>>>               pause();
>>>
>>>
>> Was this with
>> https://gitlab.denx.de/Xenomai/xenomai/commit/d48071ae92754119e504202d486cd87762c46cbb
>>
>> applied?
>>
>> Jan
>>
> No. And I would expect the -g flag to solve the problem. Sorry for the false alarm.
> 

No worries! Feedback is always appreciated.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

