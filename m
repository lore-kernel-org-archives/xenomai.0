References: <1529936460-16308-1-git-send-email-gengdongjiu@huawei.com>
 <3c1822ae-c546-fdab-9105-834e0e2b8fd3@xenomai.org>
 <36097679-8641-1f7a-5609-68f520d8d6ea@huawei.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <fc6e924f-7e68-a4b0-a363-8a1db82d948e@xenomai.org>
Date: Tue, 26 Jun 2018 08:19:25 +0200
MIME-Version: 1.0
In-Reply-To: <36097679-8641-1f7a-5609-68f520d8d6ea@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] ipipe: arm_arch_timer: correct the wrong
 ipipe_timer setup
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: gengdongjiu <gengdongjiu@huawei.com>, jan.kiszka@siemens.com, edouard.tisserant@gmail.com, xenomai@xenomai.org

On 06/26/2018 03:32 AM, gengdongjiu wrote:
> Hi Philippe,
> 
> On 2018/6/25 18:28, Philippe Gerum wrote:
>> On 06/25/2018 04:21 PM, Dongjiu Geng wrote:
>>> The arch_timer_mem_use_virtual variable is used to judge the type
>>> of memory-mapped timer, it can not be used to judge the type of CP15
>>> timer, so fix this issue, otherwise it will lead to kernel panic when
>>> running as a VM.
>>>
>>
>> Merged, thanks.
> 
> Sorry for the noise, I see you just merge to "ipipe-arm" project(https://gitlab.denx.de/Xenomai/ipipe-arm).
> the ipipe-arm64" project also needs this patch, because arm arch timer driver is used by both arm32 and arm64 platforms.
> thanks.
> 
> 

Dmitriy is maintaining arm64, CCing him.

-- 
Philippe.

