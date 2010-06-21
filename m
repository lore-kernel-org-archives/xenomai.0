MIME-Version: 1.0
In-Reply-To: <4C1F2AE4.6030304@domain.hid>
References: <4C093C93.4000907@domain.hid> <4C0CEC7E.6080408@domain.hid>
	<4C0CF99F.1090700@domain.hid> <4C19E5C8.8070802@domain.hid>
	<4C1F2AE4.6030304@domain.hid>
Date: Mon, 21 Jun 2010 13:59:44 +0200
Message-ID: <AANLkTim2aawiM9Rn-9yosiqLJFfVT6ko-uluJRPskZ7y@domain.hid>
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] [comedi] NI 6251 "wrong" samples
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniele Nicolodi <daniele@domain.hid>
Cc: xenomai@xenomai.org, comedi_list@domain.hid

Hi,

On Mon, Jun 21, 2010 at 11:03 AM, Daniele Nicolodi <daniele@domain.hid> wro=
te:
> On 17/06/10 11:07, Daniele Nicolodi wrote:
>> No. I'm running a continuous memory mapped acquisition. The only maybe
>> uncommon thing I'm doing is that I'm reading the mmapped buffer in fixed
>> chunks, rather than reading all the samples available each time. The
>> number of samples I read each time is larger than the 4095 samples after
>> which the hardware sends the FIFO half full trigger event.
>
> I modified my code from a loop like:
>
> unsigned int required =3D <compute required number of bytes>;
> unsigned int read =3D 0;
> void * buffer =3D a4l_mmap(dsc, ...);
> while (1) {
> =A0while (read < required) {
> =A0 =A0read =3D a4l_pool(...);
> =A0 =A0clock_nanosleep(...);
> =A0}
> =A0process(buffer, ...);
> =A0a4l_buff_markrw(dsc, subdevice, required, ...);
> }
>
> to something like:
>
> unsigned int required =3D <compute required number of bytes>;
> unsigned int read =3D 0;
> void *buffer =3D malloc(required);
> while (1) {
> =A0while (read < required) {
> =A0 =A0a4l_sys_read(dsc, buffer + read, required - read);
> =A0}
> =A0process(buffer, ...);
> }
>
> I tested this setup over the weekend and the wrong samples went away!
>
> Therefore i suspect that the problem is not related to FIFO
> synchronization but to kernel space buffer handling.
>
> I have tried to look at Analogy buffer handling, but the lack of any
> comment in the source code makes understanding how it is supposed to
> work a complex task.
>
Please, tell me where comments are lacking, I will fix that.

> Alexis, can you see any case where there may be a synchronization issue
> like the one I'm seeing in your code? Any suggestion in where to look
> for the bug?
>

You told you that the bug was occuring randomly and that there was no
pattern in the repetition of the bad samples. But are you sure that
the wrong samples do not occur every modulo x * 64KB ?

If the bug is located in Analogy buffer handling, it should not be
specific to a driver. So, I will try to reproduce it with the testing
drivers. I will compare the mapped and unmapped acquisition results.
If I remember well, the "fake" driver outputs some deterministic
content.  If nothing comes out, I will try to use a NI device.

Many thanks for reporting that.

> Thanks. Cheers,
> --
> Daniele
>

Alexis.

