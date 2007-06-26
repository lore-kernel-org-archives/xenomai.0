MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18049.25729.508237.602835@domain.hid>
Date: Tue, 26 Jun 2007 21:09:53 +0200
In-Reply-To: <5CBBAC9E1EA66C4E976DDF1D1B55DFE6291B3743EC@MAIL.engr.sc.edu>
References: <5CBBAC9E1EA66C4E976DDF1D1B55DFE6291B3743EC@MAIL.engr.sc.edu>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Adeos-main] linux 2.6.17 and ARM I-pipe patch
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: "WILES, WILLIAM QUINTON" <WILESW@engr.sc.edu>
Cc: "adeos-main@gna.org" <adeos-main@gna.org>

WILES, WILLIAM QUINTON wrote:
 > I'm currently working with a board that's hardware support is focused
 > mainly on the 2.6.17 kernel revision.  I was wondering if there is a
 > specific reason the ipipe patches jumped from 2.6.14/15 to 2.6.19/20
 > other than the desire to move to the most up-to-date kernel as
 > possible.  

It is a simple matter: if at a given time we are able to make the effort
of working on one patch, we choose the most recent kernel.

My reasoning is that in an effort to get adeos up on my
 > board I took the most recent prior patch,
 > 
 > adeos-ipipe-2.6.15-arm-1.5-08.patch
 > 
 > and applied it to my board's functional kernel (2.6.17.9) and
 > manually made the changes that the patch could not apply based on the
 > diff discrepancies between the linux versions.  I had mild success in
 > that I can compile the kernel happily, however at runtime it appears
 > to stall.  After reading through the Xenomai wiki for i-pipe porting
 > and a few of the mailing lists I am starting to wonder if my
 > 'shoehorning' approach is too naive, and feedback would be greatly
 > appriciated.

This approach works, the only real reject is the syscall interception in
entry-armv.S, for which you can have a look at recent patches

That said, since it is not the first time we are asked for it, and since
I had it run once, I will try and send a patch for Linux 2.6.17.

-- 


					    Gilles Chanteperdrix.

