Message-ID: <53429F30.4080204@xenomai.org>
Date: Mon, 07 Apr 2014 14:50:56 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1396873278.9042.YahooMailNeo@web163902.mail.gq1.yahoo.com>
In-Reply-To: <1396873278.9042.YahooMailNeo@web163902.mail.gq1.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
To: Huub Van Niekerk <huubvanniekerk@yahoo.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/07/2014 02:21 PM, Huub Van Niekerk wrote:
> Hi,
>
> After struggling with the 3.10.18 kernel on armhf (both with and
> without the patch), I tried the 3.14 kernel and to my delight some
> issues are solved: the clock runs fine again, roscore and top work
> great, while they kept failing on 3.10.18.

I would say you have a timer issue, or perhaps the same issue with 
SD-card as Andreas. Have you tried turning off the options I said Adreas 
to disable yesterday? (dynamic ticks and high res timers)?

When the system is stuck, do you still see the timer interrupt count 
incrementing in /proc/interrupts? Same question for the MMC interrupts.

Since you are the one having the issue, you will have to do the 
investigation. If you do not do that, do not expect the issue to 
magically go away.

> So my question is if (or
> when) there will be a patch for the 3.14 kernel line ?

I work for the I-pipe patch for the ARM architecture on my free time. 
So, I do things when I want to, without any deadline, and certainly not 
under pressure.

-- 
					    Gilles.

