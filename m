Message-ID: <525EB7A2.1050601@xenomai.org>
Date: Wed, 16 Oct 2013 17:58:26 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <525DC044.6090201@steinkuehler.net>	<525E73FB.4060809@xenomai.org>	<525E7ABF.8040403@steinkuehler.net>	<525E7D85.9020307@xenomai.org>
	<525E81CD.6000603@steinkuehler.net>	<525E8665.8000705@steinkuehler.net>
	<525E8A43.5090601@xenomai.org> <525E8BFF.1060201@steinkuehler.net>
	<525EAFFD.3010207@steinkuehler.net>
In-Reply-To: <525EAFFD.3010207@steinkuehler.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Hung task on Xenomai patched ARM 3.8.13 BeagleBone
 Kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Charles Steinkuehler <charles@steinkuehler.net>
Cc: xenomai@xenomai.org

On 10/16/2013 05:25 PM, Charles Steinkuehler wrote:
> On 10/16/2013 7:52 AM, Charles Steinkuehler wrote:
>> Anyway, are there any in-between steps I can test with the kernel that
>> might help isolate what code to go over in the mmc driver?  Anything
>> between "no xenomai patches" and "patched and configured to run xenomai"
>> might potentially be enlightening.
>
> I built and tested a patched kernel that has no xenomai configure
> options enabled:
>
> # CONFIG_XEN is not set

CONFIG_XEN is for Xen, not Xenomai. The interesting steps are:
- CONFIG_IPIPE enabled with CONFIG_XENOMAI disabled
- patched kernel with CONFIG_IPIPE off and CONFIG_XENOMAI off.

In addition to the troubleshooting guide, you may find the following 
documentation useful:
https://www.xenomai.org/index.php/I-pipe-core:ArmPorting

If the issue is not a timer issue, and it does not seem to be, the most 
probable explanation is that either the MMC driver or the interrupt 
controller does not like receiving interrupts while they are masked. In 
this case, you will find that the patched kernel does not work with 
CONFIG_IPIPE but works with CONFIG_IPIPE off and CONFIG_XENOMAI off.
Do you know if the interrupt is level or edge triggered?

Regards.


-- 
					    Gilles.

