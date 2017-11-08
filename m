Date: Wed, 08 Nov 2017 19:47:46 +0100
From: "Mariusz Janiak" <mariuszjaniak@wp.pl>
Message-ID: <5a0351527b4071.35027230@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [Xenomai] Odp:  Sending UDP messages from xenomai context
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Schmeits Cedric (DC-AE/EHP2)" <cedric.schmeits@boschrexroth.nl>
Cc: xenomai@xenomai.org

Dnia =A6roda, 8 Listopada 2017 12:13 Schmeits Cedric (DC-AE/EHP2) <cedric.s=
chmeits@boschrexroth.nl> napisa=B3(a)=20
> Hello,
>=20
> I'm in the need of sending out an UDP package after calculations done wit=
hin the context of a
> xenomai thread. Currently the sending is done, but the thread is migrated=
 to the linux domain.
>=20
> Currently i'm using the following setup to send out the packages:
> 	int s =3D socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
> 	struct sockaddr_in  addr;
>     	memset((char *) &addr, 0, sizeof(addr));
> 	addr.sin_family =3D AF_INET;
> 	addr.sin_port =3D htons(5678);
> 	....
> 	int ret =3D sendto(s, pBuffer, bufferSize, 0, (struct sockaddr*)&addr, s=
izeof(addr));
>=20
> Slackspot is telling me the following:
>    #3  0x0000000000013a68 __real_sendto() in [/usr/xenomai/lib/libcobalt.=
so.2.0.0]
>    #4  0x00000000000111d2 __cobalt_sendto() in [/usr/xenomai/lib/libcobal=
t.so.2.0.0]
>=20
> So mine question is, is there a way of sending out the UDP message and wi=
thout migrating to
> the linux domain? One possibility I came up with, until now, is to have a=
n additional thread running=20
> in the linux domain that handles the communication, but that will cause e=
xtra undeterministic=20
> delay, which I would like to prevent.
>=20
> I know that there is RTnet, but the receiving side does not have the poss=
ibility to implement this.
>=20
> Best regards,
>=20
> Cedric Schmeits
>=20

Hi,

The task migrates to the Linux domain because you invoke a linux syscall, b=
y calling sendto on the socket managed by the Linux domain. You need a netw=
ork stack which is handled by the Xenomai domain -- only I know is RTnet. Y=
ou can omit the TDMA layer in the RTnet configuration (by setting  nomac). =
Then you can communicate with others machines that have a common network st=
ack (Linux, Windows, etc. ). This issue has been already discuses, so pleas=
e refer to previous posts. .=20

Best regards,
Mariusz

> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai




