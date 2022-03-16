From: "Steub, Peter" <Peter.Steub@baumueller.com>
Subject: Where to start with Kernel config for Atom (64bit) Xenomai4 (evl)
Date: Wed, 16 Mar 2022 11:57:39 +0000
Message-ID: <9fd72e4545a6476983467f305b4d1a53@baumueller.com>
Content-Language: de-DE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi all,

I like to get evl running on a quadcore Atom box. I started with a standard=
 ubuntu 20.04 installation and build a kernel from ,v5.15.y-evl-rebase' bra=
nch with evl enabled and things that ,evl check -file' told me disabled.=20
Good news: the kernel runs and I do have a evl api.
Bad news: latmus tells me a worst jitter of 500=B5s right away.
Also ,evl test' tells me:
*** stack smashing detected ***: terminated
Aborted (core dumped)
** poll-multiple: BROKEN

I have a Xenomai3 setup on this same machine that has a 30=B5s jitter.=20

On the evlproject.org site there is a list of ports including a x86_64 atom=
 with all the boxes checked. Is there anywhere more information about these=
 ports, are the .config files somewhere to be found, to be used as a starti=
ng point? I'm also interested in the Raspberry PI port, but I don't like to=
 try it all out again for myself, a kernel-config or in case of the PI even=
 a binary or a hole Image would be great!
Also I'm kind of lost on documentation, all I find leads back to the evlpro=
ject.org main site. Where can I find what to do if say "poll-multible" fail=
ed? I have the feeling I am still missing a big junk of documentation! Can =
anyone please point me at it!

Thank you

Peter Steub


