Received: from out28-108.mail.aliyun.com (out28-108.mail.aliyun.com [115.124.28.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8371D31BE
	for <xenomai@lists.linux.dev>; Wed,  6 Nov 2024 08:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730881738; cv=none; b=Lp3gGW83FPd/1M1TqUWKeKM44OW5sa1ud+GEA26Tvr/jQj7Vqa1SXX4QkNyZcGZh1btSU5Z/glrDWfn1aaA45AWeNtG8sg9wFUHJhU3ePhg2BESkInV9X/Q/zqdJglX9DgAh7Okcz5ULq/6HTTjVG5h1SPcRyrJf96k1ajww0dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730881738; c=relaxed/simple;
	bh=CQZVBQILFO9UFTqLpiNGtgWNstycxtNkBmnEjZ5TulM=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=KgiRpJCX1FR4rj73fheHe3esUvY+sX4TEcHR0OXwiWybDa6/OM5VzgDsu20A6AOFAhFCAaTrsG5WT+gsZcgynzi630Un0Lxc5n2FC/z9f6FVPHdSHqMKydY93/JftPzKPsKdJ4OrAbqnTVd8nZ17AysoX1Lgc9qWitQJ2kn8BYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn; spf=none smtp.mailfrom=sinsegye.com.cn; arc=none smtp.client-ip=115.124.28.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sinsegye.com.cn
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.4281027|-1;BR=01201311R151S30rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0981571-0.101512-0.800331;FP=12059016867819271329|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045207070;MF=anan@sinsegye.com.cn;NM=1;PH=DW;RN=6;RT=6;SR=0;TI=W4_0.2.3_v5ForWebDing_210E10A6_1730881442221_o7001c22i;
Received: from WS-web (anan@sinsegye.com.cn[W4_0.2.3_v5ForWebDing_210E10A6_1730881442221_o7001c22i] cluster:ay29) at Wed, 06 Nov 2024 16:28:45 +0800
Date: Wed, 06 Nov 2024 16:28:45 +0800
From: "=?UTF-8?B?5a6J5a6J?=" <anan@sinsegye.com.cn>
To: "xenomai" <xenomai@lists.linux.dev>
Cc: "jan.kiszka" <jan.kiszka@siemens.com>,
  "=?UTF-8?B?Q2hlbiwgSG9uZ3poYW4=?=" <hongzhan.chen@intel.com>,
  "=?UTF-8?B?5YiY5p2o?=" <liuyang@sinsegye.com.cn>,
  "=?UTF-8?B?5a6L5YGl546u?=" <songjianwei@sinsegye.com.cn>,
  "=?UTF-8?B?5p2O6IOk6aKJ?=" <liyinjie@sinsegye.com.cn>
Reply-To: "=?UTF-8?B?5a6J5a6J?=" <anan@sinsegye.com.cn>
Message-ID: <c2b78c66-a2a5-474e-91bf-5c4832763055.anan@sinsegye.com.cn>
Subject: =?UTF-8?B?WGVub21haSBDb21tdW5pdHkgTWVldC1VcCBpbiBCZWlqaW5nIDExLzI2?=
X-Mailer: [Alimail-Mailagent][W4_0.2.3][v5ForWebDing][Unknown]
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
x-aliyun-mail-creator: W4_0.2.3_v5ForWebDing_NjATW96aWxsYS81LjAgKGlQaG9uZTsgQ1BVIGlQaG9uZSBPUyAxN181XzEgbGlrZSBNYWMgT1MgWCkgQXBwbGVXZWJLaXQvNjA1LjEuMTUgKEtIVE1MLCBsaWtlIEdlY2tvKSBWZXJzaW9uLzE3LjUgTW9iaWxlLzE1RTE0OCBTYWZhcmkvNjA0LjE=XQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

VGhlIFhlbm9tYWkgY29tbXVuaXR5IGlzIHBsYW5uaW5nIHRvIGhvbGQgYW4gaW4tcGVyc29uIG1l
ZXQtdXAsIGdhdGhlcmluZyB3aXRoIHNwZWVjaGVzIGFuZCBsaXZlIGRpc2N1c3Npb25zLkl0IGlz
IHNjaGVkdWxlZCB0byBiZSBoZWxkIGF0IHRoZSBJbnN0aXR1dGUgb2YgQ29tcHV0aW5nIFRlY2hu
b2xvZ3ksIENoaW5lc2UgQWNhZGVteSBvZiBTY2llbmNlcyBpbiBCZWlqaW5nLCBDaGluYSBvbiBO
b3ZlbWJlciAyNiwgMjAyNC5FdmVyeW9uZSBjYW4gYXR0ZW5kIGZvciBmcmVlIGJ5IHNpbXBseSBy
ZWdpc3RlcmluZy4gTW9yZSBkZXRhaWxzIHdpbGwgYmUgZm9sbG93ZWQuCgoKWGVub21haeekvuWM
uuato+iuoeWIkuS4vuihjOS4gOasoemdouWvuemdoueahOiBmuS8mua8lOiusuWSjOeOsOWcuuiu
qOiuuu+8jArorqHliJLkuo4yMDI05bm0MTHmnIgyNuaXpeWcqOS4reWbveWMl+S6rOS4reenkemZ
ouiuoeeul+aJgOS4vuihjOOAggrmr4/kuKrkurrlj6rpnIDms6jlhozljbPlj6/lhY3otLnlj4Ll
iqDvvIzmm7TlpJrnu4boioLlsIbpmo/lkI7lhazluIPjgIIKCgpUaGUgbWVldGluZyB3aWxsIGhh
dmUgb24tc2l0ZSB0cmFuc2xhdGlvbiBhbmQgcmVjb3JkaW5nIGZvciBzaGFyaW5nIGxhdGVyLgpY
ZW5vbWFpIG1haW50YWluZXJzIHdpbGwgcHJvdmlkaW5nIHRoZSBsYXRlc3QgbmV3cyBhbmQgcGxh
bnMgYW5kIGFsc28gd2lsbCBoYXZlIFEmQSBhbmQgb3BlbiBkaXNjdXNzaW9uIHNlc3Npb25zIGFm
dGVyd2FyZHMuCkluIGFkZGl0aW9uLCB3ZSBhcmUgYWxzbyBsb29raW5nIGZvciBzcGVlY2hlcyBm
cm9tIHRoZSBjb21tdW5pdHksIGluIGVpdGhlciBFbmdsaXNoIG9yIENoaW5lc2U6Ci1Ib3cgZG8g
eW91IHVzZSBYZW5vbWFpPwotQXJlIHlvdSBkb2luZyB0cmFuc3BsYW50YXRpb24gb3IgZXh0ZW5z
aW9uPwotQXJlIHRoZXJlIGFueSBiZXN0IHByYWN0aWNlcyB0byBzaGFyZT8KLVdoYXQgYXJlIHlv
dXIgZXhwZWN0YXRpb25zIGZvciB0aGUgZnV0dXJlIG9mIFhlbm9tYWk/CgoK5Lya6K6u5bCG6L+b
6KGM546w5Zy657+76K+R5ZKM5b2V6Z+z77yM5Lul5L6/5LmL5ZCO5YiG5Lqr44CCCuWFtuS4reS4
gOmhueaXpeeoi+WwhueUsVhlbm9tYWnnu7TmiqTogIXmj5Dkvpvpobnnm67nmoTmnIDmlrDmtojm
ga/lkozorqHliJLjgIIK5LmL5ZCO6L+Y5Lya5o+Q5L6b6Zeu562U5ZKM5YWs5byA6K6o6K66546v
6IqC44CCCumZpOatpOS5i+Wklu+8jOaIkeS7rOS5n+WcqOWvu+aJvuadpeiHquekvuWMuueahOa8
lOiusu+8jOWGheWuueS4reiLseWdh+WPrzoKLSDkvaDmmK/lpoLkvZXkvb/nlKhYZW5vbWFp55qE
PwotIOS9oOS7rOWcqOWBmuenu+akjeaIluiAheaJqeWxleWQlz8KLSDmnInmnIDkvbPlrp7ot7Xl
j6/ku6XliIbkuqvlkJc/Ci0g5L2g5a+5WGVub21haeacquadpeacieS7gOS5iOacn+W+hT8KCgpQ
bGVhc2Ugc2VuZCB5b3VyIHByb3Bvc2FsLCBpbmNsdWRpbmcgdGhlIHRpdGxlIGFuZCBhIGJyaWVm
IHN1bW1hcnkgdG8KamFuLmtpc3prYUBzaWVtZW5zLmNvbSBhbmQgYW5hbkBzaW5zZWd5ZS5jb20u
Y24KCgror7flsIbmgqjnmoTmj5DmoYjvvIzljIXmi6zmoIfpopjlkoznroDnn63mkZjopoHlj5Hp
gIHliLAKamFuLmtpc3prYUBzaWVtZW5zLmNvbSDlkowgYW5hbkBzaW5zZWd5ZS5jb20uY24KCgoK
SW1wb3J0YW50IGRhdGVzOgotIENGUCBjbG9zZXM6IEZyaWRheSwgTm92ZW1iZXIgOCwgMjAyNAot
IENGUCBub3RpZmljYXRpb25zOiBXZWRuZXNkYXksIE5vdmVtYmVyIDEzLCAyMDI0Ci0gU2NoZWR1
bGUgYW5ub3VuY2VtZW50OiBOb3ZlbWJlciAxNCwgMjAyNAotIEV2ZW50OiBOb3ZlbWJlciAyNiwg
MjAyNAoKCumHjeimgeaXpeacnzoKLSDmj5DmoYjlvoHpm4bmiKrmraLvvJoyMDI05bm0MTHmnIg4
5pel5pif5pyf5LqUCi0g5o+Q5qGI57uT5p6c6YCa55+l77yaMjAyNOW5tDEx5pyIMTPml6XmmJ/m
nJ/kuIkKLSDml6XnqIvlhazlkYo6IDIwMjTlubQxMeaciDE05pel5pif5pyf5ZubCi0g5rS75Yqo
OiAyMDI05bm0MTHmnIgyNuaXpe+8jOaYn+acn+S6jAo=
