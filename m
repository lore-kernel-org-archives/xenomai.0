From: Lange Norbert <norbert.lange@andritz.com>
Subject: Some build issues with dovetail + ipipe 4.19
Date: Wed, 10 Feb 2021 11:23:59 +0000
Message-ID: <VI1PR05MB591721033A800D11F012D853F68D9@VI1PR05MB5917.eurprd05.prod.outlook.com>
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

Hello,


By accident I built 4.19.152-cip37-x86-15 with the wip/dovetail branch. I u=
nderstand that this should be supported one day?
In the hope that this is of use for you, I get built following errors durin=
g the modpost step with this config:

ERROR: "__rtdm_nrtsig_execute" [drivers/xenomai/testing/xeno_switchtest.ko]=
 undefined!
ERROR: "__rtdm_nrtsig_execute" [drivers/xenomai/net/drivers/igb/rt_igb.ko] =
undefined!
ERROR: "pipeline_read_wallclock" [drivers/xenomai/net/drivers/igb/rt_igb.ko=
] undefined!

Mit besten Gr=FC=DFen / Kind regards

NORBERT LANGE

AT-RD3

ANDRITZ HYDRO GmbH
Eibesbrunnergasse 20
1120 Vienna / AUSTRIA
p: +43 50805 56684
norbert.lange@andritz.com<mailto:norbert.lange@andritz.com>
andritz.com<http://www.andritz.com/>

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
