Message-ID: <4B327375.7030304@domain.hid>
Date: Wed, 23 Dec 2009 20:45:57 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B326F1A.3000905@domain.hid> <4B325C12.7000902@domain.hid>
	<4B32482C.7010508@domain.hid> <4B30E2EE.6000308@domain.hid>
	<17562953.1358371261493595174.JavaMail.coremail@domain.hid>
	<23404643.433811261586259575.JavaMail.coremail@domain.hid>
	<1201618.436081261588028205.JavaMail.coremail@domain.hid>
	<18018862.440661261596184606.JavaMail.coremail@domain.hid>
	<5349479.441121261597341772.JavaMail.coremail@domain.hid>
In-Reply-To: <5349479.441121261597341772.JavaMail.coremail@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xeno-test can not run
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: robert165 <robert165@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

robert165 wrote:
> 
>>> OK, I have found the FCSE option with kernel 2.6.28.
>>> My working computer is not here, so I tested in a VMware and a old
>>> kernel 2.6.20 at first. Then I download a 2.6.28 kernel and things be OK
>>> now.
>>
>>I took care to tell you clearly that the FCSE option was available in
>>the latest versions of the I-pipe patches, which were in the Xenomai
>>2.4.10 release. Obviously the patch for kernel 2.6.20 is not part of
>>Xenomai 2.4.10.
>>
>>> 
>>>>Properly loading the system means hammering it real hard. And if you do
>>>>that, you will get real results. Around 260us in user-space without
>>>>FCSE, or 200us with FCSE.
>>> 
>>>  "hammering it real hard ", you mean work in real application?
>>> Sorry, my English is so terrible, I just know that hammer is a tool for strike.
>>
>>Yes, so hammering means striking with a hammer... It is an image.
> 
> I used nfs filesystem in the test, that's the point?

The point is to generate activity on your system, to stress it. But real
hard.


-- 
					    Gilles.

