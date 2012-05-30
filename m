From: Chris Stone <chris.stone@optelian.com>
Date: Wed, 30 May 2012 17:32:48 +0000
Message-ID: <623784B6C75D274389918D358E89E8BB0B7FE2DD@OPTELIAN5.optelian.local>
References: <CAKKWdtc6Py7A9YuJ1nNzwmq0SiEcrP_D8pztoo_eNWsp9EAsFg@mail.gmail.com>
	<4FC637EB.90908@xenomai.org> <4FC63C53.3020805@xenomai.org>
	<20120530155743.GK32727@csclub.uwaterloo.ca>
In-Reply-To: <20120530155743.GK32727@csclub.uwaterloo.ca>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] a question about ADEOS
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Rest assured there are many users of Adeos/Xenomai that believe it is a muc=
h more elegant/reliable/efficient/simple=20
choice for real time in Linux. The linux scheduler is a mammoth beast that =
takes far too long to run. One of=20
the finest advantages of Adeos/Xenomai is that you get to preempt the mammo=
th beast with a simple and fast=20
real time scheduler. PREEMPT-RT is an interesting solution, but is not a pa=
rticularly well thought out one.=20
PREEMPT-RT is unstable and slow, which is why it STILL isn't fully accepted=
 into the native kernel yet, after at=20
least 8 years of trying to get it in. In another five years, PREEMPT_RT wil=
l make Xenomai better by reducing=20
worst case latency when an application switches to secondary mode, but it w=
ill never replace Adeos/Xenomai.=20

Cheers,
  Chris.

-----Original Message-----
From: xenomai-bounces@xenomai.org [mailto:xenomai-bounces@xenomai.org] On B=
ehalf Of Lennart Sorensen
Sent: Wednesday, May 30, 2012 11:58 AM
To: Gilles Chanteperdrix
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai] a question about ADEOS

On Wed, May 30, 2012 at 05:27:15PM +0200, Gilles Chanteperdrix wrote:
> If the question is: why is not Adeos integrated in the mainline kernel ?
> the answer is that the kernel community has chosen another solution to=20
> enable real-time, and is not interested in integrating the Adeos patch.

As a user of adeos and xenomai, I do look forward to the day xenomai works =
with the other option so that a single scheduler can handle everything and =
give much better control over things.  But there is much work to be done be=
fore that happens as far as I can tell.

ipipe is an interesting solution, although not a particularly nice one.

--
Len Sorensen

_______________________________________________
Xenomai mailing list
Xenomai@xenomai.org
http://www.xenomai.org/mailman/listinfo/xenomai

