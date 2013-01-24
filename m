Message-ID: <510166D3.8050905@logilin.fr>
Date: Thu, 24 Jan 2013 17:52:35 +0100
From: Christophe Blaess <mailist@logilin.fr>
MIME-Version: 1.0
References: <CALJOq=VtrBhMzCaT=7omDVN9hnnwZ+cmM1_1eff9DTS-fvLjaw@mail.gmail.com>
	<201301200013.09110.paul_c@tuxcnc.org>
	<50FBF628.1000709@xenomai.org>
	<201301220306.28220.paul_c@tuxcnc.org>
In-Reply-To: <201301220306.28220.paul_c@tuxcnc.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] GPIO Interrupts problem with RTDM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 22/01/2013 04:06, Paul wrote:
> On Sunday 20 January 2013, Gilles Chanteperdrix wrote:
>> Yes, this patch is based on 3.5.7 and is used with and without
>> GENERIC_CLOCKEVENTS.
> Short version: Updated my kernel to 3.5.7 and backported the Raspberry
> Pi changes from 3.6.11 and added in the ipipe support. Interrupts are
> not being recognised unless irq_set_irq_type() is called. Digging
> through the rtdm, nucleus, and ipipe code, at no point is
> irq_chip->irq_set_type() called - Also have a problem that none of the
> ipipe_pic_muter fields are set, so __ipipe_enable_irqdesc() & friends
> do nothing.

I'm trying to follow the same steps as you but I still have some 
compilation errors while porting
R-Pi modifications to 3.5.7. (especially arm timer code).

Do you have any available patch against 3.5.7 vanilla kernel ?

I have a working GPIO interrupt rtdm driver with 3.2.21 kernel (Xenomai 
2.6.2) but the interrupt latencies seems terrible (about 20us and 
jiterring up to 150us without any load). To compare with the 7us latency 
I see on a vanilla Linux GPIO interrupt handler.


Regards,

-- 
Christophe

