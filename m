Subject: Re: [Xenomai-help] exception 768
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB0154E8D7@domain.hid>
References: <DD39B5C3F4963040ADC9768BE7E430CB0154E8D7@domain.hid>
Content-Type: text/plain
Date: Fri, 17 Nov 2006 18:32:59 +0100
Message-Id: <1163784779.4980.47.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2006-11-13 at 12:13 +0000, Daniel Schnell wrote:
> Hi,
>  
> I updated to the newest version in svn and applied Xenomai to my Linux
> kernel.
>  
> The first time I ran the application it was running much longer and I
> almost thought everything works smooth now. But after some while it did
> not react any more. No apparant crash message or Oops on the console.
> Instead some strange exception messages in /var/log/messages.
>  
> Please find attached the messages and the kernel symbols. It seems that
> a kernel exception happens inside __copy_tofrom_user().
> 
> Our application linker map was ~roughly 1 mb, so I did not attach it
> here. Some of the addresses I could not resolve to anything inside the
> kernel or our application, so probably some other shared objects like
> glibc are involved here.
> 
> 
> Any ideas ?

Disable CONFIG_XENO_OPT_DEBUG from your kernel configuration, this is
the source of the PTE misses you are seeing now on ppc. This is not to
say that those errors are normal, and this issue still remains to be
fixed, but unless you want to debug the Xenomai nucleus, you don't need
this option on (additionally, it adds a large overhead which translates
in significantly augmented jitter).

-- 
Philippe.



