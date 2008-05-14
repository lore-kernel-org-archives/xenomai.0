MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18475.15097.394424.565967@domain.hid>
Date: Wed, 14 May 2008 21:18:17 +0200
In-Reply-To: <20080514170246.312550@domain.hid>
References: <200805112104.56166.karl-trampe@domain.hid> <48276703.2020005@domain.hid>
	<20080514144900.216230@domain.hid> <482AFF6C.20903@domain.hid>
	<2ff1a98a0805140817v45065492qe292b872584950cf@domain.hid>
	<2ff1a98a0805140831w6c9b2c2ble3cefec79dce1081@domain.hid>
	<20080514170246.312550@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] [RTnet-users] Ideas how to measure delays with
 RTnet
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Karl Reichert <Karl-Trampe@domain.hid>
Cc: jan.kiszka@domain.hid, xenomai@xenomai.org, rtnet-users@domain.hid

Karl Reichert wrote:
 > Hmm ... what is the difference between rt_timer_read, rt_timer_inquire and rt_timer_tsc? I think rt_timer_inquire is giving the same results (and a little more, the period) like the other two ones, but in one call?
 > 
 > As I understand, TSC is a reliable value on single processor machines with CONFIG_CPU_FREQ, CONFIG_ACPI_PROCESSOR and CONFIG_APM disabled?! So I can use rt_timer_tsc?! Or should I better use rt_timer_read? (Please see above for my UseCase)

rt_timer_tsc has less overhead than rt_timer_read (it does not issue a
syscall, and it does not do any conversion).

On the other hand, rt_timer_read gives you an absolute value whose
reference is the well known 1st january 1970.

With rt_timer_inquire, you get rt_timer_tsc and rt_timer_read at the
same time, and you know the relation between the two values.

-- 


					    Gilles.

