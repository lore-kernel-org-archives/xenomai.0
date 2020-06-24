Subject: Re: Migrating code, rt_dev_*() API missing
References: <DB7PR04MB41555084C23F8CE5E85C5771F3940@DB7PR04MB4155.eurprd04.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <286a1bd0-13bb-8439-29ce-43a599bfe280@siemens.com>
Date: Wed, 24 Jun 2020 08:59:59 +0200
MIME-Version: 1.0
In-Reply-To: <DB7PR04MB41555084C23F8CE5E85C5771F3940@DB7PR04MB4155.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Kristiansen, Morten (INT)" <Morten.Kristiansen@Teledyne.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 23.06.20 16:04, Kristiansen, Morten (INT) via Xenomai wrote:
> I'm in the process of migrating from Xenomai 2.x to 3.1. Our application was using rt_dev_* to access an SPI port. According to the migration guide this class of functions seems to be removed and replaced by the rtdm_* equivalent. However, these functions doesn't seem to exist anywhere in the headers or libraries installed when building.
> 
> Should user space applications use rtdm_* (rtdm_open, rtdm_write) or should they use the native (open, write)
> 
> For reference, this is how I built Xenomai:
> 1.     wget https://xenomai.org/downloads/xenomai/stable/xenomai-3.1.tar.bz2
> 2.     tar -jxf xenomai-3.1.tar.bz2<https://xenomai.org/downloads/xenomai/stable/xenomai-3.1.tar.bz2>
> 3.     mkdir build
> 4.     cd build
> 5.     ../xenomai-3.1/configure CFLAGS="-march=armv7-a -mfpu=vfp3" LDFLAGS="-march=armv7-a -mfpu=vfp3" --build=i686-pc-linux-gnu --host=arm-linux-gnueabihf --with-core=cobalt --enable-smp
> 6.     make
> 7.     mkdir ../xenomai-arm-install
> 8.     make DESTDIR=../xenomai-arm-install install
> 

Use native open & Co. plus the appropriate wrapping as delivered by 
xeno_config for the rtdm 'skin'. If you do not like to wrap, you can use 
__RT(open(...)) etc.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

