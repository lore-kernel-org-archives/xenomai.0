Message-ID: <52C7CF1E.2050404@xenomai.org>
Date: Sat, 04 Jan 2014 10:06:38 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAFnctWFSGJc0Q6ebZ0zBhxRmFEwkvCYKinAEgD-xzcCbfLaPBg@mail.gmail.com>
In-Reply-To: <CAFnctWFSGJc0Q6ebZ0zBhxRmFEwkvCYKinAEgD-xzcCbfLaPBg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rtdm_task_init call freezes the system
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Nima Nourozi <n.nourozi@gmail.com>, xenomai@xenomai.org

On 01/04/2014 01:48 AM, Nima Nourozi wrote:
> I'm writing an SPI device driver using rtdm skin. If I call rtdm_task_init
> from anywhere in the code the system freezes indefinitely with no errors
> thrown.
>
> Here is how I call the function in __init function of my module:
> retval = rtdm_task_init(&heartbeat_task, "spi_transfer", xx_start_transfer,
> NULL, 99, 100000000);
>
> I'm using xenomai 2.6.1 patched with
> adeos-ipipe-2.6.38.8-arm-1.18-09.patch<http://download.gna.org/adeos/patches/v2.6/arm/adeos-ipipe-2.6.38.8-arm-1.18-09.patch>
> Linux 2.6.38.8 and my compiler is Sourcery G++ Lite 2010q1-202
>
> The rtdm_timer_start function works perfectly so the problem is only with
> the task function.
>
> I've been trying different kernel versions but I get the same result.
>
> I'm attaching the .config file in case there is a setting that's causing
> this issue.
>

Check your own code in xx_start_transfer. It is likely running away, 
locking up the system. Enabling CONFIG_XENO_OPT_WATCHDOG may help.

-- 
Philippe.

