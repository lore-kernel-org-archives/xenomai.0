Message-ID: <4FB219F8.7080400@domain.hid>
Date: Tue, 15 May 2012 10:55:20 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtfuUhrPprNM4r3TZB=HsxQz8v+CV56=v5HX4C0ZqVaXzw@domain.hid>
In-Reply-To: <CAKKWdtfuUhrPprNM4r3TZB=HsxQz8v+CV56=v5HX4C0ZqVaXzw@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] POSIX API
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: ali hagigat <hagigatali@domain.hid>
Cc: xenomai@xenomai.org

On 05/15/2012 10:02 AM, ali hagigat wrote:
> I am looking for all POSIX functions of Linux, i wonder if any body
> has POSIX.1-2008 manual or IEEE1003.1 or a similar document.
> Does xenomai change libc.a ? As far as I understood, xenomai adds new
> functions(they start with rt_), besides it changes some of posix
> functions while it keeps some posix functions untouched.

Functions which start with rt_ are part of the native skin. The
implementation of the posix skin does not change libc.a, it implements a
new library libpthread_rt.so, and the function substitution is done at
link-edition time by using the linker --wrap option.

> Is there any book regarding to the real time programming in xenomai?

You can start here:
http://www.xenomai.org/index.php/Included_documentation_summary

For instance the --wrap trick is explained here:
http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai#Under_the_hood:_the_--wrap_flag

-- 
					    Gilles.

