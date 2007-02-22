Message-ID: <bc4264770702220339m1b8dfcbfk11f9c05e2a0aed91@domain.hid>
Date: Thu, 22 Feb 2007 11:39:54 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
Subject: Re: [Xenomai-help] CAN driver
In-Reply-To: <45DD7C42.9070407@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45DC1D05.1000206@domain.hid> <45DC2478.2020602@domain.hid>
	<45DC39DE.8050802@domain.hid> <45DC3E6C.8040905@domain.hid>
	<45DD5DC0.6040402@domain.hid>
	<bc4264770702220214y697c57abv9d5170b64fad40eb@domain.hid>
	<45DD7C42.9070407@domain.hid>
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

Hi Jan,

>
> rtcanX are networking devices, but only visible in the context of
> RTDM/AF_CAN.
What is this?

 To enable them, use rtcanconfig as explained in the README.
Which README are you referring to? The only one I know of that says
something about rtcanconfig is in /src/utils/can and it does not
explain how to use ctrlmode and bittime. There is an example in it

rtcanconfig rtcan0 --baudrate=125000 start.

If I try

rtcanconfig rtcan0 --baudrate=125000 start

I get:

"Can't get interface index for rtcan0, code=-19"

Any idea what is wrong?

Regards,

Roland.



>
> Jan
>
>
>

