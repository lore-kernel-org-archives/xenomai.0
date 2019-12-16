From: Lange Norbert <norbert.lange@andritz.com>
Subject: rtcap destroys packet contents
Date: Mon, 16 Dec 2019 12:36:11 +0000
Message-ID: <VI1PR05MB59178694A8343C2EE1A5081BF6510@VI1PR05MB5917.eurprd05.prod.outlook.com>
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

Hi,

I have such a setup, where I push/pull ethernet traffic from an Application=
 every millisecond:

[App] ---IDDP--> [RTSwitch] --ETH_P_ALL socket--> [rt_igp]
[App] <---IDDP-- [RTSwitch] <--ETH_P_ALL socket-- [rt_igp]
[Tun] <---tundev---/


Now I am sometimes missing packets that the other side should definitely ha=
ve sent. I wanted to use rtcap
to inspect this issue, but unfortunately then I get messed up data so that =
I can't even finish some handshake procedures.

Is there some incompatibility between RTCAP and ETH_P_ALL (which makes its =
own copies of rtskb's)?
Btw, I can't unload rtap/rtnet once loaded.

Mit besten Gr=FC=DFen / Kind regards

NORBERT LANGE

AT-RD3

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

