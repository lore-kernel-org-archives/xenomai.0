Message-ID: <53394F2E.5070801@xenomai.org>
Date: Mon, 31 Mar 2014 13:19:10 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1396262085.387.YahooMailNeo@web171601.mail.ir2.yahoo.com>
In-Reply-To: <1396262085.387.YahooMailNeo@web171601.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] EINTR in notifier.c (mercury)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/31/2014 12:34 PM, Matthias Schneider wrote:
> Hi all,
>
>
> still working on thread suspension in mercury, I noticed that some
>
> threadobj_suspend() and threadobj_resume() calls seemed not to have the desired
>
> effect. Analyzing the issue, I found out that sometimes the read operations on
> the pipe in notifier_wait() seem to return with EINTR, especially in
> heavily loaded systems. Restarting the read system call in that case made
> thread suspension a lot more reliable in my case.
>
> I have attached a patch adding loops to deal with the EINTR situation in all
>
> read and write operations of notifier.c.
>

Agreed, we are reading from a deemed slow device. However, the patch is 
wrong in testing the first loop condition (notifier_sighandler). In 
addition, we don't need two nested loops, a single one would suffice 
with a proper test condition.

Nitpicking: please move all variable declarators to the outer local 
declaration block, and avoid compound braces for single-statement blocks.

-- 
Philippe.

