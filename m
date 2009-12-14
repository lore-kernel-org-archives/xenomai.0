Message-ID: <4B264562.4090803@domain.hid>
Date: Mon, 14 Dec 2009 15:02:10 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <4B263E6A.7040104@domain.hid> <4B264295.9080308@domain.hid>
In-Reply-To: <4B264295.9080308@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Build tests.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Alexis Berlemont <alexis.berlemont@domain.hid>, xenomai-core <xenomai@xenomai.org>

Hi Jan,

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Hi,
>>
>> I am working on automated build tests of several configurations of
>> Xenomai head. While running them, I found a few issues, and would need
>> acks, since it is in parts others maintain.
>>
>> Alex: https://mail.gna.org/public/xenomai-git/2009-12/msg00112.html
>>
>> Wolfgang: https://mail.gna.org/public/xenomai-git/2009-12/msg00113.html
>>
> 
> Though I'm not Wolfgang:
> 
>  config XENO_DRIVERS_CAN_SJA1000_PEAK_DNG
> -       depends on XENO_DRIVERS_CAN_SJA1000
> +       depends on XENO_DRIVERS_CAN_SJA1000 && !PARPORT
>         tristate "PEAK Parallel Port Dongle"
>         help
> 
> That's not obviously related. Why do we need it?

As the help text explains, parport should be disabled. See:

http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/can/sja1000/Kconfig#066

Wolfgang.

