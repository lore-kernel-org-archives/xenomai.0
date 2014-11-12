Date: Wed, 12 Nov 2014 14:45:31 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141112134531.GP17476@sisyphus.hd.free.fr>
References: <314E5ECDAA86314791309FA670550F89C676CD2D@SINTEFEXMBX05.sintef.no>
 <20141111140230.GA17476@sisyphus.hd.free.fr>
 <314E5ECDAA86314791309FA670550F89C676CE2D@SINTEFEXMBX05.sintef.no>
 <314E5ECDAA86314791309FA670550F89C676E884@SINTEFEXMBX05.sintef.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <314E5ECDAA86314791309FA670550F89C676E884@SINTEFEXMBX05.sintef.no>
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

On Wed, Nov 12, 2014 at 12:50:20PM +0000, Terje Frøysa wrote:
> I have now carefully checked your suggestions and other suggestions I received from Charles Steinkuehler at beagleboard forum.
> 
> The UARTs appears to be byte accessible and the UART clock system is running:

It makes sense that the clocks are running when the omap_serial driver
is running. My question was to know whether they were running
without the driver.

> 
> 
> 
> •                    I have checked that the UART dtbo are loaded at boot-time (by uEnv.txt)
> 
> •                    I have built  (and booted) the kernel with the xeno_16550A as loadable module.
> 
> •                    I have checked the functionality of the /dev/ttyOx by running physical loop-back data traffic.
> The sudo cat /proc/tty/driver/OMAP-SERIAL reports the correct amount of traffic and the sent data is echoed correctly in another terminal window.
> 
> •                    I have crawled the /proc/device-tree/ocp/serial* and cannot find any discrepancies.
> 
> 
> 
> Everything seem correct.
> 
> But the UARTs are now occupied by the omap_serial driver.
> 
> According to Xenomai (http://xenomai.org/serial-16550a-driver/) the driver should now be disabled by the setserial command.
> 
> I can't get this command working. It reports the serial port but changing it results in error (regardless of the ttyO -number):
> 
> 
> 
> debian@beaglebone:~$ setserial /dev/ttyO2
> 
> /dev/ttyO2, UART: undefined, Port: 0x0000, IRQ: 74
> 
> 
> 
> debian@beaglebone:/boot$ sudo setserial /dev/ttyO2 uart none
> 
> Cannot set serial info: Invalid argument
> 
> 
> 
> Consequently, I cannot load the xeno_16550A.ko module by modprobe.
> 
> I have browsed the net for the same problem, but have not found relevant subjects.

At first sight, I would say that the omap_serial driver does not
implement the necessary support (probably some ioctls), for what
setserial is trying to do.

I see several ways out:
- implement the missing support in omap serial so that you can use
the "setserial none" command;
- try and use the 8250 driver instead of the omap_serial driver,
since the omap serial devices are 8250 compatible, this driver
supports the necessary ioctls for the "setserial none" command to
work. At some point in time, I know using this serial driver for the
kernel console worked, but I do not know if it was by chance (u-boot
enables the clock, so the driver does not have to enable it), and if
it still works;
- do not enable any uart in the kernel configuration, neither
omap_serial, nor 8250, and arrange for the clocks to be started
before loading the xeno_16550a driver.

-- 
					    Gilles.

