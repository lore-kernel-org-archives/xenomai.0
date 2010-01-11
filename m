Message-ID: <4B4B6591.6090309@domain.hid>
Date: Mon, 11 Jan 2010 18:53:21 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <065A7D06F7D4E546A18E80E08D066E18146A3016C3@domain.hid>
In-Reply-To: <065A7D06F7D4E546A18E80E08D066E18146A3016C3@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai user app working very slowly
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Landau, Bracha" <BLandau@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Landau, Bracha wrote:
> I converted my regular posix application to a xenomai-posix
> application, hoping to see an improvement in performance. However,
> the new xenomai application runs e-x-t-r-e-m-e-l-y slowly, and seems
> to take undue amounts of CPU time.
> 
> I configured the xenomai with -enable-smp and -enable-x86-sep. It is
> an Atom processor (a single cpu).
> 
> Any ideas why this is happening?

Check:
http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai
and:
http://www.xenomai.org/index.php/FAQs#What_may_cause_a_freeze_or_machine_lockup.3F

If you do not find what is wrong, please isolate the issue you have in a
small self-contained test case, which we can compile and run to
investigate your issue.

I insist on "which we can compile", we are not interested in partial
pieces of code with ellipsis where we have to figure out what you add to
run your test.

-- 
Gilles Chanteperdrix, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

