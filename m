Date: Tue, 10 Apr 2018 11:55:40 +0200
Message-ID: <20180410115540.Horde.H294h3JStvJtlChN-M_sesR@webmail.uam.es>
From: Rodrigo Amaducci <rodrigo.amaducci@uam.es>
References: <1c628d16-62c7-bcb5-fe41-2cc9c0a5ebf6@xenomai.org>
 <6m2m4tbt7p9f2b8p30a2ptbt.1523206626964@embeddedgreg.com>
 <20180409115919.Horde.F6jK7go7kRv9owEvxxe7yxw@webmail.uam.es>
 <CALLqZ8SMzQ1ddAje--udcvWqKpUpDtJEPDEwLGWYz+JUXSXTmg@mail.gmail.com>
 <CALLqZ8TrbPvVPGd6PK7M10NNhJQ_FO_-ekhBQ6OR1KTYnOgOhg@mail.gmail.com>
In-Reply-To: <CALLqZ8TrbPvVPGd6PK7M10NNhJQ_FO_-ekhBQ6OR1KTYnOgOhg@mail.gmail.com>
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
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: xenomai@xenomai.org

Quoting Greg Gallagher <greg@embeddedgreg.com>:

> I was able to reproduce the issue, but it only happened if I didn't
> have the driver loaded.  I would try building it as a loadable module
> then load it and confirm it's running using lsmod.  Then run your test
> application.
>
> -Greg

Ok, I manually loaded the module and it works. I just thought that the  
driver was already loaded from boot (as Analogy drivers are, for  
example).

Thank you very much for the help, I'll see now if using XDDP fixes the  
context switching problems.

- Rodrigo




