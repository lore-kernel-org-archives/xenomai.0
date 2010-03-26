From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <181804936ABC2349BE503168465576460E388C67@domain.hid>
References: <181804936ABC2349BE503168465576460E388C67@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 26 Mar 2010 06:20:45 +0100
Message-ID: <1269580845.2418.133.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Patch series for Denx ipipe?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steve Deiters <SteveDeiters@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2010-03-24 at 17:39 -0500, Steve Deiters wrote:
> Hello,
>  
> I was wondering if anyone knows if there is a patch series available
> for the Denx ipipe Git heads?  I was wanting to try out the version
> for the 2.6.33 kernel with the latest Xenomai, but the Git head
> already has all the patches applied to the kernel when I download a
> snapshot
> (http://git.denx.de/?p=ipipe-2.6.git;a=shortlog;h=refs/heads/ipipe-2.6.33-powerpc).  I was looking for a patch so that I could easily use it with the Xenomai installer. 

prepare-kernel.sh will detect that your kernel is pre-patched, and won't
ask for a separate pipeline patch.

>  If one doesn't exist, does anyone know which kernel tree this might
> be based off of so I can try to make a patch myself?

See there:
http://git.xenomai.org/?p=xenomai-2.5.git;a=blob;f=ksrc/arch/powerpc/patches/README;h=010a86ecabce19212a8eaa1e0aaf8dc43b4805f3;hb=HEAD

>  
> Thanks.
>  
>  
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.



