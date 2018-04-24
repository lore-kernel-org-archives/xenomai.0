From: Henning Schild <henning.schild@siemens.com>
Date: Tue, 24 Apr 2018 14:37:45 +0200
Message-Id: <20180424123745.7015-4-henning.schild@siemens.com>
In-Reply-To: <20180424123745.7015-1-henning.schild@siemens.com>
References: <20180424123745.7015-1-henning.schild@siemens.com>
Subject: [Xenomai] [PATCH 3/3] build: link dlopen libs with "nodelete"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

This way a dlclose() will not unmap the libs memory anymore. A real
dlclose() will not work anyways because we lack destructors for all the
stuff we initialize in setup_descriptor->init().

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 configure.ac | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure.ac b/configure.ac
index 82aea1e5a..4f9b1f928 100644
--- a/configure.ac
+++ b/configure.ac
@@ -685,6 +685,7 @@ AC_MSG_RESULT(${CONFIG_XENO_LIBS_DLOPEN:-no})
 if test x$CONFIG_XENO_LIBS_DLOPEN = xy; then
 	AC_DEFINE(CONFIG_XENO_LIBS_DLOPEN,1,[config])
 	AC_DEFINE_UNQUOTED(CONFIG_XENO_TLS_MODEL,"global-dynamic",[TLS model])
+	XENO_LIB_LDFLAGS="-Wl,-z -Wl,nodelete"
 else
 	AC_DEFINE_UNQUOTED(CONFIG_XENO_TLS_MODEL,"initial-exec",[TLS model])
 	XENO_LIB_LDFLAGS="-Wl,-z -Wl,nodlopen"
-- 
2.16.1


