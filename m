From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <35a5-5ff8a600-5-48dc0d80@255670131>
Content-Type: text/plain; charset="utf-8"
Date: Tue, 19 Jan 2021 18:41:55 +0100
MIME-Version: 1.0
Message-ID: <4c80-60071a00-11-743e7c00@26732586>
Subject: =?utf-8?q?Re=3A?= Weird =?utf-8?q?semaphore=2Ftimeout?= behaviour
 with gdbserver
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

Le Vendredi, Janvier 08, 2021 19:35 CET, Fran=C3=A7ois Legal via Xenoma=
i <xenomai@xenomai.org> a =C3=A9crit: 
 
> Hello,
> 
> Working on ARMv7 with linux 4.4 and xenomai 3.1, I get a strange beha=
viour when using GDB.
> There seem to be troubles with threads pending on semaphores, which d=
o not wake up when sem is posted nor when the timedwait is over.
> It does not seem to make a problem with all the semaphores on the sof=
tware, but at program startup, the behaviour is pretty constant.
> 
> If I start the same program from shell, thread activation works flawl=
essly.
> 
> ANybody can give a hint on this ?
> 
> Thanks.
> 
> Fran=C3=A7ois
> 
> 
 
I've got another case with pulse semaphores with timeout, that outline =
the same behaviour without gdbserver.
I've got 2 threads and 2 pulse semaphores. Thread1 (priority 60) succes=
sively pends (with 30s timeout) on SEM1 then posts SEM2, while thread2 =
(priority 52) posts SEM1 then pends (forever) on SEM2. Both semaphores =
are initialized at 0.
I can see from debug log that Thread1 pends on SEM1, then thread2 posts=
 SEM1 and pends SEM2, then thread1 posts SEM2, then thread2 posts SEM1 =
then pends SEM2, then thread1 pends SEM1, then nothing happens anymore.=
 I thought thread1 should be unblocked (either by thread2 posting SEM1,=
 or by the 30s timeout) but that never happens.

What am I getting wrong here ?

Fran=C3=A7ois


