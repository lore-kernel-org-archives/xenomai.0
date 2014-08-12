Message-ID: <53EA69C7.8080908@xenomai.org>
Date: Tue, 12 Aug 2014 21:23:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <49d17c437c8f4a26b2f7539403af05c4@CVEX13.valentin-carl.de>
In-Reply-To: <49d17c437c8f4a26b2f7539403af05c4@CVEX13.valentin-carl.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] (slave) SPI driver for Am3354...?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Reitinger, Peter" <preitinger@carl-valentin.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 08/12/2014 11:14 AM, Reitinger, Peter wrote:
> Dear Xenomai people,
> 
> as we like to avoid to re-invent the wheel when possible, I'd like to
> ask you if there is a mature spi driver as rtdm driver which enables
> usage of McSPI in slave mode and combined with dma. (A big preloaded
> byte array shall be clocked to the master in an FPGA in eventually
> varying clock speed requested by it up to maximal speed of 48MHz.) Or
> do you think it is a better idea to use the standard Linux SPI
> protocol driver with RT-Preempt patch? I've seen there is the project
> https://github.com/nradulovic/xdrv-spi/. Can anybody recommend it?

I can not really recommend this driver, but it is there, you have the
source, so what do you need to ask the mailing list before testing it?

-- 
                                                                Gilles.

