References: <20181001135619.24883-1-rpm@xenomai.org>
 <20181001135619.24883-6-rpm@xenomai.org>
 <9cd23077-9f88-e06f-dbb5-6c1a39b7f578@siemens.com>
 <7f72d34f-22cd-757d-9dcc-f1f84b41d105@siemens.com>
 <69325d5b-0558-b764-8d93-fb40825ff182@xenomai.org>
 <7ff0fd30-e3da-1bdc-1824-112352ee819f@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <29cb3d46-a652-2bab-7793-58839a333aa2@xenomai.org>
Date: Tue, 9 Oct 2018 20:02:05 +0200
MIME-Version: 1.0
In-Reply-To: <7ff0fd30-e3da-1bdc-1824-112352ee819f@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH 5/6] boilerplate/setup: cobalt: retrieve the
 default CPU affinity
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On 10/09/2018 12:40 PM, Jan Kiszka wrote:
> On 02.10.18 18:30, Philippe Gerum wrote:
>> On 10/02/2018 05:38 PM, Jan Kiszka wrote:
>>> On 02.10.18 17:26, Jan Kiszka wrote:
>>>> On 01.10.18 15:56, Philippe Gerum wrote:
>>>>> Over Cobalt, make sure the default CPU affinity mask reflects the set
>>>>> of CPUs available for running real-time threads
>>>>> (i.e. /proc/xenomai/affinity).
>>>>
>>>> "This avoids that thread will be created on CPU that is not support by
>>>> Xenomai and first needs to be migrated when it is hardened."
>>>>
>>>
>>> After proof-reading:
>>>
>>> "This avoids that a thread will be created on a CPU that is not
>>> supported by Xenomai and first needs to be migrated when it is
>>> hardened."
>>
>> Not really. The issue is not with the creation phase, we have
>> xnthread_pin_initial() making sure that any emerging thread switches to
>> a CPU from the rt set already.
>>
>> The issue is with manual CPU migration outside of the rt set applied to
>> a thread, which leads to a denial from the core (automatic
>> cancellation). You may want to factor in commit 2dc780e42 when reviewing
>> the changes.
>>
>> So yes, it looks like reading the code is not that obvious. I'll rework
>> the log.
> 
> Did you have a chance to reword this commit log? I'd like to push it to
> next, along with its siblings.
> 

Not yet, sorry. You can push this one independently later if you can't
wait, the real bug is solved elsewhere in the series. This one simply
prevents the default affinity settings to trigger the termination of the
app, which now works without panicking.

-- 
Philippe.

