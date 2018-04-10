Date: Tue, 10 Apr 2018 12:58:31 +0200
Message-ID: <20180410125831.Horde.X7v7Wl0ey8ipkTILVqw0H3Q@webmail.uam.es>
From: Rodrigo Amaducci <rodrigo.amaducci@uam.es>
References: <1c628d16-62c7-bcb5-fe41-2cc9c0a5ebf6@xenomai.org>
 <6m2m4tbt7p9f2b8p30a2ptbt.1523206626964@embeddedgreg.com>
 <20180409115919.Horde.F6jK7go7kRv9owEvxxe7yxw@webmail.uam.es>
 <CALLqZ8SMzQ1ddAje--udcvWqKpUpDtJEPDEwLGWYz+JUXSXTmg@mail.gmail.com>
 <CALLqZ8TrbPvVPGd6PK7M10NNhJQ_FO_-ekhBQ6OR1KTYnOgOhg@mail.gmail.com>
 <20180410115540.Horde.H294h3JStvJtlChN-M_sesR@webmail.uam.es>
In-Reply-To: <20180410115540.Horde.H294h3JStvJtlChN-M_sesR@webmail.uam.es>
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Subject: Re: [Xenomai] Context switching with POSIX skin
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>, rpm@xenomai.org
Cc: xenomai@xenomai.org

Quoting Rodrigo Amaducci <rodrigo.amaducci@uam.es>:
>
> Ok, I manually loaded the module and it works. I just thought that  
> the driver was already loaded from boot (as Analogy drivers are, for  
> example).
>
> Thank you very much for the help, I'll see now if using XDDP fixes  
> the context switching problems.
>
> - Rodrigo

I'm trying to understand the XDDP example and I have a couple of questions:

- Why is there not context switch in the real-time thread if it is  
using printf?
- In the documentation I can see that there is a wrapper for sendmsg,  
so sendto can be used too, since it calls sendmsg, without leaving  
primary-mode?

I'm checking the context switches in /proc/xenomai/sched/stat, looking  
the MSW value. What do the other columns (CSW, XSC, etc) mean?

- Rodrigo




