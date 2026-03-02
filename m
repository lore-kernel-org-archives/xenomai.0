Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E5C72631
	for <xenomai@lists.linux.dev>; Mon,  2 Mar 2026 09:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772444906; cv=none; b=nfMvRrx0Vmj5FUPEHf53XxNjftQVzq6swXmICZRGEoMwDoZ9R68nTVgv7J1NrO1e0PJb8O3/Qnb013xUuKLVbxmiAolEq0lHmi2BqZ7O4UW1KVMLyDVwTBej1ibvLoT5qoxE8SDFOmCHLLN1USU3QY4kvHpMDSti+v8leV17Qck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772444906; c=relaxed/simple;
	bh=CsBwAiL2qvA0yhzOKNzPmKOrlO7f7kaIq+QmDQlTdV0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wmv4uiIoTnpunOmVfBa+y+KscLWNnJynquGzDnH8fuCsga/u0pMan/pd6rQUByu8hqDgK/OtsrIrJvJlXPfX/Ln/7EfBpszaeV/cUGVSKVRWVt4oA/DMRuRqYGYeJF31JY7MakXoxwL+0aXmbk2IGBaArgG6nZ2Aqp8NNqbA7EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=WumSLuj6; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="WumSLuj6"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20260302093811ee44f0d6e90002073f
        for <xenomai@lists.linux.dev>;
        Mon, 02 Mar 2026 10:38:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=m/YJOcKP0Xjn3I69IsriCLEjiZ3yGXdt9GOlyZPl5uM=;
 b=WumSLuj6V058LkG6FDWQEj9F5GO4F8gRMigVAOcTNQ9PE3x8qQPDjqjqNuSEu5eQdDwY9N
 Sd8S3fWL5do4Ni2xG1k0L3psFBoQEAdHLZO4Gk3WDNKoXbu4+A2Yz/TfYhd7qx88b3Jf3UAg
 BdW/0whj1ApE3K+0bkRW1f0EfUg5Nq9+dbsXgR0cTFDjhs1Zddbi6/PXYSWedturBsI13N3S
 IzAbp2IrnfwnBWdoSWFhutkKNj9rQOtrfDHOvDL0LZWlvZ9d7o0WkgzyFZ7HdkBG2TAVH6k9
 jTSkWWjRLufWPsgGJ6yhtKHJJtBZvxjMo7hgI7WdVHTyxYYbiCISa2AA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 02 Mar 2026 10:38:19 +0100
Subject: [PATCH v2 20/20] scripts/xeno-config: Allow disabling the y2038 /
 time64_t support
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-wip-flo-fix-time64-32bit-native-v2-20-7caefce29bcd@siemens.com>
References: <20260302-wip-flo-fix-time64-32bit-native-v2-0-7caefce29bcd@siemens.com>
In-Reply-To: <20260302-wip-flo-fix-time64-32bit-native-v2-0-7caefce29bcd@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

xeno-config got a new cmdline option --disable-y2038 that will disable
the time64_t or (year 2038) support inside the application that is
being build against libcobalt.

libcobalt provides both interfaces, so for native time_t and for
time64_t at the same time. By default, the time64_t based interfaces
will be used. If an application does really want to go back to native
time_t --disable-y2038 has to be specified before the --cflags option.

The new parameter is only useful for (old) 32 bit applications.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 scripts/xeno-config-cobalt.in | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/xeno-config-cobalt.in b/scripts/xeno-config-cobalt.in
index 46b6c11b92fe20e4474e0173a211b18dc5cd7e3b..ecbfefb8f0a9f7ea99864d07e5f717841ef5da4e 100644
--- a/scripts/xeno-config-cobalt.in
+++ b/scripts/xeno-config-cobalt.in
@@ -62,6 +62,7 @@ Options :
         --core
         --info
         --compat
+        --disable-y2038
 EOF
     exit $1
 }
@@ -173,6 +174,9 @@ while test $# -gt 0; do
 	--posix|--cobalt|--vxworks|--psos|--alchemy|--rtdm|--smokey)
 	    skin_list="$skin_list `expr "$1" : '--\(.*\)'`"
 	    ;;
+	--disable-y2038)
+	    disable_y2038=y
+	    ;;
 	--cflags)
 	    do_cflags=y
 	    ;;
@@ -233,6 +237,7 @@ if test x$do_cflags = xy; then
 		;;
 	esac
     done
+    test x$disable_y2038 = xy && cflags="$cflags -U_TIME_BITS -U_FILE_OFFSET_BITS"
     echo $cflags
 fi
 

-- 
2.53.0

