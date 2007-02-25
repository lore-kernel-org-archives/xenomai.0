Message-ID: <bc4264770702250528u1f7a4736s919eb998d064289b@domain.hid>
Date: Sun, 25 Feb 2007 13:28:44 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] rt_timer_start()
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

Hi,

The Native API tour dictates that rt_timer_start() MUST be called in
all userspace applications that access the rt_timer.

It displays and example very similar to the example trivial_periodic.c

howeve trivial_periodic.c does not call the rt_timer_start() even
though it does have calls such as rt_timer_read.

and it seems to work.

Why is that?

Regards,

Roland

