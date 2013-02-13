MIME-Version: 1.0
Date: Wed, 13 Feb 2013 09:26:47 -0500
Message-ID: <CAA+HEuk86rVdKy1DDWmzRGjpvNkDpVsAmG+H-R4mg1Bu2RLy+A@mail.gmail.com>
From: Kris Ellis <drfrankencopter@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Segfault error 4 when running latency test (and all
	userspace tests)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi All,



I=92m using buildroot to build and configure Xenomai 2.6.1 on Linux 3.2.21
for an Intel Atom based single board computer.



I=92ve managed to get the kernel to compile with the Xenomai patch. That mu=
ch
seems to run correctly. The kernel boots and if I open a shell and type
=93dmesg  | grep Xenomai=94 I get:

I-pipe: head domain Xenomai registered.

Xenomai: hal/i386 started.

Xenomai: scheduling class idle registered.

Xenomai: scheduling class rt registered.

Xenomai: real-time nucleus v2.6.1 (Light Years Away) loaded.

Xenomai: debug mode enabled.

Xenomai: starting native API services.

Xenomai: starting POSIX services.

Xenomai: starting RTDM services.



So far so good, but when I try to run the latency test I get:

segfault at 0 ip  (null) sp bfd30cfc error 4 in latency

Segmentation fault



Something is not right with my user-space build, but I=92m sort of at a los=
s
since buildroot did both the kernel build and the user-space build. Any
guidance that can be offered would be greatly appreciated.



Thanks
