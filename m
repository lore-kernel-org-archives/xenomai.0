From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
MIME-Version: 1.0
Date: Mon, 07 Dec 2020 11:49:05 +0100
Subject: =?utf-8?q?=5BPatch?==?utf-8?q?_0=2F4=5D?= Problems with upstream
 SPECTRE mitigation found in =?utf-8?q?sendmsg=2Frecvmsg?= syscalls
Message-ID: <1176-5fce0880-151-12dbaa60@116771034>
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

From: Fran=C3=A7ois LEGAL <devel@thom.fr.eu.org>

The syscall entry code used to copy the struct user=5Fmsghdr on the sys=
call stack, and some registered callbacks (notably in RTNet) were then =
calling again copy=5Ffrom/to=5Fuser on that struct, which would trigger=
 the SPECTRE mitigation protection.

I ran the iddp/xddp/bufp-label tests which seems ok with the patch, and=
 retested RTNet af=5Fpacket part
I did not test the rtcan part as I have no hardware available.

 kernel/cobalt/posix/io.c          | 20 ++------------------
 kernel/drivers/can/rtcan=5Fraw.c    | 37 +++++++++++++++++++++++++++++=
--------
 kernel/drivers/ipc/bufp.c         | 14 ++++++++++++--
 kernel/drivers/ipc/iddp.c         | 14 ++++++++++++--
 kernel/drivers/ipc/xddp.c         | 14 ++++++++++++--
 5 files changed, 67 insertions(+), 32 deletions(-)


