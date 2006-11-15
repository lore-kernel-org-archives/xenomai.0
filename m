Subject: RE: [Xenomai-help] [PATCH] pthread_setname_np
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB0154F047@domain.hid>
References: <DD39B5C3F4963040ADC9768BE7E430CB0154F047@domain.hid>
Content-Type: text/plain
Date: Wed, 15 Nov 2006 18:50:01 +0100
Message-Id: <1163613001.4974.17.camel@domain.hid>
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

On Wed, 2006-11-15 at 16:56 +0000, Daniel Schnell wrote:
> Gilles Chanteperdrix wrote:
> 
> > If you feel like modifying the documentation, please send a patch.
> 
> Here is the patch.
> 
> Best regards,
> 
> Daniel
> 
> 
> 
> Index: ksrc/skins/posix/thread.c
> ===================================================================
> --- ksrc/skins/posix/thread.c   (revision 1834)
> +++ ksrc/skins/posix/thread.c   (working copy)
> @@ -650,7 +650,7 @@
>  }
> 
>  /**
> - * Set a thread name.
> + * Set the name of a running thread.

s/running/existing/

which boils down to documenting the fact that you must apply this
thread-related request against a valid thread. I'm not sure this is
worth a patch, actually.

-- 
Philippe.



