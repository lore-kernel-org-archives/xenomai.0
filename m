References: <E1b6BNz-0003SF-Fa@sd-51317.xenomai.org>
 <20160527065822.GH22660@hermes.click-hack.org> <57480435.7040408@web.de>
 <20160527083333.GK22660@hermes.click-hack.org>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <57480F0E.2050501@web.de>
Date: Fri, 27 May 2016 11:10:38 +0200
MIME-Version: 1.0
In-Reply-To: <20160527083333.GK22660@hermes.click-hack.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : cobalt/rtdm: Fix driver
 reference counting
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 2016-05-27 10:33, Gilles Chanteperdrix wrote:
> On Fri, May 27, 2016 at 10:24:21AM +0200, Jan Kiszka wrote:
>> On 2016-05-27 08:58, Gilles Chanteperdrix wrote:
>>> On Fri, May 27, 2016 at 08:36:43AM +0200, git repository hosting wrote:
>>>> Module: xenomai-jki
>>>> Branch: for-forge
>>>> Commit: c9d83776c0ed882c71045dc32b340b57f88c5e00
>>>> URL:    http://git.xenomai.org/?p=3Dxenomai-jki.git;a=3Dcommit;h=3Dc9d=
83776c0ed882c71045dc32b340b57f88c5e00
>>>>
>>>> Author: Jan Kiszka <jan.kiszka@siemens.com>
>>>> Date:   Fri May 27 08:32:41 2016 +0200
>>>>
>>>> cobalt/rtdm: Fix driver reference counting
>>>>
>>>> The rtdm smokey test triggered a BUG due to rtdm_dev_unregister not
>>>> taking the reference counter of a driver into account. Fix this by
>>>> moving the check into unregister_driver directly.
>>>
>>> Did you have a look at commit
>>> 96e85548a56c8c7fbd6d64c079701483a8e5da27 ?
>>> This looks like a revert, so since the commit was fixing something,
>>> I believe you are reintroducting a bug.
>>>
>>
>> Didn't see that. However, that commit was wrong because you were mixing
>> up different reference counters. One is that for devices, which is
>> decreased in __rtdm_put_device. The other is what un/register_driver
>> have to handle: that of the corresponding rtdm_driver. A device might
>> pass earlier than a driver because the latter may manage multiple
>> devices - exactly what the unit test checks.
>>
>> Maybe you can describe what scenarios was triggering the issue back, and
>> we can check if it reoccurred and fix it for good.
> =

> Well, that was pretty simple, removing kernel modules registering
> devices (in my case it was rtnet.ko), would fail to unregister some
> part of the driver (some proc or sys files if I remember correctly),
> so that reinserting the driver would first cause some warning, and
> after several rmmod/insmod result in a crash or a simple failure I
> do not remember. I traced that to the fact that the test for the
> reference counter in unregister_driver was failing because the
> reference counter had already been decremented elsewhere. This was a
> long time ago, I do not remember all the details, but I think it is
> something like that.
> =


I can remove and reload a stack of rtnet, rt_e1000 and rtipv4 multiple
times without any bug reports. /proc/rtnet also properly disappears and
reappears. However, unloading and loading rtpacket causes an oops.

BUG: unable to handle kernel paging request at ffffffffa01b5b20
IP: [<ffffffff81079d20>] blocking_notifier_chain_register+0x40/0xb0
...
Call Trace:
 [<ffffffff8114f6b8>] cobalt_add_state_chain+0x18/0x20
 [<ffffffff8117a403>] rtdm_dev_register+0x1d3/0x660
 [<ffffffff8110e84c>] ? ipipe_unstall_root+0x5c/0x90
 [<ffffffff810003b0>] ? do_one_initcall+0x80/0x1f0
 [<ffffffffa01d5000>] ? 0xffffffffa01d5000
 [<ffffffffa01d5015>] rt_packet_proto_init+0x15/0x48 [rtpacket]
 [<ffffffffa01d5000>] ? 0xffffffffa01d5000
 [<ffffffff810003c0>] do_one_initcall+0x90/0x1f0

Let me check that.

Jan

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: OpenPGP digital signature
URL: <http://xenomai.org/pipermail/xenomai/attachments/20160527/e7bff3ed/at=
tachment.sig>
