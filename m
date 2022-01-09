References: <20220109102820.638985-1-rpm@xenomai.org>
 <87mtk5q655.fsf@xenomai.org>
 <2230e37d-7632-ed02-0a37-f0157671464a@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH v3] dovetail: mm: fix logic of COW-disabling check
Date: Sun, 09 Jan 2022 18:06:41 +0100
In-reply-to: <2230e37d-7632-ed02-0a37-f0157671464a@siemens.com>
Message-ID: <871r1grg3n.fsf@xenomai.org>
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

> On 09.01.22 16:22, Philippe Gerum wrote:
>> 
>> Philippe  Gerum <rpm@xenomai.org> writes:
>> 
>>> From: Philippe Gerum <rpm@xenomai.org>
>>>
>>> COW-disabling for a dovetailed task does not depend on the pinning
>>> status of the source VMA considered by copy_present_page(). Decouple
>>> both checks, which fixes the following kernel splat on fork() from a
>>> dovetailed task:
>>>
>> 
>> Although this patch does prevent the crash, this still does not work the
>> way it should. Basically, we should not allow the DMA pinning check to
>> prevent COW from being disabled for a VMA attached to a dovetailed
>> task. This needs more thought. I'll follow up on this.
>
> Only read now - did anything change in upstream? Or do we have a
> sleeping issue in 5.10 as well?
>

5.10 is fine because the checks are in proper order there: first whether
the page may be concerned about COW, next whether the mm belongs to a
dovetailed process which forces a COW-break, whether a DMA pinning
requires a COW-break eventually.

-- 
Philippe.

