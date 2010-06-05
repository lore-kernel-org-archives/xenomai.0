Message-ID: <4C0ABA8F.8000104@domain.hid>
Date: Sat, 05 Jun 2010 22:58:55 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <4C037798.8070307@domain.hid>	<1275403262-23939-1-git-send-email-P.B.Cheblakov@domain.hid>	<4C051D3F.2030407@domain.hid>
	<4C0A8B94.7020207@domain.hid>
In-Reply-To: <4C0A8B94.7020207@domain.hid>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-core] [PATCH V3] rtcan: add rtcan_plx_pci driver
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 06/05/2010 07:38 PM, Gilles Chanteperdrix wrote:
> P.B.Cheblakov wrote:
>> I'vу merged fixes from Wolfgang for Kconfig and for warnings in this 
>> patch and tested it
> 
> Thanks, but it seems we still have a few build issues:
> - the PCI IDs used by this patch are not available in old kernels

OK, this can to be fixed with some "ifndef ..." lines. What kernel did
make problems?

> - the I-pipe patches no longer apply on some stable releases.

I don't understand this issue? What does it have to do with this driver?

Wolfgang.



