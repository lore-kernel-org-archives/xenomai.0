MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17413.53046.678712.9021@domain.hid>
Date: Wed, 1 Mar 2006 17:43:34 +0100
Subject: Re: AW: AW: [Xenomai-core] vxworks-skin taskSpawn
In-Reply-To: <4405A5A3.6020303@domain.hid>
References: <5D63919D95F87E4D9D34FF7748CE2C2A1C3EE6@domain.hid>
	<4405A5A3.6020303@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Roderik_Wildenburg@domain.hid, xenomai@xenomai.org

Philippe Gerum wrote:
 > Roderik_Wildenburg@domain.hid wrote:
 > > Philippe Gerum wrote :
 > > 
 > >>I've run the satch example successfully on an Icecube board 
 > >>here using -rc2. 
 > >>What's the status of this issue on your side? Was it a timer 
 > >>configuration issue as suspected by Gilles?
 > >>
 > > 
 > > 
 > > Status is unchanged. I still try to debugg satch with gdb/ddd and have been a little bit successfull with this.
 >   But I face more and more problems the deeper I dig into the system (e.g. 
 > unresolved symbols when compiling vxWorks-examples
 >   with --debug enabled (see other thread)
 > 
 > This has been fixed in the repository:
 > http://mail.gna.org/public/xenomai-help/2006-02/msg00149.html
 > 

The UVM timer configuration issue is also fixed in the repository: uvm
module insertion fails if the system timer is started in periodic mode.

-- 


					    Gilles Chanteperdrix.

