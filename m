Message-ID: <444419E1.6040100@domain.hid>
Date: Tue, 18 Apr 2006 00:42:41 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] let skins select nucleus features
References: <443E99C5.70202@domain.hid> <4442786B.40301@domain.hid>
In-Reply-To: <4442786B.40301@domain.hid>
Content-Type: multipart/mixed; boundary="------------090606000005050507070607"
Sender: jan.kiszka@domain.hid
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
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------090606000005050507070607
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Hi,
>>
>> this patch aims at avoiding to select unneeded nucleus features if no
>> user is requiring it in the skins. Particularly, it addresses the
>> nucleus registry and the pipes.
>>
>> I have spent no effort on 2.4 yet as I first want to wait for comments.
>> Furthermore, 2.4. is lacking "select", so the feature selection has to
>> remain manually there anyway.
> 
> Looks good. Merged, thanks.
> 

In the same sense, but not that comfortable, here is the a 2.4 variant
of the patch.

Jan

--------------090606000005050507070607
Content-Type: text/x-patch;
 name="nucl-reg-select-2.4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nucl-reg-select-2.4.patch"

Index: ksrc/skins/vrtx/Config.in
===================================================================
--- ksrc/skins/vrtx/Config.in	(Revision 941)
+++ ksrc/skins/vrtx/Config.in	(Arbeitskopie)
@@ -2,4 +2,10 @@
 # Xenomai configuration for Linux v2.4
 #
 
+if [ "$CONFIG_XENO_OPT_REGISTRY" = "n" ]; then
+	comment 'VRTX emulator requires CONFIG_XENO_OPT_REGISTRY'
+else
+
 dep_tristate 'VRTX emulator' CONFIG_XENO_SKIN_VRTX $CONFIG_XENO_OPT_NUCLEUS
+
+fi
Index: ksrc/skins/vxworks/Config.in
===================================================================
--- ksrc/skins/vxworks/Config.in	(Revision 941)
+++ ksrc/skins/vxworks/Config.in	(Arbeitskopie)
@@ -2,4 +2,10 @@
 # Xenomai configuration for Linux v2.4
 #
 
+if [ "$CONFIG_XENO_OPT_REGISTRY" = "n" ]; then
+	comment 'VxWorks emulator requires CONFIG_XENO_OPT_REGISTRY'
+else
+
 dep_tristate 'VxWorks emulator' CONFIG_XENO_SKIN_VXWORKS $CONFIG_XENO_OPT_NUCLEUS
+
+fi
Index: ksrc/skins/native/Config.in
===================================================================
--- ksrc/skins/native/Config.in	(Revision 941)
+++ ksrc/skins/native/Config.in	(Arbeitskopie)
@@ -2,6 +2,10 @@
 # Xenomai configuration for Linux v2.4
 #
 
+if [ "$CONFIG_XENO_OPT_PERVASIVE" = "y" -a "$CONFIG_XENO_OPT_REGISTRY" = "n" ]; then
+	comment 'Native skin requires CONFIG_XENO_OPT_REGISTRY in pervasive mode'
+else
+
 dep_tristate 'Native skin' CONFIG_XENO_SKIN_NATIVE $CONFIG_XENO_OPT_NUCLEUS
 
 if [ "$CONFIG_XENO_SKIN_NATIVE" != "n" ]; then
@@ -24,3 +28,5 @@ if [ "$CONFIG_XENO_SKIN_NATIVE" != "n" ]
 	bool 'Interrupts' CONFIG_XENO_OPT_NATIVE_INTR
 	endmenu
 fi
+
+fi
Index: ksrc/nucleus/Config.in
===================================================================
--- ksrc/nucleus/Config.in	(Revision 941)
+++ ksrc/nucleus/Config.in	(Arbeitskopie)
@@ -17,11 +17,7 @@ if [ "$CONFIG_XENO_OPT_NUCLEUS" != "n" ]
 	if [ "$CONFIG_XENO_OPT_PIPE" != "n" ]; then
 		int 'Number of pipe devices' CONFIG_XENO_OPT_PIPE_NRDEV 32
 	fi
-	if [ "$CONFIG_XENO_OPT_PERVASIVE" != "n" ]; then
-		define_bool CONFIG_XENO_OPT_REGISTRY y
-	else
-		bool 'Registry support' CONFIG_XENO_OPT_REGISTRY
-	fi
+	bool 'Registry support' CONFIG_XENO_OPT_REGISTRY
 	if [ "$CONFIG_XENO_OPT_REGISTRY" != "n" ]; then
 		int 'Number of registry slots' CONFIG_XENO_OPT_REGISTRY_NRSLOTS 512
 	fi

--------------090606000005050507070607--

