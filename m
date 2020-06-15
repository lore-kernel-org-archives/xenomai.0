Date: Mon, 15 Jun 2020 10:34:26 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
Message-ID: <268263506.398534.1592235266643.JavaMail.zimbra@wolfram.com>
Subject: Usage of xenomai-images
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

Hi list=20

I thought I'd take the xenomai-images from [1] out for a spin and I think I=
 got it working. However, A few pointers about what is what would have been=
 helpful.=20

E.g.=20

Under "Building Target Images" there could have been a note saying that you=
 need the kas.yml files and board-qemu-amd64.yml available. I feel those in=
structions are a bit incomplete.=20
At docker-hub there are no comments/descriptions for the kas-isar and kas i=
mages so it's a bit difficult to know what to use.=20

Now it seems to be working when using the provided "kas-docker" script, but=
 then I tried using a bind-mount and bash to get inside the docker and run =
it from there. 'docker run -it --mount type=3Dbind,source=3D"$HOME"/kas-bui=
lder,target=3D/builder kasproject/kas bash'.=20

For the "kas" docker image I get errors related to missing isar, and for th=
e kas-isar docker image i get "mount: /proc/sys/fs/binfmt_misc: permission =
denied." so i tried adding the --privileged flag which seems to be working.=
 Perhaps there could be a better "Start Here" guide giving some hints about=
 this.=20

Also, are there any binary links to -wic files that I can download and run =
using my own qemu so that I don't have to build them myself?

[1] https://gitlab.denx.de/Xenomai/xenomai-images

Per =C3=96berg=20

