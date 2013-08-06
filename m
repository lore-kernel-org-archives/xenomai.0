MIME-Version: 1.0
In-Reply-To: <51F1820E.4030805@xenomai.org>
References: <CABSOR2gjLVQdXoxdPDHf6kuh-HT-XRPSj42vLP975-q2PR=jkw@mail.gmail.com>
	<51F1820E.4030805@xenomai.org>
Date: Tue, 6 Aug 2013 11:28:40 +0530
Message-ID: <CABSOR2j5WJAMpJ3Nz-DgTWw1XqmY2QKVrwepNR2jYnp4zF9Uag@mail.gmail.com>
From: ILESH PATEL <patelilesh01@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Xenomai application tracing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

We are making bench mark of throughput,latency and Bandwidth of network
with Xenomai.
We make network of two i5-PC. On which Intel's 10G X-540-T2 NIC card is
installed on PCIe slot.
For measuring bench mark we use iperf ,netperf and jperf.

So I have little-bit of confusion about
1.   whatever I test  and measure using iperf and jperf is through real
time Xenomai or not ?
2.   Can we say  this bench-marking is real time bench marking with Xenomai
?


If above is not real time then
1.    Can you suggest some way to measure throughput, latency and bandwidth
of network using 10G NIC as real time using Xenomai.
2.    Or any way to use iperf with Xenomai as real time execution for
measure throughput, latency and bandwidth of network using 10G NIC ?


On our PC following packages is installed.
Ubuntu 12.04 with kernel 3.5.1
Xenomai 2.6.2.1
NIC driver ixgbe 3.15.1
iperf 2.0.5


We have installed iperf as the regular installation method.
I use the following command to install iperf

#./configure
#make
#make install




On Fri, Jul 26, 2013 at 1:22 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 07/20/2013 04:59 PM, ILESH PATEL wrote:
>
>  Hi,
>>
>> I used iperf network testing utility on my network.
>> My PC is configured with ubuntu 12.04 with Xenomai 2.6.2.1
>>
>> So, I want to know iperf utility is running with real time environment
>> path
>> or non real time environment path.
>>
>> Please Give me hits tracing application.
>> So, I can know this application response is real time or non real time.
>>
>
>
> It is a bit hard to know what you are testing, I mean you compiled iperf,
> we have no idea how you compiled it. So, to be safe, we will say, no,
> probably not, iperf is not using xenomai services.
>
> --
>                                                                 Gilles.
>
