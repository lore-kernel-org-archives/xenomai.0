MIME-Version: 1.0
In-Reply-To: <1922489700.2220688.1483748234061@mail.yahoo.com>
References: <CAA7GYCTc7t-z4zTu-awtg96nJ70O92QfAtQaj6JNUPaGbDxZFg@mail.gmail.com>
 <1922489700.2220688.1483748234061@mail.yahoo.com>
From: =?UTF-8?Q?=C3=98yvind_Netland?= <oyvind@netland.name>
Date: Sat, 7 Jan 2017 10:02:03 +0100
Message-ID: <CAA7GYCS0QpJSpyZ_vohoZu2oG+_0y2sacRDAtjpQSdnOFsRgig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Xenomai 3 with kernel 4.1 for Beaglebone (with GPIO
 and PWM drivers)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <giuliomoro@yahoo.it>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Thanks for that info, for some reason I haven't noticed that... Strange..
Might be because I have mostly used the bb-kernel repository, not looked as
closely at the ti-linux-kernel-dev repository....

Just tested RobertCNelsons 4.4 xenomai kernel and it seems to work fine. So
I guess both solutions works.

A slight difference was that with the 4.1 kernel /proc/xenomai/latency
returned 6041, while 4.4 returned 6499. Dont know if that really is a
practical difference...

However, the GPIO and PWM RTDM drivers are currently only available for the
4.1 version. I will see if I can get those to work on the 4.4 at some
point, but might take some time to get around to that...

I tried to install a xeno_gpio module that came with the 4.4 kernel, but
that did not work (a lot of RTDM related "unknown symbol").

Best Regards
=C3=98yvind Netland




On Sat, Jan 7, 2017 at 1:17 AM, Giulio Moro <giuliomoro@yahoo.it> wrote:

> If it can help, a 4.4.y kernel for BeagleBone by RobertCNelson with
> Xenomai 3.0.3 is here
> https://github.com/RobertCNelson/ti-linux-kernel-
> dev/tree/ti-linux-xenomai-4.4.y
>
>
>
> ------------------------------
> *From:* =C3=98yvind Netland <oyvind@netland.name>
> *To:* xenomai@xenomai.org
> *Sent:* Friday, 6 January 2017, 20:01
> *Subject:* [Xenomai] Xenomai 3 with kernel 4.1 for Beaglebone (with GPIO
> and PWM drivers)
>
> Hi
>
> I have seen several implementations of xenomai 2.x for Beaglebone, but no=
t
> Xenomai 3. It was actually not that difficult if you just started with th=
e
> correct commit of RobertCNelsons bb-kernel on github, and I assume that
> somebody have done it before.
>
> However, I thought it would be worth while to make this as easy as
> possible, thus I have made a fork of RobertCNelson on my github with a ne=
w
> "am33x-v4.1-xenomai" branch.
>
> To build, just do
> git clone https://github.com/oyvindnetland/bb-kernel.git
> cd bb-kernel
> git checkout am33x-v4.1-xenomai
> ./build_kernel.sh or ./build_deb.sh
>
> As I am using the GPIO and PWM of the Beaglebone, I have also included RT=
DM
> drivers for this, just enable them in the kernel menuconfig
> (Xenomai/Cobalt->Drivers->Beaglebone RTDM I/O). It will make one entry in
> /dev/rtdm for each GPIO and PWM. All GPIO available by default is enabled=
,
> and all 6 PWM (device tree rules are done automatically)
>
> I have made a simple library also available on my github (
> https://github.com/oyvindnetland/librtbbio) that allow easy use of the
> RTDM
> drivers. It includes a simple test, but this is not complete yet.
>
> I have plans to expand with other RTDM drivers, e.g. UART, but have
> currently no timeframe on this, if anybody want to help with this, let me
> know.
>
> Let me know if you test this and have any issues or comments!
>
> Best regards
> =C3=98yvind Netland
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai
>
>
>
