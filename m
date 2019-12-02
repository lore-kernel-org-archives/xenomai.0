From: smpd support <symphonic.mpd@gmail.com>
Subject: Re: arm64 support
Date: Mon, 2 Dec 2019 12:29:38 +0000
Message-ID: <DM5PR15MB11630EF73A861E9528FA74FFF0430@DM5PR15MB1163.namprd15.prod.outlook.com>
References: <DM5PR15MB11635BC3912646333637C66FF0430@DM5PR15MB1163.namprd15.prod.outlook.com>,
 <9c64de1d-dacd-3d1e-674e-0e5b93d55ab3@siemens.com>
In-Reply-To: <9c64de1d-dacd-3d1e-674e-0e5b93d55ab3@siemens.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Thank you for your reply.

  *   Linux 4.19.81 (Raspberry pi github repos)
  *   ipipe-core-4.19.55-arm64-4.patch
  *   Xenomai-3.1-rc3

When I build with arm64 and run it on a Raspberry Pi 3,
mmap fails when I run userland tools.
(The situation is the same for all tools such as corectl.)

I think it's a matter of kernel configuration,
so I'm going to do trial and error.
If you have any advice, please let me know.

```
root [ /opt/xenomai/sbin ]# ./corectl
   0"000.000| BUG in cobalt_check_features(): [main] failed mmap(/dev/mem):=
 Operation not permitted
```

Excerpt the log at startup.
```
root [ ~ ]# dmesg |grep pipe
[ 0.000346] Interrupt pipeline (release #4)
[ 0.414059] I-pipe: head domain Xenomai registered.

root [ ~ ]# dmesg |grep Xeno
[ 0.413758] [Xenomai] scheduling class idle registered.
[ 0.413807] [Xenomai] scheduling class rt registered.
[ 0.414059] I-pipe: head domain Xenomai registered.
[ 0.418702] [Xenomai] Cobalt v3.1-rc3
```

---

For comparison, here is a log from Linux 4.14. 52 (arm) on Raspberry Pi 3.

pi@smpd:~ $ dmesg |grep pipe
[ 0.000000] I-pipe, 19.200 MHz clocksource, wrap in 960767920505705 ms
[ 0.000000] clocksource: ipipe_tsc: mask: 0xffffffffffffffff max_cycles: 0x=
46d987e47, max_idle_ns: 440795202767 ns
[ 0.000316] Interrupt pipeline (release #4)
[ 0.390886] clocksource: Switched to clocksource ipipe_tsc
[ 0.406179] I-pipe: head domain Xenomai registered.

pi@smpd:~ $ dmesg |grep Xeno
[ 0.406084] [Xenomai] scheduling class idle registered.
[ 0.406087] [Xenomai] scheduling class rt registered.
[ 0.406179] I-pipe: head domain Xenomai registered.
[ 0.407629] [Xenomai] Cobalt v3.0.7 (Lingering Dawn)

K.Yoshioka

________________________________
=1B$B:9=3DP?M=1B(B: Jan Kiszka <jan.kiszka@siemens.com>
=1B$BAw?.F|;~=1B(B: =1B$B7nMKF|=1B(B, 12=1B$B7n=1B(B 2, 2019 8:46 =1B$B8a8e=
=1B(B
=1B$B08@h=1B(B: smpd support; xenomai@xenomai.org
=1B$B7oL>=1B(B: Re: arm64 support

Try 3.1-rc3 (or the master branch directly). 4.19-based I-pipe is
strongly recommended. See also [1] for a working arm64 setup, on a hikey
though.

Jan

[1] https://gitlab.denx.de/Xenomai/xenomai-images
