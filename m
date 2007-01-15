Message-ID: <45ABA9FC.7070606@domain.hid>
Date: Mon, 15 Jan 2007 17:21:16 +0100
From: Steven Scholz <steven.scholz@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] IPIPE for ARM9 i.MX and AT91RM9200 ?
References: <45AB9D58.3060308@domain.hid> <45ABA0C7.3050407@domain.hid>
	<45ABA6E4.3030707@domain.hid> <45ABA91F.909@domain.hid>
In-Reply-To: <45ABA91F.909@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles,

>>>> are there IPIPE Patches for recent kernels (2.6.19) available for
>>>> Freescale's i.MX1/i.MXL and Atmel's AT91RM9200 cpus available.
>>> The IPIPE patches for ARM exist for linux 2.6.14 and 2.6.15. There is an
>>> i.MX21 port for 2.6.14 and an AT91 port for 2.6.15...
>>
>> Thanks very much.
>>
>> Where can I find the AT91 patches? The i.MX stuff seems to be in xenomai-2.3.0.
> 
> Yes, the AT91 port should be in the next release of the 2.3 branch.
> 
> In the meantime, you can find them in Xenomai svn repository, either
> under trunk/ksrc/arc/arm/patches/at91 or
> branches/v2.3.x/ksrc/arch/arm/patches/at91.

Ok. Thanks.

IIUC then 2.6.15 was before the introduction of the generic irq layer.

So would these make it easier to port to a newer kernel? Or harder?

Steven

