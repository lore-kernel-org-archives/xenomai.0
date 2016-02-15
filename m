MIME-Version: 1.0
Date: Mon, 15 Feb 2016 13:48:57 +0100
Message-ID: <CAMgLWPm3z5h-aLw5X5LdU+6ULQoqHTN2ebwR0Y4=z1F+qFVsKA@mail.gmail.com>
From: "GEORGE, Laurent" <laurent.george@esiee.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Problem with rt_igb driver for I210 card
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I have dowloaded and tested the stable version of Xenoma=C3=AF 3 including =
a
support for the I210 (Intel) card, available at the following git:

https://git.xenomai.org/xenomai-3.git/commit/?h=3Dnext&id=3D8268c5e87cf0ac5=
223d98a86918b9420a0e94382

I have the following problem:

The Installation of Xenomai went well. When I load rt_igb.ko module, the
rteth0 interface for Intel i210 NIC goes up well but there are following 2
issues:

a) when I try the rtsolicit command to add devices in network, it doesn't
work
b) When I try to remove rt_igb module after taking down rteth0 interface it
hangs and the only way to get back is a hard restart by pressing the
restart button on PC.

I precise that I have other fully functionnal NIC interfaces based on
rt_e1000e driver on my PC.

Thank you for your help.

Best regards,
Laurent George.

--=20


*Laurent George*Professor at ESIEE Paris

*ESIEE Paris - LIGM, Universit=C3=A9 Paris-Est*2 Boulevard Blaise Pascal,
93162 Noisy-le-Grand
Laurent.George@esiee.fr
