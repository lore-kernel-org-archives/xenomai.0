References: <E1b6BNz-0003SF-Fa@sd-51317.xenomai.org>
 <20160527065822.GH22660@hermes.click-hack.org>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <57480435.7040408@web.de>
Date: Fri, 27 May 2016 10:24:21 +0200
MIME-Version: 1.0
In-Reply-To: <20160527065822.GH22660@hermes.click-hack.org>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

On 2016-05-27 08:58, Gilles Chanteperdrix wrote:
> On Fri, May 27, 2016 at 08:36:43AM +0200, git repository hosting wrote:
>> Module: xenomai-jki
>> Branch: for-forge
>> Commit: c9d83776c0ed882c71045dc32b340b57f88c5e00
>> URL:    http://git.xenomai.org/?p=3Dxenomai-jki.git;a=3Dcommit;h=3Dc9d83=
776c0ed882c71045dc32b340b57f88c5e00
>>
>> Author: Jan Kiszka <jan.kiszka@siemens.com>
>> Date:   Fri May 27 08:32:41 2016 +0200
>>
>> cobalt/rtdm: Fix driver reference counting
>>
>> The rtdm smokey test triggered a BUG due to rtdm_dev_unregister not
>> taking the reference counter of a driver into account. Fix this by
>> moving the check into unregister_driver directly.
> =

> Did you have a look at commit
> 96e85548a56c8c7fbd6d64c079701483a8e5da27 ?
> This looks like a revert, so since the commit was fixing something,
> I believe you are reintroducting a bug.
> =


Didn't see that. However, that commit was wrong because you were mixing
up different reference counters. One is that for devices, which is
decreased in __rtdm_put_device. The other is what un/register_driver
have to handle: that of the corresponding rtdm_driver. A device might
pass earlier than a driver because the latter may manage multiple
devices - exactly what the unit test checks.

Maybe you can describe what scenarios was triggering the issue back, and
we can check if it reoccurred and fix it for good.

Jan


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: OpenPGP digital signature
URL: <http://xenomai.org/pipermail/xenomai/attachments/20160527/f8710e97/at=
tachment.sig>
