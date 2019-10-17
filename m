Date: Thu, 17 Oct 2019 00:52:12 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
Message-ID: <479718447.15280.1571291532705.JavaMail.zimbra@wolfram.com>
In-Reply-To: <d8d9992a-68b6-0257-b4c1-dc5ec436dde7@linx-info.com>
References: <7f7c7a6a-ae0b-a95a-93ec-05940a109fc3@linx-info.com>
 <1830389674.1482147.1571212525654@mail.yahoo.com>
 <d09e3dbd-c507-f000-f07a-344b6b7603a6@siemens.com>
 <d8d9992a-68b6-0257-b4c1-dc5ec436dde7@linx-info.com>
Subject: Re: issue of hibernate for ipipe
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Alec Ari <neotheuser@ymail.com>, =?utf-8?B?5b2t5b+X6Iiq?= <zhpeng@linx-info.com>, duanwujie <wjduan@linx-info.com>


----- Den 17 okt 2019, p=C3=A5 kl 2:56, xenomai xenomai@xenomai.org skrev:

> Here is my test case:

> Install debian 9.6 in virtual machine(virtualbox).

> - Case 1: Build ipipe kernel(4.9.146) with debian's kerner default
> config, when use this kernel to bootup system, click hibernate
> button(This condition will be failed)

> - Case 2: Build ipipe kernel(4.14.134) with debian's kernel default
> config (this version will be success), can hibernate and wake up

I think what Jan ment with his question was:=20
Is there a reason you need this functionality? Does it benefit your product=
 or application somehow? Do you perhaps have a controller that sometimes ne=
eds real time performance and sometimes needs to hibernate/sleep to save po=
wer?

> =E5=9C=A8 2019/10/17 =E4=B8=8A=E5=8D=881:29, Jan Kiszka =E5=86=99=E9=81=
=93:
> > On 16.10.19 09:55, Alec Ari via Xenomai wrote:
>>> Hibernate/suspend/C-states etc generally cause problems with IPIPE. Bes=
t to not
> >> have any of that.
> > Indeed (at least hibernate and suspend). I remember having looked at
> > these paths only a long time ago (>10 years) when I was running Xenomai
> > for testing purposes on my notebook. And that was recurring effort.
> > Since then, likely no one cared.

> > We could declare the related config options as "depends on !IPIPE" to
> > avoid troubles.

> > Or do you have an actual use case for for hibernate, Wujie Duan?

> > Jan

> --
> *Linx Software Corportaion Sichuan Branch
> Name=EF=BC=9Awujie duan
> Tel=EF=BC=9A028-65182023-6202
> E-mail: wjduan@linx-info.com
> *

Per =C3=96berg=20

