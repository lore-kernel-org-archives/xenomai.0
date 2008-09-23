Message-ID: <48D9364B.70505@domain.hid>
Date: Tue, 23 Sep 2008 20:32:43 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <899865CA54E4444DAF2E3639C04C5F48E4DA6A@trillian.at.omicron.at>
	<48D66DC4.8030706@domain.hid>
In-Reply-To: <48D66DC4.8030706@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] FW: [PATCH] repost: ARM FCSE
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Richard Cochran <richard.cochran@domain.hid>
Cc: adeos-main@gna.org

Gilles Chanteperdrix wrote:
> Richard Cochran wrote:
>> I posted this patch today on linux-arm-kernel, but I repeat it
>> here because there does not seem to be too much interest on that
>> list for the ARM FCSE.
>>
>> I also tried to combine this patch with ipipe for kernel 2.6.20
>> running on the Intel IXDP465, but after booting I soon get a BUG.
>>
>> Anyhow, perhaps the ARM people might take a look at combining
>> ipipe with FCSE...
> 
> Ok. Six monthes later, I finally gave a try to your patch on at91rm9200,
> which supports FCSE as well.
> 
> When booting, I get random segmentation faults (either with or without
> the I-pipe), assertion which fails in glibc, and such things.

A small update: I get the same random failures with a vanilla kernel
(without I-pipe patch at all).

I will now investigate pmd_populate.

-- 
					    Gilles.

