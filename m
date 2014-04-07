Message-ID: <5342A4C7.5080700@xenomai.org>
Date: Mon, 07 Apr 2014 15:14:47 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1396873278.9042.YahooMailNeo@web163902.mail.gq1.yahoo.com>
In-Reply-To: <1396873278.9042.YahooMailNeo@web163902.mail.gq1.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] patch for 3.14 kernel ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Huub Van Niekerk <huubvanniekerk@yahoo.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/07/2014 02:21 PM, Huub Van Niekerk wrote:
> Hi,
>
> After struggling with the 3.10.18 kernel on armhf (both with and without the patch), I tried the 3.14 kernel and to my delight some issues are solved: the clock runs fine again, roscore and top work great, while they kept failing on 3.10.18. So my question is if (or when) there will be a patch for the 3.14 kernel line ?
>

raw/ipipe-3.14.0 is currently work in progress. ppc6xx and x86 32/64 
boot and run the basic tests here, but mainline is so much in a state of 
flux for ARM with the dt introduction, that Gilles needs time to fix up 
the pipeline for several SoCs. He's enduring most of the pain these days 
when it comes to upgrading to recent kernel releases, even worse than I 
used to suffer for x86 a few years ago, so please be patient.

We will keep the list posted.

-- 
Philippe.

