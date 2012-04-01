Message-ID: <4F78D378.6000501@domain.hid>
Date: Mon, 02 Apr 2012 00:15:20 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F68BDBF.2030002@domain.hid>
In-Reply-To: <4F68BDBF.2030002@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] CAN: Locked in rtdm_sem_timeddown of tx_sem;
 Lost TX IRQ ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Thierry Bultel <thierry.bultel@domain.hid>
Cc: xenomai@xenomai.org, Jean-Baptiste Tredez <jean-baptiste.tredez@domain.hid>

On 03/20/2012 06:26 PM, Thierry Bultel wrote:
> Hello,
> 
> the issue I am describing here happens on a dual-core Atom (without 
> hyperthreading)
> 
> It is easy to reproduce with 2.6.32.7+xenomai 2.5.2, which was my 
> initial configuration until
> I remembered that Philippe told us that SMP was correctly supported from 
> 2.6.38.8
> 
> The fact is that I have been able to reproduce it with 
> 2.6.38.8+xenomai-2.6 as well. Only once, but I did.
> 
> I am using CAN with a IXXAT PCI-04 board .
> There is a single thread per bus.
> 
> With the old kernel, after about 400-500 seconds, and heavy load the 
> communication stops, and after some
> analysis, I found out that my process was stuck at :
> 
> rtcan_raw.c
> 
>    /* Try to pass the guard in order to access the controller */
> *  ret = rtdm_sem_timeddown(&dev->tx_sem, timeout, NULL);*
> 
> 
> The Refcount shown in /proc/rtcan/rtcan0/info is 1.
> 
> The workaround I found was to set the timeout to a non-zero value with 
> the appropriate ioctl,
> and when a timeout issues, to stop and restart the bus, with the effect 
> to destroy and re-recreate the semaphore and
> thus to communicate again.
> 
> By reading the code, the only reason I can see is that a TX interrupt is 
> lost.
> 
> I do not have much more ways to analyze deeper, so any advice would be 
> greatly appreciated

Have you tried xenomai 2.5.6 ?

-- 
                                                                Gilles.

