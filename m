From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 1/9] testsuite: Move alchemy tests into testsuite/
Date: Wed, 13 Apr 2022 23:58:11 +0200
Message-Id: <20220413215819.22954-2-richard@nod.at>
In-Reply-To: <20220413215819.22954-1-richard@nod.at>
References: <20220413215819.22954-1-richard@nod.at>
MIME-Version: 1.0
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

This is the very first step to have the alchemy tests embedded
into our testsuite.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 {lib/alchemy/testsuite =3D> testsuite/alchemytests}/alarm-1.c  | 0
 {lib/alchemy/testsuite =3D> testsuite/alchemytests}/buffer-1.c | 0
 {lib/alchemy/testsuite =3D> testsuite/alchemytests}/event-1.c  | 0
 {lib/alchemy/testsuite =3D> testsuite/alchemytests}/heap-1.c   | 0
 {lib/alchemy/testsuite =3D> testsuite/alchemytests}/heap-2.c   | 0
 {lib/alchemy/testsuite =3D> testsuite/alchemytests}/mq-1.c     | 0
 {lib/alchemy/testsuite =3D> testsuite/alchemytests}/mq-2.c     | 0
 {lib/alchemy/testsuite =3D> testsuite/alchemytests}/mq-3.c     | 0
 {lib/alchemy/testsuite =3D> testsuite/alchemytests}/mutex-1.c  | 0
 {lib/alchemy/testsuite =3D> testsuite/alchemytests}/pipe-1.c   | 0
 {lib/alchemy/testsuite =3D> testsuite/alchemytests}/sem-1.c    | 0
 {lib/alchemy/testsuite =3D> testsuite/alchemytests}/sem-2.c    | 0
 {lib/alchemy/testsuite =3D> testsuite/alchemytests}/task-1.c   | 0
 {lib/alchemy/testsuite =3D> testsuite/alchemytests}/task-10.c  | 0
 {lib/alchemy/testsuite =3D> testsuite/alchemytests}/task-2.c   | 0
 {lib/alchemy/testsuite =3D> testsuite/alchemytests}/task-3.c   | 0
 {lib/alchemy/testsuite =3D> testsuite/alchemytests}/task-4.c   | 0
 {lib/alchemy/testsuite =3D> testsuite/alchemytests}/task-5.c   | 0
 {lib/alchemy/testsuite =3D> testsuite/alchemytests}/task-6.c   | 0
 {lib/alchemy/testsuite =3D> testsuite/alchemytests}/task-7.c   | 0
 {lib/alchemy/testsuite =3D> testsuite/alchemytests}/task-8.c   | 0
 {lib/alchemy/testsuite =3D> testsuite/alchemytests}/task-9.c   | 0
 22 files changed, 0 insertions(+), 0 deletions(-)
 rename {lib/alchemy/testsuite =3D> testsuite/alchemytests}/alarm-1.c (10=
0%)
 rename {lib/alchemy/testsuite =3D> testsuite/alchemytests}/buffer-1.c (1=
00%)
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
 rename {lib/alchemy/testsuite =3D> testsuite/alchemytests}/task-9.c (100=
%)

diff --git a/lib/alchemy/testsuite/alarm-1.c b/testsuite/alchemytests/ala=
rm-1.c
similarity index 100%
rename from lib/alchemy/testsuite/alarm-1.c
rename to testsuite/alchemytests/alarm-1.c
diff --git a/lib/alchemy/testsuite/buffer-1.c b/testsuite/alchemytests/bu=
ffer-1.c
similarity index 100%
rename from lib/alchemy/testsuite/buffer-1.c
rename to testsuite/alchemytests/buffer-1.c
diff --git a/lib/alchemy/testsuite/event-1.c b/testsuite/alchemytests/eve=
nt-1.c
similarity index 100%
rename from lib/alchemy/testsuite/event-1.c
rename to testsuite/alchemytests/event-1.c
diff --git a/lib/alchemy/testsuite/heap-1.c b/testsuite/alchemytests/heap=
-1.c
similarity index 100%
rename from lib/alchemy/testsuite/heap-1.c
rename to testsuite/alchemytests/heap-1.c
diff --git a/lib/alchemy/testsuite/heap-2.c b/testsuite/alchemytests/heap=
-2.c
similarity index 100%
rename from lib/alchemy/testsuite/heap-2.c
rename to testsuite/alchemytests/heap-2.c
diff --git a/lib/alchemy/testsuite/mq-1.c b/testsuite/alchemytests/mq-1.c
similarity index 100%
rename from lib/alchemy/testsuite/mq-1.c
rename to testsuite/alchemytests/mq-1.c
diff --git a/lib/alchemy/testsuite/mq-2.c b/testsuite/alchemytests/mq-2.c
similarity index 100%
rename from lib/alchemy/testsuite/mq-2.c
rename to testsuite/alchemytests/mq-2.c
diff --git a/lib/alchemy/testsuite/mq-3.c b/testsuite/alchemytests/mq-3.c
similarity index 100%
rename from lib/alchemy/testsuite/mq-3.c
rename to testsuite/alchemytests/mq-3.c
diff --git a/lib/alchemy/testsuite/mutex-1.c b/testsuite/alchemytests/mut=
ex-1.c
similarity index 100%
rename from lib/alchemy/testsuite/mutex-1.c
rename to testsuite/alchemytests/mutex-1.c
diff --git a/lib/alchemy/testsuite/pipe-1.c b/testsuite/alchemytests/pipe=
-1.c
similarity index 100%
rename from lib/alchemy/testsuite/pipe-1.c
rename to testsuite/alchemytests/pipe-1.c
diff --git a/lib/alchemy/testsuite/sem-1.c b/testsuite/alchemytests/sem-1=
.c
similarity index 100%
rename from lib/alchemy/testsuite/sem-1.c
rename to testsuite/alchemytests/sem-1.c
diff --git a/lib/alchemy/testsuite/sem-2.c b/testsuite/alchemytests/sem-2=
.c
similarity index 100%
rename from lib/alchemy/testsuite/sem-2.c
rename to testsuite/alchemytests/sem-2.c
diff --git a/lib/alchemy/testsuite/task-1.c b/testsuite/alchemytests/task=
-1.c
similarity index 100%
rename from lib/alchemy/testsuite/task-1.c
rename to testsuite/alchemytests/task-1.c
diff --git a/lib/alchemy/testsuite/task-10.c b/testsuite/alchemytests/tas=
k-10.c
similarity index 100%
rename from lib/alchemy/testsuite/task-10.c
rename to testsuite/alchemytests/task-10.c
diff --git a/lib/alchemy/testsuite/task-2.c b/testsuite/alchemytests/task=
-2.c
similarity index 100%
rename from lib/alchemy/testsuite/task-2.c
rename to testsuite/alchemytests/task-2.c
diff --git a/lib/alchemy/testsuite/task-3.c b/testsuite/alchemytests/task=
-3.c
similarity index 100%
rename from lib/alchemy/testsuite/task-3.c
rename to testsuite/alchemytests/task-3.c
diff --git a/lib/alchemy/testsuite/task-4.c b/testsuite/alchemytests/task=
-4.c
similarity index 100%
rename from lib/alchemy/testsuite/task-4.c
rename to testsuite/alchemytests/task-4.c
diff --git a/lib/alchemy/testsuite/task-5.c b/testsuite/alchemytests/task=
-5.c
similarity index 100%
rename from lib/alchemy/testsuite/task-5.c
rename to testsuite/alchemytests/task-5.c
diff --git a/lib/alchemy/testsuite/task-6.c b/testsuite/alchemytests/task=
-6.c
similarity index 100%
rename from lib/alchemy/testsuite/task-6.c
rename to testsuite/alchemytests/task-6.c
diff --git a/lib/alchemy/testsuite/task-7.c b/testsuite/alchemytests/task=
-7.c
similarity index 100%
rename from lib/alchemy/testsuite/task-7.c
rename to testsuite/alchemytests/task-7.c
diff --git a/lib/alchemy/testsuite/task-8.c b/testsuite/alchemytests/task=
-8.c
similarity index 100%
rename from lib/alchemy/testsuite/task-8.c
rename to testsuite/alchemytests/task-8.c
diff --git a/lib/alchemy/testsuite/task-9.c b/testsuite/alchemytests/task=
-9.c
similarity index 100%
rename from lib/alchemy/testsuite/task-9.c
rename to testsuite/alchemytests/task-9.c
--=20
2.34.1


