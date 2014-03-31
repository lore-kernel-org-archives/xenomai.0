Message-ID: <5339AACA.4090807@xenomai.org>
Date: Mon, 31 Mar 2014 19:50:02 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1396262085.387.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <53395104.6050109@xenomai.org> <53396B31.1090903@xenomai.org>
In-Reply-To: <53396B31.1090903@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/31/2014 03:18 PM, Philippe Gerum wrote:
> On 03/31/2014 01:27 PM, Gilles Chanteperdrix wrote:
>> On 03/31/2014 12:34 PM, Matthias Schneider wrote:
>>> Hi all,
>>>
>>>
>>> still working on thread suspension in mercury, I noticed that some
>>>
>>> threadobj_suspend() and threadobj_resume() calls seemed not to have the desired
>>>
>>> effect. Analyzing the issue, I found out that sometimes the read operations on
>>> the pipe in notifier_wait() seem to return with EINTR, especially in
>>> heavily loaded systems. Restarting the read system call in that case made
>>> thread suspension a lot more reliable in my case.
>>>
>>> I have attached a patch adding loops to deal with the EINTR situation in all
>>
>> You can probably avoid testing for EINTR if all signal handlers are
>> registered with the SA_RESTART flag.
>>
>
> The app may not explicitly care for signals (granted, most would do, but
> we would then have to assume they do it right).
>

Yes, applications may want to use signals to interrupt a call to read 
and voluntarily get EINTR anyway.

-- 
					    Gilles.

