Received: from out198-29.us.a.mail.aliyun.com (out198-29.us.a.mail.aliyun.com [47.90.198.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8F22AF03
	for <xenomai@lists.linux.dev>; Tue,  5 Aug 2025 03:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754363461; cv=none; b=fiRe3xxw+6so5O8WxmnZuaJvGvfkctwVqIDuy7UGrrjTloiNKJNY5Yh0joOaXfpyymSgIn8NIEJSm0Bz+VzBU0X8jf+pFYthh8CFMMIygbe8Bh41UX2mqz2sPZIuQoOxBhO98kLlUVi//5yy3Xe9fElneSQcGYrcaksUcHIsfeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754363461; c=relaxed/simple;
	bh=ccUcs9pkt1841IlYM7m8Y8VyRXMeV/cUEVEgA9ssgpk=;
	h=Subject:From:Mime-Version:Content-Type:Date:Message-Id:To; b=KolrztNxF54t0V6wKaQlHBri1kbEKttQwjXOGWE7zDDhIoHbutdoXiVW91YQXjBigPW2ugvCJPsJOGfaqj3bSBayazUjBgCAYRznb7oEwITs/gEkQ+YIjMvHdY1vhMWamXwQUyYh4wIVAqexqiwRsD6p06NtD/PxuSWKCTrn5cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn; spf=none smtp.mailfrom=sinsegye.com.cn; arc=none smtp.client-ip=47.90.198.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sinsegye.com.cn
Received: from localhost(mailfrom:liuyang@sinsegye.com.cn fp:SMTPD_---.e6cCnn8_1754361595 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 05 Aug 2025 10:39:56 +0800
Subject:  compile error
From: =?utf-8?q?=E5=88=98=E6=9D=A8?= <liuyang@sinsegye.com.cn>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 Aug 2025 10:39:53 +0800
Message-Id: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.7c286a69.cd5e.495d.9c9c.dd0849b27801@feishu.cn>
To: "Xenomai" <xenomai@lists.linux.dev>
X-Lms-Return-Path: <lba+168916ef9+f2e767+lists.linux.dev+liuyang@sinsegye.com.cn>
Content-Transfer-Encoding: quoted-printable

Hi xenomai=EF=BC=9A
My compilation environment:=C2=A0 kernel 5.15.51 =C2=A0 xenomai:=C2=A0 3.3.=
1=C2=A0 platform: x86_64 =C2=A0=C2=A0 gcc version 13.3.0 (Ubuntu 13.3.0-6ub=
untu2~24.04)
When i enable CONFIG_XENO_DRIVERS_NET_RTCFG_DEBUG, I compilation failed.=C2=
=A0 The error log is below.=C2=A0
#####################################################################
=C2=A0 CC [M]=C2=A0 drivers/xenomai/net/stack/rtcfg/rtcfg_event.o
In file included from ./include/linux/printk.h:582,
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 from ./includ=
e/linux/kernel.h:19,
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 from drivers/=
xenomai/net/stack/rtcfg/rtcfg_event.c:25:
drivers/xenomai/net/stack/rtcfg/rtcfg_event.c: In function =E2=80=98rtcfg_d=
o_main_event=E2=80=99:
./include/linux/dynamic_debug.h:131:49: error: expected expression before =
=E2=80=98do=E2=80=99
=C2=A0 131 | #define __dynamic_func_call(id, fmt, func, ...) do { =C2=A0=C2=
=A0 \
=C2=A0=C2=A0 =C2=A0=C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~
./include/linux/dynamic_debug.h:152:9: note: in expansion of macro =E2=80=
=98__dynamic_func_call=E2=80=99
=C2=A0 152 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 __dynamic_func_call(__UNIQUE_ID(dd=
ebug), fmt, func, ##__VA_ARGS__)
=C2=A0=C2=A0 =C2=A0=C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~
./include/linux/dynamic_debug.h:162:9: note: in expansion of macro =E2=80=
=98_dynamic_func_call=E2=80=99
=C2=A0 162 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 _dynamic_func_call(fmt, __dynamic_=
pr_debug, =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
=C2=A0=C2=A0 =C2=A0=C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:597:9: note: in expansion of macro =E2=80=98dynami=
c_pr_debug=E2=80=99
=C2=A0 597 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 dynamic_pr_debug(fmt, ##__VA_ARGS_=
_)
=C2=A0=C2=A0 =C2=A0=C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~
./drivers/xenomai/net/stack/include/rtcfg/rtcfg.h:45:33: note: in expansion=
 of macro =E2=80=98pr_debug=E2=80=99
=C2=A0=C2=A0 45 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 (rtcfg_debug >=3D (n)) ? (pr_=
debug(fmt, ##__VA_ARGS__)) : 0
=C2=A0=C2=A0 =C2=A0=C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~
drivers/xenomai/net/stack/rtcfg/rtcfg_event.c:107:9: note: in expansion of =
macro =E2=80=98RTCFG_DEBUG=E2=80=99
=C2=A0 107 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 RTCFG_DEBUG(3, "RTcfg: %s() rtdev=
=3D%d, event=3D%s, state=3D%s\n",

I made the following changes and compiled successfully.
diff --git a/kernel/drivers/net/stack/include/rtcfg/rtcfg.h b/kernel/driver=
s/net/stack/include/rtcfg/rtcfg.h
index eb9ad076e..7e480f792 100644
--- a/kernel/drivers/net/stack/include/rtcfg/rtcfg.h
+++ b/kernel/drivers/net/stack/include/rtcfg/rtcfg.h
@@ -41,8 +41,11 @@ extern int rtcfg_debug;
=C2=A0/* use 0 for production, 1 for verification, >2 for debug */
=C2=A0#define RTCFG_DEFAULT_DEBUG_LEVEL 10

-#define RTCFG_DEBUG(n, fmt, ...) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
- =C2=A0 =C2=A0 =C2=A0 (rtcfg_debug >=3D (n)) ? (pr_debug(fmt, ##__VA_ARGS_=
_)) : 0
+#define RTCFG_DEBUG(n, fmt, args...) \
+ =C2=A0=C2=A0 do { \
+ =C2=A0 =C2=A0 =C2=A0=C2=A0 if (rtcfg_debug >=3D (n)) \
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 pr_debug(fmt, ##args); \
+ =C2=A0=C2=A0 } while (0)
=C2=A0#else
=C2=A0#define RTCFG_DEBUG(n, fmt, ...)
=C2=A0#endif /* CONFIG_RTCFG_DEBUG */

Is my modification correct?
Thanks.
