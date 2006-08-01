From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Wed, 2 Aug 2006 00:50:35 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608020050.35697.berlemont.hauw@domain.hid>
Subject: [Xenomai-core] Re: Comedi4xenomai (Was: Re: [Orocos-Dev] [Bug 115]
	[Project] Move device drivers to orocos-components)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Klaas Gadeyne <klaas.gadeyne@domain.hid>, xenomai-core <xenomai@xenomai.org>
Cc: Orocos Developers <orocos-dev@domain.hid>

Hi,

> > > This could change fast with e.g. comedi4xenomai in the pipeline...
> >
> > Do you have more information about this?
>
> [putting Alexis Berlemont in cc:, as he is probably the one who can
> answer this question]
> I haven't seen anything on the xenomai MLs lately.  AFAIS from
> <http://svn.gna.org/viewcvs/xenomai/branches/> there hasn't been a lot
> of activity on the branch lately.
>

Sorry for answering so late, I was on holiday.

comedi-over-rtdm is currently undergoing deep modifications. I am trying to 
redefine an architecture more suitable for RTDM. That implies I am rewriting 
a big chunk of the Comedi code and its drivers without commiting into SVN.

I thought it was a bad idea to commit broken code (It does not even compile). 
Tell me if I'm wrong.

This is one of the two reasons why you did not notice any change on the comedi 
branch in the SVN trunk the last two months.

The other reason is private, bought a little flat =>  moved out => moved in => 
working on the appartment => all this stuff took and is still taking a lot of 
my spare time ;)

Eventually, if anyone is interested in the new comedi4xeno architecture, I 
will try to commit a reduced version in two or three weeks. 

> I don't know if that means the comedi-over-rtdm code is already in a
> "usable" state as is?

The code available in the trunk is a proof of concept, it does not contain 
real drivers, you can just find test drivers.

Regards.

Alexis.

