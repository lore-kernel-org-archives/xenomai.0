Message-ID: <e325d110607100838q4955cfa3p3ef1386f38e3e599@domain.hid>
Date: Mon, 10 Jul 2006 16:38:43 +0100
From: "Kim Chuan Lim" <lim.kim.chuan@domain.hid>
Subject: Re: [Xenomai-help] xenomai beginner problem.
In-Reply-To: <44B13745.300@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e325d110607071259g5ebc019bs2565887803265adc@domain.hid>
	<e325d110607080632u5d80322bte8d32d8e4828030e@domain.hid>
	<17583.47182.991802.118974@domain.hid>
	<e325d110607080808w7778fb6ayf1f033b79be7c92b@domain.hid>
	<1152371904.5004.2.camel@domain.hid>
	<e325d110607081156n42b7d8f1m892949b16dc2e9f@domain.hid>
	<17584.4915.679135.575538@domain.hid>
	<44B02B69.9050903@domain.hid>
	<e325d110607090646m6fe877c7sc33777a370648d99@domain.hid>
	<44B13745.300@domain.hid>
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

Hi all,

I managed to install Xenomai into another of my machine.
I am able to run all the test program without any problem.

I am interested with the hard real time serial port example from..
http://www.captain.at/xenomai-serial-port-example.php

The following is the error message i received when i try to run the program..
./rt_serial_uprog
rt_serial_uprog: PRESS CTRL-C to EXIT
rt_serial_uprog: timer started
rt_serial_uprog: can't open rtser0
rt_serial_uprog: stop timer

May i know which device is "rtser0"?
shall i just change it to /dev/ttyS0?

Regards,
Kim Chuan.


On 7/9/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> Kim Chuan Lim wrote:
> > Hi all,
> >
> > Please find the attachment for my linux kernel config.
> > Please let me know if anything wrong in the configuration.
>
> Nothing suspicious on first sight. Please proceed with Gilles' and my
> other suggestions now.
>
> Jan
>
>
>
>

