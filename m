From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 0/6] Revive alchemy tests
Date: Fri,  8 Apr 2022 10:03:55 +0200
Message-Id: <20220408080401.22235-1-richard@nod.at>
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
alchemy tests into Xenomai's test suite.
Since each test assumes running as own process a test driver is needed
which executes each tests separately.
The driver makes use of the smokey framework.


Richard Weinberger (6):
  testsuite: Move alchemy tests into testsuite/
  testsuite: Hook up alchemytests
  testsuite: Add a simple test driver for alchemytests
  Remove old alchemy tests Makefile
  alchemytests: Fix gcc warning in buffer-1
  alchemytests: Fix gcc warning in task-9

 configure.ac                                  |   1 +
 lib/alchemy/testsuite/Makefile                |  70 --------
 testsuite/Makefile.am                         |   6 +-
 testsuite/alchemytests/Makefile.am            | 159 ++++++++++++++++++
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
 27 files changed, 250 insertions(+), 74 deletions(-)
 delete mode 100644 lib/alchemy/testsuite/Makefile
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

--=20
2.34.1


