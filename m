From: Marc =?ISO-8859-1?Q?Str=E4mke?= <marc.straemke@eltropuls.de>
Date: Thu, 30 Apr 2015 16:33:40 +0200
Message-ID: <3382708.2jmfqTEg5F@eltrolinux48.eltroad.eltropuls>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Hang/Reboot when using CONFIG_CC_STACKPROTECTOR_REGULAR
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello everyone,

during migration to xenomai 3 we found in testing that enabling the kernel =

config option CONFIG_CC_STACKPROTECTOR_REGULAR leads to hangs or reboots =

(depends on the target platform we are testing on). =


This post: http://www.xenomai.org/pipermail/xenomai/2012-July/000511.html =

shows that the old xenomai 2.6 triggered an error when the stack protector =
was =

enabled.

I think this warning should be readded to the newer source or at least a =

warning added to the kernel compile documentation.

Attached see my kernel config which crashed (based on debian 8 config) =


Marc

-- =

Dipl.-Ing. Marc Str=E4mke
Gesch=E4ftsf=FChrer / CEO

ELTROPULS Anlagenbau GmbH
Arnold-Sommerfeld-Ring 3
52499 Baesweiler
Germany

www.eltropuls.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config_crash
Type: text/x-mpsub
Size: 134194 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150430/9e4a5a6=
e/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: This is a digitally signed message part.
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150430/9e4a5a6=
e/attachment.sig>
