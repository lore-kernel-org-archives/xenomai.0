Date: Mon, 11 Jan 2016 15:55:36 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160111145536.GB853@hermes.click-hack.org>
References: <D9EDB4F689BF9F4EA6F2158A073942732E7C9E64@de08ex3008.global.ds.honeywell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9EDB4F689BF9F4EA6F2158A073942732E7C9E64@de08ex3008.global.ds.honeywell.com>
Subject: Re: [Xenomai] Test program not accessing RTDM driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Heinick, J Michael" <Michael.Heinick@Honeywell.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Jan 11, 2016 at 02:33:58PM +0000, Heinick, J Michael wrote:
> 
> .........1.........2.........3.........4.........5.........6.........7....|
> 
> Currently, I have a RTDM driver that installs with insmod, creates the
> node in /dev/rtdm, uninstalls with rmmod, and removes the node from
> /dev/rtdm.  At this early stage this RTDM driver is only a skeleton that
> should log a message with rtdm_printk whenever the open, close, read,
> write, and ioctl handlers are called. So far I have been unable to get
> any indication that any of the handlers I have written for the driver are
> interacting with the small test program even though the program appears to
> run without errors.
> 
> The ioctl call in the test program generates the following message in the
> dmesg file:
> 
> [12503.672657] [Xenomai] tcgrtdmtest[3595] called regular ioctl() on /dev/rtdm/tcgrtdm
> 
> The example at http://git.xenomai.org/xenomai-jro.git/tree/demo/posix/cobalt/gpiopwm.c?h=410c
> recently suggested by Jorge Ramirez Ortiz has been somewhat helpful, but
> I still do not know what I am missing.  Are my rtdm_device and
> rtdm_driver structures correct enough to get the handlers called, or is the
> problem elsewhere?
> 
> Thanks for any help that you can provide.
> Mike H.
> 
> Additional details on our situation are included below:
> 
> The code: vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
> // ------------- tcgrtdmtest.c -----------
> #include <xenomai/init.h>
> #include <rtdm/rtdm.h>
> #include <stdlib.h>
> #include <errno.h>
> #include <error.h>
> #include <stdio.h>
> 
> int main()
>   {
>   int fd;
>   unsigned int rply;
>   rply = 987; // =0x3DB
>   fd = open("/dev/rtdm/tcgrtdm",O_RDWR);

What happens if you try open("/dev/tcgrtdm", ...) ?

-- 
					    Gilles.
https://click-hack.org

