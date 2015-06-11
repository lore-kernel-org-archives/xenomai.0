From: Lowell Gilbert <kludge@be-well.ilk.org>
References: <79A9E4882C44D44FA53B5AB15E6198011385C369@ADEERL01SMS001.cznet.zeiss.org>
 <b692bb78ab6f887dfd41f71655a0a205.squirrel@sourcetrek.com>
 <44y4jq71ku.fsf@be-well.ilk.org>
 <650830a42485b39f0a0443dcb4c5c962.squirrel@sourcetrek.com>
 <79A9E4882C44D44FA53B5AB15E6198011385D400@ADEERL01SMS001.cznet.zeiss.org>
Date: Thu, 11 Jun 2015 13:30:10 -0400
In-Reply-To: <79A9E4882C44D44FA53B5AB15E6198011385D400@ADEERL01SMS001.cznet.zeiss.org>
 (Alexandre Lopes's message of "Thu, 11 Jun 2015 15:45:23 +0000")
Message-ID: <44oakm9mql.fsf@be-well.ilk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] init failed code -19 on Cyclone V SoC
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Lopes, Alexandre" <alexandre.lopes.ext@zeiss.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

>> Note that the mail you are replying to is talking about "global timer", =
not "global clock".
>>
>> --=20
>>                     Gilles.

Oops. Sorry; and thanks.

"Lopes, Alexandre" <alexandre.lopes.ext@zeiss.com> writes:

> @Lowell: Like Gilles mentioned, there are several timers in the=20
> Cortex A9. At address PERIPH_BASE_ADDR + 0x200 you have the global timer=
=20
> registers and at PERIPH_BASE_ADDR + 0x600 you have the private timer and=
=20
> watchdog timer registers (on a per core basis). On the Altera socfpga sys=
tems
> the base address is, in this case, 0xfffec000.=20

The Cyclone V has a timer block external to the Cortex A9 as well, if I
remember correctly.

>                                                Unfortunately Altera didn=
=92t
> register the global timer, at least not on the upstream Kernels.

I would expect it to come from Qsys, in the sopcinfo file, but
apparently at some point I added it to my board info file instead.

