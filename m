MIME-Version: 1.0
In-Reply-To: <4DCBD790.4050604@domain.hid>
References: <BANLkTikenoYE=42uhjRq=DeP5FT9sip-dg@domain.hid>
	<4DCBD790.4050604@domain.hid>
Date: Thu, 12 May 2011 16:44:12 +0200
Message-ID: <BANLkTikvNxfE53_Bpw8u+urwyMXRk+oMOA@mail.gmail.com>
From: Henri Roosen <henriroosen@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Fast-sync and auto-relaxed priority 0 threads
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Thu, May 12, 2011 at 2:50 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On 05/12/2011 02:07 PM, Henri Roosen wrote:
>> Hi,
>>
>> We are using the auto-relax patches on top of the latest Xenomai 2.5.6
>> release. This means our priority 0 task is in secondary domain most of
>> the time.
>>
>> We've seen a lot of domain switching and gatekeeper activity when this
>> task is acquiring a mutex which is not locked. Of course an
>> auto-relaxed prio 0 thread will do domain switching more often, but in
>> this case because we have fast sync enabled I would expect it doesn't
>> have to make a kernel call thus no switching..
>>
>> Looking into the code I've found that at rt_mutex_acquire_inner there
>> is explicitly a check for secondary domain. This must have been done
>> while xnsynch_fast_acquire can only be called from primary domain. Is
>> that the case?? In the implementation behind xnsynch_fast_acquire I
>> cannot find a reason why it cannot be called from secondary domain.
>> Can anyone comment on this?
>>
>> It would save a lot of overhead for our priority 0 task if we could
>> have fast sync in secondary mode. All suggestions are welcome!
>
> Yes, the automatic switch to primary mode is made on purpose. It is a
> kind of priority inheritance, when a thread holds a mutex, this mutex
> may be shared with a primary mode only thread, so, we do not want the
> linux scheduler to take the decision of preempting this task, and create
> a priority inversion.
>
> It is hard to do this differently: if a real-time thread arrives and try
> and take the mutex while the priority 0 thread is preempted by Linux
> scheduler, there is not much we can do without hacking savagely the
> Linux scheduler.
>

I understand. Thanks Gilles for the explanation!

> What we can do however, is do this only for threads with priority
> inheritance.
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Gilles.
>

