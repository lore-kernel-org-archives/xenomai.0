From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
MIME-Version: 1.0
Date: Tue, 15 Feb 2022 21:28:12 +0100
Subject: Weird nanosleep behaviour while debugging after toolchain change
Message-ID: <d00-620c0d00-9-12ac4c80@203449265>
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

using xenomai 3.1/linux 4.4 on arm, I'm facing a weird issue with gdb d=
ebugging.
I was previously using a croostool-ng generated toolchain, and had to s=
witch to a yocto generated one.

The same application/kernel/xenomai user land being used, when I run th=
e application through the debugger, the calls to nanosleep in my RT thr=
ead seem to block indefinitely unless I single step through the code. P=
lacing a break right after a nanosleep and continuing will not trigger =
the break.

I don't know what to do to chase this.

While the thread is in nanosleep, I can see this in /proc/xenomai/sched=
 :
CPU  PID    CLASS  TYPE      PRI   TIMEOUT       STAT       NAME
  0  1666   rt     cobalt     60   839ms140us    w          Thread a (s=
em=5Ftimedwaiting. Timeout changes each time I display threads)
  0  1667   rt     cobalt     62   -                        s          =
Thread b (nanosleeping)

CPU  PID    MSW        CSW        XSC        PF    STAT       %CPU  NAM=
E
  0  1666   6          42         50         0     00248046    0.0  Thr=
ead a 
  0  1667   4          96         95         0     00640040    0.0  Thr=
ead b

Can anybody help ?

Fran=C3=A7ois


