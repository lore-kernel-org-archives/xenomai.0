From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <c9443b76-da71-9885-82a4-9e524b460998@xenomai.org>
Date: Thu, 25 Jan 2018 18:40:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [RFC] FOSDEM meeting agenda
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>, Sebastian Smolorz <Sebastian.Smolorz@gmx.de>, Jan Leupold <leupold@rsi-elektrotechnik.de>, Jorge Ramirez <jro@xenomai.org>
Cc: Steven Seeger <steven.seeger@nasa.gov>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>


Here are some points I would like to discuss during this meeting. Please
feel free to comment:

1. Release management

	* Currently, the person who contributes most of the code is also the
release manager, which is clearly not optimal. Both activities should be
decoupled for efficiency (esp. hindsight) and practical reasons. At some
point, I will stop acting as the release manager, so the project will
need a different organization in this respect. Which one?

	* As a corollary, the current release process is broken: no explicit
release plan or schedule, limited testing, barely any user feedback
about the development version in general. Practical steps to improve
this should be discussed.

	* My understanding is that v3.1 is almost there feature-wise, with a
working arm64 port Dmitriy is polishing, a bunch of rtnet fixes actually
enabling RTnet with SMAP/x86 (which still need some feedback btw), and
support for recent kernels up to 4.14 (arm, arm64, powerpc). x86 is
still lagging behind with kernel 4.9 though. I'm about to queue a couple
of ABI changes more, with the implementation of sendmmsg() and
recvmmsg() for RTDM sockets.

This raises the following questions: 1) may we freeze the v3.1 ABI, 2)
should we wait for supporting 4.14/x86 before releasing v3.1, 3) how
much use/testing do we currently have of the -next branch, on which CPU
architecture(s)?

2. Documentation

	* The existing documentation has several weaknesses; from the traffic
on the mailing list, the main one may be that it leaves newcomers with a
steep learning curve, in some occasions, even when the information is
published on the website and/or present in the inline documentation. How
to improve the situation, how to better organize the existing doc so
that people do find what they are looking for?

	* Doxygen may not be the best option anymore for inline documentation;
Chasing glitches with using the markup has been a real pain over the
years, getting properly structured output has never been obvious. Could
we do better with Doxygen in a reasonably simple fashion, or should
reStructuredText and Sphinx be considered as a replacement, so that we
can converge toward the kernel documentation system?

3. Pipeline maintenance

	* We now have a dedicated I-pipe maintainer per CPU architecture, which
is a great relief to me. Now I'd like we discuss the maintenance
process, 1) how to organize the upstream/downstream flow of the generic
pipeline bits I still maintain currently, between other maintainers and
me? 2) how to best disseminate knowledge about the I-pipe implementation?

	* mainline vs CIP kernel, LTS maintenance policy

4. Misc

	* formalizing the decision about dropping the blackfin and powerpc64
port, since we had zero feedback from users so far, so everyone must be
fine with this.

Thanks,

-- 
Philippe.

