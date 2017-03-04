From: Nitin Kulkarni <nitink@kth.se>
Date: Sat, 4 Mar 2017 04:30:46 +0000
Message-ID: <1488601846543.4195@kth.se>
References: <1488597983336.36220@kth.se>
In-Reply-To: <1488597983336.36220@kth.se>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Latency test fails after in a Xenomai patched Ostro XT
 linux distro - part 2
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

After the below things happened I added a regular user (nitin) to the allow=
ed_group parameter file in /sys/module/xenomai/parameters/allowed_group


Then executed the latency test to get this message :


nitin@intel-corei7-64:/usr/bin$ /usr/xenomai/bin/latency
   0"000.000| WARNING: [main] cannot open RTDM device /dev/rtdm/memdev-priv=
ate: Permission denied
   0"000.000| WARNING: [main] cannot map private umm area: Permission denie=
d
   0"000.000| BUG in init_bind(): [main] (CONFIG_DEVTMPFS_MOUNT not enabled=
?)

?I must be doing something wrong. Please let me know.

- Nitin


________________________________
From: Nitin Kulkarni
Sent: Saturday, March 4, 2017 4:26 AM
To: xenomai@xenomai.org
Subject: Latency test fails after in a Xenomai patched Ostro XT linux distr=
o


Hi,

I have patched the Xenomai 3.0.3 to an Ostro XT linux distribution and afte=
r flashing the image and booting on the Intel Joule board I installed the X=
enomai libraries natively. When I run the Latency test it gives this messag=
e and stops.


root@intel-corei7-64:~/Xenlib# /usr/xenomai/bin/latency
=3D=3D Sampling period: 100 us
=3D=3D Test mode: periodic user-mode task
=3D=3D All results in microseconds
/usr/xenomai/bin/latency: pthread_create(latency): Operation not permitted

Although I am running as a root user it gives this error. I have not added =
any user group through the Kernel command line parameter xenomai.allowed_gr=
oup?.
when I run the command

dmesg | grep -i xenomai


I get this from the Kernel log
[    0.000000] Command line: rootwait console=3Dtty0 xenomai.sysheap_size=
=3D256 xenomai.state=3Denabled xenomai.smi=3Ddetect xenomai.smi_mask=3D1 co=
nsole=3DttyS2,115200 video=3Defifb maxcpus=3D4 noxsave reboot=3Defi kmemlea=
k=3Doff fsck.mode=3Dskip no-ima ro root=3DPARTUUID=3D12345678-9abc-def0-0fe=
d-cba987654321 rootfstype=3Dext4 installer
[    0.000000] Kernel command line: rootwait console=3Dtty0 xenomai.sysheap=
_size=3D256 xenomai.state=3Denabled xenomai.smi=3Ddetect xenomai.smi_mask=
=3D1 console=3DttyS2,115200 video=3Defifb maxcpus=3D4 noxsave reboot=3Defi =
kmemleak=3Doff fsck.mode=3Dskip no-ima ro root=3DPARTUUID=3D12345678-9abc-d=
ef0-0fed-cba987654321 rootfstype=3Dext4 installer
[    0.668993] [Xenomai] scheduling class idle registered.
[    0.669456] [Xenomai] scheduling class rt registered.
[    0.670016] I-pipe: head domain Xenomai registered.
[    0.672804] [Xenomai] Cobalt v3.0.3 (Groovy Cosmic Halo)

?
Please let me know how to handle this issue.

Regards,
Nitin








