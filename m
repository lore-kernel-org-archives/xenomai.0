From: Brian Eley <Brian.Eley@pason.com>
Date: Fri, 17 Oct 2014 19:31:37 +0000
Message-ID: <1CDD098F4EDCFE4790DD5E4B0D5FFC5A01CECD3B1D@exchmbx1.int.pason.com>
References: <1CDD098F4EDCFE4790DD5E4B0D5FFC5A01CECAF9EF@exchmbx1.int.pason.com>
 <54413268.3080206@xenomai.org>
In-Reply-To: <54413268.3080206@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Xenomai 2.6 Kernel Panic Caused by IO Permissions
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

> -----Original Message-----
> From: Philippe Gerum [mailto:rpm@xenomai.org]
> Sent: October 17, 2014 9:15
> To: Brian Eley; xenomai@xenomai.org
> Subject: Re: [Xenomai] Xenomai 2.6 Kernel Panic Caused by IO Permissions
>=20
> On 09/29/2014 10:57 PM, Brian Eley wrote:
> > Hi All,
> >
> > I've been trying out Xenomai 2.6 for several weeks for use in an embedd=
ed
> system. Xenomai has been working great, but I can make it crash (Kernel
> Panic) in a repeatable way by starting and stopping processes that use IO
> Permissions (for directly accessing IO ports from user space). Interestin=
gly,
> the process with IO permissions doesn't need to use Xenomai to cause the
> panic.
> >
> > I believe I have found the root cause, and I have come up with a potent=
ial
> fix for the issue, but because I am an embedded systems designer with ver=
y
> little kernel programming experience, I would really like to leave it to =
the
> Xenomai team to decide on and implement a proper fix.
> >
> > Following is a description of my setup along with crash dumps, instruct=
ions
> for reproducing, my analysis of the crash, and a patch I used to fix the
> problem on my test system.
> >
>=20
> Your analysis, and the related fix are both correct. I merged the latter =
in the
> mainline repo, along with additional protection for the FPU fixup code ex=
actly
> for the same reason. Thanks for this thorough investigation, and sorry fo=
r the
> late reply.
>=20
> http://git.xenomai.org/ipipe.git/commit/?h=3Dipipe-
> 3.14&id=3D1b59795aaf0ae26b7d024c6311a9788b5256ec7e
>=20
> --
> Philippe.

Hi Philippe,

I'm very happy that you've put in a fix. Many thanks!

Brian


