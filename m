Message-ID: <2ff1a98a0804170542u618c174cra6f93007a6cf6e43@domain.hid>
Date: Thu, 17 Apr 2008 14:42:26 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <a7575bba0804170410k6e05bf53v8b023065e22c1754@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a7575bba0804150405iec3cc82ia823f010f034a671@domain.hid>
	<a7575bba0804170215k2999fadcn8de7a4e0bf87c64e@domain.hid>
	<2ff1a98a0804170307v53ec52a6p553d2f93cd72e643@domain.hid>
	<a7575bba0804170410k6e05bf53v8b023065e22c1754@domain.hid>
Subject: Re: [Xenomai-core] About Xenomai questions
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Josh Zhao <joshsystem@domain.hid>
Cc: xenomai@xenomai.org

On Thu, Apr 17, 2008 at 1:10 PM, Josh Zhao <joshsystem@domain.hid> wrote:
> Hi Gilles, thanks a lot.
> >This is the wrong list to ask them. This answer is the last I will
>  >make to you on this list for Xenomai questions.
>
>  I m a beginner for Xenomai. Do you have any suggetions how to dig into the
> xenomai code ?

You may use Xenomai cross reference:
http://www.rts.uni-hannover.de/xenomai/lxr/source

Also, the best way to know the nucleus, is to have to make some
modification. An example of modification could be to make the
scheduling policy of the nucleus configurable (to allow for instance
to use EDF scheduling policy).

On the other hand, if you plan to simply use Xenomai, you probably do
not have to know its internals.

-- 
 Gilles

