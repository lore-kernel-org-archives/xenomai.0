Message-ID: <4F187D9E.5050501@domain.hid>
Date: Thu, 19 Jan 2012 21:31:26 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1326994144.4f1852e0aa680@domain.hid>
In-Reply-To: <1326994144.4f1852e0aa680@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai tests hanging
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: mlkjhgfds@domain.hid
Cc: xenomai@xenomai.org

On 01/19/2012 06:29 PM, mlkjhgfds@domain.hid wrote:
> 
> Hello,
> 
> Having trouble running tests on Xenomai 2.6.0 (trying to use analogy with a NI
> DAQ and getting errors after binding assumedly because the Xenomai install isn't
> running properly)

What do you mean the xenomai install isn't running properly? What error
do you get?

> 
> xeno-test hangs and results in a kernel failure,
> tried individual tests : cyclictest seemed ok, but latency and clocktest hang.

Could you try using a serial console or netconsole and cut and paste the
exact error message you get? The most interesting thing is the functions
names in the stack trace. Also, if you are running gcc 4.6 or later,
please try reconfiguring and recompiling everything passing
CFLAGS="-fno-omit-frame-pointer"
on configure command line. If reconfiguring, do not forget "make clean".
-- 

                                                                Gilles.

