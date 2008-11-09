Message-ID: <49175FB6.1020105@domain.hid>
Date: Sun, 09 Nov 2008 23:09:58 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <mailman.10531.1226258953.25037.xenomai@xenomai.org>
	<217b7eb20811091134h77fbd77bm2e880708b21e5b06@domain.hid>
In-Reply-To: <217b7eb20811091134h77fbd77bm2e880708b21e5b06@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai skins init errors
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Hank <hank007@domain.hid>
Cc: xenomai@xenomai.org

Hank wrote:
> Hi
> 
> I'm Porting Xenomai to Freescale imx31 platform. Have previously been
> using ipipe 1.7 + xenomai 2.4.4. <http://2.4.4.> Now migrated to ipipe
> 1.9 and latest Xenomai snapshot. The kernel is 2.6.24. <http://2.6.24.>
> Ipipe seems to OK but getting errors on xenomai skins initialization:
> 
> 
> -----------------------------------------------------------
> I-pipe: Domain Xenomai registered.
> 
> Xenomai: hal/arm started.
> 
> Xenomai: real-time nucleus v2.5-devel (Flying In A Blue Dream) loaded.
> 
> Xenomai: native skin init failed, code -38.
> 
> Xenomai: starting POSIX services.
> 
> Xenomai: POSIX skin init failed, code -38.
> 
> Xenomai: RTDM skin init failed, code -38.
> ----------------------------------------------------------
>

A possible explanation could be that Xenomai does not ask for grabbing the right
ARM timer. Sending your .config may help ARM folks here.

> 
> Will appreciate any hint on this one!
> 
> Hank
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.

