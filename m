MIME-Version: 1.0
References: <CAEmXcAzOL4M-JRUWgm3mjmz+bQ=nHc-QW5dr-iBc24RXXu5CTg@mail.gmail.com>
 <320b1c56-047f-764f-036a-d3302ddbd0f4@siemens.com>
 <CAEmXcAxuFzE2uQHGMUjBnbgadTTcNU_DwV64uvLPahxxDMKTyQ@mail.gmail.com>
 <be5b28d1-e689-5c60-4d20-2be511ec489a@siemens.com>
 <CAEmXcAxs3O_Hmph-48JArHgCmWSj+wAiffkNCZKiL9uVew6irg@mail.gmail.com>
 <22b6931e-8f7b-0cae-2316-5b278d1186d6@siemens.com>
 <CAEmXcAzzSfT5jVQpM2CidLh-CCJRPt45jJMRq_mmXz0wHFnyXQ@mail.gmail.com>
 <34f86f81-70f4-9b07-26e7-3525bfaf6fcf@siemens.com>
 <CAEmXcAz6p9yg65uigQx6zJyey1nnkmdq8+i1Ou2bT888n-thrg@mail.gmail.com>
 <309d004d-23de-a4a5-7536-4c08e463c556@siemens.com>
 <CAEmXcAzn2jagk3CkTk=5zhuWu4tPWC9hUSSpsCOzmG=Gu4rn4Q@mail.gmail.com>
 <0cd6d298-cee7-2799-4b61-2b868d742128@siemens.com>
 <CAEmXcAyuDquTNG3ZWtXGf+9oYArgT8PnRDgS_RzD_ZoWNxZ79w@mail.gmail.com>
 <671d8c8c-ea95-3189-c82c-cb70da0168be@siemens.com>
In-Reply-To: <671d8c8c-ea95-3189-c82c-cb70da0168be@siemens.com>
From: danwe <daniel.wenninger92@gmail.com>
Date: Wed, 12 Jun 2019 08:48:47 +0200
Message-ID: <CAEmXcAyZX6XRqk0acx26Cv6ejWBfyDhgU2qrSCGi3-CqCktO_A@mail.gmail.com>
Subject: Re: Fwd: Round-Trip Time Requester with Xenomai / RTnet on Beaglebone
 Black
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

I have checked ifconifg -a and rtifconfig -a. For my "rtt-sender" do I have
to use my IP address 192.168.127.11 or my internet address 127.0.0.1?
Output:
# rtifconfig -a
rteth0    Medium: Ethernet  Hardware address: 86:98:B3:8B:88:B4
          IP address: 192.168.127.11  Broadcast address: 192.168.127.255
          UP BROADCAST RUNNING  MTU: 1500
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

# ifconfig -a
lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

Am Fr., 7. Juni 2019 um 13:48 Uhr schrieb Jan Kiszka <jan.kiszka@siemens.com
>:

> On 07.06.19 12:22, danwe wrote:
> > Raw-ethernet rteth0 does work. See the output:
> >
> > # /usr/examples/xenomai/posix/raw-ethernet eth0
> > cannot get interface index: No such device
> > # /usr/examples/xenomai/posix/raw-ethernet rteth0
> > Sent frame of 1514 bytes
> > Sent frame of 1514 bytes
> > Sent frame of 1514 bytes
> > Sent frame of 1514 bytes
> > shutting down
> >
> > So should I compare the invoked gcc command line with the output of
> "xeno-config
> > --skin=posix --ldflags"? Can that be possible if "raw-ethernet" is
> working?
>
> It doesn't make sense yet, I agree - unless there is RTmac with its vnic
> also
> loaded so that you have rteth0 on the Linux side as well (check ifconfig
> -a).
>
> Jan
>
> >
> > Daniel
> >
> > Am Fr., 7. Juni 2019 um 12:15 Uhr schrieb Jan Kiszka <
> jan.kiszka@siemens.com
> > <mailto:jan.kiszka@siemens.com>>:
> >
> >     On 07.06.19 11:40, danwe wrote:
> >      > I have checked what the generated binary is using.
> >      > E.g. it is using lines like:
> >      >
> >      > 19: 00008bc8   0 FUNC   GLOBAL DEFAULT UND ioct1@GLIBC_2.4 (3)
> >      > 45: 00008cc4   0 FUNC   GLOBAL DEFAULT UND socket@GLIBC_2.4 (3)
> >      >
> >      > Does that mean that it is using the non-rt glibc services? If so
> then I
> >     do not
> >      > understand one thing: the file "raw-ethernet" is a example where
> it uses the
> >      > same ioct1@GLIBC and socket@GLIBC but it does not throw the
> "network is
> >      > unreachable error".
> >      > But how can I change that it is using the __wrap_socket?
> >
> >     Compare the invoked gcc command line with the output of "xeno-config
> >     --skin=posix --ldflags". Something is preventing the the required
> flags make it
> >     into your build. Also try building manually, to exclude flaws in
> your buildroot
> >     environment.
> >
> >     Does "raw-ethernet rteth0" actually work? Or are you calling
> "raw-ethernet
> >     eth0"
> >     by accident?
> >
> >     Jan
> >
> >     --
> >     Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> >     Corporate Competence Center Embedded Linux
> >
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
>
