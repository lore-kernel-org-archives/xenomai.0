References: <558D5FAD.3060003@siemens.com> <20170307193444.79df74cd@md1em3qc>
 <507e7a5d-284f-7098-7736-4644c4cd8b87@xenomai.org>
 <ffae09d9-b277-24a7-8fd6-809e13ef8ba6@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <7194280d-f9ac-df05-8038-1280820e8f95@xenomai.org>
Date: Wed, 8 Mar 2017 12:29:23 +0100
MIME-Version: 1.0
In-Reply-To: <ffae09d9-b277-24a7-8fd6-809e13ef8ba6@siemens.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Heads up: some race condition fixes for Xenomai 3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Henning Schild <henning.schild@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 03/08/2017 12:25 PM, Jan Kiszka wrote:
> On 2017-03-08 09:54, Philippe Gerum wrote:
>> On 03/07/2017 07:34 PM, Henning Schild wrote:
>>> Am Fri, 26 Jun 2015 16:20:29 +0200
>>> schrieb Jan Kiszka <jan.kiszka@siemens.com>:
>>>
>>>> Hi,
>>>>
>>>> just pushed 3 patches to git.xenomai.org/xenomai-jki.git for-forge
>>>> that are supposed to fix race conditions while manipulating
>>>> xnthread::state and info (both need to be nklock-protected). Please
>>>> review if finding and fixes make sense.
>>>>
>>>>       cobalt/kernel: Fix locking for xnthread info manipulations
>>>>       cobalt/kernel: Fix locking for setting XNFPU
>>>>       cobalt/kernel: Rework thread debugging helpers
>>>>
>>>> Maybe some of the issues also exist in Xenomai 2, didn't check yet.
>>>
>>> After looking deeper into the the mysterious -EINTR i asked about a few
>>> days ago we now got a trace that suggests something is going wrong. Jan
>>> remembered the race in thread flag manipulation he found in Xeno3.
>>>
>>> I did not do a thorough code analysis yet but instead just put two
>>> asserts into xnthread_set_info and xnthread_clear_info.
>>> 1. !xnlock_is_owner(&nklock)
>>> 2. xnpod_current_thread() != thread_to_update
>>>
>>> Both cases do happen. The flags are manipulated without holding the
>>> lock and the flags are manipulated from another context. I guess that
>>> suggests that the race found in xenomai3 is also in xenomai2.
>>>
>>
>> I would not compare both code bases. Much rewrite took place from the
>> legacy nucleus to the cobalt core.
>>
>> I have reviewed every single statement involving set/clear info bits in
>> 3.x and I can't seem to find any unlocked access for those. Any
>> specifics about the exact locations where your debug statements trigger?
>>
> 
> One quickly discoverable example is in xnshadow_harden
> (xnthread_set/clear_info(curr, XNATOMIC) without nklock protection). And

This is v2. I'm referring to v3.


-- 
Philippe.

