Received: from sonic304-49.consmr.mail.ir2.yahoo.com (sonic304-49.consmr.mail.ir2.yahoo.com [77.238.179.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4DC5392
	for <xenomai@lists.linux.dev>; Wed, 22 Feb 2023 12:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677070388; bh=vT7zPnzk4aomDswvrVAZUz9vRn7cF33PlXCVhIKdmQ0=; h=Date:To:Subject:From:References:From:Subject:Reply-To; b=LQiJWRbcko+07ROvimRdR6df/MYnayvNthUudGmCcTi6Kii7kWxU/IJcvg2KwzbSgvvj+AHz2jR1Br9e9qvkfMt3bGVXtlmRKBqschHi2xWIyxgO03IK1WyuaKqS8YhvYvPK6cTYrzzv8I05mKZU17dYpMNJLZ1L/n8I6nztRa3VrEC+6LkRLf9/y9x/SRbKYXk5SOHmRX/89D/bBqUSPeZoXuMZdoBRRaoAAHsTzVuLBcFmBDI/XCEMziV3P7ZO5xhg61Ug/tfkdrD2CbYTXrvqz7LPeEM075JBfvEnCGcXo5qQdw6vD9JWsVQcuSmN4XrmRrzGNPPpLc3lY4wATA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677070388; bh=RsjE9IIhAThO9iAaVGX0Purbb1fi+5IP1omZwU24tLm=; h=X-Sonic-MF:Date:To:Subject:From:From:Subject; b=eIFqVZUE5mvMrB7HyeiZ7Iai6ifVVJjzz0NKB85rUV354lAM0/PVAh4qXU4HLkAvWgYlK+0ZL61OHOmxdl6LPaX4Q1fSSYaOpuvv9ndWGZvAK5OSWJPtzcyAbwzF4f6x2Ry/DHqFiyXeJOIArgLghyzguKdocV/rLFnwH+fK/D1p9fhC4v2M0Sh6Vokv+9Ra6k9V8LfzGPeMxYZ3xYMixyaryZtxJHtRDPlt4XlnObIY8w5senRfQ9RCoQqxytz/K86cDJAoR73OQk3ln+v7j+olqGiet1h9u1nTAC7SClrjh0XAj7+3W8cEw7TQf99tPeR9B4AyE5QwSR5vzsIgqA==
X-YMail-OSG: tYdO9m8VM1lTfJNsl1YqpTivO.BIu0fVO_tWKQqIxr3Ymog9osWb.eShwYAYvrt
 SLk4wZ98mbEWo6IuGGj4uxDrABImVdfhT3WRTno2kJgldDegYuRx7tdyEAwP4jTAmDdooYPAAH_s
 EgupDJG.FkLviRv3jQB53o8MPP14GKMTJmGQaIE_IIH5ZOJ7KBaIG3EMu22VRSK9tXnrzdVxWTly
 .dMhmUTL3v.frtiFE9W4prMHrjk_get_c8Q_2t8dmGl.L8Wzza2XRBGD7FKRun3E__o3XvLG_yeW
 SjZRytyzOUg3SJ1tHrn2RV9k7pcQCRX0ZmYnHeEZc0FHDe7klCSJHu3q_WzmnGx1I4qvclJpRaYe
 ezG9PHhEYEWp64VwqkOwHGGc7W8E5rPJt7FhIkI0A79rDU82Z67tQzfOBFUJX7ty_S45zrjg6wvy
 9lGD8dFb.dOzqebStU3jsCwrwgy2NVJhnHUr5l6.U6iwRZORHzBeouG4S2LdHTINjRCyqToS0jdY
 eeALwdgHlZfAed7NKSirFNUBbiVffQNrcDs1qFlMxAFkPkrTJfq6VkizH_SWFJHYqYtSjULKYCpG
 Ii0.y0_Pex_xv86kJTYHX9DKMIig4PKJcHuu4GAEgnPah3Zk0mWYGEW8CZz7DtbCL6tkGjN2zpJC
 iNkA5WS8UbVz4tu0X6b_jJRPFV0keQLXyi7uwX_h0p8GeAl69O.k1QPMo.WXIRpf9UFhB0Z7kfkU
 WtZdgZtS3U5g3apiphEHIvh2XQkZqAWQeNOA0TIMCReBBdHgRySQINuSNyINeABLvWLozJe2YRyT
 67vfDWw3kbxutqvxBrxZbwZLa1O6UCKHZwo0ZnrZNfX4JD.2A0GE8jKri9EPrjGMvbHPJr1fNwXL
 TQeXMyV0SouZUhCzfzmilkkMqM5IkoAshfmm92fvKdguX9zJuL2.84r8trEQLX4tNpKV4EfrzDfO
 1fXFBnHHhuQQwFSkQ6UElXJubeAoofWMm53_w_n70KvunjP5Igqs8LlZuKz7ArkBuHTZNG2nXl8C
 0JuXTKgWV.Ey.FkIuMX5xzGxiidqsEMLlOZvKadknAY_gwN7PSCYXj6HWkc07VFtSXtIkFQ5Q069
 QeItBl3JbRis2XiUKZahFjTJ_2MdcehMTXlC_HHEUy7..dWvV9vVnwiW6rHxNuc2PQb0F8OqJ9w4
 ozZWlWry5Fn60OH1F5U_o9KJi6ZZuROaKQAKb0WNwQYVd13xIS_JVh7P68WWVfKYCvEJYX_bS26h
 vSRRhCmO553FZvbFVC45WkqbGAe8pemo76lDvxG9oyLR6YBNrXYVEqADhg7KziC7Jypa_0MdRD8Q
 UuxPYYIld6WClWHbSFI7ipHiDhoR5ntII8S1LjOHEhcoQs5biHuboBWsjMS_X7rGNLGP8GfzHnaI
 FzPcsCydTP9t3oJN1DBHrHzfzJMtQXsmp3q4_hjsd85P4FYcS92ZFtUwUGwW8rv6lFJ0K.JMiKvc
 7cr1h0Q3Qf9w_3fBxvGtKKzca.Ze_ihyQmY.WaILLSiFfrobrvjtXIBdWNIVZoTgX95k1p_ru2Tt
 bI7Me5SGryGtdZoGgpPDK_lcEb.w78.BqbwFfdJ2zUzODEp2unjwgnZtDAnVDctcOQEbRf9eaUVd
 HE3J.dY7rk7BfTo3mH3dwQg3fA7jLwsG92uYxqOjvSRe3raK4pzw9WHxXsCyIEWpkaS01JLrLxDl
 5svXICn4f1_XqGSdQsptjZm7dhCi8_.QI2YY88kGvtix1rMY86S3tehB9QB_XfRnQXjQKM3Wo35z
 DBVZHjUEgTe2uQ7G6NuFolfL_J4mnGPy5e2iH7VfNtHQGAGCs7lkFr4wmTIZF3GeekMiIJJGuHi9
 qRTyW3557EvKLzJP.7cNOWiHg5K36wa4Oe9MoE1QSaIeX2vAJybo6RSBggRyugvXFRlnSewQvqwr
 ChbyutrhAXvCnPft3y1zK9oXRkD0SZIwwGK2HHpDxibzAu.Le_xfUaTdHQBgcfdmC_VtzcATXGpY
 74gFzvqu59Rljcis7eNN2yH1SOCjoZdmFnoMZa3AKAp3ciywtBnoATaDO9hNOkWYBKA_hONqzTR7
 .XUKHqLNULdjwA_Ow0rPTZ0F_5IHWNXjLGzWDjOSHLB3io8C.KPpNPye290MOh1osk2yhJ4nkNyV
 KGWDZutsF0WxINWtEEyLggrg.dPMe7Tpv5stUURsE81_HKivmAGt9J0IQSjOJ4ECEOYYnTyNqGH1
 0wA--
X-Sonic-MF: <mau.salvi@yahoo.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ir2.yahoo.com with HTTP; Wed, 22 Feb 2023 12:53:08 +0000
Received: by hermes--production-ir2-65c64dfd66-ntl7g (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 42f702054613bc2a3a310df6d0c2d47a;
          Wed, 22 Feb 2023 12:51:06 +0000 (UTC)
Message-ID: <fe268669-3bf8-627a-05c3-6231e44cead5@yahoo.com>
Date: Wed, 22 Feb 2023 13:51:04 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: [PATCH] copperplate: sysregd: fix Makefile.am
Content-Language: it-IT
From: "Mauro S." <mau.salvi@yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
References: <fe268669-3bf8-627a-05c3-6231e44cead5.ref@yahoo.com>
X-Mailer: WebService/1.1.21183 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo


To avoid following Yocto error:

   do_package_qa: QA Issue: File /usr/sbin/sysregd in package xenomai
   doesn't have GNU_HASH (didn't pass LDFLAGS?) [ldflags]

Signed-off-by: Mauro Salvini <mau.salvi@yahoo.com>
---
  lib/copperplate/regd/Makefile.am | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/copperplate/regd/Makefile.am 
b/lib/copperplate/regd/Makefile.am
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

