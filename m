Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C708D7.01E03B37"
Subject: RE: [Xenomai-help] [PATCH] pthread_setname_np
Date: Wed, 15 Nov 2006 16:56:34 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB0154F047@domain.hid>
In-Reply-To: <455B3B6B.1030109@domain.hid>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
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

This is a multi-part message in MIME format.

------_=_NextPart_001_01C708D7.01E03B37
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:

> If you feel like modifying the documentation, please send a patch.

Here is the patch.

Best regards,

Daniel



Index: ksrc/skins/posix/thread.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/posix/thread.c   (revision 1834)
+++ ksrc/skins/posix/thread.c   (working copy)
@@ -650,7 +650,7 @@
 }

 /**
- * Set a thread name.
+ * Set the name of a running thread.
  *
  * This service set to @a name, the name of @a thread. This name is
used for
  * displaying information in /proc/xenomai/sched.

------_=_NextPart_001_01C708D7.01E03B37
Content-Type: text/plain;
	name="patch-docu.txt"
Content-Transfer-Encoding: base64
Content-Description: patch-docu.txt
Content-Disposition: attachment;
	filename="patch-docu.txt"

SW5kZXg6IGtzcmMvc2tpbnMvcG9zaXgvdGhyZWFkLmMKPT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0ga3NyYy9za2lu
cy9wb3NpeC90aHJlYWQuYyAgIChyZXZpc2lvbiAxODM0KQorKysga3NyYy9za2lucy9wb3NpeC90
aHJlYWQuYyAgICh3b3JraW5nIGNvcHkpCkBAIC02NTAsNyArNjUwLDcgQEAKIH0KCiAvKioKLSAq
IFNldCBhIHRocmVhZCBuYW1lLgorICogU2V0IHRoZSBuYW1lIG9mIGEgcnVubmluZyB0aHJlYWQu
CiAgKgogICogVGhpcyBzZXJ2aWNlIHNldCB0byBAYSBuYW1lLCB0aGUgbmFtZSBvZiBAYSB0aHJl
YWQuIFRoaXMgbmFtZSBpcyB1c2VkIGZvcgogICogZGlzcGxheWluZyBpbmZvcm1hdGlvbiBpbiAv
cHJvYy94ZW5vbWFpL3NjaGVkLgo=

------_=_NextPart_001_01C708D7.01E03B37--

