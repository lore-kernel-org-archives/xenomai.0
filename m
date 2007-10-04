From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <46FB62F2.2010104@domain.hid>
References: <46FA850A.8040201@domain.hid>  <46FB62F2.2010104@domain.hid>
Content-Type: text/plain
Date: Thu, 04 Oct 2007 10:14:44 +0200
Message-Id: <1191485684.20623.34.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] fix SYSENTER_CS modificaton race (was:
	[BUG] sep-related oops on 2.6.20)
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
Cc: adeos-main@gna.org, Xenomai-core@domain.hid

On Thu, 2007-09-27 at 09:59 +0200, Jan Kiszka wrote:

> And here comes the solution:
> 
> The attached patch fixes a race related to changing MSR_IA32_SYSENTER_CS 
> when user space requested vm86[old]() services (I assume my X-server 
> does so in the scenario above, maybe to call into the BIOS). We have to 
> make sure that current->thread is always in sync with the MSR because we 
> consult both in __switch_to, thus we have to enforce atomicity of the 
> related code.
> 
> The patch is for ipipe-1.8-08, but 1.10 is affected just as well.
> 

Merged into both branches, thanks.

> Jan
> 
-- 
Philippe.



