Message-ID: <4546494d0611022048i120b6437lf363bc8a8af3f16e@domain.hid>
Date: Fri, 3 Nov 2006 12:48:21 +0800
From: "Li Yi (Adam)" <liyiadam@domain.hid>
In-Reply-To: <1160687379.4970.34.camel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_23790_33498537.1162529301293"
References: <4546494d0609300026s6be1145awedaeb10af460d56d@domain.hid>
	<1160687379.4970.34.camel@domain.hid>
Subject: [Xenomai-core] Re: Updated ADEOS patch for Blackfin uClinux 2006R2
	release
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: adeos-main@gna.org, xenomai@xenomai.org

------=_Part_23790_33498537.1162529301293
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Philippe,

"This said, I'm currently struggling with the tracer, which makes the
bf533 freeze when enabled, during the very early boot steps. I suspect
some issues with having -pg enabled for early setup code. Another issue
causes the linker to choke on the "mcount" symbol being undefined for
some files; this looks like some inconsistency with the C symbol prefix.
Btw, I'm using the 06r2 toolchain."

Sorry for the late response - I was on vocation and did not check mails for
a long time.
I have tried your merged bfin-adeos patch. I also saw the frozen at boot
time.
And the "mcount" undefined symbol error. This is due to issue in 06r2
toolchain when dealing with "-pg" option.
I am talking with the toolchain developer to add the fix into 06r2 updated
release.

And I will test the bfin-adeos patch to make sure it works for 06r2 kernel
and 06r2 toolchain and give you update when finished.

Thanks

-Yi

On 10/13/06, Philippe Gerum <rpm@xenomai.org> wrote:
>
>
> Hello Yi,
>
> On Sat, 2006-09-30 at 15:26 +0800, Li Yi (Adam) wrote:
> > Hi Philippe,
> >
> > I updated the adeos-bfin patch to bfin-uClinux 2006R2 (the release
> > will be available soon).
> > Could you please have a look?
>
> This looks good, and works as expected, thanks.
>
> > The patch can also be found and the bfin-uClinux CVS:
> >
> http://blackfin.uclinux.org/plugins/scmcvs/cvsweb.php/~checkout~/uClinux-dist/bfin_patch/adeos_patch/adeos-bfin-cvs.patch?rev=1.1.2.1;content-type=text%2Fplain;cvsroot=uclinux533
> >
>
> Ok, I've merged your patch with the latest generic changes in the Adeos
> CVS, so we will have the Blackfin support in sync with the most recent
> I-pipe updates, over the Blackfin CVS head. Figures look good, actually
> with a better worst-case than the 1.4 series had, likely due to the
> PF_EVNOTIFY feature which has been recently introduced. The large
> latency spot I told you recently about has also been fixed in the
> meantime (the vanilla Blackfin kernel was out of cause, but the Adeos
> PF_EVNOTIFY feature did break due to a Blackfin-specific issue).
>
> I'm now merging your tracer support. From now on, the latter will be
> integrated to the main Adeos patch for all archs, since it does not make
> much sense to have two separate patches for each of them now, which
> would also uselessly increase the maintenance burden.
>
> This said, I'm currently struggling with the tracer, which makes the
> bf533 freeze when enabled, during the very early boot steps. I suspect
> some issues with having -pg enabled for early setup code. Another issue
> causes the linker to choke on the "mcount" symbol being undefined for
> some files; this looks like some inconsistency with the C symbol prefix.
> Btw, I'm using the 06r2 toolchain.
>
> Could you send me your .config with the tracer options you used
> (configuration for a bf533 or bf537 would do), and confirm that an
> unmodified 06r2 toolchain should work properly building the whole tree
> with -pg enabled? TIA,
>
> > Best Regards,
> >
> > -Yi
> --
> Philippe.
>
>
>

------=_Part_23790_33498537.1162529301293
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Philippe,<br><br>&quot;This said, I'm currently struggling with the <span id="st" name="st" class="st">tracer</span>, which makes the<br>bf533 freeze when enabled, during the very early boot steps. I suspect<br>some issues with having -pg enabled for early setup code. Another issue
<br>causes the linker to choke on the &quot;mcount&quot; symbol being undefined for<br>some files; this looks like some inconsistency with the C symbol prefix.<br>Btw, I'm using the 06r2 toolchain.&quot;<br><br>Sorry for the late response - I was on vocation and did not check mails for a long time.
<br>I have tried your merged bfin-adeos patch. I also saw the frozen at boot time.<br>And the &quot;mcount&quot; undefined symbol error. This is due to issue in 06r2 toolchain when dealing with &quot;-pg&quot; option.<br>
I am talking with the toolchain developer to add the fix into 06r2 updated release.<br><br>And I will test the bfin-adeos patch to make sure it works for 06r2 kernel and 06r2 toolchain and give you update when finished.<br>
<br>Thanks <br><br>-Yi<br><br><div><span class="gmail_quote">On 10/13/06, <b class="gmail_sendername">Philippe Gerum</b> &lt;<a href="mailto:rpm@xenomai.org">rpm@xenomai.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>Hello Yi,<br><br>On Sat, 2006-09-30 at 15:26 +0800, Li Yi (Adam) wrote:<br>&gt; Hi Philippe,<br>&gt;<br>&gt; I updated the adeos-bfin patch to bfin-uClinux 2006R2 (the release<br>&gt; will be available soon).<br>&gt; Could you please have a look?
<br><br>This looks good, and works as expected, thanks.<br><br>&gt; The patch can also be found and the bfin-uClinux CVS:<br>&gt; <a href="http://blackfin.uclinux.org/plugins/scmcvs/cvsweb.php/~checkout~/uClinux-dist/bfin_patch/adeos_patch/adeos-bfin-cvs.patch?rev=1.1.2.1;content-type=text%2Fplain;cvsroot=uclinux533">
http://blackfin.uclinux.org/plugins/scmcvs/cvsweb.php/~checkout~/uClinux-dist/bfin_patch/adeos_patch/adeos-bfin-cvs.patch?rev=1.1.2.1;content-type=text%2Fplain;cvsroot=uclinux533</a><br>&gt;<br><br>Ok, I've merged your patch with the latest generic changes in the Adeos
<br>CVS, so we will have the Blackfin support in sync with the most recent<br>I-pipe updates, over the Blackfin CVS head. Figures look good, actually<br>with a better worst-case than the 1.4 series had, likely due to the<br>
PF_EVNOTIFY feature which has been recently introduced. The large<br>latency spot I told you recently about has also been fixed in the<br>meantime (the vanilla Blackfin kernel was out of cause, but the Adeos<br>PF_EVNOTIFY feature did break due to a Blackfin-specific issue).
<br><br>I'm now merging your tracer support. From now on, the latter will be<br>integrated to the main Adeos patch for all archs, since it does not make<br>much sense to have two separate patches for each of them now, which
<br>would also uselessly increase the maintenance burden.<br><br>This said, I'm currently struggling with the tracer, which makes the<br>bf533 freeze when enabled, during the very early boot steps. I suspect<br>some issues with having -pg enabled for early setup code. Another issue
<br>causes the linker to choke on the &quot;mcount&quot; symbol being undefined for<br>some files; this looks like some inconsistency with the C symbol prefix.<br>Btw, I'm using the 06r2 toolchain.<br><br>Could you send me your .config with the tracer options you used
<br>(configuration for a bf533 or bf537 would do), and confirm that an<br>unmodified 06r2 toolchain should work properly building the whole tree<br>with -pg enabled? TIA,<br><br>&gt; Best Regards,<br>&gt;<br>&gt; -Yi<br>--
<br>Philippe.<br><br><br></blockquote></div><br>

------=_Part_23790_33498537.1162529301293--

