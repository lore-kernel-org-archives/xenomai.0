Message-ID: <4A3D471A.6050007@domain.hid>
Date: Sat, 20 Jun 2009 22:31:22 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4A3CC746.3040605@domain.hid> <1245510817.4090.186.camel@domain.hid>
In-Reply-To: <1245510817.4090.186.camel@domain.hid>
Content-Type: multipart/mixed; boundary="------------050804030202050602060209"
Subject: Re: [Xenomai-help] debian specific kernel patching/unpatching
 problems with 2.6.29
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------050804030202050602060209
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Philippe Gerum schrieb:
> On Sat, 2009-06-20 at 13:25 +0200, Stefan Kisdaroczi wrote:
>   
>> Hi,
>>
>> applying the xenomai kernelpatch created during debian package building
>> results to a corrupt init/Kconfig file and 'make menuconfig' fails. The 
>> problem
>> starts with linux-2.6.29.  reason: growing init/Kconfig file, see  [1].
>> This patch [2] fixed it (tested with 2.6.28 and 2.6.29).
>>
>> [...]
> Thunderbird did massive whitespace damages to your patch it seems; could
> you resend it attached? TIA,
>   
sorry, attached.


--------------050804030202050602060209
Content-Type: text/x-diff;
 name="initKconfig.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="initKconfig.patch"

diff -uNrp xenomai-2.4.91.orig/debian/prepare-patch.sh xenomai-2.4.91/debian/prepare-patch.sh
--- xenomai-2.4.91.orig/debian/prepare-patch.sh	2009-03-30 12:24:49.000000000 +0200
+++ xenomai-2.4.91/debian/prepare-patch.sh	2009-06-20 11:40:13.000000000 +0200
@@ -78,7 +78,7 @@ diff_addons() {
 
     echo "--- linux/init/Kconfig	1970-01-01 01:00:00.000000000 +0100" >> $patch_file
     echo "+++ linux-patched/init/Kconfig	2007-03-06 17:55:58.000000000 +0000" >> $patch_file
-    echo "@@ -950,0 +950,$lines @@" >> $patch_file
+    echo "@@ -1400,0 +1400,$lines @@" >> $patch_file
     sed -e "s,@LINUX_ARCH@,$linux_arch,g" $xenomai_root/scripts/Kconfig.frag | sed 's/^/+/' >> $patch_file
     echo " " >> $patch_file
 }

--------------050804030202050602060209--

