References: <20210220124527.401015-1-rpm@xenomai.org>
 <20210220124527.401015-3-rpm@xenomai.org>
 <b15e7868-3e9d-aed9-b503-9c71efac6a4b@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH 3/8] cobalt/trace: dovetail: add placeholders for trace
 management
In-reply-to: <b15e7868-3e9d-aed9-b503-9c71efac6a4b@siemens.com>
Date: Mon, 08 Mar 2021 13:31:30 +0100
Message-ID: <87a6rdkesd.fsf@xenomai.org>
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

> On 20.02.21 13:45, Philippe Gerum wrote:
>> From: Philippe Gerum <rpm@xenomai.org>
>> 
>> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
>> ---
>>  .../cobalt/kernel/dovetail/pipeline/trace.h   | 123 ++++++++++++++++++
>>  1 file changed, 123 insertions(+)
>>  create mode 100644 include/cobalt/kernel/dovetail/pipeline/trace.h
>> 
>> diff --git a/include/cobalt/kernel/dovetail/pipeline/trace.h b/include/cobalt/kernel/dovetail/pipeline/trace.h
>> new file mode 100644
>> index 000000000..819b8a713
>> --- /dev/null
>> +++ b/include/cobalt/kernel/dovetail/pipeline/trace.h
>> @@ -0,0 +1,123 @@
>> +/*
>> + * Copyright (C) 2006 Jan Kiszka <jan.kiszka@web.de>.
>> + *
>
> Should likely be updated when filled.
>
>> + * Xenomai is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published
>> + * by the Free Software Foundation; either version 2 of the License,
>> + * or (at your option) any later version.
>> + *
>> + * Xenomai is distributed in the hope that it will be useful, but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with Xenomai; if not, write to the Free Software
>> + * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
>> + * 02111-1307, USA.
>
> And this can then be done shorter.
>
> Both just remarks for future patches, no blockers.

I moved to SPDX tags for libevl and the EVL core. I believe this is the
way to go.

-- 
Philippe.

