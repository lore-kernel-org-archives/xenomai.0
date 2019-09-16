Date: Mon, 16 Sep 2019 05:10:42 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
Message-ID: <1762355232.5762576.1568628642606.JavaMail.zimbra@wolfram.com>
In-Reply-To: <cdf92817-b8a6-83a3-0f51-e271aec5fdc3@siemens.com>
References: <2078452807.5749189.1568619128144.JavaMail.zimbra@wolfram.com>
 <cdf92817-b8a6-83a3-0f51-e271aec5fdc3@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@xenomai.org>

----- Den 16 sep 2019, p=C3=A5 kl 11:34, Jan Kiszka jan.kiszka@siemens.com =
skrev:

> On 16.09.19 09:32, Per Oberg via Xenomai wrote:
> > Hello list

>> I am trying to understand how rtdm works, and possibly why out of a hist=
orical
>> context. Perhaps there is a good place to read up on this stuff, then pl=
ease
> > let me know.

> > It seems like in the rtdm-api there is only open, but no open_rt or ope=
n_nrt.
> > More specifically we have:
> > - read_rt / read_nrt
> > - recvmsg_rt / recvmsg_nrt
> > - ioctl_rt / ioctl_nrt
> > - .. etc.

>> However, when studying an old xenomai2->3 ported driver it seems like th=
ere used
>> to be open_rt and open_nrt. The problem I was having before (see my back=
ground
>> comment below) was because the open had been mapped to the old open_nrt =
code,
>> which in turned used a rt-lock, thus a mix of the two. When switching to=
 a
> > regular mutex it "worked", as in it didn't complain.

>> In a short discussion Jan Kiszka gave me the impression that open could =
possibly
> > end up being rt or nrt depending on situation.

>> P=C3=96: I'm guessing that open is always non-rt and therefore a rtdm_lo=
ck should be
> > used? ...

> > JK: This depends. If the open code needs to synchronize only with other=
 non-RT
> > JK: paths, normal Linux locks are fine. If there is the need to sync wi=
th the
> > JK: interrupt handler or some of the _rt callbacks, rtdm_lock & Co. is =
needed.


>> So, how does this work? And why was (if it was) open_nrt and open_rt rep=
laced
> > with a common open?


> The original RTDM design was foreseeing the use case of creating and dest=
roying
> resources like file descriptors for devices in RT context. That idea was =
dropped
> as also the trend for the core was clearly making this less realistic.
> Therefore, we removed open/socket_rt from Xenomai 3.

> If you have a driver that exploited open_rt, you need to remove all rt-sl=
eeping
> operations from its open function. If rtdm_lock is an appropriate alterna=
tive
> depends on the driver locking structure and the code run under the lock.
> rtdm_lock_get makes the lock holder unpreemptible. So, if rtdm_mutex was =
chosen
> because of lengthy code under the lock, that would not be a good alternat=
ive.
> Then we would have to discuss what exactly is run there, and why.

Ok, can I read up on this somewhere? I found [1], is that still valid in th=
is context? ( Oh, and can we expect a third edition perhaps ? =3D) )

[1] Building Embedded Linux Systems: Concepts, Techniques, Tricks, and Trap=
s 2nd Edition, Kindle Edition

> > Background
> > ----------------
>> I recently wrote about a driver which warned about "drvlib.c:1349
>> rtdm_mutex_timedlock". I got good answers which led me to some more gene=
ral
>> questions, but instead of continuing in the old tread I thought it bette=
r to
>> start a new one since it's not about the initial problem. The driver in =
case is
> > the Peak Linux Driver for their CAN hardware, see [1]


> > [1] https://www.peak-system.com/fileadmin/media/linux/index.htm


> Did you inform them about their problem already? Maybe they are willing t=
o fix
> it. We can't, it's not upstream code.

No, I haven't, but I will. The reason I haven't yet is because I was under =
the impression that this didn't happen to them. I'm trying to compile every=
thing (driver, lib, and application) in a Yocto based SDK setup and it seem=
s like compilation flags and environment variables are getting squashed in =
interesting ways. My reasoning so far was that I got this wrong somehow.

Then there's the fact that making it work is only part of the goal. I do re=
ally want to understand how this fits together.

> Jan



> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux

Thanks
Per =C3=96berg=20

