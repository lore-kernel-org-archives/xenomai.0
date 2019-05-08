Date: Wed, 08 May 2019 01:53:51 +0000
From: Jeff Webb <w1@codecraftsmen.org>
Reply-To: Jeff Webb <w1@codecraftsmen.org>
Subject: RE: select() unblocks when no data to read()
Message-ID: <VpFdLbJqKpBKdxuwpEr9vxR2VBu2j4uXIps1EM68ktxueh7Q9bRQeHRA56sFDKeY1xbPcvb6TuGG01MVtxNt03OdF6N1b3YIEPjJnzbRjqk=@codecraftsmen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

I am having trouble using select() to perform a timed wait on a UDD file de=
scriptor to detect interrupts from a custom PCI card.  After some searching=
, I came across this thread from 2017 that describes my exact issue:

https://xenomai.org/pipermail/xenomai/2017-July/037494.html

I am using x86-64 instead of ARM, but I am having the same trouble.  The or=
iginal poster did a great job of describing the problem, so I won't repeat =
it.  If I use only read() without select(), things work as expected, but I =
need to implement a timeout.

It sounds like Philippe was going to look into the issue further.  Has any =
progress on this issue been made since the last post in this thread?

Thanks,

-Jeff Webb


