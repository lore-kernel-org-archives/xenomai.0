Date: Tue, 16 Jun 2020 01:10:12 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
Message-ID: <521678817.890223.1592287812570.JavaMail.zimbra@wolfram.com>
In-Reply-To: <87c60740-7bc5-4790-ff6d-424a325fa871@siemens.com>
References: <268263506.398534.1592235266643.JavaMail.zimbra@wolfram.com>
 <87c60740-7bc5-4790-ff6d-424a325fa871@siemens.com>
Subject: Re: Usage of xenomai-images
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

----- Den 15 jun 2020, p=C3=A5 kl 17:57, Jan Kiszka jan.kiszka@siemens.com =
skrev:

> On 15.06.20 17:34, Per Oberg via Xenomai wrote:
> > Hi list

>> I thought I'd take the xenomai-images from [1] out for a spin and I thin=
k I got
> > it working. However, A few pointers about what is what would have been =
helpful.

> > E.g.

>> Under "Building Target Images" there could have been a note saying that =
you need
>> the kas.yml files and board-qemu-amd64.yml available. I feel those instr=
uctions
> > are a bit incomplete.

> We are happy to take patches! It's always a bit tricky for the those
> using the tool every day in various projects to document the
> (non-)obvious parts for first-time users.

Thanks, I'll do that. I just need to get back up on Github again.

>> At docker-hub there are no comments/descriptions for the kas-isar and ka=
s images
> > so it's a bit difficult to know what to use.

>> Now it seems to be working when using the provided "kas-docker" script, =
but then
>> I tried using a bind-mount and bash to get inside the docker and run it =
from
>> there. 'docker run -it --mount
> > type=3Dbind,source=3D"$HOME"/kas-builder,target=3D/builder kasproject/k=
as bash'.

> Such "simple" docker calls are where kas-docker evolved from. If you
> look at the latest version, it can do way more. It's goal is to provide
> the same frontend as kas natively.


>> For the "kas" docker image I get errors related to missing isar, and for=
 the
>> kas-isar docker image i get "mount: /proc/sys/fs/binfmt_misc: permission
>> denied." so i tried adding the --privileged flag which seems to be worki=
ng.
>> Perhaps there could be a better "Start Here" guide giving some hints abo=
ut
> > this.


> "kas-docker --isar build ..." is doing that for you. "docker/podman run"
> is for the experts. That's why we documented the former.

>> Also, are there any binary links to -wic files that I can download and r=
un using
> > my own qemu so that I don't have to build them myself?

> So far, there is no public build and, thus, artifacts. We will probably
> have them as catch-by of using xenomai-image for regular testing "soon".

> Jan

Great! I think that would be very helpful for attracting people to xenomai.=
=20

> > [1] https://gitlab.denx.de/Xenomai/xenomai-images

> > Per =C3=96berg


> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux

Per =C3=96berg

