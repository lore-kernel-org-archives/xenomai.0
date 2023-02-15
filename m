Received: from m1561.mail.126.com (m1561.mail.126.com [220.181.15.61])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4797C
	for <xenomai@lists.linux.dev>; Wed, 15 Feb 2023 11:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=sNQWWaiaYmXnNRPjQOv27gMUk2KRhRq/aCvCCXW+/Sg=; b=o
	i6pIOy1c73+dHE8ztvljTz7hWa4UnnT8OBV0RIBqJEEoUl2fwXGbv3tnbFwoeNDp
	3bkem+hQPUNksNOa18e9ZXRfHjLeH+lxp6vISY+vGEMnSbgZ6iEsN1Zcrmy/IACp
	baw7ilvi3W6Zo77vVuthyTAEmQJd50bVd+z2wWUXiU=
Received: from yxianyao$126.com ( [103.161.254.5] ) by ajax-webmail-wmsvr61
 (Coremail) ; Wed, 15 Feb 2023 19:07:18 +0800 (CST)
X-Originating-IP: [103.161.254.5]
Date: Wed, 15 Feb 2023 19:07:18 +0800 (CST)
From: "Yao,Yongxian" <yxianyao@126.com>
To: "Jan Kiszka" <jan.kiszka@siemens.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re:Re: about rcu_preempt detected stalls on CPUs/tasks
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220708(c4627114)
 Copyright (c) 2002-2023 www.mailtech.cn 126com
In-Reply-To: <f2b91213-82a0-f78f-9948-3c7f9a13888b@siemens.com>
References: <502ffef0.6ee4.186548762d8.Coremail.yxianyao@126.com>
 <f2b91213-82a0-f78f-9948-3c7f9a13888b@siemens.com>
X-NTES-SC: AL_QuycBPietkoo7iOeZekXn0wRhu49WsO3vvUj1YJTOJs0oyrE3CsKcl1fEHD4z9mqKyaDkjqKfT1i7sRGRIVjQ5u2fXiWCpuwgI6eT6LOtg6W
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <6cb72fb7.7353.18654c1e3da.Coremail.yxianyao@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:PcqowABXcrrmvOxj7l8SAA--.46524W
X-CM-SenderInfo: p10lt0x1drqiyswou0bp/1tbifhgXs1pEJGqHfAACsr
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkhpIEphbiwKCm9uIDIwMjMtMDItMTUgMTg6NDk6MTHvvIwiSmFuIEtpc3prYSIgPGphbi5raXN6
a2FAc2llbWVucy5jb20+IHdyb3Rl77yaCj5PbiAxNS4wMi4yMyAxMTowMywgWWFvLFlvbmd4aWFu
IHdyb3RlOgo+PiAgCj4+IEZvbGxvd2luZyBleGNlcHRpb25zIG9jY3VyIG9uIHRoZSBEZWJpYW4x
MC4zIHVzaW5nIExpbnV4K3hlbm9tYWkga2VybmVsLsKgCj4+IFBsZWFzZSBnaXZlIG1lIHNvbWUg
aGludHMuwqAKPgo+SXMgeW91ciBYZW5vbWFpIGFwcGxpY2F0aW9uIGRvbWluYXRpbmcgYSBDUFUg
Zm9yIG1vcmUgdGhhbiBhIGZldyBkb3plbnMKPm9mIG1pbGxpc2Vjb25kcz8gRG8geW91IGhhdmUg
dGhlIFhlbm9tYWkgd2F0Y2hkb2cgZW5hYmxlZCAoaXQgd291bGQKPmNhdGNoIHN1Y2ggY2FzZXMs
IGFmdGVyIHNvbWUgc2Vjb25kcyk/IElmIHlvdSBkbyBoYXZlIHN1Y2ggYSB3b3JrbG9hZCwKPkxp
bnV4IGNvbXBsYWluaW5nIGFib3V0IG5vdCBoYXZpbmcgdGhlIHRpbWUgdG8gImJyZWF0aCIgb24g
c3VjaCBhIENQVSBpcwo+bm8gc3VycHJpc2UuCgpSZWFsLXRpbWUgYXBwbGljYXRpb25zIHdpbGwg
bm90IG9jY3VweSBDUFUgY29udGludW91c2x5IGZvciBhIGxvbmcgdGltZS4KQWRuIHRoZSB4ZW5v
bWFpIHdhdGNoZG9nIGhhcyBiZWVuIHR1cm5lZCBvbi4KCkNPTkZJRytYRU5PX09QVF9XQVRDSERP
Rz15CkNPTkZJR19YRU5PX09QVF9XQVRDSERPR19USU1FT1VUPTEKCi0tCllhbyBZb25neGlhbgoK

