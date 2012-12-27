Message-ID: <50DCC0DD.6030105@xenomai.org>
Date: Thu, 27 Dec 2012 22:42:53 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAFjfccCyg_nbnNB3UGxEbWy3+SV+wp9T5iuj87DBN1Do08C7DQ@mail.gmail.com>
	<loom.20121227T200150-371@post.gmane.org>
	<50DCA303.7090303@xenomai.org>
	<CAAq7VdD_rrspRMqE8MVfLLnwPi+wOj87QedkdiSAto5YBG76Kw@mail.gmail.com>
In-Reply-To: <CAAq7VdD_rrspRMqE8MVfLLnwPi+wOj87QedkdiSAto5YBG76Kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Kernel compilation error due to Adeos patch error in
 'io_apic.c'
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wim Meeussen <wim@hidof.com>
Cc: xenomai@xenomai.org

On 12/27/2012 10:38 PM, Wim Meeussen wrote:

>>> I can confirm that this problem still exists with yesterday's
>>> stable Xenomai release 2.6.2, ipipe-core-3.2.21-x86-2.patch, a vanilla 3.2.21
>>> kernel, ang gcc 4.6.3 on Ubuntu 12.04.
> 
>> Ok, do you have the issue with I-pipe core 3.4 and 3.5 ?
> 
> 
> With Xenomai 2.6.2, ipipe-core-3.5.3-x86-2.patch, linux 3.5.3 and gcc
> 4.6.3, I have a different problem, which I haven't been able to solve
> yet (that's why I started using the older 3.2.21 kernel, and ran into
> the problem described above).
> 
> Running "make CONFIG_DEBUG_SECTION_MISMATCH=y -j4" on the 3.5.3 kernel
> sources gives me the result below.  The
> "CONFIG_DEBUG_SECTION_MISMATCH" parameter was suggested by the
> previous build that failed, to get more information on the failure.
> 
> 
> WARNING: drivers/scsi/fcoe/libfcoe.o(.init.text+0x1e): Section
> mismatch in reference from the function init_module() to the function
> .exit.text:fcoe_transport_exit()
> The function __init init_module() references
> a function __exit fcoe_transport_exit().
> This is often seen when error handling in the init function
> uses functionality in the exit path.
> The fix is often to remove the __exit annotation of
> fcoe_transport_exit() so it may be used outside an exit section.
> 


Are you sure this error is related to xenomai?


-- 
                                                                Gilles.

