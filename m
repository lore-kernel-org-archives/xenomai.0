MIME-Version: 1.0
In-Reply-To: <4B7019AA.8020102@domain.hid>
References: <20100204105700.GB20669@domain.hid>
	<4B6ADA01.2080803@domain.hid>
	<20100205103744.GA12904@domain.hid>
	<4B6BFEDC.60403@domain.hid>
	<b88603c31002050439n790f4f71kd6e152198de511f2@domain.hid>
	<4B6C1E66.2000008@domain.hid> <4B6C2D59.9060200@domain.hid>
	<b88603c31002050727p1decfdacm919d3f2278fdf2f0@domain.hid>
	<4B7019AA.8020102@domain.hid>
Date: Mon, 8 Feb 2010 15:33:03 +0100
Message-ID: <b88603c31002080633v1b9ee7b4s2a6ee82eeaab644d@domain.hid>
From: Henri Roosen <henriroosen@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai-help] Force switch back to primary domain
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

We run on an x86 (32bit) system on chip (VortexDX chip).

On Mon, Feb 8, 2010 at 3:03 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Henri Roosen wrote:
>> We run on x86.
>>
>> I agree it is important to fix issues ASAP. It helps all of us.
>> However, I am not sure it is a Xenomai problem. The
>> mutex-torture-native runs fine, as well as the other Xenomai test
>> apps.
>>
>> I ran into the a mutex issue when using git version
>> 51adc67cd1d4128c62050ea647c074066a5f3c83 (=2.5.0++). Then I traced it
>> to a mutex_acquire that blocked the system, even though the mutex was
>> not acquired by anyone. And I noticed the app would run again when
>> switching off the FASTSYNC. We could not explain why it locked up.
>> Seemed very strange and probably our own app's issue.
>>
>> Even though it was likely to be our own apps issue, we decided to
>> leave the 2.5.x branch and base our development on the 2.4.x branch.
>> Our app runs fine on that branch with respect to Xenomai.
>>
>> I just compiled our app against the 2.5.1 and noticed the application
>> behaves different again from the git version I tried before. I'm not
>> sure if it is the mutex problem but it locks up earlier than before.
>> Fact is our app has a problem with 2.5.x branch and like I said
>> before: very likely the issue is in our own app.
>>
>> Unfortunately currently we get no time to investigate 2.5.x because of
>> project pressure and deadlines :-(. Although personally I think it
>> would be wise to investigate, for our own good! I'll try to find some
>> spare time to investigate further.
>>
>> I will keep the mailinglist posted, but I don't think there is a
>> reason to worry...
>
> Ok. Could you tell us on which platform you have these issues?
>
> --
> Gilles Chanteperdrix, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
>

