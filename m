From: Lange Norbert <norbert.lange@andritz.com>
Date: Tue, 3 Apr 2018 14:10:30 +0000
Message-ID: <99BAB48E90E86D42AD41F0BCE3225AEB019FC0631A@GRZSMS582.andritz.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] building Xenomai Apps with CMake (RFC)
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

I went ahead and created a script to add support for Xenomai (3+) to CMake.=
 Its currently sufficient for me,
but I would like to get this in a shape that it is useful and robust enough=
 for most people.
Ultimately it should end up up streamed to CMake (I hope the binutils-speci=
fic wrappers aren't a knock-out against adoption).

Mostly this should interest people that want to use CMake, but a few things=
 might need support from the Xenomai distribution.
To be more specific: using precompiled object-files like the boostrap code =
and its linker wraps and redirections are something I would
like to avoid, or atleast offer an alternative that does not need that much=
 work outside of a "regular build".
For that, having the bootstrap code (configurable or a few variants) instal=
led as sourcecode would help.

Code is uploaded to Github : https://github.com/nolange/cmake_xenomai

Kind regards
Norbert Lange


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

