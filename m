References: <1396873278.9042.YahooMailNeo@web163902.mail.gq1.yahoo.com>
 <53429F30.4080204@xenomai.org>
Message-ID: <1396961235.36322.YahooMailNeo@web163901.mail.gq1.yahoo.com>
Date: Tue, 8 Apr 2014 05:47:15 -0700 (PDT)
From: Huub Van Niekerk <huubvanniekerk@yahoo.com>
In-Reply-To: <53429F30.4080204@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Xenomai] patch for 3.14 kernel ?
Reply-To: Huub Van Niekerk <huubvanniekerk@yahoo.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Monday, April 7, 2014 2:51 PM, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
 
On 04/07/2014 02:21 PM, Huub Van Niekerk wrote:
> Hi,
>
> After struggling with the 3.10.18 kernel on armhf (both with and
> without the patch), I tried the 3.14 kernel and to my delight some
> issues are solved: the clock runs fine again, roscore and top work
> great, while they kept failing on 3.10.18.

>I would say you have a timer issue, or perhaps the same issue with 
>SD-card as Andreas. Have you tried turning off the options I said Adreas 
>to disable yesterday? (dynamic ticks and high res timers)?

>When the system is stuck, do you still see the timer interrupt count 
>incrementing in /proc/interrupts? Same question for the MMC interrupts.

>Since you are the one having the issue, you will have to do the 
>investigation. If you do not do that, do not expect the issue to 
>magically go away.


> So my question is if (or
> when) there will be a patch for the 3.14 kernel line ?

>I work for the I-pipe patch for the ARM architecture on my free time. 
>So, I do things when I want to, without any deadline, and certainly not 
>under pressure.

Right now I can't test anything under the 3.10.18 kernel since for some weird reason (which has nothing to do with Xenomai) my network and USB (combined on my board) is off. With the same configuration file, the 3.14 kernel works fine. 
