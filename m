From: luxInteg <lux-integ@domain.hid>
Date: Sun, 17 Oct 2010 15:23:21 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201010171523.21229.lux-integ@domain.hid>
Subject: [Xenomai-help] xenomai-2.5.5 xml requirments
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Greetings,

I have successfully patched, compiled and installed kernels  2.6.32 and 
2.6.35.7   with senomai-2.5.5 on a computer  (not on the internet) 
 with these:-
----cpu amd64 2 cores
----kernel: linux-2.6.35.7 (64-bit CBLFS linux)

I am now attempting to build the xenomai userspace  tools (out of kernel-
build)  via autonconf


----------A) if I pass:-
-------------------------
--enable-dbx \
--with-dbx-root=/usr/share/xml/docbook/xml-dtd-4.5  \
--disable-dbx-network

to configure

configure responds with:-
-------------------
checking for docbook-xml root dir... /usr/share/xml/docbook/xml-dtd-4.5
checking for docbook-xsl root dir... network
configure: error: The Docbook XML DTD was not found, and accessing it
through network is forbidden.

AND no makefiles are generated.


I have xml installed as follows


rtBOX [ ~ ]# ls -l /usr/share/xml/docbook
total 8
drwxr-xr-x  3 root root 4096 Oct  8 18:31 xml-dtd-4.5
drwxr-xr-x 19 root root 4096 Oct  8 18:31 xsl-stylesheets-1.75.2
rtBOX [ ~ ]# 




rtBOX [ ~ ]# ls -l  /usr/share/xml/docbook/xml-dtd-4.5
total 392
-rw-r--r-- 1 root root   9174 Oct  8 18:31 calstblx.dtd
-rw-r--r-- 1 root root  10155 Oct  8 18:31 dbcentx.mod
-rw-r--r-- 1 root root   1565 Oct  8 18:31 dbgenent.mod
-rw-r--r-- 1 root root  63686 Oct  8 18:31 dbhierx.mod
-rw-r--r-- 1 root root   4521 Oct  8 18:31 dbnotnx.mod
-rw-r--r-- 1 root root 247056 Oct  8 18:31 dbpoolx.mod
-rw-r--r-- 1 root root   4010 Oct  8 18:31 docbook.cat
-rw-r--r-- 1 root root   5791 Oct  8 18:31 docbookx.dtd
drwxr-xr-x 2 root root   4096 Oct  8 18:31 ent
-rw-r--r-- 1 root root   8184 Oct  8 18:31 htmltblx.mod
-rw-r--r-- 1 root root  13150 Oct  8 18:31 soextblx.dtd
rtBOX [ ~ ]# 


----------B) if  I do-NOT pass the above to configure makefiles are generatd 
but  make ends like so

------------------------------
SGML_CATALOG_FILES=../../../../../doc/docbook/catalog \
        xsltproc --catalogs --xinclude --nonet  --output xeno-titlepage.xsl \
 http://docbook.sourceforge.net/release/xsl/current/template/titlepage.xsl 
xeno-titlepage.spec.xml
../../../../../doc/docbook/catalog:0: element rewriteURI: Catalog error : 
rewriteURI entry 'rewritePrefix' broken ?: 
http://http://docbook.sourceforge.net/release/xsl/current/
I/O error : Attempt to load network entity 
http://docbook.sourceforge.net/release/xsl/current/template/titlepage.xsl
warning: failed to load external entity 
"http://docbook.sourceforge.net/release/xsl/current/template/titlepage.xsl"
cannot parse 
http://docbook.sourceforge.net/release/xsl/current/template/titlepage.xsl
make[5]: *** [xeno-titlepage.xsl] Error 4



I would like to have the XML documentation so I would be grateful If someone   
tell me which files I should have and where in my xml installation these 
should live to enable xenomai-2.5.5 compilation.

sinceely
lux-integ

