From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <2ff1a98a0710080145x2317ebc4ga4974a17abf22bdf@domain.hid>
References: <46F9167F.20008@domain.hid> <46FA26ED.4070505@domain.hid>
	<46FF78DF.7090104@domain.hid> <1191149545.5989.7.camel@domain.hid>
	<46FF81BA.1020506@domain.hid> <46FF8BB9.9080207@domain.hid>
	<1191156133.5989.17.camel@domain.hid> <46FFC139.60905@domain.hid>
	<2ff1a98a0710010204x60178291u9633e61a89d49921@domain.hid>
	<4709DD41.3030306@domain.hid>
	<2ff1a98a0710080145x2317ebc4ga4974a17abf22bdf@domain.hid>
Content-Type: text/plain
Date: Tue, 09 Oct 2007 11:11:01 +0200
Message-Id: <1191921061.22917.72.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] crashing 2.6.22
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

On Mon, 2007-10-08 at 10:45 +0200, Gilles Chanteperdrix wrote:
> > Ooops. By reading all my mails, I would have avoided reinventing
> this
> > wheel on my own. Your patch is almost what I posted yesterday to fix
> the
> > vmalloc issue.
> >
> > Looks like we no longer need the last hunk of it on recent kernels,
> right?
> 
> Yes, it fixes an issue which was fixed a long time ago.
> 
Yeah, my mistake. I've postponed this patch and forgot to push it
forward again after the testing period in my cooker. Sorry about that.

> > Jan
> >
> > PS: We should really consider using bug trackers for Adeos and
> Xenomai!
> > I have a few (minor) patches hanging around as well, but things
> quickly
> > get lost when bigger problems pop up.
> 
> We have bug trackers, the point is think about using them.

Indeed. We even have patch trackers we could activate. Either we use
them, or any patch sent for inclusion should be posted in a separate
mail to the -core list, with a [PATCH] header. I'm sometimes missing
them because they are part of a lengthy conversation, buried under lots
of mail I could fast-forward a bit aggressively.
> 
-- 
Philippe.



