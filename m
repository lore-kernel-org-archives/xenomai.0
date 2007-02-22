Message-ID: <45DD5DC0.6040402@domain.hid>
Date: Thu, 22 Feb 2007 10:09:20 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] CAN driver
References: <45DC1D05.1000206@domain.hid> <45DC2478.2020602@domain.hid>
	<45DC39DE.8050802@domain.hid> <45DC3E6C.8040905@domain.hid>
In-Reply-To: <45DC3E6C.8040905@domain.hid>
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
Cc: Xenomai-help@domain.hid

Jan Kiszka wrote:
> Wolfgang Grandegger wrote:
[...]
>> I have attached a patch for a nice program to measure
>> the round trip time of CAN messages. It contrast to the other CAN
>> utility programs, it uses the POSIX-API and works as-is for Socket-CAN
>> as well. Jan, any objections to include it? If yes, I'm going to provide
>> a README.
> 
> On first glance, nope, looks nice and clean.

I have just commited the example program "rtcan_rtt" to the trunk.

Wolfgang.

