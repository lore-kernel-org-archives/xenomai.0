From: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Date: Thu, 06 Oct 2016 19:44:12 +0200
Message-ID: <3295970.2sMGvTqrqm@fura>
In-Reply-To: <d9542f00-1ca0-9263-dc68-f21da27319e8@xenomai.org>
References: <2990549.hKSmcVRoDB@indiana> <7810159.2OkF4KFj7y@fura>
 <d9542f00-1ca0-9263-dc68-f21da27319e8@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] About SMAP (was Re: Xenomai 3.0.3 is broken in my
	system)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

El Dijous, 6 d'octubre de 2016, a les 19:30:54, Philippe Gerum va escriure:
> On 10/06/2016 07:24 PM, Leopold Palomo-Avellaneda wrote:
> > El Dijous, 6 d'octubre de 2016, a les 13:50:00, Jan Kiszka va escriure:
> >> On 2016-10-06 11:51, Leopold Palomo-Avellaneda wrote:
> >>> Hi,
> >>> =

> >>> lasts weeks I have been in a trouble with Xenomai and RTnet. Finally =
it
> >>> was
> >>> solved disabling some parameters in kernel (nosmap) Thanks again Jan.
> >>> =

> >>> That parameter is an interesting feature of the Intel processors [1,2=
],
> >>> that IMHO affects all the RTnet code and I hope that nothing more of
> >>> Xenomai.
> >>> =

> >>> It seems that fix it is could be easy, but it must be done (a boring
> >>> task
> >>> ;-) In the middle, I would propose that some note could be added to t=
he
> >>> FAQ, or "Troubleshooting a dual kernel configuration" page. Something
> >>> like this in the "Common kernel configuration issues":
> >>> =

> >>> CONFIG_X86_SMAP
> >>> =

> >>> On modern Intel processors with SMAP-enabled systems, kernel is not
> >>> allowed to access to userspace memory, it must be done in a special w=
ay.
> >>> So, until all Xenomai code was updated, specially RTnet, if you find
> >>> crashes with " unable to handle kernel paging request at " disable th=
is
> >>> feature neither in kernel configuration or in boot with nosmap.
> >> =

> >> Send your proposal as patch for the included documentation or even the
> >> kernel Kconfig tests.
> > =

> > I think that I don't understand you. AFAIK xenomai documentation is in a
> > Wordpress that Gilles installed and configured.
> =

> No, I did it, =


Sorry, I thought that was him. =


> and wordpress is fed by asciidoc input. =


Generated from where? make doc?

> But instead of
> documenting a shortcoming, I would rather fix it in the code. Sentences
> like "until some code is updated" in a documentation reads as "when hell
> freezes", simply because the effort was not put at the right place.

You are right, but I didn't know how to express it in a polite and appropri=
ate =

way. I just try to put a simply note in some place to try that other people =

(as today) didn't got crazy as me trying to find what the hell was happen.

> So, since you seem to be requiring RTnet to work, why not writing a
> patch fixing the places where that code hurts with respect to smap?

Yes, it=A1s in my TODO list. But it, at least to me, need some days, and ad=
d a =

simple note is simple and probably help other users.

Also, I would note that "maybe" there are more hidden places where this BUG =

could appears and not just only RTnet. =


Best regards,

Leopold

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part.
URL: <http://xenomai.org/pipermail/xenomai/attachments/20161006/b251a356/at=
tachment.sig>
