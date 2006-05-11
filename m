From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17507.30574.767081.244257@domain.hid>
Date: Thu, 11 May 2006 19:42:06 +0200
Subject: Re: [Xenomai-core] Errors running sim testsuite for vxWorks
In-Reply-To: <17507.27519.455277.534105@domain.hid>
References: <200605111823.51650.niklaus.giger@domain.hid>
	<17507.27519.455277.534105@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid, xenomai@xenomai.org

Gilles Chanteperdrix wrote:
 > Niklaus Giger wrote:
 >  > Hi
 >  > 
 >  > Running the sim testsuite vxworks (revision 1078) (using the attached script) 
 >  > I get the following a few failures and memory corruption:
 >  > 
 >  > trestart.c:46, taskSpawn("nop", 19, 0, 32768, nopTask, 0,0,0,0,0,0,0,0,0,0) != 
 >  > ERROR
 >  > *** glibc detected *** malloc(): memory corruption: 0x100bf000 ***
 >  > 
 >  > t010726-1.log:t010726-1.c:106, test finished: 4 failures/ 15 tests
 >  > t010726-2.log:t010726-2.c:224, test finished: 0 failures/ 82 tests
 >  > t010728.log:t010728.c:119, test finished: 0 failures/ 4 tests
 >  > t010820-1.log:t010820-1.c:90, test finished: 0 failures/ 23 tests
 >  > t010820-2.log:t010820-2.c:81, test finished: 0 failures/ 11 tests
 >  > t010823-1.log:t010823-1.c:114, test finished: 0 failures/ 16 tests
 >  > t010823-2.log:t010823-2.c:166, test finished: 1 failures/ 33 tests
 >  > 
 >  > Is this normal or a powerpc specific error of the Xenomai simulator?
 > 
 > The tests run here without any failure, however the round-robin test
 > relies on a precise number of "virtual cycles" which is probably
 > architecture dependent.

Ok, I get the errors too.

Counts of "virtual cycles" depend on the count of lines in the source
program, so are architecture independent. But they have been divided by
ten, because vxworks tick rate is now 1000 whereas it used to be 100.

-- 


					    Gilles Chanteperdrix.

