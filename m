Message-ID: <479DAE31.5070108@domain.hid>
Date: Mon, 28 Jan 2008 11:28:01 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <479DAA2E.7000307@domain.hid>
	<2ff1a98a0801280221h7cf2cb4cl84c696bfb51887a5@domain.hid>
In-Reply-To: <2ff1a98a0801280221h7cf2cb4cl84c696bfb51887a5@domain.hid>
Content-Type: multipart/mixed; boundary="------------050909020005090407060509"
Subject: Re: [Xenomai-core] [PATCH] consistent xeno-config output
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai-core@domain.hid

This is a multi-part message in MIME format.
--------------050909020005090407060509
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Gilles Chanteperdrix wrote:
> On Jan 28, 2008 11:10 AM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>> I received some complaint that xeno-config [--verbose] does not match
>> xeno-config --posix-ldflags. Here is a fix.
> 
> Useless use of cat detected ! When parsing posix.wrappers, we could
> redirect input from posix.wrappers instead of using cat.
> 

OK. Is this one better?

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

--------------050909020005090407060509
Content-Type: text/x-patch;
 name="consistify-xeno-config-output-v2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="consistify-xeno-config-output-v2.patch"

---
 scripts/xeno-config.in |   48 ++++++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 22 deletions(-)

Index: b/scripts/xeno-config.in
===================================================================
--- a/scripts/xeno-config.in
+++ b/scripts/xeno-config.in
@@ -23,6 +23,22 @@ XENO_LIBRARY_DIR="${staging}${libdir}"
 
 unset prefix exec_prefix libdir datadir datarootdir pkgdatadir includedir
 
+posix_ldflags ()
+{
+    if test \! -r $XENO_POSIX_WRAPPERS; then
+        echo "POSIX support is not available" >&2
+        exit 1
+    fi
+    if test "$XENO_POSIX_FAST_WRAPPING" = "yes"; then
+        echo -n "-Wl,@$XENO_POSIX_WRAPPERS $XENO_POSIX_LDFLAGS"
+    else
+        wrappers=`while read wrap_option symbol; do \
+                      echo -n "-Wl,$wrap_option,$symbol " ; \
+                  done < $XENO_POSIX_WRAPPERS`
+        echo -n "$wrappers $XENO_POSIX_LDFLAGS"
+    fi
+}
+
 usage ()
 {
 cat <<EOF
@@ -46,15 +62,15 @@ EOF
 verbose ()
 {
     echo xeno-config --verbose
-    echo "   " --version="\"${XENO_VERSION}\""
-    echo "   " --cc="\"$XENO_CC\""
-    echo "   " --arch="\"$XENO_TARGET_ARCH\""
-    echo "   " --prefix="\"$XENO_PREFIX\""
-    echo "   " --xeno-cflags="\"$XENO_BASE_CFLAGS\""
-    echo "   " --xeno-ldflags="\"$XENO_BASE_LDFLAGS\""
-    echo "   " --posix-cflags="\"$XENO_POSIX_CFLAGS\""
-    echo "   " --posix-ldflags="\"$XENO_POSIX_LDFLAGS\""
-    echo "   " --library-dir="\"$XENO_LIBRARY_DIR\""
+    echo "        --version=\"${XENO_VERSION}\""
+    echo "        --cc=\"$XENO_CC\""
+    echo "        --arch=\"$XENO_TARGET_ARCH\""
+    echo "        --prefix=\"$XENO_PREFIX\""
+    echo "        --xeno-cflags=\"$XENO_BASE_CFLAGS\""
+    echo "        --xeno-ldflags=\"$XENO_BASE_LDFLAGS\""
+    echo "        --posix-cflags=\"$XENO_POSIX_CFLAGS\""
+    echo "        --posix-ldflags=\"`posix_ldflags`\""
+    echo "        --library-dir=\"$XENO_LIBRARY_DIR\""
 }
 
 if test $# -eq 0; then
@@ -90,19 +106,7 @@ while test $# -gt 0; do
             echo $XENO_POSIX_CFLAGS
             ;;
         --posix-ldflags)
-            if test \! -r $XENO_POSIX_WRAPPERS; then
-               echo "POSIX support is not available" >&2
-               exit 1
-            fi
-            if test "$XENO_POSIX_FAST_WRAPPING" = "yes"; then
-                echo "-Wl,@$XENO_POSIX_WRAPPERS $XENO_POSIX_LDFLAGS"
-            else
-                wrappers=`cat $XENO_POSIX_WRAPPERS | \
-                    while read wrap_option symbol; do \
-                        echo -n "-Wl,$wrap_option,$symbol " ; \
-                    done`
-                echo "$wrappers $XENO_POSIX_LDFLAGS"
-            fi
+            echo `posix_ldflags`
             ;;
         --lib*-dir|--libdir|--user-libdir)
             echo $XENO_LIBRARY_DIR

--------------050909020005090407060509--

