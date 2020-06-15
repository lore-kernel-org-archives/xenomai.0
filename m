Subject: Re: Usage of xenomai-images
References: <268263506.398534.1592235266643.JavaMail.zimbra@wolfram.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <87c60740-7bc5-4790-ff6d-424a325fa871@siemens.com>
Date: Mon, 15 Jun 2020 17:57:50 +0200
MIME-Version: 1.0
In-Reply-To: <268263506.398534.1592235266643.JavaMail.zimbra@wolfram.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Per Oberg <pero@wolfram.com>, xenomai <xenomai@xenomai.org>

On 15.06.20 17:34, Per Oberg via Xenomai wrote:
> Hi list 
> 
> I thought I'd take the xenomai-images from [1] out for a spin and I think I got it working. However, A few pointers about what is what would have been helpful. 
> 
> E.g. 
> 
> Under "Building Target Images" there could have been a note saying that you need the kas.yml files and board-qemu-amd64.yml available. I feel those instructions are a bit incomplete. 

We are happy to take patches! It's always a bit tricky for the those
using the tool every day in various projects to document the
(non-)obvious parts for first-time users.

> At docker-hub there are no comments/descriptions for the kas-isar and kas images so it's a bit difficult to know what to use. 
> 
> Now it seems to be working when using the provided "kas-docker" script, but then I tried using a bind-mount and bash to get inside the docker and run it from there. 'docker run -it --mount type=bind,source="$HOME"/kas-builder,target=/builder kasproject/kas bash'. 

Such "simple" docker calls are where kas-docker evolved from. If you
look at the latest version, it can do way more. It's goal is to provide
the same frontend as kas natively.

> 
> For the "kas" docker image I get errors related to missing isar, and for the kas-isar docker image i get "mount: /proc/sys/fs/binfmt_misc: permission denied." so i tried adding the --privileged flag which seems to be working. Perhaps there could be a better "Start Here" guide giving some hints about this. 
> 

"kas-docker --isar build ..." is doing that for you. "docker/podman run"
is for the experts. That's why we documented the former.

> Also, are there any binary links to -wic files that I can download and run using my own qemu so that I don't have to build them myself?

So far, there is no public build and, thus, artifacts. We will probably
have them as catch-by of using xenomai-image for regular testing "soon".

Jan

> 
> [1] https://gitlab.denx.de/Xenomai/xenomai-images
> 
> Per Öberg 
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

