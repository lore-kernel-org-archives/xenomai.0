Date: Fri, 22 Sep 2017 14:44:41 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20170922144441.3e7cc374@md1em3qc>
In-Reply-To: <CAB6vvjm0GH4kzobZ4c-FdqcARoDDwNFmAJBGOEWESFTwXoJw8Q@mail.gmail.com>
References: <CAB6vvjm0GH4kzobZ4c-FdqcARoDDwNFmAJBGOEWESFTwXoJw8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] MAXSMP prevents booting on 16.04/x64-4.9.38
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Antoine Hoarau <hoarau.robotics@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Am Thu, 21 Sep 2017 12:03:47 +0200
schrieb Antoine Hoarau <hoarau.robotics@gmail.com>:

> Hello,
> 
> After many trials and error, I finally found the option that made both
> of my Ubuntu 16.04/x64 (i7 7500U and 2600K) to hang at Loading initial
> ramdisk.
> 
> CONFIG_MAXSMP
> 
> * Processor type and features
>   --> Enable maximum number of SMP processors and NUMA nodes  
> 
> It seems to be enabled by default on kernel 4.x, and causes the system
> to hang at

No it is not set in an x86_64 defconfig and i also do not see it in
ubuntu 4.4 kernels. Not sure how it got enabled in your config.

Henning

>    x86 : Booting SMP configuration:
>    .... node #0, CPUs:     #1
> 
> I've always built the kernel with the xenomai patch, but I don't think
> the two are related.
> Did any of you had this issue as well ?
> 
> ------
> Antoine Hoarau
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


