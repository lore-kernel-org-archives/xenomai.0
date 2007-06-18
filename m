Message-ID: <46763C3D.3080005@domain.hid>
Date: Mon, 18 Jun 2007 10:03:09 +0200
From: Benjamin ZORES <benjamin.zores@domain.hid>
MIME-Version: 1.0
References: <464814D9.8070700@domain.hid>
	<1179135141.5045.53.camel@domain.hid>
In-Reply-To: <1179135141.5045.53.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Adeos for Linux 2.6.19 PowerPC kernels.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org, xenomai@xenomai.org

Philippe Gerum wrote:
> FWIW, I've almost finished an I-pipe port over 2.6.21 also using the
> arch/powerpc tree. It relies on the genirq layer which makes things way
> more comfortable, and which does not require to redefine particular ack
> routines but rather keep the original irqchip handlers.
>
>   
Hello Philippe,

Do you have any news about the 2.6.21 port ?
Is there something that can be tested ?
> This should get better when the I-pipe/powerpc development is merged
> into the main git repo here, which should happen in a reasonable future:
> http://www.denx.de/cgi-bin/gitweb.cgi?p=ipipe-2.6.git;a=summary
>
>   
There's not much about PowerPC arch changes right there.
Is the development stuck ? :-(

Thanks for any news.

Ben

