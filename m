From: "Stoidner, Christoph" <c.stoidner@arvero.de>
Date: Thu, 11 Dec 2014 11:17:42 +0000
Message-ID: <67263b7a47034e2fba906d0b68b3277f@EX132MBOX1A.de2.local>
References: <8119909587ec45d1ba5696722a1b0945@EX132MBOX1A.de2.local>
 <20141210190114.GQ1524@hermes.click-hack.org>
 <6f637a6b60964c49bbc08e3204c8eae3@EX132MBOX1A.de2.local>
 <20141211100520.GA21808@hermes.click-hack.org>
 <88cb5162a0ca44fb8251aa8161a8d8d8@EX132MBOX1A.de2.local>
 <20141211102249.GB21808@hermes.click-hack.org>
 <14309ee2cb7e45c9a01e6e1504c5bed5@EX132MBOX1A.de2.local>,
 <20141211104713.GC21808@hermes.click-hack.org>
In-Reply-To: <20141211104713.GC21808@hermes.click-hack.org>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Sleeping function called from invalid context
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

>>=0A=
>> In this application the switchback syscalls are used rather often.=0A=
>=0A=
>Two things to note:=0A=
>=0A=
>- mode switches do not go without some overhead, it is almost never=0A=
>a good idea to force the switchback, since the nucleus will switch=0A=
>the target thread to secondary mode when needed anyway, all that you=0A=
>risk is to introduce useless mode switches, so, if you do it, you=0A=
>must have a good reason for it;=0A=
=0A=
Yes I know. However we need to assure that the task switches back to second=
ary domain after using skin's call, since otherwise it would affect other l=
inux tasks which actual have a higher linux-priority. In general we try to =
simulate something like "priority coupling" since this is marked as depreca=
ted.=0A=
=0A=
>- there is a risk of overflowing the nucleus queue for relax=0A=
>requests, you will see a message in the kernel logs when this=0A=
>happens if you enable debugging of the nucleus=0A=
>(CONFIG_XENO_OPT_DEBUG_NUCLEUS).=0A=
=0A=
I have enabled CONFIG_XENO_OPT_DEBUG_NUCLEUS now but I do not see any accor=
ding message.=0A=
=0A=
Regards,=0A=
Christoph=0A=

