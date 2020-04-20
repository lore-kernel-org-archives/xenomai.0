Subject: Re: [PATCH v2] cobalt: allow to compile without __USE_LARGEFILE64
References: <20200417083559.10684-1-nolange79@gmail.com>
 <2538ff79-f37c-eb3e-16a3-b40f7efe9006@siemens.com>
 <CADYdroMpT2pr46R7gzKeBsHRV+x+y5m8T3u1YbcgD68em9mQTQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <e78e63aa-1e63-e26d-4e82-5e4cf90cd60b@siemens.com>
Date: Mon, 20 Apr 2020 15:15:11 +0200
MIME-Version: 1.0
In-Reply-To: <CADYdroMpT2pr46R7gzKeBsHRV+x+y5m8T3u1YbcgD68em9mQTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Norbert Lange <nolange79@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On 20.04.20 13:21, Norbert Lange wrote:
> Well, I dont think 1-2 lines of a preprocessor checks count as some
> kind of intellectual work.
> I wouldn't think that way if I take some pretty much known math
> formula from wikipedia.

This is just a convenience topic for the maintainer. In fact, he already 
has tooling to remind him of fixing up this primarily cosmetic issue 
prior to applying a patch.

Jan

> 
> Norbert
> 
> Am So., 19. Apr. 2020 um 11:22 Uhr schrieb Jan Kiszka <jan.kiszka@siemens.com>:
>>
>> On 17.04.20 10:35, Norbert Lange via Xenomai wrote:
>>> A header uses the off64_t which is only conditionally available,
>>> causing compile failures.
>>> The macro might be necessary to compile cobalt libraries,
>>> but should not be needed for software depending on them.
>>>
>>> Signed-off-by: Norbert Lange <nolange79@gmail.com>
>>> ---
>>>    include/cobalt/sys/mman.h | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/include/cobalt/sys/mman.h b/include/cobalt/sys/mman.h
>>> index 1c47777a2..75a00da0c 100644
>>> --- a/include/cobalt/sys/mman.h
>>> +++ b/include/cobalt/sys/mman.h
>>> @@ -31,8 +31,10 @@ extern "C" {
>>>    COBALT_DECL(void *, mmap(void *addr, size_t length, int prot, int flags,
>>>                         int fd, off_t offset));
>>>
>>> +#if defined(_LARGEFILE64_SOURCE) || defined(_GNU_SOURCE)
>>>    COBALT_DECL(void *, mmap64(void *addr, size_t length, int prot, int flags,
>>>                           int fd, off64_t offset));
>>> +#endif
>>>
>>>    #ifdef __cplusplus
>>>    }
>>>
>>
>> Thanks, applied.
>>
>> A "From:" line in the message would be nice to avoid that the authorship
>> goes to xenomai@xenomai.org.
>>
>> Jan
>>
>> --
>> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
>> Corporate Competence Center Embedded Linux
-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

