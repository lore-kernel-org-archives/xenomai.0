References: <0c161e7a-7bc3-1a06-4ccc-2386440a51d2@jan-melcher.de>
 <5c46cfa0-c696-928e-f5d4-356989d7a797@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a7624c9a-9bf2-5912-517a-7a11584856b8@siemens.com>
Date: Tue, 7 Nov 2017 13:06:37 +0100
MIME-Version: 1.0
In-Reply-To: <5c46cfa0-c696-928e-f5d4-356989d7a797@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Docker / PID Namespaces in Cobalt
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Jan Melcher <mail@jan-melcher.de>, xenomai@xenomai.org

On 2017-11-07 09:23, Philippe Gerum wrote:
> On 11/07/2017 12:10 AM, Jan Melcher wrote:
>> However, rt_task_set_periodic/rt_task_wait_period does not work
>> (rt_task_wait_period just never returns). I figured this is because
>> Cobalt does not support PID namespaces. Can someone confirm this? Some
>> log outputs I added suggest that Cobalt is confusing namespace-local and
>> global PIDs.
>>
> 
> Correct.
> 
>> My question is if you think that fixing PID namespaces would be
>> sufficent to support Docker with Cobalt.
>>
> No idea. I have zero experience in Docker unfortunately.
> 

Maybe it's "just" about using the right kernel functions to resolve
PIDs. In which details did you debug the topic already, Jan?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

