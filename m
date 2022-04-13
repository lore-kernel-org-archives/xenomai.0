From: Richard Weinberger <richard@nod.at>
Subject: [PATCH v2 0/9] Revive alchemy, pSOS and VxWorks tests
Date: Wed, 13 Apr 2022 23:58:10 +0200
Message-Id: <20220413215819.22954-1-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Richard Weinberger <richard@nod.at>

This patch series is a first attempt to integrate the currently abandoned
alchemy, pSOS and VxWorks tests into Xenomai's test suite.
Since each test assumes running as own process a test driver is needed
which executes each tests separately.
The driver makes use of the smokey framework.

Test results on a x86 VM (5.15.19, Xenomai master as of today):
- Alchemy:
  test2 fails:
	[8] at task-2.c:71
	[1] at task-2.c:24
	[9] at task-2.c:79
	[4] at task-2.c:43
	[10] at task-2.c:87
	[5] at task-2.c:48
	[11] at task-2.c:92
	[2] at task-2.c:29
	[6] at task-2.c:52
	   0"022.972| BUG in __traceobj_check_abort(): [FGND] wrong return statu=
s:
		      task-2.c:55 =3D> EINVAL (want OK)

  task5 fails:
	[9] at task-5.c:79
	[1] at task-5.c:23
	[10] at task-5.c:87
	[3] at task-5.c:40
	[11] at task-5.c:95
	[4] at task-5.c:45
	[5] at task-5.c:50
	[6] at task-5.c:55
	[2] at task-5.c:28
	[7] at task-5.c:60
	   0"003.160| BUG in __traceobj_check_abort(): [FGND] wrong return statu=
s:
		      task-5.c:63 =3D> EINVAL (want OK)

  If Xenomai was configured with --enable-lores-clock, tests mq1, mutex1,=
 pip1 and sem1 fail due to:
	undefined symbol: __clockobj_ticks_to_timeout

- pSOS (Xenomai has to be configured with --enable-lores-clock):
  rn1 fails:
	0"001.017| BUG in __traceobj_assert_failed(): [rn1] trace assertion fail=
ed:
		rn-1.c:46 =3D> "ret =3D=3D 0"
  task2 fails:
	[8] at task-2.c:73
	[1] at task-2.c:23
	[9] at task-2.c:81
	[4] at task-2.c:44
	[10] at task-2.c:89
	[5] at task-2.c:49
	[11] at task-2.c:94
	[2] at task-2.c:28
	[3] at task-2.c:33
	[6] at task-2.c:53
	   0"004.756| BUG in __traceobj_assert_failed(): [FGND] trace assertion =
failed:
		      task-2.c:56 =3D> "ret =3D=3D 0"

  task6 fails:
	[9] at task-6.c:79
	[1] at task-6.c:22
	[10] at task-6.c:87
	[3] at task-6.c:39
	[11] at task-6.c:95
	[4] at task-6.c:44
	[5] at task-6.c:49
	[6] at task-6.c:54
	[2] at task-6.c:27
	[7] at task-6.c:59
	   0"002.870| BUG in __traceobj_assert_failed(): [FGND] trace assertion =
failed:
		      task-6.c:62 =3D> "ret =3D=3D 0 && oldprio =3D=3D myprio"

  task8 runs forever (100% CPU)

- VxWorks:
  task2 fails:
	[8] at task-2.c:85
	[1] at task-2.c:32
	[9] at task-2.c:91
	[4] at task-2.c:57
	[10] at task-2.c:97
	[5] at task-2.c:62
	[11] at task-2.c:103
	[2] at task-2.c:37
	[12] at task-2.c:109
	[6] at task-2.c:66
	   0"005.790| BUG in __traceobj_assert_failed(): [foregroundTask] trace =
assertion failed:
		      task-2.c:69 =3D> "ret =3D=3D 0"



Changes since v1:
 - Revive pSOS and VxWorks tests too=20

Richard Weinberger (9):
  testsuite: Move alchemy tests into testsuite/
  testsuite: Hook up alchemytests
  testsuite: Add a simple test driver for alchemytests
  Remove old alchemy tests Makefile
  alchemytests: Fix gcc warning in buffer-1
  alchemytests: Fix gcc warning in task-9
  testsuite: Move pSOS tests into testsuite/
  testsuite: Add a simple test driver for psostests
  testsuite: Integrate vwworks tests into testsuite/

 configure.ac                                  |   3 +
 lib/alchemy/testsuite/Makefile                |  70 --------
 lib/psos/testsuite/Makefile                   |  49 ------
 lib/vxworks/testsuite/Makefile                |  43 -----
 testsuite/Makefile.am                         |  10 +-
 testsuite/alchemytests/Makefile.am            | 159 +++++++++++++++++
 .../alchemytests}/alarm-1.c                   |   0
 testsuite/alchemytests/alchemytest_driver.c   |  84 +++++++++
 .../alchemytests}/buffer-1.c                  |   2 +-
 .../alchemytests}/event-1.c                   |   0
 .../alchemytests}/heap-1.c                    |   0
 .../alchemytests}/heap-2.c                    |   0
 .../alchemytests}/mq-1.c                      |   0
 .../alchemytests}/mq-2.c                      |   0
 .../alchemytests}/mq-3.c                      |   0
 .../alchemytests}/mutex-1.c                   |   0
 .../alchemytests}/pipe-1.c                    |   0
 .../alchemytests}/sem-1.c                     |   0
 .../alchemytests}/sem-2.c                     |   0
 .../alchemytests}/task-1.c                    |   0
 .../alchemytests}/task-10.c                   |   0
 .../alchemytests}/task-2.c                    |   0
 .../alchemytests}/task-3.c                    |   0
 .../alchemytests}/task-4.c                    |   0
 .../alchemytests}/task-5.c                    |   0
 .../alchemytests}/task-6.c                    |   0
 .../alchemytests}/task-7.c                    |   0
 .../alchemytests}/task-8.c                    |   0
 .../alchemytests}/task-9.c                    |   2 +-
 testsuite/psostests/Makefile.am               | 166 ++++++++++++++++++
 .../testsuite =3D> testsuite/psostests}/mq-1.c  |   0
 .../testsuite =3D> testsuite/psostests}/mq-2.c  |   0
 .../testsuite =3D> testsuite/psostests}/mq-3.c  |   0
 testsuite/psostests/psostest_driver.c         |  85 +++++++++
 .../testsuite =3D> testsuite/psostests}/pt-1.c  |   0
 .../testsuite =3D> testsuite/psostests}/rn-1.c  |   0
 .../testsuite =3D> testsuite/psostests}/sem-1.c |   0
 .../testsuite =3D> testsuite/psostests}/sem-2.c |   0
 .../psostests}/task-1.c                       |   0
 .../psostests}/task-2.c                       |   0
 .../psostests}/task-3.c                       |   0
 .../psostests}/task-4.c                       |   0
 .../psostests}/task-5.c                       |   0
 .../psostests}/task-6.c                       |   0
 .../psostests}/task-7.c                       |   0
 .../psostests}/task-8.c                       |   0
 .../psostests}/task-9.c                       |   0
 .../testsuite =3D> testsuite/psostests}/tm-1.c  |   0
 .../testsuite =3D> testsuite/psostests}/tm-2.c  |   0
 .../testsuite =3D> testsuite/psostests}/tm-3.c  |   0
 .../testsuite =3D> testsuite/psostests}/tm-4.c  |   0
 .../testsuite =3D> testsuite/psostests}/tm-5.c  |   0
 .../testsuite =3D> testsuite/psostests}/tm-6.c  |   0
 .../testsuite =3D> testsuite/psostests}/tm-7.c  |   0
 testsuite/vxworkstests/Makefile.am            | 100 +++++++++++
 .../vxworkstests}/lst-1.c                     |   0
 .../vxworkstests}/msgQ-1.c                    |   0
 .../vxworkstests}/msgQ-2.c                    |   0
 .../vxworkstests}/msgQ-3.c                    |   0
 .../vxworkstests}/rng-1.c                     |   0
 .../vxworkstests}/sem-1.c                     |   0
 .../vxworkstests}/sem-2.c                     |   0
 .../vxworkstests}/sem-3.c                     |   0
 .../vxworkstests}/sem-4.c                     |   0
 .../vxworkstests}/task-1.c                    |   0
 .../vxworkstests}/task-2.c                    |   0
 testsuite/vxworkstests/vxworkstest_driver.c   |  74 ++++++++
 .../vxworkstests}/wd-1.c                      |   0
 68 files changed, 681 insertions(+), 166 deletions(-)
 delete mode 100644 lib/alchemy/testsuite/Makefile
 delete mode 100644 lib/psos/testsuite/Makefile
 delete mode 100644 lib/vxworks/testsuite/Makefile
 create mode 100644 testsuite/alchemytests/Makefile.am
 rename {lib/alchemy/testsuite =3D> testsuite/alchemytests}/alarm-1.c (10=
0%)
 create mode 100644 testsuite/alchemytests/alchemytest_driver.c
 rename {lib/alchemy/testsuite =3D> testsuite/alchemytests}/buffer-1.c (9=
9%)
 rename {lib/alchemy/testsuite =3D> testsuite/alchemytests}/event-1.c (10=
0%)
 rename {lib/alchemy/testsuite =3D> testsuite/alchemytests}/heap-1.c (100=
%)
 rename {lib/alchemy/testsuite =3D> testsuite/alchemytests}/heap-2.c (100=
%)
 rename {lib/alchemy/testsuite =3D> testsuite/alchemytests}/mq-1.c (100%)
 rename {lib/alchemy/testsuite =3D> testsuite/alchemytests}/mq-2.c (100%)
 rename {lib/alchemy/testsuite =3D> testsuite/alchemytests}/mq-3.c (100%)
 rename {lib/alchemy/testsuite =3D> testsuite/alchemytests}/mutex-1.c (10=
0%)
 rename {lib/alchemy/testsuite =3D> testsuite/alchemytests}/pipe-1.c (100=
%)
 rename {lib/alchemy/testsuite =3D> testsuite/alchemytests}/sem-1.c (100%=
)
 rename {lib/alchemy/testsuite =3D> testsuite/alchemytests}/sem-2.c (100%=
)
 rename {lib/alchemy/testsuite =3D> testsuite/alchemytests}/task-1.c (100=
%)
 rename {lib/alchemy/testsuite =3D> testsuite/alchemytests}/task-10.c (10=
0%)
 rename {lib/alchemy/testsuite =3D> testsuite/alchemytests}/task-2.c (100=
%)
 rename {lib/alchemy/testsuite =3D> testsuite/alchemytests}/task-3.c (100=
%)
 rename {lib/alchemy/testsuite =3D> testsuite/alchemytests}/task-4.c (100=
%)
 rename {lib/alchemy/testsuite =3D> testsuite/alchemytests}/task-5.c (100=
%)
 rename {lib/alchemy/testsuite =3D> testsuite/alchemytests}/task-6.c (100=
%)
 rename {lib/alchemy/testsuite =3D> testsuite/alchemytests}/task-7.c (100=
%)
 rename {lib/alchemy/testsuite =3D> testsuite/alchemytests}/task-8.c (100=
%)
 rename {lib/alchemy/testsuite =3D> testsuite/alchemytests}/task-9.c (97%=
)
 create mode 100644 testsuite/psostests/Makefile.am
 rename {lib/psos/testsuite =3D> testsuite/psostests}/mq-1.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/mq-2.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/mq-3.c (100%)
 create mode 100644 testsuite/psostests/psostest_driver.c
 rename {lib/psos/testsuite =3D> testsuite/psostests}/pt-1.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/rn-1.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/sem-1.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/sem-2.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/task-1.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/task-2.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/task-3.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/task-4.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/task-5.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/task-6.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/task-7.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/task-8.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/task-9.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/tm-1.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/tm-2.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/tm-3.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/tm-4.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/tm-5.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/tm-6.c (100%)
 rename {lib/psos/testsuite =3D> testsuite/psostests}/tm-7.c (100%)
 create mode 100644 testsuite/vxworkstests/Makefile.am
 rename {lib/vxworks/testsuite =3D> testsuite/vxworkstests}/lst-1.c (100%=
)
 rename {lib/vxworks/testsuite =3D> testsuite/vxworkstests}/msgQ-1.c (100=
%)
 rename {lib/vxworks/testsuite =3D> testsuite/vxworkstests}/msgQ-2.c (100=
%)
 rename {lib/vxworks/testsuite =3D> testsuite/vxworkstests}/msgQ-3.c (100=
%)
 rename {lib/vxworks/testsuite =3D> testsuite/vxworkstests}/rng-1.c (100%=
)
 rename {lib/vxworks/testsuite =3D> testsuite/vxworkstests}/sem-1.c (100%=
)
 rename {lib/vxworks/testsuite =3D> testsuite/vxworkstests}/sem-2.c (100%=
)
 rename {lib/vxworks/testsuite =3D> testsuite/vxworkstests}/sem-3.c (100%=
)
 rename {lib/vxworks/testsuite =3D> testsuite/vxworkstests}/sem-4.c (100%=
)
 rename {lib/vxworks/testsuite =3D> testsuite/vxworkstests}/task-1.c (100=
%)
 rename {lib/vxworks/testsuite =3D> testsuite/vxworkstests}/task-2.c (100=
%)
 create mode 100644 testsuite/vxworkstests/vxworkstest_driver.c
 rename {lib/vxworks/testsuite =3D> testsuite/vxworkstests}/wd-1.c (100%)

--=20
2.34.1


