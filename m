Message-ID: <4BF04E9A.6020005@domain.hid>
Date: Sun, 16 May 2010 21:59:22 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4BEEE3D9.8060000@domain.hid> <4BF01615.4070709@domain.hid>
In-Reply-To: <4BF01615.4070709@domain.hid>
Content-Type: multipart/mixed; boundary="------------030409030206080403080805"
Subject: Re: [Xenomai-core] New Debian source package format 3.0
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

This is a multi-part message in MIME format.
--------------030409030206080403080805
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Gilles Chanteperdrix schrieb:
> Roland Stigge wrote:
>> Hi,
>>
>> * To migrate appropriately, you can do the following changes in the 
>> xenomai.org repository:
>>
>> $ mkdir debian/source
>> $ echo '3.0 (native)' > debian/source/format
>> $ dch 'Switch to dpkg-source 3.0 (native) format'
> 
> It is OK with me, but I probably do not have the proper tools installed.
> Could someone do it and send me the patches? Stefan maybe?
> 
> TIA.
> 

patch attached, stefan

--------------030409030206080403080805
Content-Type: text/x-diff;
 name="0001-debian-switch-to-dpkg-source-3.0-native-format.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-debian-switch-to-dpkg-source-3.0-native-format.patch"

>From fa86da573916f59869e6f2e552525d9f9c4135de Mon Sep 17 00:00:00 2001
From: Stefan Kisdaroczi <kisda@domain.hid>
Date: Sun, 16 May 2010 21:48:34 +0200
Subject: [PATCH] debian: switch to dpkg-source 3.0 (native) format

---
 debian/changelog     |    6 ++++++
 debian/source/format |    1 +
 debian/watch         |    2 --
 3 files changed, 7 insertions(+), 2 deletions(-)
 create mode 100644 debian/source/format
 delete mode 100644 debian/watch

diff --git a/debian/changelog b/debian/changelog
index 9f001a9..c69851e 100644
--- a/debian/changelog
+++ b/debian/changelog
@@ -1,3 +1,9 @@
+xenomai (2.5.3) unstable; urgency=low
+
+  * Switch to dpkg-source 3.0 (native) format
+
+ -- Stefan Kisdaroczi <kisda@domain.hid>  Sun, 16 May 2010 21:46:58 +0200
+
 xenomai (2.5.2-2) unstable; urgency=low
 
   * Added patch from Stefan Kisdaroczi <kisda@domain.hid>:
diff --git a/debian/source/format b/debian/source/format
new file mode 100644
index 0000000..89ae9db
--- /dev/null
+++ b/debian/source/format
@@ -0,0 +1 @@
+3.0 (native)
diff --git a/debian/watch b/debian/watch
deleted file mode 100644
index caf6853..0000000
--- a/debian/watch
+++ /dev/null
@@ -1,2 +0,0 @@
-version=3
-http://download.gna.org/xenomai/stable/xenomai-(.*)\.tar\.bz2
-- 
1.5.6.5


--------------030409030206080403080805--

