Message-ID: <bc4264770702220214y697c57abv9d5170b64fad40eb@domain.hid>
Date: Thu, 22 Feb 2007 10:14:52 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
Subject: Re: [Xenomai-help] CAN driver
In-Reply-To: <45DD5DC0.6040402@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45DC1D05.1000206@domain.hid> <45DC2478.2020602@domain.hid>
	<45DC39DE.8050802@domain.hid> <45DC3E6C.8040905@domain.hid>
	<45DD5DC0.6040402@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: Xenomai-help@domain.hid, Jan Kiszka <jan.kiszka@domain.hid>

Hi,

The first thing I notice is that I do not seem to find the devices
rtcan0, rtcan1 etc.

They are mentioned in the documentation and I presume they must be nodes in
/dev or so. But I cannot find them. rt-can is statically built into my
kernel so I don;t need to load any modules. I have selected the SJA
chip and the PEAK CAN Dongle.

I am reading the README in /src/can and the one in ksrc/drivers/can.

/proc/rtcan is present but no devices rtcan0, rtcan1 etc under it.

What have I missed?

Regards,

Roland


On 2/22/07, Wolfgang Grandegger <wg@domain.hid> wrote:
> Jan Kiszka wrote:
> > Wolfgang Grandegger wrote:
> [...]
> >> I have attached a patch for a nice program to measure
> >> the round trip time of CAN messages. It contrast to the other CAN
> >> utility programs, it uses the POSIX-API and works as-is for Socket-CAN
> >> as well. Jan, any objections to include it? If yes, I'm going to provide
> >> a README.
> >
> > On first glance, nope, looks nice and clean.
>
> I have just commited the example program "rtcan_rtt" to the trunk.
>
> Wolfgang.
>

