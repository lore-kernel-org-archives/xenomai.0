From: Sagi Maimon <SMaimon@advaoptical.com>
Date: Wed, 4 Apr 2018 10:10:45 +0000
Message-ID: <a15b6705f2b441e694abd59212291285@advaoptical.com>
References: <mailman.27.1522680894.4366.xenomai@xenomai.org>
 <8214382.neGrAg1Q7R@wirbelwind>
 <20180403183138.muvg7ntdj2hhesd3@csclub.uwaterloo.ca>
 <2544472.VAFtTCK4Fx@wirbelwind>
In-Reply-To: <2544472.VAFtTCK4Fx@wirbelwind>
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
To: "steven.seeger@nasa.gov" <steven.seeger@nasa.gov>, Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Correct :-)


-----Original Message-----
From: Xenomai [mailto:xenomai-bounces@xenomai.org] On Behalf Of Steven Seeg=
er
Sent: Tuesday, April 03, 2018 21:34
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai] Unrecoverable FP Unavailable Exception 801

On Tuesday, April 3, 2018 2:31:38 PM EDT Lennart Sorensen wrote:
> On Tue, Apr 03, 2018 at 09:57:52AM -0400, Steven Seeger wrote:
> > I'm a little curious about the fact that the address this occurred=20
> > at is 0xc0003858, which suggests it's kernel code. As Philippe=20
> > asked, what version of the ipipe are you using? Also, what is your=20
> > exact CPU? The
> > e300c2 does not have an FPU, so this would be quite a configuration=20
> > problem.
>=20
> Did I miss e300c2 being mentioned?  If so, that would be a problem.

He did not mention the e300c2 but I just wanted to clarify. From a private =
email, it sounds like Sagi is working on a legacy product from before his t=
ime at the company that has periodically had this problem and required thei=
r customers to reboot it.

This brings back many "fond" memories of Gilles helping me chase down a sim=
ilar bug on the Geode about ten years ago.

Sagi is using some extremely old stuff, so if he has the capability to put =
a fix in and recompile he might as well update the kernel if possible.

Steven




_______________________________________________
Xenomai mailing list
Xenomai@xenomai.org
https://xenomai.org/mailman/listinfo/xenomai

