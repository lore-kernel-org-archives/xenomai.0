Date: Thu, 12 May 2011 19:04:32 +0200
From: Richard Cochran <richardcochran@domain.hid>
Message-ID: <20110512170432.GA4659@domain.hid>
References: <20110409184122.GA11908@domain.hid>
	<20110409185503.GB11908@domain.hid>
	<4DA0B580.4070602@domain.hid> <4DA0B878.9010106@domain.hid>
	<20110410065250.GA28869@domain.hid>
	<4DA192E0.2090802@domain.hid>
	<20110414164248.GA4725@domain.hid>
	<4DCB23D6.9010706@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DCB23D6.9010706@domain.hid>
Subject: Re: [Xenomai-core] arm ixp: more trouble with recent xenomai
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Thu, May 12, 2011 at 02:03:34AM +0200, Gilles Chanteperdrix wrote:
> the issue on ixp looks like the last one to be fixed on arm. If you have
> time, could you try the following program? It makes a very basic test,
> but not having a big-endian ixp at end, I am wondering about very basic
> assumptions...:

~> armeb-unknown-linux-gnueabi-gcc -Wall arm.c
arm.c: In function 'f':
arm.c:7: warning: control reaches end of non-void function
arm.c: In function 'g':
arm.c:13: warning: control reaches end of non-void function

and then

# ./a.out 
f: ffffffff
g: ffffffff

> If you do not have time, do you agree for a revert of the KUSER_TSC code
> to the one we had before, and which is working for you?

I sorry about not getting back about this. I have had crunch trying to
meet a deadline, but now that is over. Tomorrow I'm on the road, but
next week looks good for IXP testing.

And thanks, thanks, for all your good work,

Richard


