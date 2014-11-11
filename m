Date: Tue, 11 Nov 2014 14:49:57 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141111134957.GZ17476@sisyphus.hd.free.fr>
References: <314E5ECDAA86314791309FA670550F89C676CD2D@SINTEFEXMBX05.sintef.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <314E5ECDAA86314791309FA670550F89C676CD2D@SINTEFEXMBX05.sintef.no>
Subject: Re: [Xenomai] xeno_16550A driver install problems.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Terje =?utf-8?Q?Fr=C3=B8ysa?= <Terje.Froysa@sintef.no>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On Tue, Nov 11, 2014 at 01:31:33PM +0000, Terje Frøysa wrote:
> Dear forum,
> 
> I have struggled for 4 days and I am out of ideas/suggestions on how to make this xeno_16550A driver work.
> 
> I have successfully installed the Xenomai 2.6.4 and the Debian 3.8.13.
> Self-developed RTDM driver is working satisfactory.
> But installing the xeno_16550A driver (kernel install) is giving me a headache.
> 
> First a fight to find the correct syntax for the uEnv.txt kernel parameters (example show setting of only one parameter):
> cmdline=xeno_16550A.mem=0x48022001,0x48024000,0x481a6000,0x481a8000,0x481aa000 \
>         xeno_16550A.irq=73,74,44,45,46 \
>         xeno_16550A.baud_base=115200,115200,115200,115200,115200 \
>         xeno_16550A.tx_fifo=64,64,64,64,64 \
>         xeno_16550A.start_index=1
> The kernel parameters is correctly stored in the /sys/module/xeno_16550A/parameters.
> The Debian boots as long as the irq=0,0,0,0,0
> 
> BUT, at the moment I specify correct irq numbers, the boot-process crashes (see boot-log below).
> 
> I have disabled the CONFIG_SERIAL_OMAP without result.
> I have disabled the serial8250 driver that occupies the ttySx UARTS, but the kernel still crashes as soon as the irq is set <> 0.
> 

The xeno_16550A driver uses byte access, have you checked the AM33xx
TRM to check that this is valid?

-- 
					    Gilles.

