From: Lange Norbert <norbert.lange@andritz.com>
Subject: libcopperplate.so depends on modecheck?
Date: Wed, 20 Mar 2019 10:50:15 +0000
Message-ID: <f467b76008e5458c8741a0e56c02e2e1@andritz.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
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

Seems like libcopperplate.so always depends on libmodechk.so, as the follow=
ing symbols would imply:

nm -D /home/lano/buildroot/host/x86_64-buildroot-linux-gnu/sysroot/usr/xeno=
mai/lib/libcopperplate.so | grep __real
                 U __real_free
                 U __real_malloc

xeno-config deals with this by always linking modeck, even if you add --no-=
mode-check-

I am not completely confident with the wrapper-magic,
but shouldn't libcopperplate use either cobalt_malloc or the libc malloc?
__real_malloc is just a stub for libc malloc, so I really don't get the poi=
nt (assuming this is intentional).

Modeswitches could also be detected by interposing libraries, so removing l=
ibmodechk
Is a viable thing to do.
(shameless plug: https://github.com/nolange/preload_checkers )


Regards, Norbert
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


Rechtsform/ Legal form: Gesellschaft mit beschr=C3=A4nkter Haftung / Corpor=
ation

Firmensitz/ Registered seat: Wien

Firmenbuchgericht/ Court of registry: Handelsgericht Wien

Firmenbuchnummer/ Company registration: FN 61833 g

DVR: 0605077

UID-Nr.: ATU14756806


Thank You
________________________________

