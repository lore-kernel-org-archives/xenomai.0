Message-ID: <45FE5132.30203@domain.hid>
Date: Mon, 19 Mar 2007 10:00:34 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] question
References: <35481f3d0703160950t6100f375o169a0cfd7bd9e9b8@domain.hid>	
	<17917.21994.572525.93172@domain.hid>
	<35481f3d0703190139r52764f23r71caf0be1cdd816e@domain.hid>
In-Reply-To: <35481f3d0703190139r52764f23r71caf0be1cdd816e@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xd yang <yangxd614@domain.hid>
Cc: xenomai@xenomai.org

xd yang wrote:
> Hi, Gilles:
>    thanks very much for your answers, i really appreciate it.
>    I would like to give you more descriptions of my problem  in case if
> you could give me more advices.The thing is i have a certain  device 
> with a dsp in it which is connected by PCI port with PC. And a driver
> for that device will be  implemented in Xenomai kernel layer, and i need
> another application in linux user space to pass some commande to the DSP
> or receive some messages from the device. So that i need to implement a
> linux driver in standard  linux kernel layer to connect the linux user
> space application and the Xenomai device driver.  How  could i realise
> it in this situation? could you give me some suggestions? thanks a
> lot,have a good day.
>         |

The RTDM API allow you to write drivers that may be accessed both from
real-time and non real-time contexts. So, you only have to write your
driver with the RTDM API and you will be able to access it from
real-time as well as non real-time application.

-- 
                                                 Gilles Chanteperdrix

