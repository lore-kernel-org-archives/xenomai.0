Received: from sonic307-33.consmr.mail.ir2.yahoo.com (sonic307-33.consmr.mail.ir2.yahoo.com [87.248.110.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0AB5392
	for <xenomai@lists.linux.dev>; Wed, 22 Feb 2023 14:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677074874; bh=qq0Du5mvTmdJy/r8ww5nIr0Y7VKqvDWDxAsyQFqTyGg=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=ebzHMYGcb2Vxa53O94nGxD6sFe0JHOVvEWv4DIItnynk4+dNRMUDocyjz5wpROF4dWvZ05GFUdE30jjHsDgcxCli/9LfUxcBrBmYOFJOsvz1HCYMgVV5P1cEmaY7flXlhRiSBJqIkQDTOdQDVuepwVBYiWvUWDfIlkm6bk8MVsfqkC1u+uHckWrWMxWJKY7Km7nEQkVrCSSFHNzxKpwYCghwr9wleClx3upfBL+lY4f1eTAcGzzV2HAjp5iV8GUSy7+cgOh7jobcxqipVoQy9JHEhC9j5zvumIQiVcQPfQn18KdrCeIc3sc904N2O8IZwn3FBNNvT/gcbt3ewo9rlQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677074874; bh=WptaceeLVkakU0phP11C4uipf8HpPXl7J1A+C1Zx1wX=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=FHdYd6FBizS2aCnPMOUnFjUA1NBhkG3oKuwqVPghyKFMkqGs2qBm3EEvHyDDL/OfY8p37qCR9nUMLlT+UdE289MJ1UGWrpMbTtvO1qH+epmU1Ztu1lefU5wgc9dciYFQoWbJW5w9phS/1vlTl8OVZGj3Bple7cv1FIz4WHcWB6lN91PFtMPYhIguGrlUlLEXKSylJS+hE/oFwmI97kOMdtZIaxm5Hm4XJhS3otNngvOvTZ5kLJU9n9t0sAELhQMrtri25aSWLSlM/BHZabN0tXv5MWEMRWqzRvVFogX2jYTQkvFXd6hhxtapH3B11OLXoRUP+JV7WuXApnCV8cmuMg==
X-YMail-OSG: 5eSZl58VM1nVD3QGKYrVM1u2IIN9KLXtaU7sXn8j4Uz.mIMtH6Xog9jN6NemkFf
 KPecCAbz3Qb1WAMgl3DLCl.G14K7H1o9YC5O7.3LfnDUvHedNzvRlEa_VaSD7LVXxGbg_z0M3BzS
 hBdjcuRgSxSMg8kbN4hB_s2danYXFQW8Sk2SG6AMsHzORymCPUt.n2T94VOx_GKKlDEzCEAg8rOD
 cLFQxh0RGXYlW8FRadMY0B8Fb6ciuGIjkGl4k1zIL6kZeEmb8G8CzhKvh4hoYXR.h80cYGzk_U7D
 qbNQ87KXxibD3ncfeiAW7d834JHG36HWPVlckbkb_.Ql1KD04QYeLFhqEQ7WJRI4dF.uH679Xr5a
 kX9CWjLifCbXN6Zr8.qsZIbXShP1RMTJTaOeRrSeh2buSpZ28hbjaG9FhWW0qgWzt7VtQWKZQ2yB
 B9JySz7Vz6tLkG6oZk..gu0HhetwWiXNOfb36FSJoOeoqb_vvEVdNUanUHLCUGsRiWWEWcotemfr
 yGDNi1E4gi99aQX5Tz_eEZ9thIXeR7RzjDbzpdHgPWwTu3MIdpXq8XPyEkRljM7trD5PLEOlnsMm
 7UIzhUUGkMeF7E9yd5vMo2uFm5wyZMrZzzpr1vP0B.AcotEn84T5ajic1HafL3aZiRT2PrEhE84h
 uM01qP9U8kLxXtts0Y6Dw1bvKxiK.r2y171VScDF..9myHwBffQU4TyzJ8qvP4MHGOfVah5ILtz7
 7xgZLjFW7q_E5ZrKI2Fn_G3UVqRr2R5KqaNB8SIF6UrhLTy0pwMieg1uS78SYPggs_lW5NqDrbVw
 d8LEjKR6_aokZZxcWe.45UfDayQCe5e0E.JAWnoJbLIzub5pOF3WuqGsgweXthVgkrhbBwE87wgl
 tSM.hPAIJUhoYqjNBGBg.YnFoX8x2S3vkF.A17sOpb.9rWSdVo6VbbZe.p2lxSv6fKdAgZcDkBZ7
 fmaS2mlSFgchwAXtsZ4BpEKSAiywPnJJLDz3Iqe3PBwhvFgo7Uxc0b5Yo4yZIMdbTzr6J458k6xO
 BzC3agsJCVvh9XZ9awogvf8_hgDg5VZAvb.iq8VnXFqM.9GawM7INHSsSShR5yAgzlBP_3_qOif_
 B657_KsoNbHSvjaC5XYun6tRmbkMr1w8fwFOm.M6Eib_4tu_0flhfMvxmE4tT6HLqsvgER85SPXk
 s.Ub.eNac6BpE_Q05emmpryfCQmqr_TcgyqEz5rWO9Eu0SzkxPL_84QeTBF5O_ZO60psGj7mcbN8
 yWDD1mB0AhDCdPgshBn67OHIigEVPmSji3X0F_vBpTrAsBsN_xY_Myw_890yhY4_cUPpKgnQgrNr
 TI7vLvJUiN10wrEg9O.7Oql4HpqJR.kBquyg6_VKPq.o3pon5J_rxJpTfpZ2dshFj1qMkNfZmpmA
 YR9vcFu.WDiPC_xzVElDSCXq5n6PfoTJa15lM4cELr45Z4E_uBON.PFjRC9lcrdYuBhcX9D9.R_1
 v.3R_kWXUnhnn3ekFgw2UZsQL0oSAqymuspF6XZVVCGR1U0haeAqfhXqOsPHplwGFefvTQHew4dI
 PC71wWxNrNLJahxb2nD5GiSAAebuqlnwdC.lYPQUtHWolJyt6TXj6slVTFUIsxL.Ky6KiIYfAxka
 sefSdyaWUbykYabmp6h62VKcDlEuYotG7ORmXSskTjGuLJXeTymdrPqIPcucGTfYmpr_hKDsAn2L
 YeXdT_el68InRNDU8g5MqdkUXGx_tWHBgPkqDbH1cnu1YxDAEVf5R4b1QZx2965C9pM7j9IfCI9P
 7bm2o1XprUbibdCo6XHbzuLTazaiDNJDhxJ_d7g_5JY1hRsaKvdCT6vxf6rcXev6dRf4ZYbkAb3b
 OLcPZvm_K3oKVqh61h6F3x7zZH4Nmm3WdkWgXulV4GUaHsX8XCi3wZDy3rvuA9XPQ5y2Y42O3_kY
 L4BnFVcUOMD7bwbG6m8DNPzOx__F9L9eCKDP9swelyw0EgfBRXVnbn8th4xs9PYDICBrAP0yMjDv
 _.2QCS.hl5lMiyludGYKa7Vi9JRcH1wrBvHqiocJ983xh5SSf6XfhAUgL_K7PwP1wDwCzlT6FmDl
 ApmtXEd1i4XF3p3u_jVDUsg5Ip7xfGLIjvECnebV03ODr2SjECl4RjjkZqBgzw7H32aiGu.t9hTo
 J3Ma3vlnuCiFTPkwTcR3UD2t24vl4jXXiV649BG0ZucTlQp3EiRPnQHJTUky0gydgjrzlh6CFzDH
 7bPn_kg--
X-Sonic-MF: <mau.salvi@yahoo.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ir2.yahoo.com with HTTP; Wed, 22 Feb 2023 14:07:54 +0000
Received: by hermes--production-ir2-65c64dfd66-pqdpl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c283dc74d1e86dfb378068521dd9a5a3;
          Wed, 22 Feb 2023 14:05:53 +0000 (UTC)
From: Mauro Salvini <mau.salvi@yahoo.com>
To: xenomai@lists.linux.dev
Cc: Mauro Salvini <mau.salvi@yahoo.com>
Subject: [PATCH v2] copperplate: sysregd: fix Makefile.am
Date: Wed, 22 Feb 2023 15:05:43 +0100
Message-Id: <20230222140543.19880-1-mau.salvi@yahoo.com>
X-Mailer: git-send-email 2.17.1
References: <20230222140543.19880-1-mau.salvi.ref@yahoo.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>

Settings in this Makefile.am are done without the sysregd_
prepend, differently from other tools (e.g. utils/corectl)

This also avoids following Yocto error:

  do_package_qa: QA Issue: File /usr/sbin/sysregd in package xenomai
  doesn't have GNU_HASH (didn't pass LDFLAGS?) [ldflags]

Signed-off-by: Mauro Salvini <mau.salvi@yahoo.com>
---
 lib/copperplate/regd/Makefile.am | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/copperplate/regd/Makefile.am b/lib/copperplate/regd/Makefile.am
index 3b14e9863..590a47c2f 100644
--- a/lib/copperplate/regd/Makefile.am
+++ b/lib/copperplate/regd/Makefile.am
@@ -1,14 +1,14 @@
 sbin_PROGRAMS = sysregd
 
-CPPFLAGS = 			\
+sysregd_CPPFLAGS = 			\
 	@XENO_USER_CFLAGS@	\
 	@XENO_FUSE_CFLAGS@	\
 	-I$(top_srcdir)/lib	\
 	-I$(top_srcdir)/include
 
-LDFLAGS = $(XENO_POSIX_WRAPPERS)
+sysregd_LDFLAGS = $(XENO_POSIX_WRAPPERS)
 
-LDADD = 			\
+sysregd_LDADD = 			\
 	../libcopperplate@CORE@.la	\
 	@XENO_CORE_LDADD@	\
 	@XENO_USER_LDADD@	\
-- 
2.17.1

