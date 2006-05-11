From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17507.27519.455277.534105@domain.hid>
Date: Thu, 11 May 2006 18:51:11 +0200
Subject: Re: [Xenomai-core] Errors running sim testsuite for vxWorks
In-Reply-To: <200605111823.51650.niklaus.giger@domain.hid>
References: <200605111823.51650.niklaus.giger@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

Niklaus Giger wrote:
 > Hi
 > 
 > Running the sim testsuite vxworks (revision 1078) (using the attached script) 
 > I get the following a few failures and memory corruption:
 > 
 > trestart.c:46, taskSpawn("nop", 19, 0, 32768, nopTask, 0,0,0,0,0,0,0,0,0,0) != 
 > ERROR
 > *** glibc detected *** malloc(): memory corruption: 0x100bf000 ***
 > 
 > t010726-1.log:t010726-1.c:106, test finished: 4 failures/ 15 tests
 > t010726-2.log:t010726-2.c:224, test finished: 0 failures/ 82 tests
 > t010728.log:t010728.c:119, test finished: 0 failures/ 4 tests
 > t010820-1.log:t010820-1.c:90, test finished: 0 failures/ 23 tests
 > t010820-2.log:t010820-2.c:81, test finished: 0 failures/ 11 tests
 > t010823-1.log:t010823-1.c:114, test finished: 0 failures/ 16 tests
 > t010823-2.log:t010823-2.c:166, test finished: 1 failures/ 33 tests
 > 
 > Is this normal or a powerpc specific error of the Xenomai simulator?

The tests run here without any failure, however the round-robin test
relies on a precise number of "virtual cycles" which is probably
architecture dependent.

In order to display the errors, you should grep '^[^ ]*:[0-9]*:' in the
logs.

 > 
 > How do I debug trestart as it is not a fully linked executable?

trestart is a script, the fully linked executable is in the .libs
directory, because of libtool. There is a way to run gdb using the
script arguments, which I do not remember, something like 
--mode=exec gdb


 > Is it normal that a "make check" only works, if one builds the simulator 
 > inside the source code?

Last time I checked it worked when built out-of-tree, but you must build
the simulator in the sim subdirectory of a xenomai build directory.

-- 


					    Gilles Chanteperdrix.

