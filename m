Message-ID: <4C726911.6050201@domain.hid>
Date: Mon, 23 Aug 2010 14:26:57 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTikjB1vF+0Ldnc_80_+TJeG2MKo5i42hE5Ah3nj9@domain.hid>	<4C6BD747.1090304@domain.hid>	<AANLkTimiofme9duMMyiqe3snHmGxWFxGf7AJDaaAGE6b@domain.hid>	<AANLkTinYt1Gj+Vsm1NXCXyDPa92KS+DMFVhpNcVvYjgw@domain.hid>	<4C6D4BDE.1050605@domain.hid>	<AANLkTi=-7yEyDLn1tBmzkxMK+=Tr4F-7XNGdtzoespod@domain.hid>
	<4C7260B4.4070100@domain.hid>
In-Reply-To: <4C7260B4.4070100@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] kernel compilation problem with a Cortex A8,
 AM3517 EVM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: marc doz <doz.marc@domain.hid>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> marc doz wrote:
>> Hi,
>> I don't know where do you from my vendor kernel but it seems that it
>> is a 2.6.32 kernel.
> 
> I have no doubt that it is a 2.6.32 kernel. The question is to know
> whether it is a vanilla kernel, i.e. coming from kernel.org. Since in
> your first post the kernel directory was named linux_0030 or something
> like that, I assumed it was not. But in any case it does not change
> anything since the I-pipe patch for arm does not exist for linux-2.6.32
> either.
> 
>> This is my first time with git ! so I will need that you valid my
>> method, please.
>>
>> I test with these commands :
>>
>> #git clone git://git.denx.de/ipipe-2.6.git
>> #git checkout -branch -b ipipe-2.6.32-noarch origin/ipipe-2.6.32-noarch
>> #git checkout -b vendor
>> #cp -vR ../TI_linux/* ./
> 
> It will work better if the branch "vendor" comes from the vendor git.

No, what you did does not work at all. After this cp, the "vendor"
branch will contain a mix of files from the noarch branch with the ones
of your vendor.

-- 
					    Gilles.


