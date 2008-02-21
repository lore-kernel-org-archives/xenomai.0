Message-ID: <2ff1a98a0802210727g6a08bcdbtfb6c1d9a719c0678@domain.hid>
Date: Thu, 21 Feb 2008 16:27:33 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <47BD41F502000001001927C9@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <47BD41F502000001001927C9@domain.hid>
Subject: Re: [Xenomai-help] Non RT PCI device driver vs interrupts
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Hubert Talbot <Hubert.Talbot@domain.hid>
Cc: xenomai@xenomai.org

On Thu, Feb 21, 2008 at 3:18 PM, Hubert Talbot <Hubert.Talbot@domain.hid> wrote:
> Hi,
>
>  I have a PCI card that works good with a non realtime device driver, I can catch interrupts from it.
>
>  Can I expect to be able to catch interrupts with rt_intr_wait() in a rt task?

Yes, you can intercept an interrupt in a real-time task. However, if
you want your Linux drivers to keep working, you will have to
propagate every interrupt you receive.

>
>  Or, should I have to translate all the PCI device driver into xenomai-rtdm way?
>  (http://www.xenomai.org/index.php/Weblinks#Installation_of_Xenomai_and_RTDM_Driver_Writing)

It really depends, what do you want to do?

-- 
 Gilles Chanteperdrix

