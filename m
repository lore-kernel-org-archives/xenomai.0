From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4CA8D713.8090900@domain.hid>
References: <4CA8D713.8090900@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 07 Oct 2010 16:33:38 +0200
Message-ID: <1286462018.13186.44.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] Problem with dm9000 and
 adeos-ipipe-2.6.34-blackfin-1.14-02.patch
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Javier Herrero <jherrero@domain.hid>
Cc: adeos-main@gna.org

On Sun, 2010-10-03 at 21:18 +0200, Javier Herrero wrote:
> Hello,
> 
> I'm trying adeos on a Blackfin BF532 board with a DM9000 ethernet 
> interface. If ethernet is down (cable disconnected) the system boots and 
> works OK, but as soon as the ethernet cable is plugged, the system 
> apparently hangs. After several seconds, a message  dm9000 dm9000.0: 
> status check fail: 226 appears.
> 
> I've read a previous post about problems with dm9000 and an ARM 
> processor, 
> https://mail.gna.org/public/xenomai-help/2010-03/msg00147.html but it 
> seems that there was not a response.
> 

dm9000 is probably not the important issue, what makes a difference is
which kind of IRQ is handled by this device. Knowing about the output
of /proc/interrupts when the pipeline is disabled would help.

You may want to upgrade to this patch as well:
http://download.gna.org/adeos/patches/v2.6/blackfin/older/adeos-ipipe-2.6.34-blackfin-1.15-01.patch


> Thank you very much. Best regards,
> 
> Javier
> 

-- 
Philippe.



