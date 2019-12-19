Subject: Re: [PATCH] powerpc: ipipe: Do full exit checks after
 __ipipe_call_mayday
References: <d93a6092-b340-b74b-ff3d-51ac5c438c25@siemens.com>
 <1738468.DV2hKNJMbQ@omoikane>
 <d09d638e-276b-9a4d-28e9-e58392bb6aeb@siemens.com>
 <15932776.13ek4xDJqg@omoikane>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <77ed81c9-e26f-a5ea-63c1-3135e7e18091@siemens.com>
Date: Thu, 19 Dec 2019 18:24:16 +0100
MIME-Version: 1.0
In-Reply-To: <15932776.13ek4xDJqg@omoikane>
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
To: Steven Seeger <steven.seeger@flightsystems.net>
Cc: Xenomai <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

On 19.12.19 18:15, Steven Seeger wrote:
> On Thursday, December 19, 2019 12:14:27 PM EST Jan Kiszka wrote:
>>
>> Check ipipe-arm/ipipe/master:arch/arm/kernel/entry-common.S for the call
>> to ipipe_call_mayday. I suspect that pattern transfers nicely.
>>
>> Jan
> 
> Will do. Can you point me to a smokey test that will prove the implemention is
> fixed? Preferably if you have something that shows it's currently broken.

Hmm, I suppose we have none, otherwise this would have triggered 
earlier. The pattern exposing it may be: Thread A blocks on RT syscall, 
thread B injects Linux signal to thread A, then hands over control. 
Next, thread A should be migrated on return from the syscall, but the 
pending signal delivery should be delayed.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

