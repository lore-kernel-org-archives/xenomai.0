MIME-Version: 1.0
Sender: alexis.berlemont@domain.hid
In-Reply-To: <9c789a000906160810s77ceb784xb3a0d8320d210a7c@domain.hid>
References: <9c789a000906160810s77ceb784xb3a0d8320d210a7c@domain.hid>
Date: Tue, 16 Jun 2009 18:06:48 +0200
Message-ID: <72cf3fb0906160906y3171cd79q4fb92a836e4a54b9@domain.hid>
From: Alexis Berlemont <berlemont.hauw@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Driver testing procedure ?!
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Cristian Axenie <cristian.axenie@domain.hid>
Cc: xenomai@xenomai.org

Hi,

On Tue, Jun 16, 2009 at 5:10 PM, Cristian
Axenie<cristian.axenie@domain.hid> wrote:
> Hi !
> I've got a snapshot of the current git update but I still receive some
> errors! Now the kernel is stable and doesn't crashes anymore but it seems
> that there is a problem with attaching a driver !
>
> Here's the output !
>
> /usr/xenomai/sbin # ./comedi_config comedi0 comedi_pcimio
> PCI: Unable to reserve mem region #1:1000@domain.hid for device 0000:00:10.0
> Comedi: comedi_pcimio: pcmio_attach: error setting up mite
> Comedi: comedi_assign_driver: call(drv->attach) failed (ret=-5)
> comedi_config: comedi_snd_attach failed ret=-5
>

Thank you for the feedback. The error message is quite clear.

Could you send a dump of the command "cat /proc/iomem" on your board?

Alexis.

