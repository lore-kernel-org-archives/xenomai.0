Subject: Re: dovetail: add prctl() call form
References: <5283f8ff-33bf-910d-25b5-044ea6a963ae@siemens.com>
 <87a6iepm0x.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f636f600-cf0f-54fd-149d-003fc2d10c28@siemens.com>
Date: Mon, 8 Nov 2021 19:00:41 +0100
MIME-Version: 1.0
In-Reply-To: <87a6iepm0x.fsf@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 08.11.21 18:57, Philippe Gerum wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> Hi Philippe,
>>
>> this dovetail commit makes the pipeline go red, crashing the kernels
>> (e.g. [1][2]). I hope this is something we can quickly fix in dovetail,
>> maybe via a config option?
>>
>> Jan
>>
>> [1] https://source.denx.de/Xenomai/xenomai-images/-/jobs/348118#L966
>> [2] https://source.denx.de/Xenomai/xenomai-images/-/jobs/348121#L1429
> 
> Cobalt needs some update to cope with this now. I'll send a fix either
> way (dovetail or xenomai) tomorrow morning.

This should be fixed in dovetail - API breakage. We can update Xenomai
later, along with enabling this feature again.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

