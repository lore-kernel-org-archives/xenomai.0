References: <de71569b-291a-afad-14f1-6f876b9cffde@siemens.com>
 <87y23s3byb.fsf@xenomai.org> <87ee5is12i.fsf@xenomai.org>
 <87a6g6s0d6.fsf@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: mm problems with 5.15.9-dovetail1
Date: Sat, 08 Jan 2022 16:45:45 +0100
In-reply-to: <87a6g6s0d6.fsf@xenomai.org>
Message-ID: <875yqurzyn.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org


Philippe Gerum via Xenomai <xenomai@xenomai.org> writes:

> Philippe Gerum via Xenomai <xenomai@xenomai.org> writes:
>
>> Philippe Gerum <rpm@xenomai.org> writes:
>>
>>> Hi,
>>>
>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>
>>>> Hi Philippe,
>>>>
>>>> seems we have some issue with the new 5.15 dovetail kernel, see e.g.
>>>>
>>>> https://source.denx.de/Xenomai/xenomai-images/-/jobs/371693
>>>> https://source.denx.de/Xenomai/xenomai-images/-/jobs/371694
>>>> https://source.denx.de/Xenomai/xenomai-images/-/jobs/371695
>>>> (kernel BUG at mm/rmap.c:1049!)
>>>>
>>>> Or are there changes needed on Xenomai side?
>>>
>>> Nope. Plain bug I'd say. I'll have look at this in a couple of days.
>>
>> posix_fork is triggering the bug. The logic disabling COW for dovetailed
>> tasks breaks with Cobalt over 5.15, but does not with EVL which explains
>> why I did not notice earlier. Working on this.

This bug was introduced in Dovetail for kernel v5.13, so it has no
impact on xenomai3 users who run v5.10.y.

-- 
Philippe.

