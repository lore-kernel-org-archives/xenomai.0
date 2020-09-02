Subject: Re: About the reasons for setting the timer-internal thread with the
 THREADOBJ_IRQCONTEXT flag.
References: <CAAvDm6YkY012JKwbWErAe2CYpcDzyT+31P1n+nTaogx0tA1L8g@mail.gmail.com>
 <7f665187-523e-02fc-6de3-bc4e41b96d02@siemens.com>
 <CAAvDm6aTM_BSf5ynk-3STppE3GAy6+t0NLk5-bK8fR5N45XX8w@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <43c2be41-b485-dd09-c13d-552b388ec1c4@siemens.com>
Date: Wed, 2 Sep 2020 11:16:36 +0200
MIME-Version: 1.0
In-Reply-To: <CAAvDm6aTM_BSf5ynk-3STppE3GAy6+t0NLk5-bK8fR5N45XX8w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On 02.09.20 11:12, 孙世龙 sunshilong wrote:
> Hi,
> 
>> That is a (reasonable) design decision because you would otherwise risk
>> that a handler registered for low-prio task can block the delivery of an
>> event for a high-prio task. I would just be a mess, at least in a more
>> complex RT application.
> 
> I see, thank you for the clarification.
> 
> It causes what can be done in the callback function of the alarm is very
> limited since a lot of APIs can not be invoked(i.e.:
> No data synchronization could be done by locking/unlocking RT_Mutex.
> Message pipe services(RT_QUEUE), Semaphore services(RT_SEM) and etc
> could not be called, too.)
> 
> Am I right?

Conceptually, anything that blocks, yes. It's like an asynchronous
signal handler where many libc functions aren't available as well - or
you run into deadlocks (the classic printf-from-signal-handler bug...).

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

