Message-ID: <51228628.20801@xenomai.org>
Date: Mon, 18 Feb 2013 20:51:04 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAPeEhapftuafRVnLOnAT0mcMDu7o_WVBfHFpLAqf_a0DtyxUDQ@mail.gmail.com>
In-Reply-To: <CAPeEhapftuafRVnLOnAT0mcMDu7o_WVBfHFpLAqf_a0DtyxUDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] scheduling class rt reboots system
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: uMinded Strikes Again <iceblu3710@gmail.com>
Cc: xenomai@xenomai.org

On 02/18/2013 05:13 PM, uMinded Strikes Again wrote:

> I have compiled my kernel and it seems to register my ipipe with the
> correct frequency to the system and xenomai begins to start but then the
> system hard reboots and drops me back to u-boot.
> 
> Any idea where I should start?


Try to find the last function called before the reboot by adding printks
all around.

The first things you should suspect is the timer
(ipipe_mach_timer_set_dec). 99% of the problems of porting the I-pipe
patch to a new ARM board are related to hardware timers.

-- 
                                                                Gilles.

