From: =?utf-8?Q?Deniz_U=C4=9Fur?= <deniz343@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: [EVL][dovetail] Minimum requirements for network communication for
 RPi 4B and amd64
Message-Id: <388405AD-717D-45F2-8504-515F3BE70117@gmail.com>
Date: Thu, 4 Nov 2021 11:43:36 +0300
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Greetings Xenomai community,

For the past year I have been using EVL to develop some real-time apps =
utilizing fast data acquisition through SPI interfaces on RPi 4B. I then =
send the collected data through mainline network stack to a amd64 =
machine running Xenomai 3.1. The data I=E2=80=99m sending is sensitive =
and cannot afford packet drops. By that I mean even if I use UDP I would =
have to wait for next successful packet to continue. So in that case, I =
guess, TCP without Nagle=E2=80=99s algorithm should be enough.

What I want to ask is how would one achieve a bare minimum but real-time =
communication between two devices over network. I can convert my other =
Xenomai client to EVL. Any improvements over mainline network stack =
would be enough I believe.

Thanks for your time,
Deniz.=

