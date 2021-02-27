MIME-Version: 1.0
References: <CAFZ-hKigqD1ogg8hV3--n5ts7gvHKnE3A6E2C=7cF6+zfaZqQw@mail.gmail.com>
 <CALLqZ8T03Rycd-q3QHkmzGkpT0YAa7Ps3tP7TvMiSfWhtevh4w@mail.gmail.com>
In-Reply-To: <CALLqZ8T03Rycd-q3QHkmzGkpT0YAa7Ps3tP7TvMiSfWhtevh4w@mail.gmail.com>
From: Leandro Bucci <guestleandro11@gmail.com>
Date: Sun, 28 Feb 2021 00:48:30 +0100
Message-ID: <CAFZ-hKhKXEETP=K1bdtiHcFxEpp0UMFZ1+SZ0qfN575+DfJ_uQ@mail.gmail.com>
Subject: Re: Kernel configuration
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: xenomai <xenomai@xenomai.org>

Ok, thanks.

Il sab 27 feb 2021, 15:56 Greg Gallagher <greg@embeddedgreg.com> ha scritto=
:

>
>
> On Sat, Feb 27, 2021 at 9:37 AM Leandro Bucci via Xenomai <
> xenomai@xenomai.org> wrote:
>
>> Hi, I wanted to ask how to enable serial communication in Xenomai. When
>> compiling the kernel, what parameters should I set?
>>
> The serial driver I don=E2=80=99t think has been tested much with raspber=
ry Pi.
> You want to to trace and see if the probe function is being called. There
> may be some devicetree changes needed. I=E2=80=99ve only used the I.mx se=
rial
> driver.
>
> Greg
>
