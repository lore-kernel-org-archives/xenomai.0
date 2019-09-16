Date: Mon, 16 Sep 2019 10:33:10 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
Message-ID: <1295125104.5915666.1568647990243.JavaMail.zimbra@wolfram.com>
In-Reply-To: <11d341ef-47a4-0dd6-62f7-7fc30cd1796e@siemens.com>
References: <1498070335.5810731.1568637405044.JavaMail.zimbra@wolfram.com>
 <606820185.5820958.1568637688860.JavaMail.zimbra@wolfram.com>
 <11d341ef-47a4-0dd6-62f7-7fc30cd1796e@siemens.com>
Subject: Re: RTDM open, open_rt, and open_nrt
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


----- Den 16 sep 2019, p=C3=A5 kl 16:59, Jan Kiszka jan.kiszka@siemens.com =
skrev:

> On 16.09.19 14:41, Per Oberg via Xenomai wrote:
> > ----- Den 16 sep 2019, p=C3=A5 kl 14:36, Per =C3=96berg pero@wolfram.co=
m skrev:

> >> ----- Den 16 sep 2019, p=C3=A5 kl 11:34, Jan Kiszka jan.kiszka@siemens=
.com skrev:

> >>> On 16.09.19 09:32, Per Oberg via Xenomai wrote:
> >>>> Hello list

> >>>> I am trying to understand how rtdm works, and possibly why out of a =
historical
> >>>> context. Perhaps there is a good place to read up on this stuff, the=
n please
> >>>> let me know.

> >>>> It seems like in the rtdm-api there is only open, but no open_rt or =
open_nrt.
> >>>> More specifically we have:
> >>>> - read_rt / read_nrt
> >>>> - recvmsg_rt / recvmsg_nrt
> >>>> - ioctl_rt / ioctl_nrt
> >>>> - .. etc.

> >>>> However, when studying an old xenomai2->3 ported driver it seems lik=
e there used
> >>>> to be open_rt and open_nrt. The problem I was having before (see my =
background
> >>>> comment below) was because the open had been mapped to the old open_=
nrt code,
> >>>> which in turned used a rt-lock, thus a mix of the two. When switchin=
g to a
> >>>> regular mutex it "worked", as in it didn't complain.

> >>>> In a short discussion Jan Kiszka gave me the impression that open co=
uld possibly
> >>>> end up being rt or nrt depending on situation.

> >>>> P=C3=96: I'm guessing that open is always non-rt and therefore a rtd=
m_lock should be
> >>>> used? ...

> >>>> JK: This depends. If the open code needs to synchronize only with ot=
her non-RT
> >>>> JK: paths, normal Linux locks are fine. If there is the need to sync=
 with the
> >>>> JK: interrupt handler or some of the _rt callbacks, rtdm_lock & Co. =
is needed.

> >>>> So, how does this work? And why was (if it was) open_nrt and open_rt=
 replaced
> >>>> with a common open?

> >>> The original RTDM design was foreseeing the use case of creating and =
destroying
> >>> resources like file descriptors for devices in RT context. That idea =
was dropped
> >>> as also the trend for the core was clearly making this less realistic=
.
> >>> Therefore, we removed open/socket_rt from Xenomai 3.

> >>> If you have a driver that exploited open_rt, you need to remove all r=
t-sleeping
> >>> operations from its open function. If rtdm_lock is an appropriate alt=
ernative
> >>> depends on the driver locking structure and the code run under the lo=
ck.
> >>> rtdm_lock_get makes the lock holder unpreemptible. So, if rtdm_mutex =
was chosen
> >>> because of lengthy code under the lock, that would not be a good alte=
rnative.
> >>> Then we would have to discuss what exactly is run there, and why.

> >> Ok, can I read up on this somewhere? I found [1], is that still valid =
in this
> >> context? ( Oh, and can we expect a third edition perhaps ? =3D) )

> >> [1] Building Embedded Linux Systems: Concepts, Techniques, Tricks, and=
 Traps 2nd
> >> Edition, Kindle Edition

> Basic locking principles should be covered there, not sure if it had a
> Xenomai/RTDM section. If so, check if it was written/updated after 2015.

It has, but it's written in 2008. With references for a paper you wrote. ( =
"The Real-Time Driver Model and First Applications" )

> >>>> Background
> >>>> ----------------
> >>>> I recently wrote about a driver which warned about "drvlib.c:1349
> >>>> rtdm_mutex_timedlock". I got good answers which led me to some more =
general
> >>>> questions, but instead of continuing in the old tread I thought it b=
etter to
> >>>> start a new one since it's not about the initial problem. The driver=
 in case is
> >>>> the Peak Linux Driver for their CAN hardware, see [1]

> >>>> [1] https://www.peak-system.com/fileadmin/media/linux/index.htm

> >>> Did you inform them about their problem already? Maybe they are willi=
ng to fix
> >>> it. We can't, it's not upstream code.

> >> No, I haven't, but I will. The reason I haven't yet is because I was u=
nder the
> >> impression that this didn't happen to them. I'm trying to compile ever=
ything
> >> (driver, lib, and application) in a Yocto based SDK setup and it seems=
 like
> >> compilation flags and environment variables are getting squashed in in=
teresting
> >> ways. My reasoning so far was that I got this wrong somehow.

>> Forget that, I did actually ask them and they answered in a manner that
>> suggested that I was doing something wrong (wrong compilation flags or u=
ser
>> privileges ). I never got rid of the warning though and it fell into the=
 dark
> > corners of the backlog.


> If they argued about "compilation flags" when a kernel bug was thrown, th=
ey may
> not have gotten the point yet. These flags reveal architectural issues of=
 the
> implementation. Of course they disappear when you turn debugging off. But=
 then
> the get replaced by deadlock or real crashed later.

I think I mislead you somehow. I'm not saying that this is the argument the=
y made, and while talking to you I revisited the issue and brought it up wi=
th them again. They have been friendly so far afaik so perhaps it will be s=
orted.

I will try to get my point/question more clear. What I was trying to explai=
n is that they have multiple drivers in the same driver code base covering =
Xenomai2 +3 , RTAI, and regular Linux (and perhaps more).

I am therefore trying to understand=20

1) whether the driver is fundamentally broken

2) whether I somehow got a mix of the Xenomai3 and regular Linux driver cod=
e by screwing up the build process. I agree that if this can happen there a=
re stuff that can be improved in the build process, but cross-compiling stu=
ff is a real mess...=20

3) whether there may be other ways to get this result without there being a=
n "actual" issue with the driver. Now, with my limited knowledge, I could t=
hink of ways where the driver implemented one "correct" way of opening the =
device, but failed detecting if the user somehow opened it the wrong way. I=
 agree that for this case the driver is flawed in not telling the user what=
 is actually wrong and just go along with what is at hand.=20

Given your reactions it seems like 3) is out of the question, which leaves =
1) and 2).=20

You also, implicitly, say that Xenomai cannot help with fixing their driver=
 because it's not upstream which I accept. The driver is open sourced, so p=
arts of it could eventually be adopted into xenomai (perhaps by me sometime=
, who knows). I am, however, not trying to argue about that.=20

I tried steering the discussion away from the particular issues in this dri=
ver because I to believe that they are not your / Xenomai communitys proble=
m. I simply want to understand how things are supposed to fit together so t=
hat I can eventually write my own drivers for other stuff in the future.

> Jan


> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux

Per =C3=96berg=20

