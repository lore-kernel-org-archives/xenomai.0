Date: Thu, 1 Oct 2020 02:41:26 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
Message-ID: <180268575.3119360.1601538086890.JavaMail.zimbra@wolfram.com>
Subject: Is it possible to tell whether a network socket is/will be a real
 time socket or a regular socket runtime?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hi list

Is there a way that I can tell if a network socket is a real time socket or=
 a regular socket runtime ?
Usually I always know beforehand whether something is going to be a real ti=
me socket or a std posix socket. Now it will depend on the host-address.=20

I have this posix-skin application that can be both real time and non real =
time depending on available network hardware. Because of the differences be=
tween RTNet and regular posix net implementation i sometimes have to choose=
 between setsockopt/ioctl when setting the properties. Therefore I need to =
handle a few lines of code differently depending on the situation.

This brings up another issue I have been struggling with for the posix-skin=
.=20
When, in this snippet of code, is it decided whether __std or __cobolt func=
tions are executed ?=20

Is it run-time or compile time ? If runtime, is it during the connect or du=
ring the sendto ?=20

serv_addr.sin_family =3D AF_INET;
serv_addr.sin_addr.s_addr =3D inet_addr(host_name);
serv_addr.sin_port =3D htons( portno );
sockfd =3D socket(AF_INET, SOCK_DGRAM,0);
connect( sockfd, ( struct sockaddr * ) &serv_addr, sizeof( serv_addr))
sendto(sockfd, (char*) &packet, sizeof( packetType ), MSG_DONTWAIT, NULL, s=
izeof( serv_addr ));

Regards
Per =C3=96berg=20

