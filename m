Message-ID: <434B71D7.4050609@domain.hid>
Date: Tue, 11 Oct 2005 10:03:35 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Linux powerpc merger
References: <434AAEBB.4050301@domain.hid>
In-Reply-To: <434AAEBB.4050301@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Heikki Lindholm <holindho@domain.hid>
Cc: xenomai@xenomai.org

Heikki Lindholm wrote:
> Hello,
> 
> As people following powerpc kernel mailing lists probably know, the 
> Linux "ppc" and "ppc64" architectures are merging into a single 
> "powerpc" arch. I think the same should be done to fusion.

Agreed. Let's closely follow the "natural" development path of the kernel 
incarnations we use for our ports; especially when such path is sensible.

  It would seem
> quite easy and there's already lots of redundant code there, but 
> possible problems arise from being able to work with both the old 
> unmerged kernels and the future merged arch kernels.

Would the issues be located at the Adeos level, or would this leak to Xeno's 
arch-dep layer?

  Is there any ideas
> regarding or work being done on this front?

I plan to restart working on the I-pipe/ppc patch shortly, so that we can both 
upgrade the Adeos architecture and the kernel version available for Xeno's ppc 
port. Since most of the work has been done already, we should synchronize and 
start crafting a patch for the ppc* combo after the initial I-pipe/ppc one.

-- 

Philippe.

