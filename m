From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17606.21420.165431.429261@domain.hid>
Date: Tue, 25 Jul 2006 19:23:56 +0200
Subject: Re: [Xenomai-help] Xenomai task (beginner)
In-Reply-To: <1299EF3181B10F479D85C3280132852422DABC@THEZE.intra.cea.fr>
References: <44C5B7B5.3080505@domain.hid>
	<1299EF3181B10F479D85C3280132852422DABC@THEZE.intra.cea.fr>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: GUARDIOLA-FALCO Sebastien 204282 <Sebastien.GUARDIOLA-FALCO@domain.hid>
Cc: xenomai@xenomai.org

GUARDIOLA-FALCO Sebastien 204282 wrote:
 > Hello,
 > 
 > I'm waiting for Xenomai to be included in the ElinOS Linux package, so I can't try it before next week. 
 > My question is simple : how to port a linux program to Xenomai so this program is recognized as a Xenomai task? (and has low latencies?). Is it done when launching the program? like "prio 255 myprogram" in LynxOS? or are there lines of code to include?
 > My linux task doesn't have any system call, except mmap(). Next I'm using the pointer I get from mmap() and that's it.
 > 

If you are talking about latencies, then your task has to suspend,
waiting for some event using some other system call than mmap. I assume
here that you are using the POSIX interface for that purpose. 

To have a Linux program "recognized" by Xenomai, you have to compile it
with special compilation flags, provided by the xeno-config script. The
advantage of this approach is that the regular Linux services remain
accessible by prefixing their names with the __real_ prefix. For example
Linux regular mmap remain accessible but is called __real_mmap.

If your program is called hello.c, you would compile it for Xenomai
POSIX skin by calling:

gcc -o hello.o  -c hello.c `xeno-config --posix-cflags`

gcc -o hello hello.o `xeno-config --posix-ldflags`

-- 


					    Gilles Chanteperdrix.

