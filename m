From: Stephan Zimmermann <s.zimmermann@domain.hid>
Date: Thu, 2 Nov 2006 14:53:54 +0100
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200611021453.54463.s.zimmermann@domain.hid>
Subject: [Xenomai-help] Xenomai Simulator
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

Hi, I am actually trying to set up the Simulator, which turns out to be not so 
easy...

What I did:
I installed Xenomai 2.2.4 (kernel patches) with Kernel 2.6.17.14, on Debian 
3.1 using it's standard compiler gcc-3.3. Then I downgraded the compiler (I 
need to, if I want c++ to work with the simulator, right?)  to version 2.95 
and compiled and installed xenomai and xenosim, which seems to 
be ok.

Now I wanted to try out the Simulation on a very minimal project using the 
native skin. (I posted the source some days ago because of another problem)

What I got:
Calling 
	"gcc -I/usr/xenomai/include -g -c main.cpp " 
works without any problem, a following call 
	"gcc -o test main.o -lnative -L/usr/xenomai/lib"
works also with no problem.

But calling 
	"gcic -I/usr/xenomai/include -g -c main.cpp " 
leads to :

In file included from /usr/xenomai/include/nucleus/thread.h:23,
                 from /usr/xenomai/include/native/task.h:26,
                 from main.c:5:
/usr/xenomai/include/nucleus/timer.h: In function `xntlist_insert':
/usr/xenomai/include/nucleus/timer.h:80: syntax error before `xntlholder_t'
/usr/xenomai/include/nucleus/timer.h:80: syntax error before `->'
/usr/xenomai/include/nucleus/timer.h: At top level:
/usr/xenomai/include/nucleus/timer.h:144: syntax error before 
`XNARCH_DECL_DISPLAY_CONTEXT'
/usr/xenomai/include/nucleus/timer.h:144: warning: no semicolon at end of 
struct or union
--- snip ---

I really have no idea what to do, to fix this.

Thanks for any hint, 
greetings, Stephan

