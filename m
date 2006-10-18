Message-ID: <4536087B.7040301@domain.hid>
Date: Wed, 18 Oct 2006 12:56:59 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RT socket CAN architecture
References: <54b161f50610180247m71815adfu4082fcfd5d679c0f@domain.hid>
	<45360543.7010503@domain.hid>
In-Reply-To: <45360543.7010503@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Frits de Klark wrote:
>> Hello everyone,
>>
>> I'm in the need of a realtime CAN driver which is as fast as possible
>> and at
>> the same time user-friendly. The RT socket CAN driver looks rather
>> appealing
>> to me, but I'm wondering if there's any negative impact on speed (in the
>> context of minimal response times) in using a socket approach.
>> Also, is there any of you with some testresults?
> 
> Wolfgang once had some test results (and application code) on
> hardware-based loopback latencies, maybe he can post them when time permits.

A while ago I ported the round-trip-test from RTnet. "rtcan_rtt" is a 
simplified version available in rtsocketcan-0.90.0.tar.bz2 at 
ftp://ftp.denx.de/pub/xenomai/rtsocketcan.

> For sure, twiddling directly with the CAN hardware is always faster than
> having generic layer(s) in between, but the impact of the CAN stack is
> fairly small, specifically as we have a direct wake-up path from the IRQ
> to the application on reception or TX buffer availability.
> 
> Do you have any scenario and/or numbers you would like to compare them
> against?

And what platform do you intend to use?

Wolfgang.


