Message-ID: <1374143094.1082.YahooMailNeo@web172202.mail.ir2.yahoo.com>
Date: Thu, 18 Jul 2013 11:24:54 +0100 (BST)
From: Franz Engel <franz_lambert_engel@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] __xn_sys_current_info failed: Operation not permitted
Reply-To: Franz Engel <franz_lambert_engel@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,=0A=0AI get this error when I run a programm:=0A__xn_sys_current_info fa=
iled: Operation not permitted=0A=0AI know that the error comes from the ass=
ert_nrt_inner(void) function inside the assert_context.c file. But I have n=
o idea what is the reason. The Operation not permitted is the return value =
from XENOMAI_SYSCALL1(__xn_sys_current_info, &info);. But I found no docume=
ntation about this function.=0A=0ARegards,=0A=A0=A0=A0=A0 Franz
