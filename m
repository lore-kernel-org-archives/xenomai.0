Message-ID: <47ED4DE3.2010003@domain.hid>
Date: Fri, 28 Mar 2008 20:58:27 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <20080328185158.GA9009@domain.hid>
In-Reply-To: <20080328185158.GA9009@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [PATCH][SOLO] clarify --prefix option
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
To: Robert Schwebel <r.schwebel@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Robert Schwebel wrote:
> Clafifies the description of the --prefix option in the README.
> 
> Signed-off-by: Robert Schwebel <r.schwebel@domain.hid>
> 
> ---
>  README |   11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> Index: xenomai-solo/README
> ===================================================================
> --- xenomai-solo.orig/README	2008-03-28 19:07:27.000000000 +0100
> +++ xenomai-solo/README	2008-03-28 19:11:25.000000000 +0100
> @@ -33,12 +33,13 @@
>  
>  Where <options> may be any standard autoconf switch, such as:
>  
> ---prefix=<install-dir>
> +--prefix=<dir>
>  
> -	To specify the installation root directory, under which
> -	libraries, include files, scripts and executables will be
> -	copied when running "make install". This directory defaults to
> -	/usr/local/solo.
> +	To specify the runtime path for the installation of libraries,
> +	include files, scripts and executables. "make install" installs
> +	these files to ${DESTDIR}/<dir>.
> +
> +	This directory defaults to /usr/local/solo.
>  
>  or Xenomai-specific knobs:
>  
> 

Merged, thanks.

-- 
Philippe.

