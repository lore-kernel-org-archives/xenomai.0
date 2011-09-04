Message-ID: <4E63E599.5020704@domain.hid>
Date: Sun, 04 Sep 2011 22:54:49 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAHifFDNw2K4oeJALuT9QY2FGURy1ME1tAK2S8dFmyiHwx9QkpQ@mail.gmail.com>
	<CAHifFDM5POqB_2V4n97DXzE5LhZBSNNdOfkB8RrS8E0Go8VT2w@domain.hid>
In-Reply-To: <CAHifFDM5POqB_2V4n97DXzE5LhZBSNNdOfkB8RrS8E0Go8VT2w@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai and iMX28 freescale processor
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Said Syakin <dias.be.ok@domain.hid>
Cc: xenomai@xenomai.org

On 09/04/2011 10:42 PM, Said Syakin wrote:
> Dear all,
> 
> 
> I want to know if xenomai has any support for iMX28 freescale
> processor? If not - what should I do to add it?
> 
> I try to compile the xenomai-patched kernel 2.6.35.3 with
> xenomai-2.5.6 and adeos-ipipe-2.6.35.9-arm-1.18-03.patch from the
> xenomai git repository. During building uImage I got errors:
> 
> In file included from
> 
> /home/dias/work/kernels/linux-2.6.35.3-imx287/kernel/xenomai/arch/generic/hal.c:47:
>
>  
> /home/dias/work/kernels/linux-2.6.35.3-imx287/arch/arm/include/asm/xenomai/hal.h:77:
>
>  error: #error "Unsupported ARM machine"

See:
http://www.xenomai.org/index.php/FAQs#Is_my_embedded_setup_supported_by_Xenomai.3F

-- 
                                                                Gilles.

