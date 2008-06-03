Message-ID: <2ff1a98a0806030741j7e7c12f8r5754cc79b66e3e3d@domain.hid>
Date: Tue, 3 Jun 2008 16:41:36 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <484556FE.70700@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4845166E.3000203@domain.hid>
	<2ff1a98a0806030507l6d84126et55f85d4bf1f5614b@domain.hid>
	<484556FE.70700@domain.hid>
Subject: Re: [Xenomai-help] xeno-test on AT91SAM9263 irqloop and switchtest
	problem?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Paradoxxa <paradoxxa2001@domain.hid>
Cc: xenomai@xenomai.org

On Tue, Jun 3, 2008 at 4:36 PM, Paradoxxa <paradoxxa2001@domain.hid> wrote:
> Gilles Chanteperdrix schrieb:
>>
>> On Tue, Jun 3, 2008 at 12:01 PM, Paradoxxa <paradoxxa2001@domain.hid> wrote:
>>
>>>
>>> Hi all,
>>>
>>> I have here a AT91SAM9263 with a 2.6.24 kernel, Xenomai 2.4.3 and Adeos
>>> Patch 1.9-01 and run the xeno-test. It seems there are a Problem with the
>>> irqloop and the switchtest applications.
>>> In the attachment you can find the log files.
>>>
>>
>> To run the latency test with -t 1 or -t 2, you need to enable the
>> "timerbench" driver in the kernel configuration menu.
>> In the same bench, the switchtest test needs the "switchtest" driver.
>>
>> I do not see any error message about irqloop in the logs you sent us.
>>
>>
>>
>
> Ok, i found it in the kernel configuration menu. I started the irqloop
> manual. But if a parallel port is required it doesn't matters.
> What do you think about the latency times? In the worst case i got times
> around 185 us.

It does not look bad for an ARM.

-- 
 Gilles

