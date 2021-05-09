Subject: Re: Timer_Create for periodic tasks
References: <CAK6DXL0_dMXz7Xdi4vZSBZ9J5E9dVwiWiKOLnoX686ecWe5e3w@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4b529835-b035-9e29-acc7-2fdc355222e5@siemens.com>
Date: Sun, 9 May 2021 10:12:38 +0200
MIME-Version: 1.0
In-Reply-To: <CAK6DXL0_dMXz7Xdi4vZSBZ9J5E9dVwiWiKOLnoX686ecWe5e3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marco Barletta <barlettamarco8@gmail.com>, xenomai@xenomai.org

On 08.05.21 17:13, Marco Barletta via Xenomai wrote:
> Hi everyone;
> I'm currently running Xenomai 3.1 and I'm facing with an issue. When I want
> to create a periodic task using timer_create and consequently sigwait or
> sigwaitinfo it works when running in root pid namespace, but when i run the
> task in a child pid namespace the thread doesn't receive the ALRM signal (I
> don't know if it's the timer create the problem or the sigwait). I also
> tried to use a server to translate my pid but the cobalt core rejects the
> call since the pid of the currently running thread is different. Is this a
> problem related to how xenomai manages the xnthread or is an inherent
> problem of posix?
> Thanks for helping, best regards
> 

There is currently no - or at least no consistently tested - namespace
support in Xenomai, and that may cause such troubles when userspace and
Xenomai kernel are talking about differnt PID values. If you could
provide a simple test case or describe how to reproduce the issue with
an existing test from smokey, we could have a look.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

