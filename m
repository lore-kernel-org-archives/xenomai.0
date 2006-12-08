From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Buildbot: Failure building Xenomai kernel for
	TQM860
Date: Fri, 8 Dec 2006 15:10:05 +0100
References: <200612081309.31003.niklaus.giger@domain.hid>
	<45795D28.8010606@domain.hid>
In-Reply-To: <45795D28.8010606@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612081510.05174.niklaus.giger@domain.hid>
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

Am Freitag, 8. Dezember 2006 13:40 schrieb Wolfgang Grandegger:
> Hi Niklaus,
>
> I just compiled my Linux 2.4 kernel for TQM860L with the latest revision
> of Xenomai and I cannot reproduce your problem. In you linker path there
> are no Xenomai objects. How does it come? Do you use --arch=ppc with
> prepare_kernel (--arch=powerpc is not valid any more for the ppc tree).
As seen in http://ngiger.dyndns.org:8011/tqm_f/builds/30/step-prep_bb/0
Exec in /var/buildbot/slave/tqm_f/xenomai: 
scripts/prepare-kernel.sh --arch=ppc --adeos=ksrc/arch/powerpc/patches/adeos-ipipe-2.4.25-*.patch --linux=/var/buildbot/slave/tqm_f/linux
Then in http://ngiger.dyndns.org:8011/tqm_f/builds/30/step-cfg_kernel/0
/var/buildbot/scripts/configure.sh /var/buildbot/configs/TQM860L_defconfig 
CROSS_COMPILE=powerpc-860-linux-gnu- ARCH=ppc
and finally the build with 
make --jobs=4 uImage modules
The http logs also show all environment variables (e.g. CROSS_COMPILE, PATH).

You can navigate between the different builds and buildsteps on 
http://ngiger.dyndns.org:8011/. I tried to make all steps transparent to the 
observer, to enable them to verify themselves all the build step. If you are 
unable to reach this site please tell me so. I updated my apache2 server and 
since this time the proxy/reverse proxy form 
http://ngiger.dyndns.org/buildbot to http://ngiger.dyndns.org:8011/ does not 
work anymore (but that is another problem I am investigating).

I did not change my Buildbot master setup since December 4. The 
prepare_slave.rb was updated on December 3
I updated today the TQM860L_defconfig to enable more CAN drivers etc, but that 
didn't change the error.

Build 28 (revision 1920) completed without any problem on December 6, and the 
build on December 7 (revision 1930). All these build are full build, meaning 
that all the build directories get removed before starting the 
prepare_kernel.sh

Did you also clean rebuild?

Is there somewhere a missing include?
I see that include/xenomai/nucleus/pod.h has 
#define xnlogerr(fmt,args...)  xnarch_logerr(fmt , ##args
But grep finds xnlogerr in the following object files
kernel/xenomai/nucleus/xeno_nucleus.o.
kernel/xenomai/nucleus/built-in.o.

> Wolfgang.
>
> Niklaus Giger wrote:
> > Hi
> >
> > I get an error building the TQM860 image (2.4 based kernel). Last
> > successful build was with revision 1920 (didn't build between).
> > Log is available under
> > http://ngiger.dyndns.org:8011/tqm_f/builds/30/step-mk_kernel/1
> >
> > Best regards

-- 
Niklaus Giger

