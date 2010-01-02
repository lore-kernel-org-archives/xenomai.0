Message-ID: <4B3F3C00.4000507@domain.hid>
Date: Sat, 02 Jan 2010 13:28:48 +0100
From: Simon Boulay <simon.boulay@domain.hid>
MIME-Version: 1.0
References: <729c4a400912260654vf4f99d1ta6105bdace1b4098@domain.hid>		<4B3917BF.5070600@domain.hid>	<729c4a400912281740g17ccf7bcn5d2fd7f63e08c2bd@domain.hid>	<4B39BE8D.8060503@domain.hid>
	<4B3B6957.4090901@domain.hid>
In-Reply-To: <4B3B6957.4090901@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Sensoray 526 analogy driver
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi,

On 12/30/2009 03:53 PM, Alessio Margan @ IIT wrote:
> Hi,
>
> I start test the sensoray driver.
Thank you!

> I've got problem with analogy_config :
> 1) it seems that board_name as defined have some problem, changed to
> "a4l_s526" seems better
>
>      #define BOARD_NAME "Sensoray Model 526"
>      ...
>      .board_name = BOARD_NAME
It works with quotes but it's neither handy nor consistent. It'll be 
renamed to analogy_s526.

> 2) I should be able to set as parameters io_port and irq (seems not
> used), using comedi I do comedi_config  /dev/comedi0 s526 0xDC0,0x7
> for the moment I set S526_DEFAULT_ADDRESS to my configuration
> with this modifications seems to work.
The irq parameter is not used. It's not used in comedi either.
For the io_port, the command analogy_config analogy0 analogy_s526 0xdc0 
works for me...

Did you try to acquire data?

Simon.

> analogy_config -v analogy0 a4l_s526
>
> cat /proc/analogy/drivers
> --  Analogy drivers --
> | idx | driver name
> |  00 | a4l_s526
>
> cat /proc/analogy/devices
> --  Analogy devices --
> | idx | status | driver
> |  00 | Linked | a4l_s526
> |  01 | Unused | No driver
> |  02 | Unused | No driver
> |  03 | Unused | No driver
> |  04 | Unused | No driver
> |  05 | Unused | No driver
> |  06 | Unused | No driver
> |  07 | Unused | No driver
> |  08 | Unused | No driver
> |  09 | Unused | No driver
>
> cat /proc/analogy/00-a4l_s526
> --  Subdevices --
> | idx | type
> |  00 | Counter subdevice
> |  01 | Analog input subdevice
> |  02 | Analog output subdevice
> |  03 | Digital input/output subdevice
>
> Alessio
>


