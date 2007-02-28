From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200702280750.24918.jweber@domain.hid>
References: <45E494AC.5050603@domain.hid> <200702280750.24918.jweber@domain.hid>
Content-Type: text/plain
Date: Wed, 28 Feb 2007 14:58:33 +0100
Message-Id: <1172671113.23961.36.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: [Xenomai-core] Re: [Xenomai-help] task not being scheduled
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
To: Jeff Weber <jweber@domain.hid>
Cc: Xenomai Help <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

On Wed, 2007-02-28 at 07:50 -0600, Jeff Weber wrote:
> Switching to the linked timer list from the heap list fixed it.
> 

Ok people, that's a showstopper for v2.3.1.

> 	thanks,
> 	Jeff
> 
> On Tuesday 27 February 2007 14:29, Jan Kiszka wrote:
> > I saw in the .config that you are using the heap timer list. Already
> > tried the classic linked list as well? Maybe we see in issue related to
> > this queue implementation.
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



