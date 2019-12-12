From: Lange Norbert <norbert.lange@andritz.com>
Subject: Inspecting heap allocations?
Date: Thu, 12 Dec 2019 12:29:00 +0000
Message-ID: <VI1PR05MB59171CA57D6945AB7E64112FF6550@VI1PR05MB5917.eurprd05.prod.outlook.com>
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

I have some circumstances where I run out of global heap and then simple st=
ull like creating a mutex fails with ENOMEM.
My suspicion is an IDDP connection between 2 processes, where 1 process mig=
ht send a lot small packets before the other will pull them (I will try usi=
ng a local pool).

In the future, is there a way to dump the owners of heap objects?

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
