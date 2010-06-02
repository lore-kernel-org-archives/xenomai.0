Message-ID: <4C067CCE.1050501@domain.hid>
Date: Wed, 02 Jun 2010 17:46:22 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTimAGqy-XtAk42KE2yBaJEZw6IOimq-crptl72ae@domain.hid>
In-Reply-To: <AANLkTimAGqy-XtAk42KE2yBaJEZw6IOimq-crptl72ae@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xeno-test problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Cyril Wallois <walloiscyril@domain.hid>
Cc: xenomai@xenomai.org

Cyril Wallois wrote:
> Hi all,
> 
> I have a problem when I try to load xeno-test, at the begining, I Though
> it comes from a too low sampling period on the latency test.
> I run xenomai 2.4.8 with linux 2.6.26 on a PXA270 (toradex colibri). I
> should not have these problem with newer kernel and version of xenomai.

Apparently I did not make myself clear on the rtnet mailing list: since
you mentioned a crash, then it means that you have a kernel oops or
something. There is nothing we can do if you do not show us the oops
message on the serial console. If you do not see anything after:

== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...

Then your problem is indeed not a crash, but the known lockup with too
short frequencies on ARMs.

Note that if you upgrade to Xenomai 2.5.3, you will be able to enable
the FCSE option and unlocked context switches, which should improves the
latencies.

-- 
					    Gilles.

