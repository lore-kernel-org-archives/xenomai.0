References: <1453902069-18824-1-git-send-email-henning.schild@siemens.com>
 <1454504365-7015-1-git-send-email-henning.schild@siemens.com>
 <20160203142448.GB32138@hermes.click-hack.org> <56B20F2E.2020404@siemens.com>
 <20160203143845.GC32138@hermes.click-hack.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <56B213F6.2010703@siemens.com>
Date: Wed, 3 Feb 2016 15:51:34 +0100
MIME-Version: 1.0
In-Reply-To: <20160203143845.GC32138@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH v3] ipipe x86 mm: handle huge pages in memory
 pinning
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2016-02-03 15:38, Gilles Chanteperdrix wrote:
> On Wed, Feb 03, 2016 at 03:31:10PM +0100, Jan Kiszka wrote:
>> On 2016-02-03 15:24, Gilles Chanteperdrix wrote:
>>> On Wed, Feb 03, 2016 at 01:59:25PM +0100, Henning Schild wrote:
>>>> In 4.1 huge page mapping of io memory was introduced, enable ipipe to
>>>> handle that when pinning kernel memory.
>>>>
>>>> change that introduced the feature
>>>> 0f616be120c632c818faaea9adcb8f05a7a8601f
>>>
>>> Could we have an assessment of whether avoiding the call to
>>> __ipipe_pin_range_mapping in upper layers makes the patch simpler?
>>
>> For that, we first of all need to recapitulate how
>> __ipipe_pin_range_globally is/was supposed to work at all.
>>
>> I tried to restore details but I'm specifically failing regarding that
>> "globally". To my understanding, the vmalloc_sync_one of x86 transfers
>> at best mappings from init_mm to the current mm one, but not to all mm
>> in the systems.
> 
> __ipipe_pin_range_globally calls vmalloc_sync_one for all pgds in
> the system. This is pretty ugly, not very scalable, but if you do

How are future pgds accounted for?

> not do that, each access to an ioremap/vmalloc area in, say, an
> interrupt handler, causes a fault for processes that do not have the
> mapping in their page tables. Such processes exist if they were
> created before the call to ioremap/vmalloc. Another possible fix to
> this issue is to allow handling that kind of faults over the head
> domain without switching to secondary domain.

OK, that makes more sense again.

But then Henning is definitely on the right path, because you can't tell
from 'start' and 'end' or the pgd pointer if there were only huge pages
added or maybe also some small pages. IOW, we do have to walk the page
table trees and therefore have to be prepared to hit some huge pages
along that path.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

