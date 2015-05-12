MIME-Version: 1.0
From: Michael Smith <2michael.smith@gmail.com>
Date: Tue, 12 May 2015 14:05:07 +0200
Message-ID: <CANWkrRN33Hvv-ZLh5+op0mYE7gnuZVv-59nWeACSzF1kRR9=5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] xeno-config packaging issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi
I have compiled the newest 3.x HEAD (5e81f9e) form the GIT repository
by creating Debian packages.
And when those packages are installed after the compile there is a
clash between the "xenomai-runtime" and the "libxenomai-dev" packages.
Because "xeno-config" has been included both in packages.

So as a result xeno-runtime that contains the testsuite and binaries
located under /usr/bin/
are not installed because /usr/bin/xeno-config have already been
included in the libxenomai-dev
package, and so the apt package manager aborts the install of xeno-runtime.

My architecture is as follows:
Real-time used: Cobalt
OS: Ubuntu 14.04
Vanilla Kernel: 3.16
Arch: x86_64

I suspect some or other changes in the make files have created this
conflict, because I have compiled a version older than rc3 previously,
namely 590aa2a and there were no package
issues like the above.

Regards
Michael

