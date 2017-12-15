References: <954f3936-9906-a33e-4d6a-fa5e640430e4@xenomai.org>
 <bb013c41-9b90-4bc1-a84a-6e5137061ceb@alaxarxa.net>
 <20f31474-8d30-fad7-c79d-bd4cf03295ae@xenomai.org>
 <56e8674c-9744-3bf4-ba7a-b3df1fd113fa@alaxarxa.net>
 <da516d20-d6fd-5043-8854-d648df01cf13@xenomai.org>
From: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Message-ID: <1d12f49c-6932-73e8-d29c-939a4f355eb8@alaxarxa.net>
Date: Fri, 15 Dec 2017 22:42:53 +0100
MIME-Version: 1.0
In-Reply-To: <da516d20-d6fd-5043-8854-d648df01cf13@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTnet fixes - testers needed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

El 15/12/17 a les 21:47, Philippe Gerum ha escrit:
> On 12/15/2017 01:25 PM, Leopold Palomo-Avellaneda wrote:
>> Hi,
>>
>> I forgot something more:
>>
>> On 15/12/17 12:04, Philippe Gerum wrote:
>>
>> [...]
>>>>
>>>> I guess that there's something in the kernel config or somewhere in 3.x that
>>>> affects the PCI cards. In 2.6.x worked.
>>>
>>> On x86, I'd dare to say that it worked mostly by accident, as revealed
>>> by SMAP later on. RTnet was out of the Xenomai tree in 2.6.x, some
>>> changes introduced during the merge into 3.x might have caused
>>> regressions, or maybe some latent issues started to bite when transposed
>>> in a different environment, just like the SMAP problem on x86, revealing
>>> an ancient Rnet bug. I genuinely don't know when things started to hit
>>> the fan.
>>
>> I don't know if it's relevant or not, or I didn't understand it, but I think
>> that I still have problems with SMAP. If I activate it, I got:
>>
> 
> Please confirm that you are running wip/rtnet-fixes, and not
> stable-3.0.x or next which are still plagued with direct usermem access
> bugs. The backtrace shows SMAP biting in rt_packet_ioctl(), which is
> actually the first routine I fixed in the AF_PACKET layer, removing such
> invalid accesses, since I need that one.

well, I'm remotely connected to my robotic platform and it seems that it's the
version that I built on monday 3.0.6+ds2rtnet-1~drp9+20171211. I built it from:

xenomai-3.git (wip/rtnet-fixes)$

and these are the last two entries of the git:

commit c640a6040e72c7597d06b119d3ce30fbf3408e82
Author: Philippe Gerum <rpm@xenomai.org>
Date:   Wed Dec 6 13:41:06 2017 +0100

    net/iovec: drop useless kernel<-> iovec[] copy helpers

    No more in-tree users for those, in the wake of dropping the broken
    direct references from the kernel to user-space memory.

commit 64d2b7657ce4bddb2e2cc1a209dfedfa01000502
Author: Philippe Gerum <rpm@xenomai.org>
Date:   Wed Dec 6 13:40:19 2017 +0100

    net: convert to rtdm_get_iov_flatlen()


> If you still have this issue over the wip/rtnet-fixes branch, then
> please use addr2line to find out which source line triggers the bug in
> af_packet.c.

ok, on monday I will check again and I try to follow your indications.

Best regards,

Leopold


