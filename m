Date: Thu, 2 Feb 2017 10:49:23 +0000 (UTC)
From: <thierry.xenomai43@yahoo.com>
Message-ID: <196556191.1727904.1486032563084@mail.yahoo.com>
MIME-Version: 1.0
References: <196556191.1727904.1486032563084.ref@mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] =?utf-8?q?=5BBUILDROOT=5D_Xeno-test_don=E2=80=99t_work_?=
 =?utf-8?q?=3A_Xenomai=3A_/dev/rtheap_is_missing?=
Reply-To: thierry.xenomai43@yahoo.com
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

=C2=A0 Hello,
I build Embeded linux for Paspberry Pi 3 with Buildroot-2016.11.2 suite. I =
tested Linux part and all is ok.Now I would like to use Xenomai 2.6.4 in my=
 project.
In menuconfig, on "package>Real-Time" , I selected :   =20
  =20
   - Xenomai Userspace;
  =20
   - Install testsuite
  =20
   - Native skin lib
  =20
   - POSIX lib

  =20
I not used patch during the build.
When I want use =E2=80=98xeno-test" on my target, I have this echo :" Start=
ed child 152: /bin sh /usr/bin/xeno-test-run-wrapper /usr/bin/xeno-test /us=
rbin/xeno-test-run-wrapper: /usr/bin/xeno-test: line 43: can=E2=80=99t crea=
t /proc/xenomai/latency: nonexistent directory+ echo 0+ :+ /usr/bin/arithXe=
nomai: /dev/rtheap is missing(chardev, major=3D10 minor=3D254)"I see on web=
 that I need to use I-pipe patch. Where can I found this patch for Raspbery=
3, and Xenomai 2.6.4 ?
Best regards,Thierry.
