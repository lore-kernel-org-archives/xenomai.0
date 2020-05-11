Subject: =?utf-8?q?Migrating_rt=5Fdev=5F=2E=2E=2E_from_Xenomai_2=2Ex_to_3=2Ex?=
Date: Mon, 11 May 2020 15:35:58 +0200
From: =?utf-8?q?Petr_=c4=8cervenka?= <grugh@centrum.cz>
MIME-Version: 1.0
Message-Id: <20200511153558.483FDBB3@centrum.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hello everyone.
I used "Native" skin, rtnet and rt_dev_... functions in Xenomai 2.6.x.
Now I'm trying to port it to Xenomai 3 Alchemy skin.
=C2=A0
I found out two ways how to do it (without deeper knowledge):
1) posix like functions socket | open | ioctl | ... and ldflag "-Wl,@/usr/x=
enomai/lib/cobalt.wrappers".
2) explicit __RT(socket | open | ioctl | ....) function calls.
=C2=A0
What is the proper way to port rt_dev_... functions?
=C2=A0
Petr C.

