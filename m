Date: Wed, 21 Mar 2018 09:46:48 +0200 (EET)
From: =?windows-1251?B?2OXi9+Xt6u4g0uDw4PEgw/Do4+7w/OXi6Pc=?=
 <shevchenko.taras@triolcorp.com.ua>
Message-ID: <2112615978.6228360.1521618408408.JavaMail.zimbra@triolcorp.com.ua>
In-Reply-To: <03b3c307-07bd-58d1-d555-19449186fca6@xenomai.org>
References: <6aedc4bc-74b5-4a9f-5c38-036a3d7850b9@siemens.com>
 <ee7647d4-0bfd-0933-2f10-e9fdc5da2880@web.de>
 <03b3c307-07bd-58d1-d555-19449186fca6@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] 4.9 for x86  sd card ,
	gpio interrupt  guide to system no responce
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>


Hi all,
I finished some experiments to figure out what is going on
so  again
I have udoo board x86 ultra

1) Use ubuntu with vanile kernel 4.10.0-28 or 4.13.0-37 or 4.9.51   no prob=
lem with sd card , all work perfectly
2) Use 4.9.51 with ipipe patch   -pipe-core -4.9.51-x86-4.patch  guide to s=
ystem no responce
 when i insert sd-card or insert own rtdm module for gpio test  and gpio in=
terrupt occured
3) I use xenomai from git branch  stable-3.0.y (download yesterday)
4) there is options from menuconfig that I enable/disable

* General setup
  --> Local version - append to kernel release: -xenomai-3.0.5
  --> Timers subsystem
      --> High Resolution Timer Support (Enable)
* Xenomai/cobalt
  --> Sizes and static limits
    --> Number of registry slots (512 --> 4096)
    --> Size of system heap (Kb) (512 --> 4096)
    --> Size of private heap (Kb) (64 --> 256)
    --> Size of shared heap (Kb) (64 --> 256)
    --> Maximum number of POSIX timers per process (128 --> 512)
  --> Drivers
    --> RTnet
        --> RTnet, TCP/IP socket interface (Enable)
            --> Drivers
                --> New intel(R) PRO/1000 PCIe (Enable)
                --> Realtek 8169 (Enable)
                --> Loopback (Enable)
        --> Add-Ons
            --> Real-Time Capturing Support (Enable)
* Power management and ACPI options
  --> CPU Frequency scaling
      --> CPU Frequency scaling (Disable)
  --> ACPI (Advanced Configuration and Power Interface) Support
      --> Processor (Disable)
  --> CPU Idle
      --> CPU idle PM support (Disable)
* Pocessor type and features
  --> Enable maximum number of SMP processors and NUMA nodes (Disable)
  --> Processor family
      --> Core 2/newer Xeon (if "cat /proc/cpuinfo | grep family" returns 6=
, set as Generic otherwise)
  --> Transparent Hugepage Support (Disable)
  --> Allow for memory compaction (Disable)
  --> Contiguous Memory Allocation (Disable)
  --> Allow for memory compaction
    --> Page Migration (Disable)
* Device Drivers
  --> Staging drivers
      --> Unisys SPAR driver support
         --> Unisys visorbus driver (Disable)

I consider, that something wrong with this options
Help please to start work with xenomai


=D1 =F3=E2=E0=E6=E5=ED=E8=E5=EC =E8 =ED=E0=E4=E5=E6=E4=EE=E9 =ED=E0 =F1=EE=
=F2=F0=F3=E4=ED=E8=F7=E5=F1=F2=E2=EE,
=D8=E5=E2=F7=E5=ED=EA=EE =D2.=C3.

----- Original Message -----
From: "Philippe Gerum" <rpm@xenomai.org>
To: "Jan Kiszka" <jan.kiszka@web.de>
Cc: "xenomai" <xenomai@xenomai.org>
Sent: Tuesday, March 20, 2018 5:05:07 PM
Subject: Re: [Xenomai] 4.9 for x86 issue

On 03/10/2018 11:06 PM, Jan Kiszka wrote:
> On 2018-03-09 08:51, Jan Kiszka wrote:
>> 4.9 requires more work, I've pushed the beginning to wip/4.9 in the same
>> repo.
>=20
> I started to patch further on this during my flight (wip/4.9 updated),
> noticed that the 4.14-wip queue will need a little bit sysentry tweaking
> as well (missing 64-bit syscall dispatching), and then had to find 4.9
> in a rather unfortunate state /wrt x86-64: CPUs are no longer idling
> properly. I went back to ipipe-core-4.9.24-x86-2, without a difference.
>=20
> If you should look into 4.9-x86 as you indicated, please check this.
>=20
> Another catch along that road: maxcpus=3D1 with >1 CPUs available trigger=
s
> a NULL pointer when Xenomai gets armed. That is the case with 4.4 as well=
.
>=20

Can't reproduce this one (over kvm), 4.4 and 4.9 included, so this may
be depending on the Kconfig.

--=20
Philippe.

_______________________________________________
Xenomai mailing list
Xenomai@xenomai.org
https://xenomai.org/mailman/listinfo/xenomai

