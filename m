MIME-Version: 1.0
In-Reply-To: <4F9555C5.3070300@domain.hid>
References: <CAOiXNkD+-yANz15W_cnD9QLjyGH7LUT-Pf8LEJHqx4Kh24pL+g@domain.hid>
	<4F9555C5.3070300@domain.hid>
Date: Mon, 23 Apr 2012 15:25:43 +0200
Message-ID: <CAOiXNkDRQ3tnooUWwx=spxS-=v2aktovrwnf447buCpOjb1iJw@domain.hid>
From: Andrey Nechypurenko <andreynech@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai-help] Jitter while generating PWMs with GPIO from RTDM
	driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

>> Following my tests with PWM generation using GPIO in user space [1],
>> I've made the RTDM module [2] to further reduce the jitter. As a
>> result, jitter was improved, but still under heavy system load the
>> servo motor I am trying to control starts shaking. Now, I fill stuck
>> and hope to get some help here.
>
> What jitters in micro-seconds are you speaking about? What are you
> requirements? I have not found that information yet in this thread.

The short answer is - I do not know exactly :-) .

The long answer is - my goal is to keep servo motor stable under the
high system load. I was unable to find any concrete numbers regarding
the tolerance level of the no-name servo motor. So I am just
experimenting. My recent observations, presented in the blog I've
mentioned in the original post, suggest that 20-30micro-seconds jitter
will force my concrete servo to start the movements.

I was unable to further reduce jitter, so maybe this number is
actually lower. I will try to implement what Gilles suggested (using
timer api) and see if I can a) further reduce jitter; and b) if this
jitter will be small enough to prevent servo from shaking.

Andrey.

