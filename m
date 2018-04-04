From: Sagi Maimon <SMaimon@advaoptical.com>
Date: Wed, 4 Apr 2018 14:53:13 +0000
Message-ID: <9ff6e19334f24422b06b1ae1394bc14f@advaoptical.com>
References: <mailman.27.1522680894.4366.xenomai@xenomai.org>
 <8214382.neGrAg1Q7R@wirbelwind>
 <20180403183138.muvg7ntdj2hhesd3@csclub.uwaterloo.ca>
 <e6b33545f46048ada70f0e10863bf3b4@advaoptical.com>
 <0A5CA087C7C2B54F937024C86CBC8AD515BA78D3@NDMSMBX402.ndc.nasa.gov>
 <c7227f3e81cd465bb26045a7a4a6f662@advaoptical.com>
 <20180404144548.uz5zts6chla6hhob@csclub.uwaterloo.ca>
In-Reply-To: <20180404144548.uz5zts6chla6hhob@csclub.uwaterloo.ca>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Unrecoverable FP Unavailable Exception 801
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: "Seeger, Steven D. (GSFC-582.0)[Embedded Flight Systems,
 Inc]" <steven.seeger@nasa.gov>, "xenomai@xenomai.org" <xenomai@xenomai.org>

It is powerpc e300c3 MPC8308.
You are correct the alignment fix is only on the Linux side, you can find i=
t under arch/powerpc/kernel/align.c
The code that fixes the alignment during align exception (600) works most o=
f the time, but sometimes during the alignment fix  "Unrecoverable FP Unava=
ilable Exception" occurs.
My suspicion is that the xenomai still holds the FPU, but I not familiar en=
ough with the xenomi code.
=20

-----Original Message-----
From: Lennart Sorensen [mailto:lsorense@csclub.uwaterloo.ca]=20
Sent: Wednesday, April 04, 2018 17:46
To: Sagi Maimon <SMaimon@advaoptical.com>
Cc: Seeger, Steven D. (GSFC-582.0)[Embedded Flight Systems, Inc] <steven.se=
eger@nasa.gov>; xenomai@xenomai.org
Subject: Re: [Xenomai] Unrecoverable FP Unavailable Exception 801

On Wed, Apr 04, 2018 at 12:57:31PM +0000, Sagi Maimon wrote:
> HI,
> I did it only from Linux side.
> I can try doing it from xenomai side too.
> Please explain how would it help to investigate the problem?

As far as I recall the kernel alignment fixup is only allowed from linux mo=
de since it uses linux kernel code.  The realtime side as far as I recall c=
an't use it.  So if my memory is correct, any code running in the xenomai r=
ealtime part must do everything right and not trigger those exceptions.

What CPU is this?  What does /proc/cpuinfo say it is?

--
Len Sorensen

