Message-ID: <45795D28.8010606@domain.hid>
Date: Fri, 08 Dec 2006 13:40:08 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Buildbot: Failure building Xenomai kernel for
	TQM860
References: <200612081309.31003.niklaus.giger@domain.hid>
In-Reply-To: <200612081309.31003.niklaus.giger@domain.hid>
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
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

Hi Niklaus,

I just compiled my Linux 2.4 kernel for TQM860L with the latest revision 
of Xenomai and I cannot reproduce your problem. In you linker path there 
are no Xenomai objects. How does it come? Do you use --arch=ppc with 
prepare_kernel (--arch=powerpc is not valid any more for the ppc tree).

Wolfgang.

Niklaus Giger wrote:
> Hi
> 
> I get an error building the TQM860 image (2.4 based kernel). Last successful 
> build was with revision 1920 (didn't build between).
> Log is available under 
> http://ngiger.dyndns.org:8011/tqm_f/builds/30/step-mk_kernel/1
> 
> Best regards
> 


