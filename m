From: Alex Plits <alex_plits@radwin.com>
Date: Mon, 4 Apr 2016 13:42:11 +0000
Message-ID: <DB5PR06MB1287CCF7EAF55DA6F95ED4A68F9D0@DB5PR06MB1287.eurprd06.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Mixing Posix RT APIs and vxWorks APIs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

We are currently porting some of our vxWorks  xenomai (copperplate) APIs we=
 use in our application to
Posix (cobalt I guess). We have started with the VxWorks "tasks" but it see=
ms that we're getting strange behavior on
The remaining VxWorks APIs when used from the POSIX generated tasks (thread=
s is the right word in posix) e.g. MsqQRecv function gets segfault but when=
 it is used From a VxWorks generated task it works fine.
I understand from the comments in code it should work but I was wondering i=
f there are known issues.

We are using currently xenomai 3 rc-6 (I saw there were fixes in xenomai 3.=
0.2).

Thanks in advance,
Alex Plits.

