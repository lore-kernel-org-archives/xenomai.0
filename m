Message-ID: <52F12F68.9040605@siemens.com>
Date: Tue, 04 Feb 2014 19:20:24 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <E1WAhle-0006kB-0q@sd-51317.dedibox.fr>
 <52F1172B.2080500@xenomai.org> <52F11F94.9000309@siemens.com>
 <52F1231A.7080603@xenomai.org> <52F12442.3040301@xenomai.org>
 <52F125E8.6020200@xenomai.org> <52F12700.3020400@xenomai.org>
 <52F12800.1030500@xenomai.org> <52F12937.3050105@xenomai.org>
 <52F12B7A.4060408@siemens.com>
In-Reply-To: <52F12B7A.4060408@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : alchemy: Replace static
 variable no_alchemy_task with macro
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-git@xenomai.org, xenomai@xenomai.org

On 2014-02-04 19:03, Jan Kiszka wrote:
> BTW, there are way more issues with C++ when enabling standard
> compliance. Not sure where all the errors come from and if they easy to
> fixing. But I think we should try to be as clean as possible in out
> external interfaces.

GCC-only typeof is our problem. Simply doing 

diff --git a/include/boilerplate/scope.h b/include/boilerplate/scope.h
index 2bdc747..e902a27 100644
--- a/include/boilerplate/scope.h
+++ b/include/boilerplate/scope.h
@@ -47,7 +47,7 @@ int pshared_check(void *heap, void *addr);
 
 #define __main_heap	NULL
 
-#define dref_type(t)		typeof(t)
+#define dref_type(t)		t
 #define __memoff(base, addr)	(addr)
 #define __memptr(base, off)	(off)
 #define __memchk(base, addr)	1
diff --git a/include/cobalt/wrappers.h b/include/cobalt/wrappers.h
index e0f7a63..ee1e72c 100644
--- a/include/cobalt/wrappers.h
+++ b/include/cobalt/wrappers.h
@@ -25,7 +25,7 @@
 #define __STD(call)		__real_ ## call
 #define __COBALT(call)		__cobalt_ ## call
 #define __RT(call)		__COBALT(call)
-#define COBALT_DECL(T, P)	typeof(T) __RT(P); typeof(T) __STD(P); typeof(T) __WRAP(P)
+#define COBALT_DECL(T, P)	T __RT(P); T __STD(P); T __WRAP(P)
 
 /*
  * 

fixes the C++98 build, but I bet I miss a reason why typeof is there in
the first place, right?

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

