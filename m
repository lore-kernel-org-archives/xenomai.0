Message-ID: <472112E2.90008@domain.hid>
Date: Thu, 25 Oct 2007 15:04:18 -0700
From: Dennis Nguyen <dennisnguy@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] xeno-test failed to open benchmark device,
 code -19 at t1 and t2 # latency
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

I built 2.6.22.10 linux kernel -i386 with xenomai 2.4-rc4 and
adeos-ipipe-2.6.22-i386-1.10-09.patch.

I checked enable SMI workaround, uncheck frequency scaling, uncheck ACPI
and uncheck APM.

I ran xeno-test and get the following failed message:

Thu Oct 25 13:17:02 PDT 2007
running: ./run -- -sh -T 120 -t1 # latency
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: in-kernel periodic task
== All results in microseconds
latency: failed to open benchmark device, code -19
(modprobe xeno_timerbench?)

Thu Oct 25 13:17:04 PDT 2007
running: ./run -- -sh -T 120 -t2 # latency
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: in-kernel timer handler
== All results in microseconds
latency: failed to open benchmark device, code -19
(modprobe xeno_timerbench?)

Could you help me to solve the issue?

Thank you,
Dennis

