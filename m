References: <cover.1620233588.git.jan.kiszka@siemens.com>
 <ed990049-2320-aaa1-2ab7-e99895be1c5c@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH v2 0/9] y2038 groundwork and first steps
In-reply-to: <ed990049-2320-aaa1-2ab7-e99895be1c5c@siemens.com>
Date: Thu, 06 May 2021 09:02:45 +0200
Message-ID: <87y2csqr8q.fsf@xenomai.org>
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
Cc: "Bezdeka, Florian (T RDA IOT SES-DE)" <florian.bezdeka@siemens.com>, xenomai@xenomai.org


Jan Kiszka via Xenomai <xenomai@xenomai.org> writes:

> On 05.05.21 18:52, Jan Kiszka via Xenomai wrote:
>> Picking up from Philippe's queue:
>> 
>> This patch series prepares the tree for the upcoming y2038 work,
>> converting obsolete/ambiguous time specification types to the proper
>> ones introduced upstream by the v5.x kernel series.
>> 
>> In v2, feedback on the first round has been addressed, primarily
>> regarding folding fixing into the patches that need them.
>> 
>> In addition, this includes 3 patches from Florian that add
>> sem_timedwait64 system call and a test suite for it.
>> 
>
> Seems we have some issue on ARM ("Illegal instruction" in smokey):
> https://source.denx.de/Xenomai/xenomai-images/-/jobs/264219
> https://source.denx.de/Xenomai/xenomai-images/-/jobs/264225

That one may be related to the code directing clock_gettime() either to
the vDSO with Dovetail, or TSC readouts via a memory mapping with the
I-pipe, all in libcobalt.

>
> Florian, could you check that?
>
> Thanks,
> Jan


-- 
Philippe.

