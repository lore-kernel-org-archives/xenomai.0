Message-ID: <4B0AD2CF.1050103@domain.hid>
Date: Mon, 23 Nov 2009 19:22:07 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <200911231521.32461.smolorz@domain.hid>
	<4B0AC853.6030603@domain.hid> <4B0ACEE1.5030602@domain.hid>
In-Reply-To: <4B0ACEE1.5030602@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] can: Free I/O region when unloading the
 xeno_can_isa.ko driver
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Wolfgang Grandegger wrote:
>> Sebastian Smolorz wrote:
>>> can: Free I/O region when unloading the xeno_can_isa.ko driver
>>>
>>> Signed-off-by: Sebastian Smolorz <smolorz@domain.hid>
>> Signed-off-by: Wolfgang Grandegger <wg@domain.hid>
>>
>> Philippe, should I apply the patch?
> 
> Do you have write access to the head git? Even if, this is not how that
> tree is operated today. Either send pull request from a personal tree or
> wait for Philippe to pick it up directly.

Well, you are right. I actually never tried.

> But I can also pick up Sebastian's patch and push it through my tree
> (along with the other RTDM-related commit I've queued).

You are welcome.

Thanks,

Wolfgang.


