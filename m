MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-ID: <1504864455.59b268c7f133b@mail.inbox.lv>
Date: Fri, 08 Sep 2017 12:54:15 +0300
From: Andris <andrlv@inbox.lv>
References: <1504766189.59b0e8edb9f7a@mail.inbox.lv>
 <ae84bec2-afdb-3cf0-031c-b8db97387f59@xenomai.org>
 <1504779380.59b11c7427039@mail.inbox.lv>
 <49358bd0-9902-ded1-8aa8-f2e91c73980f@xenomai.org>
In-Reply-To: <49358bd0-9902-ded1-8aa8-f2e91c73980f@xenomai.org>
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

Subject: Re: [Xenomai] Application command line
arguments(parameters) reordering problem
Date: 8 September 2017 at 12:06:50
From:  Philippe Gerum <rpm@xenomai.org>
To:  Andris <andrlv@inbox.lv>
> On 09/07/2017 12:16 PM, Andris wrote:
> > Thanks!
> > But this patch resolve problem only if all
command line arguments starts
> > with "--", but if command line is with mixed
arguments, for example:
> > ./app -p 250 --enable-feature 1
> > then the problem still exist.

> Just checked, it does not here. Are you sure?

Yes, parameters are reordered, first always is
parameter starting with "--".
argv[0]: app
argv[1]: --enable-feature
argv[2]: 1
argv[3]: -p
argv[4]: 250

But this possibly is not a problem.

Andris


