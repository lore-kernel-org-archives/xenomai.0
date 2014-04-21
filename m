Message-ID: <1398115447.70510.YahooMailNeo@web171605.mail.ir2.yahoo.com>
Date: Mon, 21 Apr 2014 22:24:07 +0100 (BST)
From: Matthias Schneider <ma30002000@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] occasional EBADF in select() in notifier.c
Reply-To: Matthias Schneider <ma30002000@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Still working on thread suspension in forge/mercury, I occasionally get a E=
BADF=0Aof the select() call in notifier.c. I suspect that this is due to ac=
cessing a=A0=0Acopy of the file descriptor list notifier_rset while one of =
the file descriptors=A0=0Ais being closed. This seems to be due to concurre=
nt access on the notifier_rset=A0=0Afrom notifier_sighandler() and notifier=
_destroy(). "notifier_lock" is held in=A0=0Anotifier_lock(), but not when c=
opying and invoking select in notifier_sighandler().=0AThe EBADF leads to a=
 "spurious notification" reporting and process termination -=0A=A0obviously=
, the thread suspension was not triggered.=0A=0AI can think of several ways=
 of addressing this issue but I am not sure about=A0=0Aside effects:=0Aa) h=
old the "notifier_lock" mutex between copying the descriptor list and calli=
ng select=0Ab) repeating the select() call in the case of EBADF=0A=0AAny id=
eas?=0A=0AAnyway, why is the select call necessary, isnt the file descripto=
r signaled via=A0=0Asiginfo->si_fd, too?=0A=0ARegards,=0AMatthias

