Message-ID: <434B75C7.9090509@domain.hid>
Date: Tue, 11 Oct 2005 11:20:23 +0300
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

>  It would seem
> 
>> quite easy and there's already lots of redundant code there, but 
>> possible problems arise from being able to work with both the old 
>> unmerged kernels and the future merged arch kernels.
> 
> 
> Would the issues be located at the Adeos level, or would this leak to 
> Xeno's arch-dep layer?

I suppose adeos level should go nicely with the kernel changes once 
they're in place; we can easily mimick the kernel techniques (#ifdefs) 
to tell which arch we're on. The issues would be with Xeno having to 
distinguish the kernel were building for. I'm quite sure putting all the 
Xenomai stuff under a common powerpc and having a few #ifdef 
__powerpc32/64__ won't be enough. Having SAID that, it probably will 
enough, though :)

-- Heikki Lindholm

