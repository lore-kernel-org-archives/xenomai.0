Message-ID: <4D2E280B.1060308@domain.hid>
Date: Wed, 12 Jan 2011 23:15:39 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <6FCCA913376DD7488F4139A4D11B8F48016311A5@domain.hid>	<4D1FAE66.8080005@domain.hid>	<6FCCA913376DD7488F4139A4D11B8F4801673CAB@troe2k1.cs.myharris.net>	<4D24E3AC.2000904@domain.hid>
	<4D24EB92.3050104@domain.hid>	<4D24F0B7.7010604@domain.hid>	<6FCCA913376DD7488F4139A4D11B8F4801673CD4@domain.hid>
	<4D25C9D6.4030707@domain.hid> <4D2CE77C.7000109@domain.hid>
	<6FCCA913376DD7488F4139A4D11B8F4801674163@domain.hid>
	<4D2DAE16.2060805@domain.hid>
	<6FCCA913376DD7488F4139A4D11B8F48016741A9@domain.hid>
	<4D2DD61E.7000006@domain.hid>
	<6FCCA913376DD7488F4139A4D11B8F48016741F6@domain.hid>
	<4D2E10E4.7040608@domain.hid>
	<6FCCA913376DD7488F4139A4D11B8F4801674280@domain.hid>
In-Reply-To: <6FCCA913376DD7488F4139A4D11B8F4801674280@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [Xenomai -help] User space access to DMA memory
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Herrera-Bendezu, Luis" <lherrera@domain.hid>
Cc: xenomai@xenomai.org

Herrera-Bendezu, Luis wrote:
> 
> I am using PPC405 processor which does not support snooping and yes
> CONFIG_NOT_COHERENT_CACHE is defined. But I still need to make memory
> consistent (dma_sync_single_*) after each DMA transfer.

That is because the memory is mapped cacheable in user-space. You need
the path which sets the vma protection to non-cacheable, but add an
rtdm_iomap_noncacheable_to_user function.
-- 
                                                                Gilles.

