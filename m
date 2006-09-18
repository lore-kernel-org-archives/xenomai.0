Message-ID: <450F1686.3010304@domain.hid>
Date: Mon, 18 Sep 2006 16:58:30 -0500
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai v2.2.3
References: <1158564530.5020.5.camel@domain.hid>
In-Reply-To: <1158564530.5020.5.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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

Philippe Gerum wrote:
> Here is the third maintenance release for the v2.2.x branch.
> ...

This release works fine on my 2.6 kernel x86 machine, with the exception of the FPU problems noted elsewhere.

I have the following problems with my 2.4 kernel x86 machine:
  * The latency and switchtest test programs yield segmentation faults.
  * My own user-space test programs seg fault.

Things that work:
  * The kernel boots and runs fine.
  * xeno_native, _posix, _rtai all insert and remove without problems.
  * Some simple kernel module test programs work fine.

I am using the same config as I was for 2.2.2 (which worked fine), but I am running a slightly newer kernel version (2.4.33.3 as opposed to 2.4.32).

I hope this helps,

-Jeff

Output of latency/run:
----------------------------------
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
/usr/xenomai/bin/xeno-load: line 249:  5358 Segmentation fault      $suflag $* $cmdargs


Output of switchtest/run:
-----------------------------

*
*
* Type ^C to stop this application.
*
*
== Testing FPU check routines...
r0: 1 != 2
r1: 1 != 2
r2: 1 != 2
r3: 1 != 2
r4: 1 != 2
r5: 1 != 2
r6: 1 != 2
r7: 1 != 2
== FPU check routines: OK.
/usr/xenomai/bin/xeno-load: line 249:  5273 Segmentation fault      $suflag $* $cmdargs
xeno_switchtest: Device or resource busy


-Jeff

