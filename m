From: "Giorgio Buffa" <giorgiobuffa.work@gmail.com>
Date: Wed, 1 Jul 2015 17:35:08 +0200
Message-ID: <00e901d0b413$83853d70$8a8fb850$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: it
Subject: [Xenomai] Have you ever used the Linux Test Project (LTP) realtime
	testsuite with Xenomai?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello list!
I'm having a look at the Linux Test project
(https://github.com/linux-test-project/ltp), which provides a collection of
tools for testing the Linux kernel and related features. It also provides a
real-time test suite that has been written to test functionality of the
PREEMPT_RT patch.

This real-time test suite uses the POSIX API, so I'm thinking to use it to
further benchmark my Xenomai installations (both single- and dual- kernel).
Have you ever used this realtime testsuite with Xenomai? Or do you only
rely on the testsuite provided by Xenomai itself?

Kind regards,
Giorgio Buffa


