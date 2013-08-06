Message-ID: <520145DA.8030800@xenomai.org>
Date: Tue, 06 Aug 2013 20:52:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CABSOR2gjLVQdXoxdPDHf6kuh-HT-XRPSj42vLP975-q2PR=jkw@mail.gmail.com>
	<51F1820E.4030805@xenomai.org>
	<CABSOR2j5WJAMpJ3Nz-DgTWw1XqmY2QKVrwepNR2jYnp4zF9Uag@mail.gmail.com>
In-Reply-To: <CABSOR2j5WJAMpJ3Nz-DgTWw1XqmY2QKVrwepNR2jYnp4zF9Uag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai application tracing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ILESH PATEL <patelilesh01@gmail.com>
Cc: xenomai@xenomai.org

On 08/06/2013 07:58 AM, ILESH PATEL wrote:
> Hi,
> 
> We are making bench mark of throughput,latency and Bandwidth of network
> with Xenomai.
> We make network of two i5-PC. On which Intel's 10G X-540-T2 NIC card is
> installed on PCIe slot.
> For measuring bench mark we use iperf ,netperf and jperf.
> 
> So I have little-bit of confusion about
> 1.   whatever I test  and measure using iperf and jperf is through real
> time Xenomai or not ?
> 2.   Can we say  this bench-marking is real time bench marking with Xenomai
> ?
> 
> 
> If above is not real time then
> 1.    Can you suggest some way to measure throughput, latency and bandwidth
> of network using 10G NIC as real time using Xenomai.
> 2.    Or any way to use iperf with Xenomai as real time execution for
> measure throughput, latency and bandwidth of network using 10G NIC ?
> 
> 
> On our PC following packages is installed.
> Ubuntu 12.04 with kernel 3.5.1
> Xenomai 2.6.2.1
> NIC driver ixgbe 3.15.1
> iperf 2.0.5
> 
> 
> We have installed iperf as the regular installation method.
> I use the following command to install iperf
> 
> #./configure
> #make
> #make install

Hi,

so no, iperf is not compiled for Xenomai. In order to do real-time
networking with Xenomai, you need:
- a network driver for Xenomai, likely using RTnet
- an application compiled to use Xenomai services, if you want to port
an application using the POSIX API, which is probably the case of iperf,
you may have a look at this guide:
https://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai

Regards.


-- 
                                                                Gilles.

