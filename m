Message-ID: <5294847D.3030501@xenomai.org>
Date: Tue, 26 Nov 2013 12:22:37 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1385464837.54248.YahooMailNeo@web122606.mail.ne1.yahoo.com>
In-Reply-To: <1385464837.54248.YahooMailNeo@web122606.mail.ne1.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] mmap and domain switch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giuseppe Iellamo <peppedx@gmail.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 11/26/2013 12:20 PM, Giuseppe Iellamo wrote:
> Hi all,
>
> In my project I'm accessing a device using a linux device driver (via sysfs) . In order to speedup the control loop I've mmapped the register i need to read. The question is: If I access a device register using mmap

assuming you mean "mmaped memory" here,

  from a xenomai task am i triggering a domain switch ?
>

No, unless you take a fault doing so, which should not happen if the MMR 
is properly mapped/accessed.

> BR,
> Giuseppe
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>


-- 
Philippe.

