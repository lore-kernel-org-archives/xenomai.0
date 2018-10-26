From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 4/9] cobalt/ancillaries: prevent false positive with
 -Wstringop-truncation
Date: Fri, 26 Oct 2018 16:08:20 +0200
Message-Id: <20181026140825.5251-4-rpm@xenomai.org>
In-Reply-To: <20181026140825.5251-1-rpm@xenomai.org>
References: <20181026140825.5251-1-rpm@xenomai.org>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>

knamecpy() is meant to copying NUL terminated strings even if this
incurs potential truncation of the source argument if need be, prevent
GCC 8.x from detecting a false positive when -Wstringop-truncation is
in effect.
---
 include/cobalt/kernel/ancillaries.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/cobalt/kernel/ancillaries.h b/include/cobalt/kernel/ancillaries.h
index cde9856da..b957310c7 100644
--- a/include/cobalt/kernel/ancillaries.h
+++ b/include/cobalt/kernel/ancillaries.h
@@ -58,7 +58,7 @@ void __knamecpy_requires_character_array_as_destination(void);
 	({								\
 		if (!__builtin_types_compatible_p(typeof(__dst), char[])) \
 			__knamecpy_requires_character_array_as_destination();	\
-		strncpy((__dst), __src, sizeof(__dst) - 1);		\
+		strncpy((__dst), __src, sizeof(__dst));			\
 		__dst[sizeof(__dst) - 1] = '\0';			\
 		__dst;							\
 	 })
-- 
2.17.2


