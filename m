Message-ID: <4FFED404.4030703@grandegger.com>
Date: Thu, 12 Jul 2012 15:41:24 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
References: <fd35ecb7304a.4ffd9779@pwr.wroc.pl>
In-Reply-To: <fd35ecb7304a.4ffd9779@pwr.wroc.pl>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai FlexCAN driver - where to start?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Tomasz Guszkowski <tomasz.guszkowski@pwr.wroc.pl>
Cc: xenomai@xenomai.org

On 07/11/2012 03:10 PM, Tomasz Guszkowski wrote:
> Hello!
> 
> I am to write a MPC8309 (powerpc made by Freescale) FlexCAN driver for Xenomai. I have a working non-RT driver for this machine. Xenomai 2.6.0 works flawlessly as far I can assess it.
> 
> I have started converting a non-RT version of the driver to rtdm (rtcan) API and after some time spent on it I have an impression it will last a good while. (I am new to Xenomai driver development.)
> 
> I have also analyzed mscan and sja1000 drivers and the conclusion is that RT and non-RT versions have almost no common parts, at least meld can't easily point them.
> 
> So the questions are:
> 
> What is the preferrable starting point for writing Xenomai CAN driver? 
> Is my path (non-RT driver -> rtdm/rtcan driver) optimal? 
> Does there exist a better way, for example a kind of a "template" for filling up with some HW-specific code?
> Now I think about trying to use a crippled mscan version as a template, despite the fact that mscan and FlexCAN have no common parts besides using Flattened Device Tree for HW description.Is this a good idea?
> 
> Any hints are welcomed.

You need to use bit and pieces out of both driver sources. From the
SJA1000 or MSCAN RTCAN driver we take the RTDM framework and RTCAN API
calls and from Linux's flexcan.c we take the platform code and the init,
config tx and rx code. But there are some distinct differences:

- The RTDM driver does not use deferred interrupt handling (napi)
- The API for mode and bitrate setting is different including bittime
  calculation.
- and even more ...

Today and tomorrow I'm out of office. I will have a closer look next
week. Maybe I find the time to implement a first test version.

Wolfgang.

