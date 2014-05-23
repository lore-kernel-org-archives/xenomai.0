Message-ID: <537FCC33.5030006@xenomai.org>
Date: Sat, 24 May 2014 00:31:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAJX3k=V+ns3H49G+5HuoMjv6+16yeRLXzr=D6dryyQiuVoQ_dA@mail.gmail.com>
In-Reply-To: <CAJX3k=V+ns3H49G+5HuoMjv6+16yeRLXzr=D6dryyQiuVoQ_dA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Troubleshooting Analogy DIO
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Manu S Madhav <manusmad@gmail.com>, xenomai@xenomai.org

On 05/23/2014 11:43 PM, Manu S Madhav wrote:
> Hello all,
> 
> I am running Ubuntu Precise (12.04) with kernel version 3.4.6 and
> xenomai-2.6.2.1. I have a NI PCIe 6259 which I am trying to configure for
> Digital I/O. Currently, the code itself is non-RT, I am trying first to
> figure out how to do I/O as well as obtain counter / quadrature information
> from my DAQ card.
> 
> Using Analogy, and with a bit of reading, I was able to get analog input
> and output up and running without too much trouble, but digital I/O is
> completely evading me. I am just trying to turn on all digital outputs to 1
> using synchronous instruction to the DIO subdevice (#2, in my case). Size
> of the subdevice is 4 (32 bits).
> 
> None of the following attempts worked. From the mailing list archives, I
> found a suggestion to compile xenomai libs with --fno-omit-frame-pointer,
> and that also didn't help. Any suggestions would be appreciated.

I will let others answer this mail, but:
- the bug with omit-frame-pointer was fixed, I believe, in xenomai
2.6.0, or 2.6.1
- 2.6.2.1 is not the latest version, so, please try 2.6.3 before
reporting an issue that may have been fixed since then.

-- 
                                                                Gilles.

