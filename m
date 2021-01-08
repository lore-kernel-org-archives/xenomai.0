From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
MIME-Version: 1.0
Date: Fri, 08 Jan 2021 19:35:06 +0100
Subject: Weird =?utf-8?q?semaphore=2Ftimeout?= behaviour with gdbserver
Message-ID: <35a5-5ff8a600-5-48dc0d80@255670131>
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

Hello,

Working on ARMv7 with linux 4.4 and xenomai 3.1, I get a strange behavi=
our when using GDB.
There seem to be troubles with threads pending on semaphores, which do =
not wake up when sem is posted nor when the timedwait is over.
It does not seem to make a problem with all the semaphores on the softw=
are, but at program startup, the behaviour is pretty constant.

If I start the same program from shell, thread activation works flawles=
sly.

ANybody can give a hint on this ?

Thanks.

Fran=C3=A7ois


