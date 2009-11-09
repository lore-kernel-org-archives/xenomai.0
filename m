MIME-Version: 1.0
In-Reply-To: <ddc6e05e0911090622m52d0297fo24061b6bea475a8e@domain.hid>
References: <ddc6e05e0911090400r37e0160aha2c3088dc673c0aa@domain.hid>
	<4AF813D2.2000001@domain.hid>
	<ddc6e05e0911090622m52d0297fo24061b6bea475a8e@domain.hid>
Date: Mon, 9 Nov 2009 15:23:43 +0100
Message-ID: <ddc6e05e0911090623w67986d66u19b71995d9c9e92f@domain.hid>
From: Remco den Breeje <remco@domain.hid>
Content-Type: multipart/mixed; boundary=000325559e26dd45790477f0f0c9
Subject: Re: [Xenomai-core] Context-sharing semaphores
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

--000325559e26dd45790477f0f0c9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Classic.

On Mon, Nov 9, 2009 at 3:22 PM, Remco den Breeje <remco@domain.hid> wrote:
> On Mon, Nov 9, 2009 at 2:06 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote=
:
>> The design. :)
>
> I totally agree :) However, I'm using generated (user-space) code that
> I want to modify as little as possible. So with a simple ioctl-call I
> want to be able to switch between software (pthread) and hardware
> triggering (rtdm-driver).
>
>> The proper design is to use a rtdm semaphore or event *inside* the
>> kernel and let the application block on it when it calls a related IOCTL
>> or other device function that shall synchronize on that condition.
>>
>> Don't share resources like this between kernel and user space. It's
>> unclean, specifically as you once may want to access driver managed data
>> along the sleeping/waking as well.
>>
>> Jan
>
> The sem_open documentation states =A0"a connection between the semaphore
> named name and the calling context (kernel-space as a whole, or
> user-space process)". I interpreted this as exactly what I want - a
> synchronization between user- and kernel-space. Please correct me if
> I'm wrong.
>
>>
>> --
>> Siemens AG, Corporate Technology, CT SE 2
>> Corporate Competence Center Embedded Linux
>>
>
> Attached you find an example.
> You can run it by executing: `make && sudo insmod ./km.ko && sudo ./um
> ; sudo rmmod km`
>
> My syslog-output is: "Error opening clock semaphore (2)"
>
> Thanks,
>
> Remco den Breeje
>

--000325559e26dd45790477f0f0c9
Content-Type: application/x-gzip; name="sem-sharing.tar.gz"
Content-Disposition: attachment; filename="sem-sharing.tar.gz"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g1tbpqt20

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
--000325559e26dd45790477f0f0c9--

