Message-ID: <47b5efc54278344fcdfe4fc0e1a2c346.squirrel@domain.hid>
In-Reply-To: <217b7eb20811091134h77fbd77bm2e880708b21e5b06@domain.hid>
References: <mailman.10531.1226258953.25037.xenomai@xenomai.org>
	<217b7eb20811091134h77fbd77bm2e880708b21e5b06@domain.hid>
Date: Mon, 10 Nov 2008 12:46:39 +0100 (CET)
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] Xenomai skins init errors
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
> using
> ipipe 1.7 + xenomai 2.4.4. Now migrated to ipipe 1.9 and latest Xenomai
> snapshot. The kernel is 2.6.24. Ipipe seems to OK but getting errors on
> xenomai skins initialization:

Xenomai 2.4.6 is now released, and should contain a patch to be applied to
linux 2.6.26 to add support for IMX31, including high resolution timers.

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

This looks like you do not pass the correct timer name to
ipipe_request_tickdev. The patch included with xenomai 2.4.6 should not
have this issue. See:
http://www.xenomai.org/index.php/I-pipe:ArmPorting#Modifying_Xenomai_headers_to_add_a_new_board
-- 
                    Gilles.


