Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD3A31AABF
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 09:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771578544; cv=none; b=To98fC1Ez6x42Oj80FmXJEiy+lZF0gt3jQal7xBOiId1uzTQ2eLHlOrrZpOmq3ie419GjS29EEHDOpVZnN8n01n4CIDMv257aC9YHhF6zpdMpcryyidsSMBJvEpTpAxbv1lXfNjvPpUopG9mJm+er0WwLBW43dFMaXMvL3OR6SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771578544; c=relaxed/simple;
	bh=CsBwAiL2qvA0yhzOKNzPmKOrlO7f7kaIq+QmDQlTdV0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tX1DPTvEPrvPtS1IW/GZXhjzxrdXNbe1q5Ef5ivdWuLGD8VM4WTkInd7cRpG0tTdU8jpOk6JI/SyIWTgraFwJSRhMroqz8RNR7tWVHcl1LQsrt3eIOkHaRtdHoALUdKIFWKq1gdr/iJIqWsMDdwoK2+I7ht/+D5SdEIUAsITuM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=ggD00M6y; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="ggD00M6y"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20260220090849e0955e0a670002076c
        for <xenomai@lists.linux.dev>;
        Fri, 20 Feb 2026 10:08:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=m/YJOcKP0Xjn3I69IsriCLEjiZ3yGXdt9GOlyZPl5uM=;
 b=ggD00M6y8aFyZil0TiSrD86MONegnlZqSh95Z4D4hcIcGKlIV6au1K7uw03dgwacOL3gbq
 nmut8xDbnayV64mW1QQ90KhSCzKN1XfN0jF+hJKbMr1Dk/lfkyMPeAP8jcaMFM6l0Sw688IF
 H94kMwCE6Mi7Ym0WMz2ulYmw8j3UgGWY0UUxx6GClwRaYhVbuCivZoTjVso90HU22If0X9ZE
 pPYjUC44Z+gyidw9pAuBYkUsNghIt4mIFV4X+Pwvwv4F3BTg4piCfhBgAeSvlyowH0aTmQDL
 7Ln+mjuP1PgZsUsrCzZwFkPziGK/vgh6VJNOvToGL6WjtI4BiXGRimLg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 20 Feb 2026 10:09:03 +0100
Subject: [PATCH 20/20] scripts/xeno-config: Allow disabling the y2038 /
 time64_t support
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-wip-flo-fix-time64-32bit-native-v1-20-731c773e72cc@siemens.com>
References: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
In-Reply-To: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
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

