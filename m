From: =?utf-8?q?Fran=C3=A7ois_Legal?= <francois.legal@thom.fr.eu.org>
MIME-Version: 1.0
Date: Fri, 12 Mar 2021 23:21:04 +0100
Subject: Get packet timestamp in =?utf-8?q?af=5Fpacket?= or other RTNET
 components
Message-ID: <4c80-604be980-9d-743e7c00@120686847>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

working on a data recorder application, I would need to get access to e=
ach packet receive timestamp (populated during packet reception ISR gen=
erally in network drivers).

I figured out, the cleanest way to do it would be using the
 "void =5F=5Fuser *msg=5Fcontrol;	/* ancillary data */" / "=5F=5Fkernel=
=5Fsize=5Ft msg=5Fcontrollen;	/* ancillary data buffer length */"
members of the struct user=5Fmsghdr that is carried over when using the=
 recvmsg call, plus possibly an ioctl to enable the timestamp retrievin=
g

Did anybody already do something like this in xenomai/RTNET ?
Any thought on the proposed vector ?
Any chance such modification could become mainline ?

Thanks

Fran=C3=A7ois


