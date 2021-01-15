From: Lange Norbert <norbert.lange@andritz.com>
Subject: FW: is memory locking per core necessary?
Date: Fri, 15 Jan 2021 12:15:57 +0000
Message-ID: <DB8PR05MB59154131C6E24BBBD60FB152F6A70@DB8PR05MB5915.eurprd05.prod.outlook.com>
References: <DB8PR05MB59158B5B0C6DB849A7E75705F6A70@DB8PR05MB5915.eurprd05.prod.outlook.com>
In-Reply-To: <DB8PR05MB59158B5B0C6DB849A7E75705F6A70@DB8PR05MB5915.eurprd05.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

I originally had the Xenomai thread tied to another CPU-Core, hence the sub=
ject.
The issue happens also if all threads are tied to Core #0.

So the question should read: is memory locking per *thread* necessary?

> -----Original Message-----
> From: Lange Norbert
> Sent: Freitag, 15. J=E4nner 2021 13:14
> To: Xenomai (xenomai@xenomai.org) <xenomai@xenomai.org>
> Subject: is memory locking per core necessary?
>
> Hello,
>
> I am trying to track down some spurios relaxes.
>
> What happens is that I:
> -   cobalt_init calls  mlockall(MCL_CURRENT | MCL_FUTURE);
> -   allocate and initialize some data in the heap area
> -   spawn the xenomai-thread
> -   wait for notification from the xenomai-thread (so that I know, any
> initialization there is done)
> -   call mlockall(MCL_CURRENT | MCL_FUTURE) once more
> -   notify the xenomai-thread (only now the real work starts)
>
> Then the Xenomai thread will have spurios relaxes when writing data in th=
e heap
> or bss (reads seem to be fine).
> I am a bit confused why this happens, adding a mlockall(MCL_CURRENT |
> MCL_FUTURE) in the Xenomai thread fixes the issue.
> Note that  the locking should happen even before spawning the threads.
>
> Message I get is:
> Jan 15 12:05:19 buildroot kernel: [Xenomai] switching realtime_packet to
> secondary mode after exception #14 from user-space at 0x40f3ed (pid 1383)
> Code is always a store to heap or bss.
>
> X86_64 + 4.19.152-cip37-xeno15-static + glibc 2.28
>
> /proc/pid/maps:
> 00429000-00435000 rw-p 00000000 00:00 0
> 014b5000-014f8000 rw-p 00000000 00:00 0                                  =
[heap]
>
> /proc/pid/smaps:
> 00429000-00435000 rw-p 00000000 00:00 0
> Size:                 48 kB
> KernelPageSize:        4 kB
> MMUPageSize:           4 kB
> Rss:                  48 kB
> Pss:                  48 kB
> Shared_Clean:          0 kB
> Shared_Dirty:          0 kB
> Private_Clean:         0 kB
> Private_Dirty:        48 kB
> Referenced:           48 kB
> Anonymous:            48 kB
> LazyFree:              0 kB
> AnonHugePages:         0 kB
> ShmemPmdMapped:        0 kB
> Shared_Hugetlb:        0 kB
> Private_Hugetlb:       0 kB
> Swap:                  0 kB
> SwapPss:               0 kB
> Locked:               48 kB
> THPeligible:    0
> VmFlags: rd wr mr mw me lo ac
> 014b5000-014f8000 rw-p 00000000 00:00 0                                  =
[heap]
> Size:                268 kB
> KernelPageSize:        4 kB
> MMUPageSize:           4 kB
> Rss:                 268 kB
> Pss:                 268 kB
> Shared_Clean:          0 kB
> Shared_Dirty:          0 kB
> Private_Clean:         0 kB
> Private_Dirty:       268 kB
> Referenced:          268 kB
> Anonymous:           268 kB
> LazyFree:              0 kB
> AnonHugePages:         0 kB
> ShmemPmdMapped:        0 kB
> Shared_Hugetlb:        0 kB
> Private_Hugetlb:       0 kB
> Swap:                  0 kB
> SwapPss:               0 kB
> Locked:              268 kB
> THPeligible:    0
> VmFlags: rd wr mr mw me lo ac
>
> Mit besten Gr=FC=DFen / Kind regards
>
> NORBERT LANGE

________________________________

This message and any attachments are solely for the use of the intended rec=
ipients. They may contain privileged and/or confidential information or oth=
er information protected from disclosure. If you are not an intended recipi=
ent, you are hereby notified that you received this email in error and that=
 any review, dissemination, distribution or copying of this email and any a=
ttachment is strictly prohibited. If you have received this email in error,=
 please contact the sender and delete the message and any attachment from y=
our system.

ANDRITZ HYDRO GmbH


Rechtsform/ Legal form: Gesellschaft mit beschr=E4nkter Haftung / Corporati=
on

Firmensitz/ Registered seat: Wien

Firmenbuchgericht/ Court of registry: Handelsgericht Wien

Firmenbuchnummer/ Company registration: FN 61833 g

DVR: 0605077

UID-Nr.: ATU14756806


Thank You
________________________________

