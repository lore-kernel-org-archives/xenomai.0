References: <1529936460-16308-1-git-send-email-gengdongjiu@huawei.com>
 <3c1822ae-c546-fdab-9105-834e0e2b8fd3@xenomai.org>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <36097679-8641-1f7a-5609-68f520d8d6ea@huawei.com>
Date: Tue, 26 Jun 2018 09:32:52 +0800
MIME-Version: 1.0
In-Reply-To: <3c1822ae-c546-fdab-9105-834e0e2b8fd3@xenomai.org>
Content-Type: text/plain; charset="utf-8"
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
To: Philippe Gerum <rpm@xenomai.org>, jan.kiszka@siemens.com, edouard.tisserant@gmail.com, xenomai@xenomai.org

Hi Philippe,

On 2018/6/25 18:28, Philippe Gerum wrote:
> On 06/25/2018 04:21 PM, Dongjiu Geng wrote:
>> The arch_timer_mem_use_virtual variable is used to judge the type
>> of memory-mapped timer, it can not be used to judge the type of CP15
>> timer, so fix this issue, otherwise it will lead to kernel panic when
>> running as a VM.
>>
> 
> Merged, thanks.

Sorry for the noise, I see you just merge to "ipipe-arm" project(https://gitlab.denx.de/Xenomai/ipipe-arm).
the ipipe-arm64" project also needs this patch, because arm arch timer driver is used by both arm32 and arm64 platforms.
thanks.


> 


