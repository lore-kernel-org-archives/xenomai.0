MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-ID: <1504879911.59b2a527dd4c7@mail.inbox.lv>
Date: Fri, 08 Sep 2017 17:11:51 +0300
From: Andris <andrlv@inbox.lv>
References: <1504766189.59b0e8edb9f7a@mail.inbox.lv>
 <ae84bec2-afdb-3cf0-031c-b8db97387f59@xenomai.org>
 <1504779380.59b11c7427039@mail.inbox.lv>
 <49358bd0-9902-ded1-8aa8-f2e91c73980f@xenomai.org>
 <1504864455.59b268c7f133b@mail.inbox.lv>
 <4a0c3249-bcdf-ea09-5b6e-bad3431ddc4d@xenomai.org>
 <2f293611-9ca8-9988-24a5-0f952874576e@xenomai.org>
In-Reply-To: <2f293611-9ca8-9988-24a5-0f952874576e@xenomai.org>
Subject: Re: [Xenomai] Application command line arguments(parameters)
 reordering problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

=C2=A0

> >>
> >>> Just checked, it does not here. Are you sure?
> >>
> >> Yes, parameters are reordered, first always is
> >> parameter starting with "--".
> >> argv[0]: app
> >> argv[1]: --enable-feature
> >> argv[2]: 1
> >> argv[3]: -p
> >> argv[4]: 250
> >>
> >> But this possibly is not a problem.
> >>
> >
> > Ok, the whole thing needs a review. I'll
follow up on this.
> >
> > Thanks,
> >

> Please try this patch:

Thanks!=20
But I can try this patch only after 2 weeks, I
will be out of office. Maybe my colleague can try it.


