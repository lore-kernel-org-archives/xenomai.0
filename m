Message-ID: <4CC9980C.6080003@domain.hid>
Date: Thu, 28 Oct 2010 17:34:36 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4CC82C8D.3080808@domain.hid>
	<4CC84327.9070202@domain.hid>	<4CC92786.3030509@domain.hid>
	<4CC92902.4040904@domain.hid>	<4CC943A2.9020806@domain.hid>
	<4CC94E0B.9070106@domain.hid> <4CC97448.3040205@domain.hid>
	<4CC99129.50507@domain.hid> <4CC99215.80600@domain.hid>
	<4CC9944D.8050909@domain.hid>
In-Reply-To: <4CC9944D.8050909@domain.hid>
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
To: Anders Blomdell <anders.blomdell@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Am 28.10.2010 17:18, Anders Blomdell wrote:
> On 2010-10-28 17.09, Jan Kiszka wrote:
>> Am 28.10.2010 17:05, Anders Blomdell wrote:
>>> Current results:
>>>
>>> 1. 2.6.35.7, maxcpus=1; a few thousand rounds, freeze and this after
>>> some time:
>>>
>>> BUG: spinlock lockup on CPU#0, raw_test/2924, c0a1b540
>>> Process raw_test (pid: 2924, ti=f18bc000 task=f1bdab00 task.ti=f18bc000)
>>> I-pipe domain Xenomai
>>> Stack:
>>> Call Trace:
>>> Code: d0 85 d8 74 0f ba 71 00 00 00 b8 78 a7 8f c0 e8 3b 03 02 00 a1 28
>>> f6 9f c0 89 f2 8b 48 20 89 d8 e8 ad fd ff ff 57 9d 8d 65 f4 5b <5e> 5f
>>> 5d c3 90 55 89 e5 0f 1f 44 00 00 8b 0d 28 f6 9f c0 ba 00
>>>
>>
>> Please provide the full kernel log, ideally also with the I-pipe tracer
>> (with panic tracing) enabled.
> Will reconfigure/recompile and do that, with full kernel log do you mean all
> bootup info?

That's best to avoid missing some detail or doing Q&A ping-pong.

>>
>>> 2. 2.6.35.7, maxcpus=4; no packets sent, this on console:
>>>
>>> e1000: rteth0: e1000_clean_tx_irq: Detected Tx Unit Hang
>>
>> Err, is this another NIC used on this box? If yes and when used as RTnet
>> NIC instead, does it trigger the same issue?
> Switched the eepro100 to a e1000, and got same user program issues (indicating
> ipipe/rtdm/rtnet_stack issues and not a specific driver), have not switched back
> yet, will do if you rather want that.

As both NICs are apparently affected, just stick with one.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

