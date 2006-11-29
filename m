Subject: Re: [Xenomai-core] [RFC] Xenomai examples repository
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <456D6451.3030705@domain.hid>
References: <456D6451.3030705@domain.hid>
Content-Type: text/plain
Date: Wed, 29 Nov 2006 19:28:19 +0100
Message-Id: <1164824900.4973.262.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>, xenomai-core <xenomai@xenomai.org>

On Wed, 2006-11-29 at 11:43 +0100, Jan Kiszka wrote:
> Hi,
> 
> we had this topic a few times before, but it's getting more and more
> urgent now: How to establish a repository for Xenomai example code?
> 
> I think we have basically two options:
> 
>  A) create /examples/<skin>, including /examples/rtdm/<profile> in the
>     SVN
> 
>  B) create corresponding pages in the wiki
> 
> Option A) has the advantage that we could easily integrate the example
> build in the regular build process (when building SVN check-outs), track
> API changes, and keep the examples in sync that way.
> 
> Option B) would be easier to maintain by non-core developers as the wiki
> is open for anyone. Both options require some review of the examples
> anyway, but B) would allow to relax the process a bit.
> 

Nothing prevents to have both. A set of canonical examples carefully
maintained with the core, and a Wiki area for keeping a slew of hands-on
examples.

> Please comment everyone, even if your are "only" a user, but maybe
> interested in contributing example code in the future.
> 
> Mahlzeit,
> Jan
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



