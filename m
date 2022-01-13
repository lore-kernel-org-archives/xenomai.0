MIME-Version: 1.0
From: Arturo Laurenzi <arturo.laurenzi@gmail.com>
Date: Thu, 13 Jan 2022 16:30:57 +0100
Message-ID: <CAMMcbao8aCNnDqfQXBzRCKJD31eMX_rcsPymA+pgRRG6xTHCog@mail.gmail.com>
Subject: Cobalt over dovetail implementation status
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all,
in our lab we're relying on Xenomai 3.1 + RTnet in order to control our
robotic platforms, which are seen as a network of EtherCat slaves.
I'd like to know more about the implementation status of Xenomai (cobalt)
over Dovetail, which to my understanding will be the only way to use > 5.4
kernel versions.

We mostly use the Posix API (thread, mutex, condvar), timers, IDDP, XDDP,
shared memory, and RTnet.

Is Dovetail already feature-complete w.r.t. Ipipe?

Is RTnet available?

How to migrate from an Ipipe kernel .config to a Dovetail counterpart?

Thank you very much,
Arturo
