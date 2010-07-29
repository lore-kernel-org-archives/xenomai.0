Message-ID: <4C51AE7E.3000306@domain.hid>
Date: Thu, 29 Jul 2010 18:38:22 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4C4F7930.90408@domain.hid> <4C4F7AF8.8090500@domain.hid>
	<4C4F949F.9090200@domain.hid> <4C4FDFD2.4010405@domain.hid>
	<4C50D87B.2010008@domain.hid>
	<4C512F32.3030903@domain.hid> <4C51AC2B.20000@domain.hid>
In-Reply-To: <4C51AC2B.20000@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai xeno-test hangs on 2.6.31 on BeagleBoard,
 same works on 2.6.33
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bob Feretich <bob.feretich@domain.hid>
Cc: xenomai@xenomai.org

Bob Feretich wrote:
>   Then what is the recommended set of test to run to determine if 
> Xenomai is fully and properly installed?

We validate Xenomai by running the latency test while running a script
called "dohell" in order to apply some load on the board, which requires
installing a few things on the board (LTP, netcat, the dohell script).
I described the procedure in the following mail:
https://mail.gna.org/public/xenomai-help/2010-07/msg00184.html

To have some basic validation, you may run the tests from the testsuite
one by one.

I am currently working on a replacement for xeno-test, which would
enable us to automate the procedure.

-- 
					    Gilles.

