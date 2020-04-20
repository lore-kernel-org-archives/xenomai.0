MIME-Version: 1.0
References: <DM5PR15MB11635BC3912646333637C66FF0430@DM5PR15MB1163.namprd15.prod.outlook.com>
 <9c64de1d-dacd-3d1e-674e-0e5b93d55ab3@siemens.com>
 <DM5PR15MB11630EF73A861E9528FA74FFF0430@DM5PR15MB1163.namprd15.prod.outlook.com>
In-Reply-To: <DM5PR15MB11630EF73A861E9528FA74FFF0430@DM5PR15MB1163.namprd15.prod.outlook.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Mon, 20 Apr 2020 01:32:19 -0400
Message-ID: <CALLqZ8R2ZZsTPF5==v9OtABXW5q2Ry4Oq5-zTau5uwSe7J9P5g@mail.gmail.com>
Subject: Re: arm64 support
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: smpd support <symphonic.mpd@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,
On Mon, Dec 2, 2019 at 7:30 AM smpd support via Xenomai
<xenomai@xenomai.org> wrote:
>
> Thank you for your reply.
>
>   *   Linux 4.19.81 (Raspberry pi github repos)
>   *   ipipe-core-4.19.55-arm64-4.patch
>   *   Xenomai-3.1-rc3
>
> When I build with arm64 and run it on a Raspberry Pi 3,
> mmap fails when I run userland tools.
> (The situation is the same for all tools such as corectl.)
>
> I think it's a matter of kernel configuration,
> so I'm going to do trial and error.
> If you have any advice, please let me know.
>
> ```
> root [ /opt/xenomai/sbin ]# ./corectl
>    0"000.000| BUG in cobalt_check_features(): [main] failed mmap(/dev/mem=
): Operation not permitted
> ```
>
> Excerpt the log at startup.
> ```
> root [ ~ ]# dmesg |grep pipe
> [ 0.000346] Interrupt pipeline (release #4)
> [ 0.414059] I-pipe: head domain Xenomai registered.
>
> root [ ~ ]# dmesg |grep Xeno
> [ 0.413758] [Xenomai] scheduling class idle registered.
> [ 0.413807] [Xenomai] scheduling class rt registered.
> [ 0.414059] I-pipe: head domain Xenomai registered.
> [ 0.418702] [Xenomai] Cobalt v3.1-rc3
> ```
>
> ---
>
> For comparison, here is a log from Linux 4.14. 52 (arm) on Raspberry Pi 3=
.
>
> pi@smpd:~ $ dmesg |grep pipe
> [ 0.000000] I-pipe, 19.200 MHz clocksource, wrap in 960767920505705 ms
> [ 0.000000] clocksource: ipipe_tsc: mask: 0xffffffffffffffff max_cycles: =
0x46d987e47, max_idle_ns: 440795202767 ns
> [ 0.000316] Interrupt pipeline (release #4)
> [ 0.390886] clocksource: Switched to clocksource ipipe_tsc
> [ 0.406179] I-pipe: head domain Xenomai registered.
>
> pi@smpd:~ $ dmesg |grep Xeno
> [ 0.406084] [Xenomai] scheduling class idle registered.
> [ 0.406087] [Xenomai] scheduling class rt registered.
> [ 0.406179] I-pipe: head domain Xenomai registered.
> [ 0.407629] [Xenomai] Cobalt v3.0.7 (Lingering Dawn)
>
> K.Yoshioka
>
> ________________________________
> =E5=B7=AE=E5=87=BA=E4=BA=BA: Jan Kiszka <jan.kiszka@siemens.com>
> =E9=80=81=E4=BF=A1=E6=97=A5=E6=99=82: =E6=9C=88=E6=9B=9C=E6=97=A5, 12=E6=
=9C=88 2, 2019 8:46 =E5=8D=88=E5=BE=8C
> =E5=AE=9B=E5=85=88: smpd support; xenomai@xenomai.org
> =E4=BB=B6=E5=90=8D: Re: arm64 support
>
> Try 3.1-rc3 (or the master branch directly). 4.19-based I-pipe is
> strongly recommended. See also [1] for a working arm64 setup, on a hikey
> though.
>
> Jan
>
> [1] https://gitlab.denx.de/Xenomai/xenomai-images
I know this thread is very old, but the reason you are seeing this
issue is because your kernel has CONFIG_STRICT_DEVMEM enabled.
Disable this config and it should work.

A new ARM64 ipipe patch should be out this week for 4.19.114 and I've
had good results testing on  the rpi3b

-Greg

