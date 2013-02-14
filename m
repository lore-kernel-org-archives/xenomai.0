MIME-Version: 1.0
Date: Wed, 13 Feb 2013 16:09:17 -0800
Message-ID: <CAJjOJyZ3H=ffAT1JbqPr4DEpZsHmAdNXt+eZuWKhg0xhVd+T1w@mail.gmail.com>
From: Jonathan Wallace <jonmon6691@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] Kernel choice for Xenomai on the Beagle Bone
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

First I just want to say that I've been doing a lot of reading in the
archives of this mailing list and I'm really impressed with the community,
I'm excited to get my project going with this software!

I'm really just trying to get my bearings before I start mucking around and
one question has been lingering during all my research that I've yet to see
a clear answer for. I'ts one that seems to come up every now and then here,
and I hope I'm not beating a dead horse with it.

Essentially I want to know what kernel I should apply the Xenomai patches
against. From what I've read, the naming conventions on the adeos patches
in .../xenomai-2.6.2.1/ksrc/arch/arm/patches/ should indicate the latest
suitable kernel version with which the patch will work. As of yesterday,
that appears to be ipipe-core-3.5.7-arm-3.patch. I have two hesitations
though. The first is the arm-3 suffix, does this imply some sort of
processor restriction e.g. no compatibility with ARMv7 isa or
something?(forgive me if that's a dumb question) And my second hesitation
is that the 3.5.7 kernel is currently EOL. Would it be a wiser choice to
use 3.4.30 which is still supported?

Thanks,
Jon RW
