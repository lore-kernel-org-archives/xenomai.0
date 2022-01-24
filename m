Message-ID: <3e940124-a34b-3050-bea7-a0ed441585d1@siemens.com>
Date: Mon, 24 Jan 2022 18:28:45 +0100
MIME-Version: 1.0
Subject: Re: Issue with driver-to-driver services
Content-Language: en-US
References: <VI1PR04MB6272E4729403931D1F856C1493599@VI1PR04MB6272.eurprd04.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <VI1PR04MB6272E4729403931D1F856C1493599@VI1PR04MB6272.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Olsen, Niels (INT)" <Niels.Olsen@Teledyne.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 19.01.22 14:28, Olsen, Niels (INT) via Xenomai wrote:
> We are having issues with a Xenomai driver module for a UART chip. The UART
> chip is connected to our i.MX8MN SOC via ECSPI, and I have a Xenomai SPI
> driver for i.MX ECSPI. The stock NXP 'spi-imx' driver is configured out of
> the kernel.
> 
> The Xenomai SPI driver initializes successfully, and after boot there is a
> slave device node available in
> 
>    /dev/rtdm/spi1/slave1.0
> 
> When I modprobe the UART driver, its module_init routine opens the SPI
> device like this:
> 
>    fd = rtdm_open("/dev/rtdm/spi1/slave1.0", O_RDWR);
> 
> which succeeds.
> 
> But when the module init routine then tries to initialize the UART device
> through SPI, the rtdm_ioctl()/rtdm_read()/rtdm_write() calls fail. I have
> traced the cause to be that 'ipipe_root_p' is true. In cobalt/rtdm/fd.c,
> the service routines for ioctl/read/write check 'ipipe_root_p', and when
> true, calls the non-realtime driver ops.
> 
> So, it seems that when loading a realtime driver module with modprobe,
> the init routine is not executing in realtime mode.
> 

This is correct - and required because most initialization stuff is 
provided by Linux and cannot be run in RT.

> Is there something special we need to do in the module init routine, in
> order to switch to realtime mode?

You need an in-kernel RT(DM) task in order to execute RT functions of 
the subordinate device. Or you need a service call from a userspace RT 
task and handle the call from there.

Jan

> 
> Environment:
>   - i.MX8MN eval board
>   - MAX14830 Quad UART eval board
>   - NXP BSP 2.3.3, kernel 5.4.70
>   - Xenomai 3.1.1
> 
> TIA,
> Niels
> 
> Teledyne Confidential; Commercially Sensitive Business Data
> 

-- 
Siemens AG, Technology
Competence Center Embedded Linux

