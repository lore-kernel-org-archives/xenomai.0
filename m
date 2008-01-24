Message-ID: <2ff1a98a0801240447p304a538ald27d1f05e7bae1b7@domain.hid>
Date: Thu, 24 Jan 2008 13:47:26 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <d3f72a390801240307r5156b4dbk7b2bfdb4515c3a85@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d3f72a390801240307r5156b4dbk7b2bfdb4515c3a85@domain.hid>
Subject: Re: [Xenomai-core] SET PERIODIC MODE
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: axel axel <softaxel@domain.hid>
Cc: xenomai@xenomai.org

On Jan 24, 2008 12:07 PM, axel axel <softaxel@domain.hid> wrote:
> Hi,
>
> how can i change  xenomai  aperiodic timer to periodic ?
>
> I explain better:
> I have only to render the hardware timer periodic or there is a flag in
> xenomai to set, or i have to rebuild xenomai, or other ?

You can fix a period in the linux kernel configuration menu of
whatever skin you are using. In this case you have to rebuild your
kernel.

Each skin module accepts a parameter allowing to fix the timer period.
In this case you have to rmmod the module, then re-run insmod with the
new parameter, or pass different kernel arguments if the skin is built
inside the kernel and not compiled as a module.

The native skin has a function, rt_timer_set_mode which allows to set
its period.

The last two methods being documented.

-- 
                                               Gilles Chanteperdrix

