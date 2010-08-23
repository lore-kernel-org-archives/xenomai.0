Message-ID: <4C723497.1060501@domain.hid>
Date: Mon, 23 Aug 2010 10:43:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTinWHLk2fc0qMygBOmgYpAAh88FbUAUFDq2DPRKL@mail.gmail.com>
	<4C7232E6.8070709@domain.hid>
In-Reply-To: <4C7232E6.8070709@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai patch for AT91ARM9200
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Prakash A S <asprakash83@domain.hid>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Prakash A S wrote:
>> Dear All,
>>          Now I am working on AT91RM9200 based processor ARM board with Linux
>> 2.6.20 kernel and also planing to port Xenomai on this board. I preferred
>> xenomai-2.4.0. Because it has adeos-ipipe patch for 2.6.20 kernel. However I
>> found that there is an separate ipipe patch available for AT91 processor in
>> xenomai-2.3.2. Do I need any similar patch for xenomai-2.4.0 or
>> adeos-ipipe-2.6.20-arm-1.802.patch is enough?.
>>
>> I beleive the steps will be like,
>> linux-2.6.20+2.6.20-at91.patch.gz+adeos-ipipe-2.6.20-arm-1.802.patch
> 
> You did it again: as documented in ksrc/arch/arm/patches/README,

And in the FAQ too:
http://www.xenomai.org/index.php/FAQs#Which_I-pipe_patch_should_I_use_with_Xenomai_version_X_on_platform_Y.3F

-- 
					    Gilles.

