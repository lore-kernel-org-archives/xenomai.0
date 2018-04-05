Date: Thu, 05 Apr 2018 15:25:18 +0200
Message-ID: <20180405152518.Horde.-CDL8q6su7PhMYoQTU0iWhp@webmail.uam.es>
From: rodrigo.amaducci@uam.es
References: <20180402162629.Horde.aGvVeyDe3lwwFExaCtLehqi@webmail.uam.es>
 <CALLqZ8TSMOAt0hVKf9UWBVwp4t2LWKkLYOjAWyhywLHAc5oFRg@mail.gmail.com>
 <d5181033-d020-34bb-8b1b-8a261c885f75@xenomai.org>
 <20180403122123.Horde.D2Qo7ce4c1LHdQcBYRZNBmd@webmail.uam.es>
 <53039d03-c118-3c20-e7cd-eefc264919d7@xenomai.org>
In-Reply-To: <53039d03-c118-3c20-e7cd-eefc264919d7@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>, greg@embeddedgreg.com
Cc: xenomai@xenomai.org

Quoting Philippe Gerum <rpm@xenomai.org>:
>
> You need to enable the ipc/xddp driver (CONFIG_XENO_DRIVERS_RTIPC_XDDP)
> in your kernel.
>
> --
> Philippe.

I have recompiled my kernel a couple of times activating all the RTIPC  
drivers but I'm still getting the same error when running xddp-echo.

Rodrigo






