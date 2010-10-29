Message-ID: <4CCB209E.6090207@domain.hid>
Date: Fri, 29 Oct 2010 21:29:34 +0200
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
References: <4CC82C8D.3080808@domain.hid>	<4CC84327.9070202@domain.hid>	<4CC92786.3030509@domain.hid>	<4CC92902.4040904@domain.hid>	<4CC943A2.9020806@domain.hid>	<4CC94E0B.9070106@domain.hid>
	<4CC97448.3040205@domain.hid>	<4CC99129.50507@domain.hid>
	<4CC99215.80600@domain.hid>	<4CC9944D.8050909@domain.hid>
	<4CC9980C.6080003@domain.hid>
	<4CCB078C.1010102@domain.hid> <4CCB0D22.4060406@domain.hid>
In-Reply-To: <4CCB0D22.4060406@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Potential problem with rt_eepro100
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2010-10-29 20.06, Jan Kiszka wrote:
> Am 29.10.2010 19:42, Anders Blomdell wrote:
>> Jan Kiszka wrote:
>>
>>>>> Please provide the full kernel log, ideally also with the I-pipe tracer
>>>>> (with panic tracing) enabled.
>>>> Will reconfigure/recompile and do that, with full kernel log do you
>>>> mean all
>>>> bootup info?
>>>
>>> That's best to avoid missing some detail or doing Q&A ping-pong.
>>
>> Full trace attached (finally...)
>>
> 
> You have to switch off CONFIG_DMA_API_DEBUG, it's incompatible with Xenomai.
Thanks, will continue with this on monday (build in progress).

With your ftrace port, how does one freeze all cpu's at the same time?


Regards

Anders

-- 
Anders Blomdell                  Email: anders.blomdell@domain.hid
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden

