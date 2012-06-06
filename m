Message-ID: <4FCF1F22.2030203@mail.polimi.it>
Date: Wed, 06 Jun 2012 11:13:06 +0200
From: Danilo De Lorenzo <danilo.delorenzo@mail.polimi.it>
MIME-Version: 1.0
References: <4FCF0FD5.1050201@mail.polimi.it>
	<CA+eKTkb6m22yqmckZusuG+zdzx8pSn1To_hOcgXdEF7ini48sw@mail.gmail.com>
In-Reply-To: <CA+eKTkb6m22yqmckZusuG+zdzx8pSn1To_hOcgXdEF7ini48sw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] analogy attach failed NI-6220
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Hadrien Caron <hadrienstegosaure@gmail.com>
Cc: Xenomai@xenomai.org

Thanks Hadrien,
I've already enabled the analogy driver in the kernel configuration and 
this is confirmed since I have all the analogy and ni modules loaded...

Danilo De Lorenzo, PhD
NearLab - Bioengineering Department
Politecnico di Milano, via Colombo 40, 20133 Milan, Italy
www.nearlab.polimi.it

email: danilo.delorenzo@mail.polimi.it
phone: +39 02-2399-9013
fax: +39 02-2399-9003


On 06/06/2012 10:51 AM, Hadrien Caron wrote:
> Hello Danilo,
>
> I am no expert, but I had a similar issue when I forgot to enable the 
> analogy driver
> in the kernel configuration (through menuconfig for example).
>
> hope it helps,
>
> Hadrien
>
> On Wed, Jun 6, 2012 at 10:07 AM, Danilo De Lorenzo 
> <danilo.delorenzo@mail.polimi.it 
> <mailto:danilo.delorenzo@mail.polimi.it>> wrote:
>
>     Hi,
>     I'm trying to make a NI-6220 acquisition board working with
>     xenomai on a x86_64 patched kernel, but I'm getting the following
>     error when I try to attach the device with the command:
>
>     /usr/xenomai/sbin/analogy_config analogy0 analogy_ni_pcimio 0xc,5
>
>     The error is:
>     analogy_config: attach failed err=-2
>
>     I know that Xenomai is working well since I can run all the
>     examples (latency, etc...).
>
>     The dmesg command gave me only this error:
>     [   69.926138] Analogy: a4l_assign_driver: call(drv->attach)
>     failed (ret=-2)
>
>
>     Thi is the lspci output for the board:
>
>     0c:05.0 Unassigned class [ff00]: National Instruments PCI-6220
>
>     I also checked for shared IRQ, it seems there is no IRQ sharing
>     with other devices and I also tried to change the PCI slot without
>     success.
>
>     Any help is appreciated
>
>
>
>     _______________________________________________
>     Xenomai mailing list
>     Xenomai@xenomai.org <mailto:Xenomai@xenomai.org>
>     http://www.xenomai.org/mailman/listinfo/xenomai
>
>
