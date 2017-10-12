References: <E1daPAo-00086l-G6@xenomai.org>
 <b0711523-af3a-b8f3-d053-f9565d66c86e@xenomai.org>
 <90457b9a-4ee4-2174-d699-02e072097509@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <9e5ca469-976a-8346-960c-ed423caa38e3@xenomai.org>
Date: Thu, 12 Oct 2017 18:05:46 +0200
MIME-Version: 1.0
In-Reply-To: <90457b9a-4ee4-2174-d699-02e072097509@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : cobalt/syscall: Filter out
 invalid Linux syscalls
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On 10/12/2017 09:58 AM, Jan Kiszka wrote:
> On 2017-07-26 19:02, Philippe Gerum wrote:
>> On 07/26/2017 06:28 PM, git repository hosting wrote:
>>> Module: xenomai-jki
>>> Branch: for-forge
>>> Commit: 92fadda472ad755db2d7b9443d3b2108a35e5d14
>>> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=92fadda472ad755db2d7b9443d3b2108a35e5d14
>>>
>>> Author: Jan Kiszka <jan.kiszka@siemens.com>
>>> Date:   Mon Jul 24 14:22:29 2017 +0200
>>>
>>> cobalt/syscall: Filter out invalid Linux syscalls
>>>
>>> Suggested by Philippe Gerum: Instead of propagating them down the
>>> pipeline, triggering a XENO_BUG_ON in ipipe_fastcall_hook, catch invalid
>>> Linux syscalls early and terminate them immediately.
>>>
>>
>> I'm holding this one for now, this requires further investigation; a
>> syscall unexpectedly triggers this guard in the ARM port.
>
> What's the status of this? Did I miss a commit that resolves this? I'm
> asking as I'm still carrying that commit locally in some queue as a
> reminder.
>

I did not have time to have a look at the ARM-specific issue yet.

-- 
Philippe.

