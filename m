Date: Thu, 21 Oct 2010 10:58:04 +0100 (BST)
From: edward.robbins@domain.hid
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-ID: <1287655084.19729856@domain.hid>
Subject: [Xenomai-help] Xenomai and MEN IO Cards/MDIS drivers
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi again,=0A=0AI've almost finished setting up xenomai on my machine. I get=
 very little time to work on this project, so wont get back to it until Sat=
urday, but the next stage for me is getting the IO cards to work, and I tho=
ught I'd throw out an email as a precursor.=0A=0AIn this system we have a M=
EN M32 digital input card and an M28 digital output card. These come with L=
inux drivers, but they have to run through MEN's cross-platform driver API/=
framework, MDIS5. Previous versions of MDIS supported Xenomai and RTAI expl=
icitly, but they seem to have dropped that support in the latest version, a=
nd I doubt the previous version will 'just work' with newer kernels. I have=
 managed to successfully build the standard Linux MDIS drivers already.=0A=
=0AMDIS adds so many layers of obfuscation and abstraction that on a previo=
us occasion when I was attempting to get some M62 analogue output cards to =
work on a VMEbus VXworks platform I gave up on MDIS and wrote a new driver =
from scratch. =0A=0ASince Linux drivers are more complex to start with, and=
 then there is Xenomai as well, and time is tight, I'd rather not do that f=
or these cards. =0A=0ADoes anyone have experience of using MEN drivers/IO c=
ards in Xenomai? Can I simply wrap the MDIS API with the Xenomai API (descr=
ibed here http://www.xenomai.org/documentation/xenomai-2.5/html/api/index.h=
tml) once I've crawled my way through their code? Is there an easier way?=
=0A=0AAlso, I presume that as a temporary fall-back I can use the standard,=
 non-RT drivers from Xenomai user-land processes?=0A=0AMany thanks,=0AEdwar=
d=0A=0AControl Systems Engineer=0AOxford Technologies Ltd=0A7 Nuffield Way,=
 Abingdon, Oxon, OX14 1RJ=0ATel: +44 (0)1235 522119 


