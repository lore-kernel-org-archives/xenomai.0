Message-ID: <4D9FB6F3.4010908@domain.hid>
Date: Sat, 09 Apr 2011 03:31:31 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <mailman.5107.1302246791.23203.xenomai@xenomai.org>
	<A651E730-C30A-4DA4-81EE-A4C5C6497BA6@domain.hid>
In-Reply-To: <A651E730-C30A-4DA4-81EE-A4C5C6497BA6@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Total system lockup doing anything real-time
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Nolan Waite <nolan@domain.hid>
Cc: xenomai@xenomai.org

Nolan Waite wrote:
> On 2011-04-08, at 1:13 AM, nolan@domain.hid wrote:
> 
>> I've attached a zip containing the output of dmesg (as run just before running the latency test), the output of `cat /proc/interrupts`, and my kernel .config file. I set up netconsole immediately prior to running the latency test, but received nothing, so I believe the attached kernel log to be whole.
> 
> Sorry, here they are.
> 

The /proc/interrupts is highly suspicious. From your logs we see that
you have many usual peripherals (disks, network card, USB controller,
etc...), but we do not see the interrupt they use in /proc/interrupts.
Are you sure that you show us the full contents of /proc/interrupts?

Also, when running in text mode, please try killing X-window and
unloading the radeon/drm modules.

We would be interested in the results of "lsmod" on your machine too...

-- 
                                                                Gilles.

