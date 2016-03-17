From: Umair Ali <ali.umair@tut.fi>
Date: Thu, 17 Mar 2016 14:11:30 +0000
Message-ID: <2396B4D2166B62479FBBE370D4A7C1F30A729F5F@mb2010-1.intra.tut.fi>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] Error: Xenomai/cobalt: Watch triggered
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

I have developed a POSIX application. In my application i am reading a file=
 using mmap function. The size of file is 600Mb. When i read the file the f=
ollowing error appears

"Xenomai/Cobalt: Watchdog triggered
CPU time limit exceeded (Core dumped)"

The Kernel messages are as follows

"[513566.035432] [Xenomai] switching raw_udp_sv to secondary mode after exc=
eption #14 from user-space at 0xb75b2f96 (pid 23177)
[513566.035460] raw_udp_sv[23177]: segfault at 0 ip b75b2f96 sp bf8f7618 er=
ror 4 in libc-2.19.so[b7536000+1a8000]
[513692.910072] [Xenomai] watchdog triggered on CPU #0 -- runaway thread 'r=
aw_udp_sv' signaled
[513816.909854] [Xenomai] watchdog triggered on CPU #0 -- runaway thread 'r=
aw_udp_sv' signaled"


I have noticed that if i am reading a different file of the same size then =
no such error appear.
I have some solution on internet about installing libc 6 but i am confused.=
 My quesstion is that what are the possible ways i can use to trace my prob=
lem if such kind of error appears.

Thanks & BR
Ali

