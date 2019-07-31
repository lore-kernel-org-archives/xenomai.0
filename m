MIME-Version: 1.0
References: <CANWkrRNq5k0sRnu2QZm5O_VQdkOHXO+Nc9T7WyDmUUMNuwH1zQ@mail.gmail.com>
 <b43d0dd5-c4bf-4145-f155-b05dfbbf903e@siemens.com>
 <CANWkrROsZumbjvf0OOwita192OcL=-0JJmvbEivaF81Cx_Nd=Q@mail.gmail.com>
In-Reply-To: <CANWkrROsZumbjvf0OOwita192OcL=-0JJmvbEivaF81Cx_Nd=Q@mail.gmail.com>
From: Michael Smith <2michael.smith@gmail.com>
Date: Wed, 31 Jul 2019 09:08:13 +0200
Message-ID: <CANWkrROFdaAumt+R4KPnGxG7unKGC8xsXz2xYsmKdJmFJqMC9w@mail.gmail.com>
Subject: Fwd: Linux UDP and RTNet
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Jul 30, 2019 at 4:24 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 30.07.19 15:07, Michael Smith via Xenomai wrote:
> > Hi I've got a RTNet setup running with a TDMA-based network.
> > At the same time I try to send normal UDP packets on another non
> > real-time Linux NIC.
>
> How do you try this? With a Xenomai application that opens a UDP socket? Then
> you have to ensure that it does that using the non-RT APIs, e.g. by wrapping the
> socket call: __STD(socket(...));

It works perfectly.
Thanks Jan.

>
> Jan
>
> > I get the error message "No route to host" when I try to do this.
> > As soon as I stop RTNet the non real-time NIC is able to send the UDP
> > packet normally.
> >
> > I assume because RTNet is UDP based it sees all UDP packets as RTNet bound.
> > Is there a way arround this? Is it possible to send a non real-time
> > UDP packet on a 2nd non real-time NIC while RTNet is running?
> > I assume maybe by using rtroute something like this can work, but I'm
> > not sure how this will be done.
> >
> > Thanks
> > Michael Smith
> >
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux

