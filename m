MIME-Version: 1.0
References: <VI1PR04MB4046410C26B84A6DD10C57ADF3519@VI1PR04MB4046.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB4046410C26B84A6DD10C57ADF3519@VI1PR04MB4046.eurprd04.prod.outlook.com>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Tue, 11 Jan 2022 18:08:56 +0100
Message-ID: <CAFc1U0vuQ636hqxd1EJRBqZLC8RwNXB1S800QExqjo6Ro_wenA@mail.gmail.com>
Subject: Re: IMX8M Nano crash
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Kristiansen, Morten (INT)" <Morten.Kristiansen@teledyne.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

What is the kernel version provided by NXP ? Is 5.4.152 an updated version =
?

Le mar. 11 janv. 2022 =C3=A0 16:37, Kristiansen, Morten (INT) via Xenomai <
xenomai@xenomai.org> a =C3=A9crit :

> I have a problem with a kernel lockup. It freeze without any messages on
> the console. It also stop responding to ping. The freeze happens more
> frequent (i.e. faster after boot) with higher CPU load.
>
> The Linux kernel and u-boot are built by hand from Vanilla source code.
>
> Linux-5.4.152
> Xenomai-3.2.2
> U-boot 2020.04
> CPU is IMX8MN (quad core ARM64) on NXP evaluation board 8MNANOD4-EVK.
> Use RT driver for IMX serial port that comes with Xenomai.
>
> To narrow down the problem I'm only running on one core (Passed nosmp as
> kernel arg).
>
> I have a JTAG connection using OpenOCD-0.11. When it locks up I can break
> execution and inspect registers, etc. What I've found is the core is
> looping over three instructions. To mee it seems the location is in user
> space and exceptions are not raised - but I'm still reading on the ARM64
> architecture. When it freeze and I halt the processor, OpenOCD writes:
>
> imx8mn.a53.0 cluster 0 core 0 multi core
> imx8mn.a53.0 halted in AArch64 state due to debug-request, current mode:
> EL0T
> cpsr: 0x80000000 pc: 0xffff8aa4131c
> MMU: enabled, D-Cache: enabled, I-Cache: enabled
>
> I have the same problem on Xenoma-3.2.1 and on the Linux kernel supplied
> from NXP for the board, patched with Xenomai. The problem is also
> demonstrated on a slightly different evaluation board (8MNANOLPD4-EVK).
>
> For troubleshooting I've written a Stress module. All it does is introduc=
e
> switching between Xenomai threads using RT_MUTEX and 100 us delay
> (rt_task_sleep). This greatly reduce the stability where a crash will
> happen with 30-60 seconds. Removing the stress module and disabling other
> activities such as processing of data, network traffic will increase
> stability to 1-2 hours before a crash.
>
> Any suggestions?
>
>
> /Morten Kristiansen
>
>
> Teledyne Confidential; Commercially Sensitive Business Data
>


--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
