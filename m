From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
MIME-Version: 1.0
Date: Thu, 20 Aug 2020 15:46:41 +0200
Subject: Strange switching =?utf-8?q?=5Bthreadname=5D?= to secondary mode
 after exception #0 in kernel-space at 0x80272444
Message-ID: <1174-5f3e7f00-1-37e14c00@201456977>
Content-Type: text/plain; charset="utf-8"
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

Using RTNet with multiple interfaces, xenomai 3.1 with linux 4.4
Whenever a posix RT thread calls recvmsg (), I get this error.

I could track this down to line 422 in udp.c :     msg =3D rtnet=5Fget=5F=
arg(fd, &=5Fmsg, u=5Fmsg, sizeof(=5Fmsg));

If I disassemble the kernel, the failing instruction (at 0x80272444) is=
 a nop in arm=5Fcopy=5Ffrom=5Fuser
Am I doing anything wrong ?

Fran=C3=A7ois


