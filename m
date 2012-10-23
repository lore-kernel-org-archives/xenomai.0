Message-ID: <50862692.4070606@xenomai.org>
Date: Tue, 23 Oct 2012 07:09:38 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <584FFDF8F96BB74593285A7D65886EC01EF7325D@ROCMXUS21.cs.myharris.net>
In-Reply-To: <584FFDF8F96BB74593285A7D65886EC01EF7325D@ROCMXUS21.cs.myharris.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Missed interrupt
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Herrera-Bendezu, Luis" <lherrera@harris.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/22/2012 09:51 PM, Herrera-Bendezu, Luis wrote:
> Hello:
> 
> I am having an issue with RTDM interrupts at the kernel level. The system
> used is as follows:
> CPU: PowerPC 405EX
> Linux: 2.6.30.3
> I-Pipe: 2.7-02
> Xenomai: 2.4.10
> Configuration: config_file (attached)
> 
> There is a periodic interrupt at 16 mSec driven by an FPGA. This interrupt
> is occasionally missed in what appears to be a case of disabled interrupt
> for more than 40 mSec. This problem occurs mostly when flash memory is
> written.
> 
> The RTDM driver registers non-shared IRQ using rtdm_irq_request()
> 
> I had searched Xenomai's mailing list and only found an instance were
> interrupts are disabled in I-Pipe but for version Xenomai 2.6:
> http://www.xenomai.org/pipermail/xenomai-help/2012-03/msg00119.html
> 
> Is there any known issue on version 2.4.10 related to interrupts and/or USB?
> Any recommendations for narrowing the scope of this problem?

Delayed interrupts is an Adeos pipeline issue, not Xenomai per se. If
your IRQ is cascaded, then this is likely the same issue as the URL
mentioned. This has been fixed in recent pipeline patches, but 2.4.10
won't be able to use them.

Unless you can upgrade to Xenomai 2.6.1 over a 3.2 kernel, you are only
left with the option of backporting the fix mentioned below, to your
2.6.30 kernel:
http://www.mail-archive.com/xenomai@xenomai.org/msg00830.html

-- 
Philippe.

