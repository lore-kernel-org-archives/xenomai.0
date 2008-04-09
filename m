Message-ID: <8c12bab70804090913w78fde0fch6613851680e71d77@domain.hid>
Date: Wed, 9 Apr 2008 18:13:04 +0200
From: "Asif Iqbal" <a.iqbal@domain.hid>
Sender: aiqbalrana@domain.hid
In-Reply-To: <18428.55929.679856.767053@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <8c12bab70803250638y36c67e0cx6d52aa4a85979720@domain.hid>
	<18428.55929.679856.767053@domain.hid>
Subject: Re: [Xenomai-help] Beginner Help
Reply-To: a.iqbal@domain.hid
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

Thank you Gilles. It is quite nice to see an answer after so many days.

Yes I realized what you said.
Anyway, I found out, that I could use memory-mapped files for this purpose.

As a side note, modifying trivial_periodic to use rt_printf solved
this 50us jitter issue. Now for a 1KHz loop, the jitter is around =B11us
only!

Addition of rt_printf produced some compile time errors which were
gone by the addition of following line to Makefile (taken from
rtprint):

###### SPECIAL TARGET RULES ######
trivial_periodic : trivial_periodic.c
        $(CC) $(CFLAGS) $? $(LDFLAGS) -lrtdk -o $@



Regards,

On Wed, Apr 9, 2008 at 5:02 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
>
> Asif Iqbal wrote:
>   > Hello
>   >
>   > I just installed Xenomai on 2.6.24 kernel and played with some exampl=
es from
>   > the cvs repository. I can create a 10 KHz hard real-time loop in an
>   > amazingly simple way *rt_task_set_periodic.* There is a certain jitte=
r that
>   > can occasionally go as high as 50us(!) but I have not had any overrun=
s.
>   >
>   > Now I would like to do the following:
>   >
>   > 1) Read data from serial port that is coming from a microcontroller b=
oard.
>   > 2) Filter this data using a simple low-pass filter
>   > 3) Share the results through a webserver  (Apache) at a much lower fr=
equency
>   > @ ca. 1 Hz.
>   >
>   > Could you point me to some example source code that resembles my need=
s, esp.
>   > step 3?
>
>  I am afraid your question is a bit off-topic on this list. Publishing
>  results through a webserver is not an issue that I face frequently, and
>  I guess this is the case for many people on this list.
>
>  --
>
>
>                                             Gilles.
>

