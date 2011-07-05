MIME-Version: 1.0
In-Reply-To: <1309810409.2157.13.camel@domain.hid>
References: <CAMJ=MEcTefZicuRNSv77kQB3XQTkvQDekHNeq04KPA86-yTEuw@domain.hid>
	<CAMJ=MEcn1ZemK7XkW5F9MpJ9pWihm7UM-t-7HZP7LPD7QDLmcA@mail.gmail.com>
	<1309767638.2157.7.camel@domain.hid> <4E11A71F.7040804@domain.hid>
	<CAMJ=MEfVauUJG=YfQ2LiMqEwRWAyFrfdGMX1ZvR2x3xvkyCTAA@mail.gmail.com>
	<1309810164.2157.12.camel@domain.hid> <1309810409.2157.13.camel@domain.hid>
Date: Tue, 5 Jul 2011 10:45:08 +0200
Message-ID: <CAMJ=MEcFSPn33STcfZ8-a8oDUYJX7sOvkMkSqtXi0Z3tHzSTUA@mail.gmail.com>
From: Ronny Meeus <ronny.meeus@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Adeos-main] Kernel blocked during send/receive raw ethernet
	packets.
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main@gna.org

On Mon, Jul 4, 2011 at 10:13 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> On Mon, 2011-07-04 at 22:09 +0200, Philippe Gerum wrote:
>> On Mon, 2011-07-04 at 22:04 +0200, Ronny Meeus wrote:
>> > On Mon, Jul 4, 2011 at 1:42 PM, Gilles Chanteperdrix
>> > <gilles.chanteperdrix@xenomai.org> wrote:
>> > > On 07/04/2011 10:20 AM, Philippe Gerum wrote:
>> > >> Could you try 2.6.36-ipipe as well in case 2.6.35.7 without pipelin=
e
>> > >> does not exhibit the issue? A number of changes went in the IRQ rep=
lay
>> > >> code during this time frame, and 2.6.35 was in a state of flux rega=
rding
>> > >> this.
>> > >
>> > > And please try Xenomai 2.5.6.
>> > >
>> > > --
>> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0Gilles.
>> > >
>> >
>> > Hello
>> >
>> > today we tested tested: "Running the same test on 2.6.35.7 without IPI=
PE".
>> > The result is also not OK. The problem can be reproduced on this
>> > kernel, so it looks like the issue has nothing to do with the I-PIPE.
>> > We are currently porting the FreeScale patches to the 2.6.36 kernel
>> > but it looks like this is going to take some effort (Thomas already
>> > spent half a day on it today).
>> >
>> > Maybe a bit of history: we started with the 2.6.34 kernel with no SMP.
>> > Here we observed issue in some scenarios. By playing with the
>> > configuration we found that these issues were resolved by switching to
>> > SMP (even on one core).
>> > After the activation of SMP we started to see BADNESS issues once we
>> > started to run our Xenomai based applications.
>> > Thomas found a patch on the Xenomai mailing list to solve the badness
>> > issue but this was based on 2.6.35.7. We ported the FreeScale patches
>> > to that releases and we observed the blocking application issue
>> > described above.
>> >
>> > We will try to port the FreeScale patches to 2.6.36 and see how the
>> > system behaves. More information on this later.
>> > Can you guys give us any hint of what would be the most stable version
>> > of Linux + Xenomai to base our application on?
>>
>> SMP-wise for powerpc, 2.6.36 + upcoming 2.5.6
>
> s,upcoming,,
>
> I mean 2.5.6 stock.
>
>>
>> >
>> > Thanks
>> > Ronny
>> >
>> > _______________________________________________
>> > Adeos-main mailing list
>> > Adeos-main@domain.hid
>> > https://mail.gna.org/listinfo/adeos-main
>>
>
> --
> Philippe.
>
>
>

Hello

we have done the test on both 2.6.36 and 2.6.36.4 without I-PIPE.
In both cases the issue is seen.

Any hints to helps us debugging this issue would be appreciated.

Best regards
Ronny

