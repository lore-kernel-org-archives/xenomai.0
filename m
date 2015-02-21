MIME-Version: 1.0
In-Reply-To: <54E7716B.5000102@mitre.org>
References: <CALe7ZU2FV4WTd-ACRYwLyz6hC1-7NG3rCqcL3Ke5t=k74DGmeA@mail.gmail.com>
 <54E7716B.5000102@mitre.org>
Date: Sat, 21 Feb 2015 15:22:39 +0530
Message-ID: <CALe7ZU1JPecK3Rb4WGNnLxTLkmik0Wo0ZOFbtQqsoK8p7NR=jg@mail.gmail.com>
From: JAY KOTHARI <jaikothari10@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] rtdm_event_wait not working as expected
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Thank you Jeff for reply

> Are you calling rtdm_event_wait() from a non-RT context? I noticed in my
> application* that rtdm_event_wait() always returns 0 in non-RT and I
> needed to ensure rtdm_event_wait() is only called from RT context.
>

I am calling from rtdm_event_wait() from function which is in rtdm
driver real time read function. But its returning 0 with even calling
rtdm_event_signal().

> I'm not sure if 0 is the intended return value or not, but the
> documentation does specify that NRT isn't a valid calling context.
>
> *Zynq, Kernel 3.8, Xenomai 2.6.4.
>

