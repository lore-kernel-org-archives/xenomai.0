From: Lange Norbert <norbert.lange@andritz.com>
Subject: cobalts printf thread affects signalfd operation
Date: Thu, 13 Jun 2019 17:08:29 +0000
Message-ID: <VI1PR05MB59173D4829F3F8EBA9143AE7F6EF0@VI1PR05MB5917.eurprd05.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

Hello,

I ran into a problem with the automatically spawned printf thread.

Short summary:
The kernel delivers signals by picking a thread that can accept a signal an=
d does not mask the specific signal,
only if none is available then the signal will be queued for asynchronous d=
elivery.
signalfd is asynchronous delivery, thus if one thread accepts signals then =
signalfd won't work as expected,
enter cobals printf thread.

Solutions would be:

- Mask all signals for this thread (is there any downside?)
- Mask all signals on the main thread before calling xenomai_init. This is =
ugly, as that removes most methods of interacting with a hung startup.
- Somehow mask the thread for signals later (only ugly solutions?).

The first option would be a rather small patch:

@@ -642,7 +642,11 @@ static void spawn_printer_thread(void)
 pthread_attr_t thattr;

 pthread_attr_init(&thattr);
+sigset_t sset, oset;
+sigfillset(&sset)
+sigprocmask(SIG_BLOCK, &sset, &oset);
 pthread_create(&printer_thread, &thattr, printer_loop, NULL);
+sigprocmask(SIG_SETMASK, &oset, NULL);
 }

Mit besten Gr=FC=DFen / Kind regards

NORBERT LANGE
AT-DES

ANDRITZ HYDRO GmbH
Eibesbrunnergasse 20
1120 Vienna / AUSTRIA
p: +43 50805 56684
norbert.lange@andritz.com
andritz.com
________________________________

This message and any attachments are solely for the use of the intended rec=
ipients. They may contain privileged and/or confidential information or oth=
er information protected from disclosure. If you are not an intended recipi=
ent, you are hereby notified that you received this email in error and that=
 any review, dissemination, distribution or copying of this email and any a=
ttachment is strictly prohibited. If you have received this email in error,=
 please contact the sender and delete the message and any attachment from y=
our system.

ANDRITZ HYDRO GmbH


Rechtsform/ Legal form: Gesellschaft mit beschr=E4nkter Haftung / Corporati=
on

Firmensitz/ Registered seat: Wien

Firmenbuchgericht/ Court of registry: Handelsgericht Wien

Firmenbuchnummer/ Company registration: FN 61833 g

DVR: 0605077

UID-Nr.: ATU14756806


Thank You
________________________________

