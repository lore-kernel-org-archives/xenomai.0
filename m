From: Lange Norbert <norbert.lange@andritz.com>
Date: Wed, 25 Apr 2018 16:40:32 +0000
Message-ID: <99BAB48E90E86D42AD41F0BCE3225AEB019FC12C42@GRZSMS582.andritz.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] xeno-config --no-mode-check still has -lmodechk
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>, "Philippe Gerum
 (rpm@xenomai.org)" <rpm@xenomai.org>

Hello,

Since I just ran into this=E2=80=A6.
libcobalt seems to really need libmodechk to define __real_malloc and __rea=
l_free.
I believe this to be a bug?

$ nm /home/lano/buildroot/host/x86_64-buildroot-linux-gnu/sysroot/usr/xenom=
ai/lib/libcobalt.so | grep malloc
00000000000199f0 T malloc_ex
                 U malloc@@GLIBC_2.2.5
000000000001aef0 T malloc_usable_size_ex
                 U __real_malloc
000000000001a430 T tlsf_malloc

Norbert
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
