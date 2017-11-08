From: "Schmeits Cedric (DC-AE/EHP2)" <cedric.schmeits@boschrexroth.nl>
Date: Wed, 8 Nov 2017 11:13:06 +0000
Message-ID: <5cc65b127d2640c690101f452e4deae1@SI-MBX1030.de.bosch.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] Sending UDP messages from xenomai context
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

I'm in the need of sending out an UDP package after calculations done withi=
n the context of a
xenomai thread. Currently the sending is done, but the thread is migrated t=
o the linux domain.

Currently i'm using the following setup to send out the packages:
	int s =3D socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
	struct sockaddr_in  addr;
    	memset((char *) &addr, 0, sizeof(addr));
	addr.sin_family =3D AF_INET;
	addr.sin_port =3D htons(5678);
	....
	int ret =3D sendto(s, pBuffer, bufferSize, 0, (struct sockaddr*)&addr, siz=
eof(addr));

Slackspot is telling me the following:
   #3  0x0000000000013a68 __real_sendto() in [/usr/xenomai/lib/libcobalt.so=
.2.0.0]
   #4  0x00000000000111d2 __cobalt_sendto() in [/usr/xenomai/lib/libcobalt.=
so.2.0.0]

So mine question is, is there a way of sending out the UDP message and with=
out migrating to
the linux domain? One possibility I came up with, until now, is to have an =
additional thread running=20
in the linux domain that handles the communication, but that will cause ext=
ra undeterministic=20
delay, which I would like to prevent.

I know that there is RTnet, but the receiving side does not have the possib=
ility to implement this.

Best regards,

Cedric Schmeits


