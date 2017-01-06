MIME-Version: 1.0
From: =?UTF-8?Q?=C3=98yvind_Netland?= <oyvind@netland.name>
Date: Fri, 6 Jan 2017 21:01:25 +0100
Message-ID: <CAA7GYCTc7t-z4zTu-awtg96nJ70O92QfAtQaj6JNUPaGbDxZFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Xenomai 3 with kernel 4.1 for Beaglebone (with GPIO and
	PWM drivers)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

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
