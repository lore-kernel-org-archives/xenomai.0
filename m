Subject: Re: [PATCH] dovetail: Add missing uapi header include
References: <b9c1832b-033a-c95a-124a-cd2f16487588@siemens.com>
 <afcae6c6-b0da-8e47-3448-e443bdaf6b5a@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <fa2abadd-5a29-89a6-8d93-37e555740388@xenomai.org>
Date: Wed, 15 Apr 2020 10:43:55 +0200
MIME-Version: 1.0
In-Reply-To: <afcae6c6-b0da-8e47-3448-e443bdaf6b5a@xenomai.org>
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 4/15/20 10:39 AM, Philippe Gerum via Xenomai wrote:
> On 4/14/20 7:30 PM, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Needed for __OOB_SYSCALL_BIT at least.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>> This targets current dovetail/master.
>>
>> BTW, evl/master seems to lag behind dovetail/master ATM.
>>
> 
> Thanks, but I already pushed the equivalent fix a couple of days ago.
> Both evl/master and dovetail/master are in sync with respect to the
> dovetail-related bits. I made sure of this as a result of rebasing them
> over 5.7-rc1.
> 
> Author: Philippe Gerum <rpm@xenomai.org>
> Date:   Mon Apr 13 19:44:24 2020 +0200
> 
>     dovetail: include header for __OOB_SYSCALL_BIT
> 
>     Signed-off-by: Philippe Gerum
> 

Btw, in case that helps tracking this work, I documented the development
& release processes I'm sticking to: https://evlproject.org/devprocess/

-- 
Philippe.

