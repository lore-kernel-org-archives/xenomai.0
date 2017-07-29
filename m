References: <CADXNiGXcYVk8JUDv24_TVLtvRQ=hJaaSiMzwQPct5V92U-jGYw@mail.gmail.com>
 <640d22cb-ac74-6702-8c15-76ace5732262@xenomai.org>
 <CADXNiGW4EB96ovgEqutmYthLS9rk9paHGj0BGQG_dZCmiB2S6Q@mail.gmail.com>
 <CADXNiGW83FQPkVvdsdYzNSjVHmE0pL1YbxuNVpC4bd3uZJBN1g@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <4d7df01d-e90b-2598-6424-7336732c2be5@xenomai.org>
Date: Sat, 29 Jul 2017 10:41:01 +0200
MIME-Version: 1.0
In-Reply-To: <CADXNiGW83FQPkVvdsdYzNSjVHmE0pL1YbxuNVpC4bd3uZJBN1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] real-time spi driver for imx6
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jackson Jones <jackson.jones@gmail.com>, xenomai@xenomai.org

On 07/29/2017 04:51 AM, Jackson Jones wrote:
> Fixed some dumb build errors, did some cleanup on the driver. Built the
> driver as a module, it loads but does nothing. It is probably not finding
> the spi device.
> 
> Using Xenomai 3.0.5.
> 
> Attaching the .dtsi so show what pins the spidev is mapped to.

Check the "compatible" string in the Xenomai SPI core, it looks for
"rtdm-spidev" slave devices to talk to, not "spidev" like the regular
driver does.

-- 
Philippe.

