Message-ID: <8158.62.39.72.60.1212497328.squirrel@domain.hid>
In-Reply-To: <2ff1a98a0806030510u49102575l792550f46b3b3f5f@domain.hid>
References: <16474.81.252.86.91.1211199249.squirrel@domain.hid> 
	<18491.29266.196753.611570@domain.hid> 
	<2766.81.252.86.91.1211992159.squirrel@domain.hid> 
	<2ff1a98a0805280931j611ae10er69b968ae8699d63d@domain.hid> 
	<16273.81.252.86.91.1212060383.squirrel@domain.hid> 
	<2ff1a98a0805290614w3d846e6by69b033204f912391@domain.hid> 
	<13639.81.252.86.91.1212153659.squirrel@domain.hid> 
	<18496.31292.674733.417262@domain.hid> 
	<6543.62.39.72.60.1212483756.squirrel@domain.hid> 
	<2ff1a98a0806030212k15afec22qde7a44e2d7e6caaf@domain.hid>
	<2ff1a98a0806030510u49102575l792550f46b3b3f5f@domain.hid>
Date: Tue, 3 Jun 2008 14:48:48 +0200 (CEST)
From: "Fabien MAHOT" <fabien.mahot@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Problem with time-out ends
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
Cc: xenomai@xenomai.org

> On Tue, Jun 3, 2008 at 11:12 AM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>> On Tue, Jun 3, 2008 at 11:02 AM, Fabien MAHOT
>> <fabien.mahot@domain.hid> wrote:
>>> Hello,
>>>
>>> I tried your new patch and, now there is no longer issue of priority
>>> inheritance with a mutex. Thanks a lot for that.
>>>
>>> However, there are still problems with my big application. It still
>>> crashes.
>>>
>>> From the test program that you corrected (with check functions), I
>>> succeeded to reproduce them.
>>>
>>> Write function returns "Interrrupt system call" error (EINTR). this i=
s
>>> normal.
>>>
>>> but I ve got the same error message with pthread_mutex_unlock. In the
>>> specification of this function, there is a note about that : "These
>>> functions shall not return an error code of [EINTR]." (these function=
s
>>> are
>>> pthread_mutex_lock, pthread_mutex_unlock, pthread_mutex_trylock)
>>
>> Actually I do not know how this can happen, since the EINTR error is
>> trapped inside pthread_mutex_lock. Will try your example.
>
> Ah, I see, it is pthread_mutex_unlock which returns EINTR, not
> pthread_mutex_lock. I will change this. In the meantime, you can
> simply ignore the EINTR error: the mutex unlock succeeeded even if it
> returns EINTR.
>
> --
>  Gilles
>

OK, thank you.

And do you have an idea about the bug traces ?



