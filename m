From: "PRADHAN, MAKARAND (RC-CA)" <makarand.pradhan@siemens.com>
Date: Mon, 15 Sep 2014 15:09:43 +0000
Message-ID: <B89CCBE86D4F62448EE4F6367C6D3C891DAD9670@USMLVA0EM24MSX.ww017.siemens.net>
References: <B89CCBE86D4F62448EE4F6367C6D3C891DACCB0F@USMLVA0EM24MSX.ww017.siemens.net>
 <53E14B37.2040202@xenomai.org>
 <1410537098.19920.YahooMailNeo@web142606.mail.bf1.yahoo.com>
 <B89CCBE86D4F62448EE4F6367C6D3C891DAD9615@USMLVA0EM24MSX.ww017.siemens.net>
 <B89CCBE86D4F62448EE4F6367C6D3C891DAD962F@USMLVA0EM24MSX.ww017.siemens.net>
 <54135D7D.30104@xenomai.org> <20140914024450.GK17690@csclub.uwaterloo.ca>
 <54150B08.5070603@xenomai.org> <54154658.7030006@xenomai.org>
 <5415AEB4.5020701@xenomai.org>
In-Reply-To: <5415AEB4.5020701@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Question regarding rt_sem_p
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Philippe Gerum <rpm@xenomai.org>, Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I've tried the commit and it seems to work. Am running more tests.

Thanks everyone.

Warm Rgds,
Makarand.

-----Original Message-----
From: Xenomai [mailto:xenomai-bounces@xenomai.org] On Behalf Of Gilles Chan=
teperdrix
Sent: Sunday, September 14, 2014 11:05 AM
To: Philippe Gerum; Lennart Sorensen
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai] Question regarding rt_sem_p

On 09/14/2014 09:40 AM, Philippe Gerum wrote:
> On 09/14/2014 05:27 AM, Gilles Chanteperdrix wrote:
>> On 09/14/2014 04:44 AM, Lennart Sorensen wrote:
>>> On Fri, Sep 12, 2014 at 10:54:21PM +0200, Gilles Chanteperdrix wrote:
>>>> On 09/12/2014 10:52 PM, PRADHAN, MAKARAND (RC-CA) wrote:
>>>>> Small correction:
>>>>>
>>>>> The ipipe patch that we are using is derived from ipipe-3.12.0 branch=
.
>>>>
>>>> This means a patch that has not even been tested. It just fixes
>>>> merge conflicts, and has been compile checked, it has not run on
>>>> real hardware. The one which has been tested on real hardware is
>>>> the I-pipe patch for 3.14.0 or 3.14.17.
>>>
>>> Well 3.12 did pass the xenomai testsuite.
>>>
>>> Unfortunately TI isn't quite done moving their patches to the 3.14
>>> branch yet, so we are still stuck at 3.12 (And the 3.8 branch was
>>> way too unstable to use for anything at all even before considering xen=
omai).
>>> Problem with new chips is that they aren't merged into the official
>>> kernel yet, so jumping to a new kernel version isn't trivial.
>>>
>>> I will be checking if the 3.14 branch has enough to boot on Monday
>>> (A lot of stuff was merged in yesterday so it might be getting close no=
w).
>>>
>> I am almost sure I fixed an issue with user-space getting -EINTR with
>> gdb. I simply did not want to look for the commit if you still have
>> the issue with 3.14. If 3.14 does not boot, it looks like I will have
>> to search the commit anyway.
>>
>
> Could be this one, which also fixed a spurious assertion trigger:
> http://git.xenomai.org/ipipe.git/commit/?h=3Dipipe-3.14&id=3Dd7a5e4762535=
f
> 55bfff8eafbf1c1dde214d09bd6
>
Indeed, that is the one.

--
                                                                Gilles.

_______________________________________________
Xenomai mailing list
Xenomai@xenomai.org
http://www.xenomai.org/mailman/listinfo/xenomai

This message and any attachments are solely for the use of intended recipie=
nts. The information contained herein may include trade secrets, protected =
health or personal information, privileged or otherwise confidential inform=
ation. Unauthorized review, forwarding, printing, copying, distributing, or=
 using such information is strictly prohibited and may be unlawful. If you =
are not an intended recipient, you are hereby notified that you received th=
is email in error, and that any review, dissemination, distribution or copy=
ing of this email and any attachment is strictly prohibited. If you have re=
ceived this email in error, please contact the sender and delete the messag=
e and any attachment from your system. Thank you for your cooperation

