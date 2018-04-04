From: Sagi Maimon <SMaimon@advaoptical.com>
Date: Wed, 4 Apr 2018 12:57:31 +0000
Message-ID: <c7227f3e81cd465bb26045a7a4a6f662@advaoptical.com>
References: <mailman.27.1522680894.4366.xenomai@xenomai.org>
 <8214382.neGrAg1Q7R@wirbelwind>
 <20180403183138.muvg7ntdj2hhesd3@csclub.uwaterloo.ca>,
 <e6b33545f46048ada70f0e10863bf3b4@advaoptical.com>
 <0A5CA087C7C2B54F937024C86CBC8AD515BA78D3@NDMSMBX402.ndc.nasa.gov>
In-Reply-To: <0A5CA087C7C2B54F937024C86CBC8AD515BA78D3@NDMSMBX402.ndc.nasa.gov>
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
To: "Seeger, Steven D. (GSFC-582.0)[Embedded Flight Systems, Inc]" <steven.seeger@nasa.gov>, Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

HI,
I did it only from Linux side.
I can try doing it from xenomai side too.
Please explain how would it help to investigate the problem?

Thanks,
Sagi

-----Original Message-----
From: Seeger, Steven D. (GSFC-582.0)[Embedded Flight Systems, Inc] [mailto:=
steven.seeger@nasa.gov]=20
Sent: Wednesday, April 04, 2018 15:55
To: Sagi Maimon <SMaimon@advaoptical.com>; Lennart Sorensen <lsorense@csclu=
b.uwaterloo.ca>
Cc: xenomai@xenomai.org
Subject: RE: [Xenomai] Unrecoverable FP Unavailable Exception 801

Can you trigger alignment exception both from a regular Linux user thread a=
nd a xenomai user thread?=20
________________________________________
From: Sagi Maimon [SMaimon@advaoptical.com]
Sent: Wednesday, April 04, 2018 6:17 AM
To: Lennart Sorensen; Seeger, Steven D. (GSFC-582.0)[Embedded Flight System=
s, Inc]
Cc: xenomai@xenomai.org
Subject: RE: [Xenomai] Unrecoverable FP Unavailable Exception 801

As far as I know The system doesn't use kernel threads that use the FPU (bu=
t it is a huge system, so I hard to be sure) What I know for sure, is that =
some processes on user space use double variables in user space.
I have also wrote some user space application that triggers the "Alignment =
Exception (600)", just for testing.


-----Original Message-----
From: Xenomai [mailto:xenomai-bounces@xenomai.org] On Behalf Of Lennart Sor=
ensen
Sent: Tuesday, April 03, 2018 21:32
To: Steven Seeger <steven.seeger@nasa.gov>
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai] Unrecoverable FP Unavailable Exception 801

On Tue, Apr 03, 2018 at 09:57:52AM -0400, Steven Seeger wrote:
> I'm a little curious about the fact that the address this occurred at=20
> is 0xc0003858, which suggests it's kernel code. As Philippe asked,=20
> what version of the ipipe are you using? Also, what is your exact CPU?
> The e300c2 does not have an FPU, so this would be quite a configuration p=
roblem.

Did I miss e300c2 being mentioned?  If so, that would be a problem.

> Are you using any kernel threads that use the FPU?

I would hope not.  Doing that is painful.

--
Len Sorensen

_______________________________________________
Xenomai mailing list
Xenomai@xenomai.org
https://xenomai.org/mailman/listinfo/xenomai

