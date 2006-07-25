Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Xenomai task (beginner)
Date: Tue, 25 Jul 2006 18:06:47 +0200
Message-ID: <1299EF3181B10F479D85C3280132852422DABC@THEZE.intra.cea.fr>
In-Reply-To: <44C5B7B5.3080505@domain.hid>
From: "GUARDIOLA-FALCO Sebastien 204282" <Sebastien.GUARDIOLA-FALCO@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello,

I'm waiting for Xenomai to be included in the ElinOS Linux package, so I =
can't try it before next week.=20
My question is simple : how to port a linux program to Xenomai so this =
program is recognized as a Xenomai task? (and has low latencies?). Is it =
done when launching the program? like "prio 255 myprogram" in LynxOS? or =
are there lines of code to include?
My linux task doesn't have any system call, except mmap(). Next I'm =
using the pointer I get from mmap() and that's it.

Thanks a lot,
S=E9bastien.


