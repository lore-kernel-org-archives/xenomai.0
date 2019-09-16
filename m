Date: Mon, 16 Sep 2019 07:36:45 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
Message-ID: <1498070335.5810731.1568637405044.JavaMail.zimbra@wolfram.com>
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

----- Den 16 sep 2019, p=C3=A5 kl 11:34, Jan Kiszka jan.kiszka@siemens.com =
skrev:=20

> On 16.09.19 09:32, Per Oberg via Xenomai wrote:=20
> > Hello list=20

>> I am trying to understand how rtdm works, and possibly why out of a hist=
orical=20
>> context. Perhaps there is a good place to read up on this stuff, then pl=
ease=20
> > let me know.=20

> > It seems like in the rtdm-api there is only open, but no open_rt or ope=
n_nrt.=20
> > More specifically we have:=20
> > - read_rt / read_nrt=20
> > - recvmsg_rt / recvmsg_nrt=20
> > - ioctl_rt / ioctl_nrt=20
> > - .. etc.=20

>> However, when studying an old xenomai2->3 ported driver it seems like th=
ere used=20
>> to be open_rt and open_nrt. The problem I was having before (see my back=
ground=20
>> comment below) was because the open had been mapped to the old open_nrt =
code,=20
>> which in turned used a rt-lock, thus a mix of the two. When switching to=
 a=20
> > regular mutex it "worked", as in it didn't complain.=20

>> In a short discussion Jan Kiszka gave me the impression that open could =
possibly=20
> > end up being rt or nrt depending on situation.=20

>> P=C3=96: I'm guessing that open is always non-rt and therefore a rtdm_lo=
ck should be=20
> > used? ...=20

> > JK: This depends. If the open code needs to synchronize only with other=
 non-RT=20
> > JK: paths, normal Linux locks are fine. If there is the need to sync wi=
th the=20
> > JK: interrupt handler or some of the _rt callbacks, rtdm_lock & Co. is =
needed.=20


>> So, how does this work? And why was (if it was) open_nrt and open_rt rep=
laced=20
> > with a common open?=20


> The original RTDM design was foreseeing the use case of creating and dest=
roying=20
> resources like file descriptors for devices in RT context. That idea was =
dropped=20
> as also the trend for the core was clearly making this less realistic.=20
> Therefore, we removed open/socket_rt from Xenomai 3.=20

> If you have a driver that exploited open_rt, you need to remove all rt-sl=
eeping=20
> operations from its open function. If rtdm_lock is an appropriate alterna=
tive=20
> depends on the driver locking structure and the code run under the lock.=
=20
> rtdm_lock_get makes the lock holder unpreemptible. So, if rtdm_mutex was =
chosen=20
> because of lengthy code under the lock, that would not be a good alternat=
ive.=20
> Then we would have to discuss what exactly is run there, and why.=20

Ok, can I read up on this somewhere? I found [1], is that still valid in th=
is context? ( Oh, and can we expect a third edition perhaps ? =3D) )=20

[1] Building Embedded Linux Systems: Concepts, Techniques, Tricks, and Trap=
s 2nd Edition, Kindle Edition=20

> > Background=20
> > ----------------=20
>> I recently wrote about a driver which warned about "drvlib.c:1349=20
>> rtdm_mutex_timedlock". I got good answers which led me to some more gene=
ral=20
>> questions, but instead of continuing in the old tread I thought it bette=
r to=20
>> start a new one since it's not about the initial problem. The driver in =
case is=20
> > the Peak Linux Driver for their CAN hardware, see [1]=20


> > [1] https://www.peak-system.com/fileadmin/media/linux/index.htm=20


> Did you inform them about their problem already? Maybe they are willing t=
o fix=20
> it. We can't, it's not upstream code.=20

No, I haven't, but I will. The reason I haven't yet is because I was under =
the impression that this didn't happen to them. I'm trying to compile every=
thing (driver, lib, and application) in a Yocto based SDK setup and it seem=
s like compilation flags and environment variables are getting squashed in =
interesting ways. My reasoning so far was that I got this wrong somehow.=20

Then there's the fact that making it work is only part of the goal. I do re=
ally want to understand how this fits together.=20

> Jan=20



> --=20
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE=20
> Corporate Competence Center Embedded Linux=20

Thanks=20
Per =C3=96berg=20
