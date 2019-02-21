MIME-Version: 1.0
References: <fe936315-6db1-d542-e80e-d4bc31d091d0@bluewin.ch>
 <CALLqZ8TNa2TAXxwnBVFu4SbxmuspWQWhsUOWw319eW=Crf_Uhg@mail.gmail.com>
 <37e844bb-f50d-115f-fe63-1526119114f8@bluewin.ch>
In-Reply-To: <37e844bb-f50d-115f-fe63-1526119114f8@bluewin.ch>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Thu, 21 Feb 2019 09:31:28 -0500
Message-ID: <CALLqZ8QzAOYVyOuHODez1z9nckgQD01kQJRtkSA5q3h0jUxW-w@mail.gmail.com>
Subject: Re: NXP i.MX RT support
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Stephan Brauss <sbrauss@bluewin.ch>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,
  So the imx series has good support in Xenomai.  I have tested
Xenomai on the imx7d, with good results.  I have some unpublished work
for pwm and a couple other drivers that I'm hoping to publish soon as
well. There's also a lot of people who have used Xenomai on the i.mx6
series with good results as well.  There's lots of information in the
mailing list archive on common bugs people have run into.

-Greg

On Thu, Feb 21, 2019 at 2:33 AM Stephan Brauss via Xenomai
<xenomai@xenomai.org> wrote:
>
> Hi!
>
> I'm still in the process of finding the best suited device for my needs
> (already or nearly ported Linux/Xenomai, "some MCU features" (GPIO, CAN,
> ADC, if possible PWM), graphics core with "good" 2D speed, <10$).
> Am I right that the support of the i.MX6 family only means the Corted-A9
> based devices? - NXP offers also an i.MX6ULL that probably would also be
> a good choice for me, but this is Corted-A7 based and is also different
> in many other aspects.
>
> Thanks & best regards,
> Stephan
>
>
>
> Am 20.02.2019 um 17:25 schrieb Greg Gallagher:
> > As far as I know Xenomai hasn't run on the Cortex-M series processors.
> > Having said that I've seen some presentations about getting Linux to
> > run on the larger M7 and M4 cores so it's possible you could try to
> > get Xenomai to run.
> >
> > -Greg
> >
> > On Wed, Feb 20, 2019 at 3:16 AM Stephan Brauss via Xenomai
> > <xenomai@xenomai.org> wrote:
> >>
> >> Hi!
> >>
> >> I have not found it in the list of supported devices, but maybe someone
> >> has already experiences with the NXP i.MX RT? - It has an Arm Cortex-M7
> >> core.
> >>
> >> Thanks & best regards,
> >> Stephan
> >>
>

