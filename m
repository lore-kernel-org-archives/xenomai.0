Received: from sonic312-45.consmr.mail.ir2.yahoo.com (sonic312-45.consmr.mail.ir2.yahoo.com [77.238.178.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534702F3C
	for <xenomai@lists.linux.dev>; Tue,  7 Feb 2023 13:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1675777680; bh=6hSDEQ0eaepU66k/uZiKNiWaKy6oKHKlLb2kuuyQiCg=; h=Date:From:Subject:To:References:From:Subject:Reply-To; b=SjvY/cAXpcuwQGOUh6s92e5Cs7R3klErCRDczJNzr02Q8mdrEYE8gNDaasbgQrG9Ph/kqn52j2ij4XwqVwixM3Mer1AtIbtM7b72OMkRDAxVOraIGYoqhzAaY05IFR3h43QwdnfYe3aG+r30h8ofvZhTo2U3JPF99Uj85igrb6BtOaoHcG9xdTuSbHE/TWKNfIZKAhbReb4RpEoGM/klqTIni9Q4XJvWxwSSwVjAjBF7F4/J36q+ARehuPMwYwavP3gfjUAgYqRm6Yqh19LK79KKQNOToZgOb4h7p/yX2fWk9+RBzTE3DopQIWiwznIOnAH2lcCPKT3PrWE06ONfEQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1675777680; bh=g8Gz8RDs9K11TvBq1yNtNu1r3L7HrVuVnTotVULVeAD=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=fbcEV0r7pHG+MOlZmrjppkEM9tZUbyQv7hRfdq86Ic1iT2X4trrPqJ9eOzJ3XTZhQh11kH1ykxv6XY9pR2zNAvtNf8Xu+Yh+9H7AfJosZiNE48xHTOpZtnEqdoSfbiz3bFM/u4OByNjT8RecYIS7Fz7WsAIyNRQfqPDwO4AqV4OrEIiQ8s/+ZpDIi02kVVZSLQOUlm4n7N9HQtbg1U0W0oBrJePAE/VJn5wU6cpGj6OKNxZA/jGikJPeBXgMRZQ8F/gMbiMN4QwvvCFb3qr/ZMrq+Ln1RWrEE7fgnOvOe0nIeyHHZcoQ/FgLQTsORbtZrRQciUJWCpe7rMcu98YSbQ==
X-YMail-OSG: 8mkDzSkVM1meAsnO1N5Q5O4f7ywYzAtlfJh6jcSnwNdY7Js8N0THxe8qm8oxGwX
 91kbjai3DS0_9Ee3R9sMDWtKTooTA3youmFyo9x5N6J7Wvab7hkYURHEpbrIoJdm.pIvS5CA75Pg
 JtvlIQ.IesIFtzmxZ9rMYytfOh5VcmJklfMhf..IFcR_U3ybJ9GPnBGcKnzzlYqnQKoG0P9jnbLw
 4FZwyVu_1PqFGa1IgLvXRdKzblQozM30tivhsze0_XBdXztnBDvnPZkaXUsvKfO1rXxBaZjS1tVK
 rzFsAaXx4eHS3Ic.TB6nXcJDB_735Oto9iaKaR.s3_oE7DCB7jw2et6kT.yuAd6GmEKRbSiX0Qj3
 CdexUJ7OmJx5h_4ofVGLUZAHXQd41Qwgdh25EeOVFcG_JEf0c69lWFlZ.qheMhIFmsuS3W9b3Xgw
 g7.Szg0fKiPkq89s3q15OjxF.hUrnwuDSJfIEJvflhl3ynd8aGXYZ68qJwcSkytHOkg_Bwad1CK6
 QIEjkrhzLE2_Tsd7_WKrEJb8DtZbir2qug.Q9E_36jN9RLB8o0T0JPTUMwJVBEYdN8hhEFPfMekL
 fDZIiIgn3MroI25TmNlQDLhW2iGDE8k6MCToR0nSn5zq7s4hwgdsOFWi2tZMgm1d2YMrhfJg36c_
 D.sB6Aw9rZIj6tbniYvOGco1VBGlZT3c_c_Dq7LAJPLAfL_gOyjd2xq0CuOW2rsiTKqBUxkGpnIP
 nyGycFOz.ngkHOJoL7lNCuivKmbMiSLXJAh7.NmJgiEsfVOXA4jvLXfAFhdMWS0CAFjuqip_3_pn
 lzObQWA5ZLQOSCcTSj8a_imNRGEd1uH5qdh4abGXREyhzrQqfkTERotEPXVrCCWs0LcyZZaTjTuY
 zU52n0qLFFHS1kWYHulofcbw6YB03h_y0gr7mfiOlxBRZVg4zh.QWJjF3JA.31ZgbG0iJ2EqBybn
 O0ZYqCb0.ihqa2.QBOWG7FR9Jogr3wbcTDodbrgBL3jGscz9B6nkWofqAZRld9IaOD6IVeburslI
 I0tTEFNYPTX_aim9jkW0q3tid.K5IPX2akcj02zjFIhbL6Rbsp9m3n02NlsmcHK2Ngae5HvTjuD7
 4VgF9GX_yWnrVoWbYxsesuqt0v9FV28GhBNS9RrTHotX0CuP13wQ70Md8L82PTHR1k23IW9piJ0N
 y9Nznchn.fXxvDrAu0y8BHT5lta4ItC4WVUnZFpgaqa9B_HVwqfOQ7pjtoQwGFETVSr5U0OmI55m
 T0zzb9O5D8.lrOersHRnQKMbgjKUIdDWJsfRr1iNZo93pC58HxWh4XUH_aA3.HY797Fjj4yTyOuA
 MltpQn3L56H._JvEPP9jLijlwSXApuDXaMbDQLQ9fvGKoaJuczjI8GtmZotAZGcDyhnpeIlK57VS
 lTQXOCaURq2sTeRLj_dCEUpNOKAk0ZQ0wQGJK5q0cbxwjsKJnEVp9tX.mdTFagiqweFfoqXaerka
 uasA5gtg3fv8wRzFbwYD5X7Rjl1dW3bIT3jmrekS3MGl0_fvAvcrceX7tV.DlNuakolnNLVPTbyv
 fZs6sUpe7uULGuFZOviR0.hbDJmeE_mVcM2vkIsBo2reSgAbJS72LLvK._YU7TOpoSI6kiXONQWC
 8EwPWU6Lft3vSpV9Iy_Q1r3JivU6Rn.sQjvo0TYDU07gZGy_EC.wkGcDtrZ7V_KnvGrIeF.xa6F8
 i7M0cDPxAwSv2rVt7kxHmiOxaXiaPjUEE5aoFhVu9TGchDceozRO5xS3B9cjIquGcDBTLD.TVsWI
 U.oqb2FVOs0Ek2e5x3LXPEb_K.qmKTU5Z_LZCiFi6SjAVBJ6bEv5FtH6.DSxyCrwfV2ui_NhU6VS
 Pk_pDO5eBMotNH8z3yGkFXVUmt_s462Y3yoIDx9eqHtYoACH8ZrYCoEn54tCSs5iBbQdAVFlMmeg
 Rmfuw27hX2TPV3AqBJBNUUSySbqZFEOrI1RGNhgj6dNIGeiofiKUzxOAnV175taaymBOj2W.Vzit
 30Vr0AoSPoCDg8xCf5jIXR3XUxsG38O36Zkiyoo98HyuHAj6q72yHUHXutrBKG9TMU2tHB6tHrY4
 qsJs9Qu1hb8j4c5cBQW1tXB.TDiPTw_Vo52AIT3Zk.Duh0cM7jWxOZCz_wu9xHPkHt8fsvHoncxh
 a6n2.95aONIQgbHiQNLGT00I9fdkdI2wD_4QcKwEvq.E0eeQgk_gJFA_rb7eubt3BAw--
X-Sonic-MF: <mau.salvi@yahoo.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ir2.yahoo.com with HTTP; Tue, 7 Feb 2023 13:48:00 +0000
Received: by hermes--production-ir2-65c64dfd66-2jlf9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 28266703b0e10bf83f9b9a992c1f9bf8;
          Tue, 07 Feb 2023 13:45:59 +0000 (UTC)
Message-ID: <fc2f8e65-dce5-452d-3789-70ebc838abf2@yahoo.com>
Date: Tue, 7 Feb 2023 14:45:57 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: it-IT
From: "Mauro S." <mau.salvi@yahoo.com>
Subject: undefined reference to `fuse_main_real_compat25' when build with
 --enable-registry
To: xenomai@lists.linux.dev
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
References: <fc2f8e65-dce5-452d-3789-70ebc838abf2.ref@yahoo.com>
X-Mailer: WebService/1.1.21161 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Hi all,

I'm bulding Xenomai 3.2.2 for x86_64.

When I configure the library with --enable-registry, I get the error

   ..
     CCLD     rtcanrecv
   libcopperplate.so: undefined reference to `fuse_main_real_compat25'
   collect2: error: ld returned 1 exit status
   ..

libfuse-dev package is installed (the configure script finds fuse), and 
it has the function fuse_main_real_compat25 exported

   readelf -Ws /usr/lib/x86_64-linux-gnu/libfuse.so | grep 
fuse_main_real_compat25
    318: 000000000001a500    14 FUNC    GLOBAL DEFAULT   12 
fuse_main_real_compat25@@FUSE_2.6

Seems that during Xenomai build the libcopperplate.so is not linked to 
libfuse.so. I tried to solve by myself but I'm not very familiar with 
autotools, so I gave up.

Thanks in advance, regards
-- 
Mauro S.
