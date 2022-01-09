Message-ID: <2230e37d-7632-ed02-0a37-f0157671464a@siemens.com>
Date: Sun, 9 Jan 2022 17:51:15 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3] dovetail: mm: fix logic of COW-disabling check
Content-Language: en-US
References: <20220109102820.638985-1-rpm@xenomai.org>
 <87mtk5q655.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <87mtk5q655.fsf@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 09.01.22 16:22, Philippe Gerum wrote:
> 
> Philippe  Gerum <rpm@xenomai.org> writes:
> 
>> From: Philippe Gerum <rpm@xenomai.org>
>>
>> COW-disabling for a dovetailed task does not depend on the pinning
>> status of the source VMA considered by copy_present_page(). Decouple
>> both checks, which fixes the following kernel splat on fork() from a
>> dovetailed task:
>>
> 
> Although this patch does prevent the crash, this still does not work the
> way it should. Basically, we should not allow the DMA pinning check to
> prevent COW from being disabled for a VMA attached to a dovetailed
> task. This needs more thought. I'll follow up on this.

Only read now - did anything change in upstream? Or do we have a
sleeping issue in 5.10 as well?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

