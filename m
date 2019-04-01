From: Philippe Gerum <rpm@xenomai.org>
Subject: Dual kernel made easy
Message-ID: <20b3f016-e519-35fc-9a9e-750ecfc509a3@xenomai.org>
Date: Mon, 1 Apr 2019 22:11:03 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>
Cc: Jorge Ramirez-Ortiz <jro@xenomai.org>, "Kiszka, Jan" <jan.kiszka@siemens.com>


Motivated by the pain we continue to inflict upon ourselves everytime
we need to rebase the I-pipe over a recent kernel release, I started
working to define its future replacement. Now that we have an
implementation of its successor running reliably, my next step is to
rebase the Cobalt ARM port on this new interface called Dovetail [1].

This work is part of a larger effort to rethink the way independent
software cores like Xenomai's integrate into the main kernel [2].

This led to not only implement Dovetail, but also to showcase it with
a new real-time co-kernel originally derived from Cobalt [3], which is
simple and compact enough to be used as a learning tool for everyone
interested in the dual kernel technology based on Linux.

The purpose of this work is about making dual kernel easy, at least as
simple as possible for people to develop and maintain their own
software core of choice over the current mainline kernel.

[1] https://evenless.org/dovetail/
[2] https://evenless.org/
[3] https://evenless.org/core/

-- 
Philippe.

