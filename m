Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Date: Wed, 18 Mar 2020 09:58:35 +0100
Subject: Get physical link status on an RTNET driven NIC
Message-ID: <7232-5e71e280-17-2896e5c0@29286636>
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka via Xenomai <xenomai@xenomai.org>

Hello,

I wa wondering if there was any mean to get the physical link state of =
a network interface driven through RTDM/RTNET.

I check /sys/class/net/rteth*/carrier but it does not seem to work on R=
T interfaces.

Thanks in advance

Fran=C3=A7ois


