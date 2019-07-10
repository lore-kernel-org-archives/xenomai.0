Subject: [PATCH] boilerplate: Fix bogus "typeof(type)" in macros
References: <CALTC7XLtQUJ9xqwAbURTDeCHzJouAUjz1Lj0nhMovsEeL0q0EQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <f2b6ba72-043d-135a-b86f-c9ee25419343@web.de>
Date: Wed, 10 Jul 2019 21:39:03 +0200
MIME-Version: 1.0
In-Reply-To: <CALTC7XLtQUJ9xqwAbURTDeCHzJouAUjz1Lj0nhMovsEeL0q0EQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Cris Almaraz <cristina.almaraz@gmail.com>, xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

This was ignored by most compilers so far, but it breaks at least under
c++11.

Reported-by: St=C3=A9phane Ancelot <sancelot@numalliance.com>
Reported-by: Cris Almaraz <cristina.almaraz@gmail.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
=2D--

Thanks for reporting (and sorry for the long patch delay). This should
fix it.

 include/boilerplate/tunables.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/boilerplate/tunables.h b/include/boilerplate/tunables=
.h
index db8523be67..38f414e455 100644
=2D-- a/include/boilerplate/tunables.h
+++ b/include/boilerplate/tunables.h
@@ -37,10 +37,10 @@ static inline int __may_change_config_tunable(void)
 	__read_ ## __name ## _ ## __scope

 #define __define_tunable(__name, __type, __val, __scope)	\
-	void __tunable_set_call(__name, __scope)(typeof(__type) __val)
+	void __tunable_set_call(__name, __scope)(__type __val)

 #define __read_tunable(__name, __type, __scope)	\
-	typeof(__type) __tunable_get_call(__name, __scope)(void)
+	__type __tunable_get_call(__name, __scope)(void)

 #define define_config_tunable(__name, __type, __val)	\
 	__define_tunable(__name, __type, __val, config)
=2D-
2.16.4

