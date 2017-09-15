MIME-Version: 1.0
References: <CAB6vvjke_16vivYH6+6QJiDR__5zcUBihvAe5+0S+CVKt1Qx8g@mail.gmail.com>
 <cda6fe24-2a17-03af-b6b0-58b63dc82a82@xenomai.org>
 <CAB6vvjno8Ysd6k7fKpEkyfU-S+myKNd517ju0-X0nAOiQPJMPw@mail.gmail.com>
 <16d2a2b6-388b-bbe8-6196-397735d5b2cb@xenomai.org>
 <CAB6vvjmJX9P8c=bAdb7n3Li2WUx=m9xgdZrkYhKF0CeRsAZjbA@mail.gmail.com>
 <657caa04-19cf-45ef-ca86-0e73daf7fabc@isir.upmc.fr>
In-Reply-To: <657caa04-19cf-45ef-ca86-0e73daf7fabc@isir.upmc.fr>
From: "Stephen D. Cohen" <steve@uscohens.com>
Date: Fri, 15 Sep 2017 00:37:00 +0000
Message-ID: <CAO460_8tfyQ0iPEPjPv8C4in0WhGGsk-LqdU662Pwtu9eW1Mkw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] Can't wait on conditions on 3.0.5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On Thu, Sep 14, 2017 at 2:13 PM Florian Richer <richer@isir.upmc.fr> wrote:

> Working as expected on my box (Beaglebone black, xeno 3.0.4 on linux
> 4.4.68) :
>
> rt_mutex_create -> 0
> rt_cond_create  -> 0
> rt_task_spawn   -> 0
> rt_cond_wait_until took 9998937664 ticks, ret -110
> rt_task_join    -> 0
>
> Maybe something is wrong with your kernel config ?
>

Not working on another 64-bit SMP kernel, though 4.4.71 in my case.
Substantially similar results to those shown by the original poster. I also
tried passing a timespec to rt_cond_wait_timed and got the same result - no
wait and a timeout report. Absolutely bizarre.

This might also be a good time to mention that I had similar issues when I
originally tried to use the posix skin for my code. The routines that
should have produced a sleep returned immediately as if they had slept. I
finally gave up on the posix skin and went back to the Alchemy I knew and
had used before and everything worked more or less as expected.

I originally wrote this off as I was doing something stupid and simply
could not figure out what it was. Browsing through the few posix skin
examples did not reveal anything obvious. At that point I was busy making
things actually work, so I moved on.

I realize that the alchemy skin is implemented using the posix routines for
the most part, but there is clearly some difference. I wonder if the two
issues are related...

Regards,

Steve
