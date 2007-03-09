Message-ID: <bc4264770703091010s2b8c2109oa49692c4ea7703b4@domain.hid>
Date: Fri, 9 Mar 2007 18:10:41 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
Subject: Re: [Xenomai-help] RTCAN and tsc
In-Reply-To: <E1HOs43-0008OG-Ki@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bc4264770703060706x5dafb942weec4d4c2c5756427@domain.hid>
	<17901.49981.701410.464219@domain.hid>
	<45EDD311.1060506@domain.hid> <E1HOs43-0008OG-Ki@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sebastian Smolorz <ssm@domain.hid>
Cc: xenomai@xenomai.org

Hi,

>
> Hm. To be more verbose on what happens between the beginning of
> rtcan_sja_interrupt and rtcan_rcv please remove the "inline" from the
> functions rtcan_sja_err_interrupt in the file
> ksrc/drivers/can/sja1000/rtcan_sja1000.c line 156 and from the function
> rtcan_sja_rx_interrupt in the same file in line 87. Compile your
> modules/kernel again and repeat the tracer/latency test.

Hi I tried this for you but come a bit short. When I try to load the
module I get the error

FATAL: Error inserting xeno_can_peak_dng (xeno_can_peak_dng.ko):
Unknown symbol in module, or unknown parameter (see dmesg)


with dmesg:

xeno_can_peak_dng: Unknown symbol mcount


What I did was simply remove the inline statement from the function
call. (I did not check the corresponding header file should I have?)
Then I did a make modules and a make install_modules after which I
retrieved the .ko files which I am trying to load.

Is this still a useful step after Paul's elucidating calculations ?


Regards,

Roland


>
> I assume that most of the time is spent in the latter function where several
> SJA HW regs are read out. A slow access to the regs could be the explanation
> for the long time the interrupt handler has to spend.
>
> --
> Sebastian
>

