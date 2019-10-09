From: Lange Norbert <norbert.lange@andritz.com>
Subject: Script for namespacing a few intel drivers
Date: Wed, 9 Oct 2019 14:31:01 +0000
Message-ID: <VI1PR05MB5917C80A2ECB5F4E8219E897F6950@VI1PR05MB5917.eurprd05.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>


I managed to build a kernel with statically linked igb, e1000 and e1000e fo=
r linux and rtnet, after running the below script to namespace those driver=
s (I only use [rt_]igb, but this driver needs symbols from e1000).
Seems to basically work, with some caveats that might only relate to my cha=
nges.

Even if you don't use both drivers at one, I am not sure if there aren't so=
me definitions leaking from the linux headers right now, so a cleanup might=
 be useful anyway.


Norbert

-----------------------
# run me in kernel/drivers/net/drivers

sedreplace() {
(
    TMPFILE=3D/tmp/functions.lst
    {
            grep -roh '\bigb_[[:alnum:]_]*[[:space:]]*(' | sed 's,[[:space:=
]]*(,,'
            grep -roh 'struct[[:space:]]*igb_[[:alnum:]_]*\b' | sed 's,stru=
ct[[:space:]]*,,'
            grep -roh '\be1000e*_[[:alnum:]_]*[[:space:]]*(' | sed 's,[[:sp=
ace:]]*(,,'
            grep -roh 'struct[[:space:]]*e1000e*_[[:alnum:]_]*\b' | sed 's,=
struct[[:space:]]*,,'

            for ad; do echo $ad; done
    } | sort -u >$TMPFILE

            while read -r f; do
              printf -- '-e s,\\b%s\\b,rt_%s,g ' $f $f
            done < $TMPFILE
)
}

SEDREP=3D$(sedreplace igb_driver_name igb_driver_version e1000_driver_name =
e1000_driver_version e1000e_driver_name e1000e_driver_version)

sed $SEDREP -e 's,^#include "rt_e1000_,#include "e1000_,' -i $(find -name '=
*.c' -o -name '*.h')

Mit besten Gr=FC=DFen / Kind regards

NORBERT LANGE

AT-DES

ANDRITZ HYDRO GmbH
Eibesbrunnergasse 20
1120 Vienna / AUSTRIA
p: +43 50805 56684
norbert.lange@andritz.com<mailto:norbert.lange@andritz.com>
andritz.com<http://www.andritz.com>
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
