MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Sun, 19 Mar 2017 14:08:05 -0400
From: andrija@stupar.com
In-Reply-To: <305872a6-028d-64e3-4804-9c46e7407193@xenomai.org>
References: <07fe7fa20faed6e818d33b54db9001b6@stupar.com>
 <adbf2787-6a0e-588e-272e-be15686fc2b7@xenomai.org>
 <ee4b936505fe83420d3e95303ebe6058@stupar.com>
 <ddc23472-e188-5482-be39-dc8f8917eed6@stupar.com>
 <305872a6-028d-64e3-4804-9c46e7407193@xenomai.org>
Message-ID: <421f62eb9f8a46b605a2f3395c09a8fa@stupar.com>
Sender: andrija@stupar.com
Subject: Re: [Xenomai] RTDM driver init: interrupts and context objects
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Hi Phillipe,

I was under the impression that I cannot, since Cobalt is a feature of 
Xenomai 3.x, and I am using Xenomai 2.6.5, where chasing the mode 
switches is a bit more complicated, as explained on the page 
https://xenomai.org//2014/06/finding-spurious-relaxes/

In any case, the causes of the mode switches that were troubling me were 
obvious, just buried in the code that I have been porting to Xenomai, 
and therefore took a while to find (doubtlessly using the debug flag 
would've been easier, but it did not take me weeks - this is not a 
project I work on full time).

Thanks,

Andrija

On 2017-03-19 05:51, Philippe Gerum wrote:

> 
> Actually, it does something wrong. You should always enable
> CONFIG_XENO_DEBUG_COBALT to detect those spurious call sites.

