MIME-Version: 1.0
In-Reply-To: <4C34438D.9020905@domain.hid>
References: <AANLkTik-cpk4RfJGxj422mOvU1xQFdQCfB8gno7uzD7N@mail.gmail.com> 
	<4C34438D.9020905@domain.hid>
From: Peter Soetens <peter@domain.hid>
Date: Wed, 7 Jul 2010 22:57:20 +0200
Message-ID: <AANLkTiklX49KAfAlZND9FhVaTJZpdADFpuUIO-lkm6f6@domain.hid>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai-help] native: A 32k stack is not always a 'reasonable'
	size
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
Cc: xenomai-help <xenomai@xenomai.org>

On Wed, Jul 7, 2010 at 11:06 AM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Peter Soetens wrote:
>> At least, not for Orocos applications. We've had hard to debug
>> application segfaults that used just a 'little' bit more than 32k. We
>> had to raise the stack size to 128k to get reliably through our
>> application startup. I stem from the old 'mlockall ate my RAM'
>> generation where we typically reduced stack sizes in order to have
>> some crumbles left for the heap. But 32k wasn't really what we were
>> aiming for.
>>
>> Maybe we should explicitly document the 32k limit and its limitations
>> for certain applications...?
>
> Again, things have been fixed in 2.5.3 with regard to stack sizes, could
> you check that you have the same behaviour?

I think we had, but I'm uncertain right now.

>
> As for 32KiB, it is only a default stack size, it is only reasonable in
> the sense that 2MiB is unreasonable on a low-end system. 32KiB was
> picked because it allows printf to work. Now, whatever stack size we
> choose, there will be applications which need more, this does not really
> make the default unreasonable.

I knew you would say that. It deserves an entry in the faq or some
trouble shooting document though.

>
>> PS: can anyone allow 'sspr' (=me) to edit/add stuff on the wiki ?
>
> Looks like you passed an incorrect mail address for this account, so it
> could not be verified, did you fix this?

I did. Didn't realize there was a problem.

Peter

