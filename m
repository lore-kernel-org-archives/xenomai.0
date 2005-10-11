Message-ID: <434B773B.2080500@domain.hid>
Date: Tue, 11 Oct 2005 11:26:35 +0300
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Linux powerpc merger
References: <434AAEBB.4050301@domain.hid> <434B71D7.4050609@domain.hid>
In-Reply-To: <434B71D7.4050609@domain.hid>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe Gerum kirjoitti:
> Heikki Lindholm wrote:
> 
>> Hello,
>>
>> As people following powerpc kernel mailing lists probably know, the 
>> Linux "ppc" and "ppc64" architectures are merging into a single 
>> "powerpc" arch. I think the same should be done to fusion.
> 
> 
> Agreed. Let's closely follow the "natural" development path of the 
> kernel incarnations we use for our ports; especially when such path is 
> sensible.
> 
>  It would seem
> 
>> quite easy and there's already lots of redundant code there, but 
>> possible problems arise from being able to work with both the old 
>> unmerged kernels and the future merged arch kernels.
> 
> 
> Would the issues be located at the Adeos level, or would this leak to 
> Xeno's arch-dep layer?
> 
>  Is there any ideas
> 
>> regarding or work being done on this front?
> 
> 
> I plan to restart working on the I-pipe/ppc patch shortly, so that we 
> can both upgrade the Adeos architecture and the kernel version available 
> for Xeno's ppc port. Since most of the work has been done already, we 
> should synchronize and start crafting a patch for the ppc* combo after 
> the initial I-pipe/ppc one.

We could actually start by proactively (ugh!) merging the Xenomai ppc 
and ppc64 dirs into one powerpc dir like the kernel folks do and see if 
we can get it to work with the current separate ppc/ppc64 patches. I 
actually had this in mind when I noticed how much code would be 
unchanged for the ppc64 arch, but decided to do it separately anyway in 
case something bigger would have surfaced later, which it seems it didn't.

-- Heikki Lindholm

