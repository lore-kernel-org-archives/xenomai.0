Date: Tue, 27 Oct 2015 13:35:40 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20151027133540.2f264249@md1em3qc>
In-Reply-To: <20151027123003.GA4874@hermes.click-hack.org>
References: <1445948476-7587-1-git-send-email-henning.schild@siemens.com>
 <20151027123003.GA4874@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] [PATCH] scripts: use mktemp instead of relying on
 TMPDIR beeing in env
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Tue, 27 Oct 2015 13:30:04 +0100
Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:

> On Tue, Oct 27, 2015 at 01:21:16PM +0100, Henning Schild wrote:
> > The environment variable TMPDIR is optional and not always set. We
> > could test for it and fall back to /tmp/ or just use the tool
> > mktemp.
>=20
> I am not sure mktemp is available everywhere. What about setting
> TMPDIR to /tmp if not set ?

=46rom what i can tell mktemp is more widely available than TMPDIR. My
gentoo boxes do not have TMPDIR set and i have used a ubuntu system
where it was not set either. mktemp is part of coreutils and even
busybox has one.
I did not feel too good reimplementing whatever else mktemp does, why
reinvent the wheel?

Henning

