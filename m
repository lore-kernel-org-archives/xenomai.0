Message-ID: <455A1C1D.6060801@domain.hid>
Date: Tue, 14 Nov 2006 20:42:21 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] Xenomai configuration help for Linux 2.4
References: <4555C56B.3070205@domain.hid> <4555DFBE.4050609@domain.hid>
In-Reply-To: <4555DFBE.4050609@domain.hid>
Content-Type: multipart/mixed; boundary="------------070007010209080801030204"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------070007010209080801030204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
> Wolfgang Grandegger wrote:
>> Hello,
>>
>> the attached patch adds Xenomai configuration help for Linux 2.4:
> 
> Cool that you picked this up! Frankly, I didn't expect that this would
> really work without any pitfalls - but it seems to.
> 
> Just one addition feature wish: Could you enhance it so that it can also
> upgrade an existing Configure.help patch? Maybe put some magic marks
> (comments) around the xeno stuff and remove the whole block before
> re-patching the help information?

I think the attached patch does what you want (using sed).

Wolfgang

> 
> Thanks,
> Jan (who wishes that this would also work for Kconfig->Config.in...)
> 


--------------070007010209080801030204
Content-Type: text/x-patch;
 name="xenomai-help-from-kconfig2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-help-from-kconfig2.patch"

Index: scripts/prepare-kernel.sh
===================================================================
--- scripts/prepare-kernel.sh	(revision 1835)
+++ scripts/prepare-kernel.sh	(working copy)
@@ -132,17 +132,27 @@
 patch_help() {
     if which perl > /dev/null; then
 	hfile=$linux_tree/Documentation/Configure.help
-	if ! grep -iq CONFIG_XENO $hfile; then
-	    kfiles=$xenomai_root/scripts/Kconfig.frag
-	    for d in ksrc/nucleus ksrc/skins ksrc/arch/$xenomai_arch \
-		ksrc/drivers sim; do
-		kfiles="$kfiles `find $xenomai_root/$d -name Kconfig`"
-	    done
-	    perl $xenomai_root/scripts/help_from_kconfig.pl $kfiles >> $hfile
-	    if test x$verbose = x1; then
-		echo 'Configuration help added.'
-	    fi
+	if grep -iq "XENOMAI PARAMETERS" $hfile; then
+	    tmp=$hfile.tmp
+	    sed -n -e \
+		'/# BEGIN XENOMAI PARAMETERS/,/# END XENOMAI PARAMETERS/!p' \
+		$hfile > $tmp
+	    mv $tmp $hfile
+	    msg="updated"
+	else
+	    msg="added"
 	fi
+	kfiles=$xenomai_root/scripts/Kconfig.frag
+	for d in ksrc/nucleus ksrc/skins ksrc/arch/$xenomai_arch \
+	    ksrc/drivers sim; do
+	  kfiles="$kfiles `find $xenomai_root/$d -name Kconfig`"
+	done
+	echo "# BEGIN XENOMAI PARAMETERS" >> $hfile
+	perl $xenomai_root/scripts/help_from_kconfig.pl $kfiles >> $hfile
+	echo "# END XENOMAI PARAMETERS" >> $hfile
+	if test x$verbose = x1; then
+	    echo "Configuration help $msg."
+	fi
     fi
 }
 

--------------070007010209080801030204--

