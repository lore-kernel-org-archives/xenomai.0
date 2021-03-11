Subject: Re: [PATCH 3/8] cobalt/trace: dovetail: add placeholders for trace
 management
References: <20210220124527.401015-1-rpm@xenomai.org>
 <20210220124527.401015-3-rpm@xenomai.org>
 <b15e7868-3e9d-aed9-b503-9c71efac6a4b@siemens.com>
 <87k0qdhekq.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <93c0d384-8b67-8b0f-3002-29f8a00842b9@siemens.com>
Date: Thu, 11 Mar 2021 16:55:39 +0100
MIME-Version: 1.0
In-Reply-To: <87k0qdhekq.fsf@xenomai.org>
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
Cc: xenomai@xenomai.org

On 11.03.21 16:53, Philippe Gerum wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 20.02.21 13:45, Philippe Gerum wrote:
>>> From: Philippe Gerum <rpm@xenomai.org>
>>>
>>> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
>>> ---
>>>  .../cobalt/kernel/dovetail/pipeline/trace.h   | 123 ++++++++++++++++++
>>>  1 file changed, 123 insertions(+)
>>>  create mode 100644 include/cobalt/kernel/dovetail/pipeline/trace.h
>>>
>>> diff --git a/include/cobalt/kernel/dovetail/pipeline/trace.h b/include/cobalt/kernel/dovetail/pipeline/trace.h
>>> new file mode 100644
>>> index 000000000..819b8a713
>>> --- /dev/null
>>> +++ b/include/cobalt/kernel/dovetail/pipeline/trace.h
>>> @@ -0,0 +1,123 @@
>>> +/*
>>> + * Copyright (C) 2006 Jan Kiszka <jan.kiszka@web.de>.
>>> + *
>>
>> Should likely be updated when filled.
>>
> 
> I'm refraining from modifying others' copyright stanzas. When splitting
> an existing file, I most often duplicate the copyright notice of the
> original one into the resulting files "as is".
> 

By the time you drop in your implementation and remove mine from the
stubs, just update this because latest then the copyright changed.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

