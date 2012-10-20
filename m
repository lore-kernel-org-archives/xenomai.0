MIME-Version: 1.0
Date: Sat, 20 Oct 2012 17:31:21 -0400
Message-ID: <CAD0gx3gM7TwoPn-0367BH848nYow02uN3dK5wOcysXFMxmBCSw@mail.gmail.com>
From: Bill Smith <shoozboot@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] Best ARM-based Linux Distribution for Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello again,

Since I am just now beginning the steps to building a cross compile
environment for the BeagleBone for inclusion with Xenomai 2.6.2, are there
any list member opinions about the best Linux distribution to run on the
BeagleBone?

I am currently running Angstrom (stock that ships with the BeagleBone), but
it seems that Debian has better support for Xenomai?

My requirements are fairly simple:  Xenomai 2.6.2, hardware RNG (or
cryptographically strong entropy from /dev/random or /dev/urandom).

Support for GNU MP (arbitrary precision math libraries); and, filesystem
support for GPIO/PWM control like Angstrom supports would be helpful as
well.
