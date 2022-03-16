References: <9fd72e4545a6476983467f305b4d1a53@baumueller.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Where to start with Kernel config for Atom (64bit) Xenomai4 (evl)
Date: Wed, 16 Mar 2022 16:01:30 +0100
In-reply-to: <9fd72e4545a6476983467f305b4d1a53@baumueller.com>
Message-ID: <87wngtex6d.fsf@xenomai.org>
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
To: "Steub, Peter" <Peter.Steub@baumueller.com>
Cc: xenomai@xenomai.org


"Steub, Peter via Xenomai" <xenomai@xenomai.org> writes:

> Hi all,
>
> I like to get evl running on a quadcore Atom box. I started with a
> standard ubuntu 20.04 installation

Which will almost never work out of the box on x86. Some options
commonly selected there will likely cause issues with any real-time
infrastructure.

> and build a kernel from ,v5.15.y-evl-rebase' branch with evl enabled and =
things that ,evl check -file' told me disabled.=20

What do you mean? "evl check" is about verifying a configuration, not
giving any runtime status. The output is a set of hints about kernel
options that should appear as indicated in the submitted .config file,
but do not.

> Good news: the kernel runs and I do have a evl api.
> Bad news: latmus tells me a worst jitter of 500=C2=B5s right away.

You may want to check this [1] first. A common issue causing large
latency peaks is with ACPI_PROCESSOR_IDLE as documented.

> Also ,evl test' tells me:
> *** stack smashing detected ***: terminated
> Aborted (core dumped)
> ** poll-multiple: BROKEN

# gdb /usr/evl/tests/poll-multiple

may help, running it then asking for a backtrace when it breaks. I could
have a look at the backtrace output to figure out what happens, since I
cannot reproduce this on any of my fixtures ATM, so this may depend on a
glibc setup.

>
> I have a Xenomai3 setup on this same machine that has a 30=C2=B5s jitter.=
=20
>

You should expect the same from EVL/x4, a bit better than x3 under SMP
stress due to the improved locking model.

> On the evlproject.org site there is a list of ports including a x86_64
> atom with all the boxes checked. Is there anywhere more information
> about these ports, are the .config files somewhere to be found, to be
> used as a starting point?

In short, no. But the document at [1] helps in removing known issues
from stock kernel configurations.

> I'm also interested in the Raspberry PI
> port, but I don't like to try it all out again for myself, a
> kernel-config or in case of the PI even a binary or a hole Image would
> be great!

Which PI? All PI kernels can be built using the default mainline config
for the architecture at hand. This is actually the ones I'm using.
e.g. ARCH=3Darm64 defconfig for PI3/64bit and PI4/64bit, or
multi_v7_defconfig for 32bit (including PI0 and PI2).

> Also I'm kind of lost on documentation, all I find leads back to the
> evlproject.org main site.

Everything related to EVL and xenomai4 is hosted at evlproject.org ATM.

> Where can I find what to do if say "poll-multible" failed? I have the fee=
ling I am still missing a big junk of documentation! Can anyone please poin=
t me at it!
>

This means a non-reg test fails, so either the test code itself is
broken, or something it exercises is broken. In this case, #1 is most
likely given the error report. What you can do is to help in
understanding why this breaks: see above regarding the gdb command.

> Thank you
>
> Peter Steub

[1] https://evlproject.org/core/caveat/

--=20
Philippe.

