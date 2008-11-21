Message-ID: <492637CB.1000707@domain.hid>
Date: Fri, 21 Nov 2008 05:23:39 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <200811190056.12595.berlemont.hauw@domain.hid>
In-Reply-To: <200811190056.12595.berlemont.hauw@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Unstable driver integration policy
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
To: Alexis Berlemont <berlemont.hauw@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>


Alex,

Alexis Berlemont wrote:
> Hi,
> 
> I would like to find a way to populate the Comedi drivers set.
> 
> However, I am stuck by a simple fact: I have no acquisition board to validate 
> a least driver...
> 
> Starting from here, I am trying to find out what should be the proper method 
> to provide non-validated drivers to anybody inclined to test them. 
> 
> Do you think creating a specific subversion branch for this stuff would be a 
> good idea ?
>

I don't think so. Moving that code away from the focal point where people are
expected to find new code to test and work with won't help.

You could decide instead to implement drivers for a small set of very popular
acquisition cards; whether that implementation is eventually fully validated or
not depends on other people to have enough interest in that work to give you
access to some hw, or to validate the driver themselves. As Jan pointed out,
"experimental" is a convenient sticker to tell people about the exact state of
this work.

You spark the effort (this is _always_ the hardest and most demanding part of
the job), they help finalize it if they want to get serious about this.

> Alexis.
> 
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
> 


-- 
Philippe.

