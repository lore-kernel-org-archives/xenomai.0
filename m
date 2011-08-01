MIME-Version: 1.0
In-Reply-To: <OF525F5E1C.0654BB8B-ONC12578DC.004AEEB3-C12578DC.004B73F2@domain.hid>
References: <OF525F5E1C.0654BB8B-ONC12578DC.004AEEB3-C12578DC.004B73F2@domain.hid>
Date: Mon, 1 Aug 2011 23:44:25 +0200
Message-ID: <CAMesUR6mRhVJGAT=FFbfwj-C2bgj2J_6R40pn3_q76NXiztDDw@domain.hid>
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai-help] Use of a4l_dtoraw
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: julien.delange@domain.hid
Cc: xenomai@xenomai.org

Hi,

On Fri, Jul 29, 2011 at 3:44 PM,  <julien.delange@domain.hid> wrote:
> Hello,
>

Sorry for the late reply. I am currently on holidays.

> I try to use the RTDM API to communicate with my boards. In fact, I
> adapted a driver from comedi to RTDM ; the low-level aspects seem to work
> (meaning : when I send something on a channel, I see an output on this
> channel). However, now, I would like the analogy API to interact with my
> device. So, I'm wondering how the conversion functions work.
>
> For example, for the a4l_dtoraw function, if some arguments are easy to
> understand, some others need more explanations. In particular,what means
> the cnt argument of this function and how should we use it ?

The cnt argument means "count of double values to convert into raw
values" . Sorry, this was not very clear. I currently do not have time
to look back at the code and give you a detailed explanation. However,
I remember that:

If you want to use a4l_dtoraw, I think you have double float data you
want to inject in some output subdevice.
- Double value size is constant: let's say 64 bits.
- The size of a raw value to be injected depends on the subdevice you
use in your card, it can be 8bits, 16bits, 24bits or whatever.

I wanted a4l_dtoraw to be generic, so I decided that this function
should take as arguments the channel descriptor and the range
descriptor that the user will use. These descriptors can be retrieved
via a4l_get_chinfo and a4l_get_rnginfo (cf. examples in
src/utils/analogy/*.c) once the user has opened a device (with
a4l_open and a4l_fill_desc).

a4l_dtoraw takes also two more arguments an input buffer (src: the
double values) and an output buffer (dst: the raw values). Obviously,
these buffers do not have the same size but they are supposed to
contain the same count of values.

That is why I decided that the last argument was the count of values
to be converted (cnt). An alternative was to pass each buffer's size
but that implies using two arguments instead of one (two arguments to
pass a redundant piece of information because internally all I need is
the count of values to convert).

The user is, of course, in charge of passing large enough output
buffer. A helper function, a4l_sizeof_chan, is available to get the
size of a raw sample, if need be.

Thus, I think the user is able to develop generic user-space code
which does not depend on the acquisition board.

> Is there some
> example of the usage of the level 2 API of the analogy level ? It would
> really help in understanding how this API interacts with the boards.
>

In src/utils/analogy/cmd_read.c, I use a4l_rawtoul so as to correctly
display hexadecimal values (freshly acquired).
In src/utils/analogy/insn_read.c: I use a4l_rawtod if a range is
passed as argument.

> Thanks in advance for any help regarding the use of this API.
>
> Best regards,
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

Alexis.

