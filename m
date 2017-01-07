Date: Sat, 7 Jan 2017 00:17:14 +0000 (UTC)
From: Giulio Moro <giuliomoro@yahoo.it>
Message-ID: <1922489700.2220688.1483748234061@mail.yahoo.com>
In-Reply-To: <CAA7GYCTc7t-z4zTu-awtg96nJ70O92QfAtQaj6JNUPaGbDxZFg@mail.gmail.com>
References: <CAA7GYCTc7t-z4zTu-awtg96nJ70O92QfAtQaj6JNUPaGbDxZFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Xenomai 3 with kernel 4.1 for Beaglebone (with GPIO
 and	PWM drivers)
Reply-To: Giulio Moro <giuliomoro@yahoo.it>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?=C3=98yvind_Netland?= <oyvind@netland.name>, "xenomai@xenomai.org" <xenomai@xenomai.org>

If it can help, a 4.4.y kernel for BeagleBone by RobertCNelson with Xenomai=
 3.0.3 is here=C2=A0https://github.com/RobertCNelson/ti-linux-kernel-dev/tr=
ee/ti-linux-xenomai-4.4.y



=20
      From: =C3=98yvind Netland <oyvind@netland.name>
 To: xenomai@xenomai.org=20
 Sent: Friday, 6 January 2017, 20:01
 Subject: [Xenomai] Xenomai 3 with kernel 4.1 for Beaglebone (with GPIO and=
 PWM drivers)
  =20
Hi

I have seen several implementations of xenomai 2.x for Beaglebone, but not
Xenomai 3. It was actually not that difficult if you just started with the
correct commit of RobertCNelsons bb-kernel on github, and I assume that
somebody have done it before.

However, I thought it would be worth while to make this as easy as
possible, thus I have made a fork of RobertCNelson on my github with a new
"am33x-v4.1-xenomai" branch.

To build, just do
git clone https://github.com/oyvindnetland/bb-kernel.git
cd bb-kernel
git checkout am33x-v4.1-xenomai
./build_kernel.sh or ./build_deb.sh

As I am using the GPIO and PWM of the Beaglebone, I have also included RTDM
drivers for this, just enable them in the kernel menuconfig
(Xenomai/Cobalt->Drivers->Beaglebone RTDM I/O). It will make one entry in
/dev/rtdm for each GPIO and PWM. All GPIO available by default is enabled,
and all 6 PWM (device tree rules are done automatically)

I have made a simple library also available on my github (
https://github.com/oyvindnetland/librtbbio) that allow easy use of the RTDM
drivers. It includes a simple test, but this is not complete yet.

I have plans to expand with other RTDM drivers, e.g. UART, but have
currently no timeframe on this, if anybody want to help with this, let me
know.

Let me know if you test this and have any issues or comments!

Best regards
=C3=98yvind Netland
_______________________________________________
Xenomai mailing list
Xenomai@xenomai.org
https://xenomai.org/mailman/listinfo/xenomai


  =20
=20
