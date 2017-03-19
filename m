References: <07fe7fa20faed6e818d33b54db9001b6@stupar.com>
 <adbf2787-6a0e-588e-272e-be15686fc2b7@xenomai.org>
 <ee4b936505fe83420d3e95303ebe6058@stupar.com>
 <ddc23472-e188-5482-be39-dc8f8917eed6@stupar.com>
 <305872a6-028d-64e3-4804-9c46e7407193@xenomai.org>
 <421f62eb9f8a46b605a2f3395c09a8fa@stupar.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <de4792b7-1dfd-b5b4-6043-9db4d72c31c4@xenomai.org>
Date: Sun, 19 Mar 2017 19:22:04 +0100
MIME-Version: 1.0
In-Reply-To: <421f62eb9f8a46b605a2f3395c09a8fa@stupar.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTDM driver init: interrupts and context objects
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: andrija@stupar.com
Cc: xenomai@xenomai.org

On 03/19/2017 07:08 PM, andrija@stupar.com wrote:
> Hi Phillipe,
> 
> I was under the impression that I cannot, since Cobalt is a feature of
> Xenomai 3.x, and I am using Xenomai 2.6.5, where chasing the mode
> switches is a bit more complicated, as explained on the page
> https://xenomai.org//2014/06/finding-spurious-relaxes/
> 
> In any case, the causes of the mode switches that were troubling me were
> obvious, just buried in the code that I have been porting to Xenomai,

It does not seem a mode switch problem, but merely a calling context
issue. There is no mode switch from kernel space, however Xenomai
switches mode automatically at the syscall boundary, as required to keep
the core system sane regardless of how well/bad an application behaves.
Whether such switch is acceptable latency-wise for such application is a
totally different matter.

> and therefore took a while to find (doubtlessly using the debug flag
> would've been easier, but it did not take me weeks - this is not a
> project I work on full time).
> 

The almost equivalent flag for Xenomai 2.6 is CONFIG_XENO_OPT_DEBUG_NUCLEUS.

-- 
Philippe.

