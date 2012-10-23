MIME-Version: 1.0
Date: Tue, 23 Oct 2012 13:17:53 -0300
Message-ID: <CANzNmi-udUjfD3fQ8cu9x8AsHCx+fbeJrO17wHJ5EhJadjcP7Q@mail.gmail.com>
From: Sebastian Pavez <sebastian.pavez.t@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Problem booting the kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi everyone,

I'm trying to install xenomai-2.6.0 with linux-2.6.38.8 on ubuntu 12.04.
I've never use linux before and I'm attempting to do this process quiest
a few times already. Now when I boot the kernel with xenomai I get some
messages like:
Failed to enable MSI-X
Failed to allocate MSI entry

After that the boot stop and I get something like this:
Gave up waiting for root devide.
 - Boot args (cat /proc/cmdline)
    - check rootdelay=3D(did ... long enough?)
    - check root=3D(did ... right device?)
- Missing modules

And also makes a lot of reference to USB ports, I don't know if there's
a way to get a print of this information to post it here, so you could
understand in a better way my problem.
I hope someone could give me some insights here, thanks
Sebasti=E1n.
