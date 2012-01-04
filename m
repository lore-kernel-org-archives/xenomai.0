Message-ID: <4F04466B.2000609@domain.hid>
Date: Wed, 04 Jan 2012 13:30:35 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <4EF1C18C.3020407@domain.hid>
	<4EF8B4E8.8060003@domain.hid>	<4F02C0A8.5020908@domain.hid>
	<4F036D27.6050800@domain.hid> <4F0424A0.3010206@domain.hid>
In-Reply-To: <4F0424A0.3010206@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai rtcan build issue on MPC5121 (kernel >=
 2.6.35)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fabrice Gasnier <fabrice.gasnier@domain.hid>
Cc: xenomai@xenomai.org

Hi Fabrice,

On 01/04/2012 11:06 AM, Fabrice Gasnier wrote:
> Thanks Gilles.
> 
> I posted some time ago another question that is somehow related to rtcan
> and mpc5121:
> insmod xeno_rtcan_mscan gets stuck on MPC5121
> https://mail.gna.org/public/xenomai-core/2011-09/msg00032.html
> 
> I still have this issue and prepared a re-worked patch that you can find
> attached to this email.
> Can this also be applied?

Looks good. This patch is obviously derived from the MSCAN driver of the
Linux kernel where we know that it works:

  http://lxr.linux.no/#linux+v3.1.7/drivers/net/can/mscan/mscan.c#L62

Just a minor issue:

s/rinit=0/rinit = 0/

Could please send a separate patch inline. I will do some testing on my
MPC5200 and MPC5121 boards later this week.

Thanks,

Wolfgang.

