References: <1529936460-16308-1-git-send-email-gengdongjiu@huawei.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <3c1822ae-c546-fdab-9105-834e0e2b8fd3@xenomai.org>
Date: Mon, 25 Jun 2018 12:28:04 +0200
MIME-Version: 1.0
In-Reply-To: <1529936460-16308-1-git-send-email-gengdongjiu@huawei.com>
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
To: Dongjiu Geng <gengdongjiu@huawei.com>, jan.kiszka@siemens.com, edouard.tisserant@gmail.com, xenomai@xenomai.org
Cc: ouyangzhaowei@huawei.com, linqiangmin@huawei.com, yangchuanlong@huawei.com, liupeifeng3@huawei.com, zhangjianwei8@huawei.com

On 06/25/2018 04:21 PM, Dongjiu Geng wrote:
> The arch_timer_mem_use_virtual variable is used to judge the type
> of memory-mapped timer, it can not be used to judge the type of CP15
> timer, so fix this issue, otherwise it will lead to kernel panic when
> running as a VM.
> 

Merged, thanks.

-- 
Philippe.

