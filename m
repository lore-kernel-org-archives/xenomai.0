MIME-Version: 1.0
In-Reply-To: <67b6b3430903111043s628c5c64m89cc8c726bdf6ff9@domain.hid>
References: <67b6b3430903091727o4a60a28ay91c7ba35ad7d08ef@domain.hid>
	<67b6b3430903101552u37244233s587898c4d0f9ef3d@domain.hid>
	<49B78113.3030308@domain.hid>
	<67b6b3430903110951m71679f89ud83859654f04aabb@domain.hid>
	<49B7EF28.4080203@domain.hid>
	<C0049A04-822D-497A-BBA0-E5C8F6E8A947@domain.hid>
	<49B7F1AC.9000301@domain.hid>
	<494CC2B0-5509-46F5-B480-CA34038F0226@domain.hid>
	<49B7F6A6.5060603@domain.hid>
	<67b6b3430903111043s628c5c64m89cc8c726bdf6ff9@domain.hid>
Date: Wed, 11 Mar 2009 10:45:13 -0700
Message-ID: <67b6b3430903111045k761f6737vb57f4f2eb8a57b22@domain.hid>
From: Mark Saiia <mark.saiia@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Fwd:  rt_queue_write return 1, with no receiver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

Forgot to cc the list.  Sorry.


---------- Forwarded message ----------
From: Mark Saiia <mark.saiia@domain.hid>
Date: Wed, Mar 11, 2009 at 10:43 AM
Subject: Re: [Xenomai-help] rt_queue_write return 1, with no receiver
To: rpm@xenomai.org


Even with klogd disabled, there is no debugging information displayed
over the serial console. =A0It looks like it is time to start writing
test code.

Mark


On Wed, Mar 11, 2009 at 10:36 AM, Philippe Gerum <rpm@xenomai.org> wrote:
> Steven Seeger wrote:
>>
>> On Mar 11, 2009, at 1:15 PM, Philippe Gerum wrote:
>>
>>> Then I have no clue; you may want to try simplifying your test until th=
e
>>> bug disappears.
>>
>> I also suggested this already. :)
>>
>> We are also always writing the same structure. It is statically allocate=
d
>> and we use queues as a means of providing a series of snapshots.
>>
>> Our app is entirely userspace. Could memory corruption in userspace caus=
e
>> issues with the /proc entry?
>>
>
> You are sharing buffers with kernel space using RT_QUEUEs. If anything go=
es
> wrong writing to this address space, you may well end up corrupting some
> kernel data, including some internal Xenomai data structures. The fact th=
at
> looking at /proc/xenomai crashes the system is telling, since the backing
> code may attempt to scan such data structures.
>
> Since you also have your own driver running, this might be another source
> for the issue. Non-reg tests did not reveal any issue with RT_QUEUEs so f=
ar.
>
>> Steven
>>
>>
>
>
> --
> Philippe.
>

