From: Henning Schild <henning.schild@siemens.com>
Date: Tue, 24 Apr 2018 14:37:42 +0200
Message-Id: <20180424123745.7015-1-henning.schild@siemens.com>
Subject: [Xenomai] [PATCH 0/3] dlopen testcase
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

The test binary was actually linked as a xenomai binary, so the test did
not actually cover the "cold" init phase.
Turns out that in fact dlclose will not truly work, because we lack
destructors for the init functions of the so called setup_descriptors.

So first revert the patch introducing destructors. We do not have code
to destruct, dont even pretent by addressing a fraction of the whole
problem.

Second change the linker flags and make the testcase cover cold init.
Remove the calls to dlclose() and the re-dlopen(), because that is not
actually supported.

And last but not least, make sure a dlclose() will not actually work on
xenomai libs.

Henning Schild (3):
  Revert "boilerplate/setup: introduce destructors for __setup_call"
  smokey/dlopen: fix testcase
  build: link dlopen libs with "nodelete"

 configure.ac                              | 1 +
 include/boilerplate/setup.h               | 7 -------
 lib/boilerplate/setup.c                   | 6 ------
 testsuite/smokey/dlopen/Makefile.am       | 8 +-------
 testsuite/smokey/dlopen/dlopentest.c      | 9 ---------
 testsuite/smokey/dlopen/libalchemy-test.c | 2 +-
 6 files changed, 3 insertions(+), 30 deletions(-)

-- 
2.16.1


