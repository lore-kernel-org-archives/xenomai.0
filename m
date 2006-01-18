From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17358.3884.837199.868705@domain.hid>
Date: Wed, 18 Jan 2006 10:49:32 +0100
Subject: Re: [Xenomai-help] Debugging
In-Reply-To: <20060117142831.M15311@domain.hid>
References: <20060117142831.M15311@domain.hid>
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

Kent Borg wrote:
 > It occurs to me I have been lax in my understanding of how debugging
 > works with Xenamai.
 > 
 >  - What happens if I just use gdb and pretend I am debugging a regular
 >    program?  (Seems scary, but it seems to work at least somewhat for
 >    me.)

It should work. Or at least is it the intention.


 >  - What is UVM for?  Sounds interesting, but the "make xconfig" help
 >    for it says it is for legacy RTOS APIs and I am mostly doing native
 >    calls.  What is the difference?

To know more about UVMs, have a look at:
http://download.gna.org/xenomai/documentation/branches/v2.0.x/pdf/Introduction-to-UVMs.pdf


 > 
 >  - How about MVM?  It sounds interesting too.  Do I just configure it
 >    in and grab it on with gdb??

The MVM is a discrete event simulator, working hand in hand with an
instrumenting compiler and a "real-time aware" graphical frontend for
gdb. In order to use it, you first have to configure and install it.

You will have to compile your applications for this simulation
environment using "gcic" the instrumenting compiler, and run them
through "xenoscope", the gdb graphical frontend.

For examples of programs using the native skin, which can be compiled
for MVM, see the directory:
skins/native/demos

For the MVM full documentation, see:
sim/doc/mvm-manual.txt

-- 


					    Gilles Chanteperdrix.

