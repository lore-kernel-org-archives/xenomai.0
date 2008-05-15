Message-ID: <482BEA7D.3020807@domain.hid>
Date: Thu, 15 May 2008 09:47:09 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <482193F0.6000401@domain.hid>
In-Reply-To: <482193F0.6000401@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [patch] prevent endless loop in prepare-kernel.sh
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
To: "Hillier, Gernot" <gernot.hillier@domain.hid>
Cc: xenomai@xenomai.org

Hillier, Gernot wrote:
> Hi there!
> 
> Just noted that prepare-kernel.sh ends up in an endless loop when you 
> use "--default" together with an invalid "--arch" parameter.
> 
> Here's a small patch. Please apply. TIA!
> 
> Index: scripts/prepare-kernel.sh
> ===================================================================
> --- scripts/prepare-kernel.sh	(Revision 3753)
> +++ scripts/prepare-kernel.sh	(Arbeitskopie)
> @@ -327,6 +327,7 @@
>      *)
>         echo "$me: unsupported architecture: $linux_arch" >&2
>         linux_arch=
> +      usedefault=
>         ;;
>      esac
>      if test \! x$linux_arch = x; then
> @@ -384,6 +385,7 @@
>         fi
>         if test \! -r "$adeos_patch"; then
>            echo "$me: cannot read Adeos patch from $adeos_patch" >&2
> +         usedefault=
>            adeos_patch=
>         fi
>      done
> 

Merged, thanks.

-- 
Philippe.

