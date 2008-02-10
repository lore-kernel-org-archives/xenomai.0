MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18351.10273.348068.591595@domain.hid>
Date: Sun, 10 Feb 2008 17:36:49 +0100
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D376ACD@slcmail.slc.mew.int>
References: <51CAD0CE1504444DBE77CBBE51A0135D376AB6@domain.hid>
	<18349.43717.622653.136257@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D376ACD@slcmail.slc.mew.int>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] fpu issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>
Cc: xenomai@xenomai.org

Steven Seeger wrote:
 >  > An idea is to disassemble the kernel task code and the function it
 > calls
 > > to see if FPU is really never used.
 > > 
 > > If this task really never calls any function using FPU, it would be
 > nice
 > > if you could (as we always ask, you may have noticed) reduce your test
 > > case to a simple code where only FPU operations and every thing which
 > > causes task switches (blocking calls, and calls waking up other tasks)
 > > is kept.
 > 
 > My application has 12 threads most of which wait on queues. How am I
 > going to reduce this to a simple case? Most of my threads are userspace
 > except for 2. 
 > 
 > I guess I'll see what I can do. I'll try the disassembler, too.

It was a bad idea: if ever your task had used FPU without the FPU bit,
Xenomai would have suspended this task, with a warning on the console.

-- 


					    Gilles Chanteperdrix.

