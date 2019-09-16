Subject: Re: Finalizing 3.1, finally
References: <65e561a8-404a-6f71-106c-b05d6d8dc34d@siemens.com>
 <trinity-464d3e0c-84f5-4f3a-bf02-144c6347537e-1568402433614@3c-app-gmx-bap08>
 <2ca1f7e5-d37c-e00b-deb7-839b2946fc17@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <7c463226-8179-c02e-1416-0e70c59a4fe6@xenomai.org>
Date: Mon, 16 Sep 2019 20:37:59 +0200
MIME-Version: 1.0
In-Reply-To: <2ca1f7e5-d37c-e00b-deb7-839b2946fc17@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, Sebastian Smolorz <Sebastian.Smolorz@gmx.de>
Cc: Xenomai <xenomai@xenomai.org>

On 9/16/19 11:26 AM, Jan Kiszka wrote:
> On 13.09.19 21:20, Sebastian Smolorz wrote:
>> Hi Jan,
>>
>> Jan Kiszka wrote:
>>> we are postponing this for too long now, so I'd like to make step
>>> towards a
>>> feature freeze for 3.1, marked by an -rc1, and then a release. So,
>>> everyone
>>> sitting on API- or even ABI-breaking changes should speak up now.
>>
>> This week I have improved the close behaviour of the rttcp driver but
>> want
>> to make some more tests in the next week before I post a patch. When do
>> you plan to release -rc1?
> 
> Depends on the feedback. Given yours, let's target for end of next week.
> Philippe, is that realistic?
> 

I'll be mostly offline until October, but I have a short window of
opportunity for fixing the device teardown stuff next week when I'm back
to my office. So end of next week seems reasonable for 3.1 with this fix in.

Regarding the vlan and multicast support for RTnet, this needs review
from your end and some exposure in -next until we can reasonably see
this merged to master. As much as I would have liked to see this queued
for 3.1, this will have to wait for 3.2.

-- 
Philippe.

