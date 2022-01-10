References: <20220109181359.811425-1-rpm@xenomai.org>
 <87iluspyeb.fsf@xenomai.org>
 <b4c5e7e6-a5f0-7e9e-cf88-77d8cc8ce786@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH] mm: dovetail: rename page_needs_cow_for_dma() to
 page_needs_cow()
Date: Mon, 10 Jan 2022 08:56:51 +0100
In-reply-to: <b4c5e7e6-a5f0-7e9e-cf88-77d8cc8ce786@siemens.com>
Message-ID: <87bl0kowdr.fsf@xenomai.org>
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 09.01.22 19:15, Philippe Gerum via Xenomai wrote:
>> 
>> Philippe  Gerum <rpm@xenomai.org> writes:
>> 
>>> From: Philippe Gerum <rpm@xenomai.org>
>>>
>>> With the addition of the Dovetail COW-breaking logic,
>>> page_needs_cow_for_dma() does not exclusively apply to pinned memory
>>> for DMA anymore. Give it a more generic name.
>>>
>> 
>> Should that be merged to the v4 fix?
>> 
>
> Yeah, would be more consistent.
>
> Will you push that patch to the rebase branch soon? Asking because CI
> would then pick it up from there automatically.
>

This patch is now merged into the -rebase branch. I sent it as v5 to the
list as well for further reference.

-- 
Philippe.

