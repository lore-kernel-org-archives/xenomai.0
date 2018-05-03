References: <C2EC5BA46D13CD44B5915A8FEEB4C44E8A2D2291@DDCEXCH.ddc-ny.com>
 <70acf08c-e861-c18b-c0f8-b60cc7571084@siemens.com>
 <C2EC5BA46D13CD44B5915A8FEEB4C44E8A2D2301@DDCEXCH.ddc-ny.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4446a085-14c2-886c-5e2a-eb61370d1d46@siemens.com>
Date: Thu, 3 May 2018 23:31:44 +0200
MIME-Version: 1.0
In-Reply-To: <C2EC5BA46D13CD44B5915A8FEEB4C44E8A2D2301@DDCEXCH.ddc-ny.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] potentially missing timer rating check in
 select_root_only_timer()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Pham, Phong" <phamp@ddc-web.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: "Hillman, Robert" <hillman@ddc-web.com>

On 2018-05-02 19:43, Pham, Phong wrote:
> 
> Hi Jan,
> 
> In my scenario, it is a single CPU Powerpc system.  What I was intending to do is replacing the decrementer (Powerpc specific count down timer) clockevent with my timer clockevent.  (My timer is located somewhere else on the chip accessible via memory mapped IO).   According to Linux, user can change the rating and kernel will select the highest rating timer for you.  So I change my timer rating to be higher than the decrementer.  In ipipe_select_timers(), it will pick the first timer found on the timers linked list.  That linked list of timers is also sorted by highest priority first.  However, when select_root_only_timer() is executed, the code goes thru the entire list and select the last one, the one with the lowest rating.

OK, I'm starting to see the problem:

1. You have some CPUs that are not used by Xenomai (ipipe_select_timers,
   "fixup" mask is non-empty)

2. There are multiple ipipe-timers available, sorted according to their
   rating in "timers" list (higher ratings first).

3. select_root_only_timer is now called for each timer in the list, and
   if the timer matches regarding the IRQ, it will be registered
   (install_pcpu_timer).

Due to this multi-registration (actually overwriting), you end up with
the lowest rated timer installed.

So the proper fix is to prevent further calls to select_root_only_timer
after the first successful one. Would you write such a patch? Should be
about making select_root_only_timer return some true/false, depending on
whether it actually installed something.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

