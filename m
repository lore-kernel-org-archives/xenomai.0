Received: from m1561.mail.126.com (m1561.mail.126.com [220.181.15.61])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5AC7B
	for <xenomai@lists.linux.dev>; Thu, 16 Feb 2023 01:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=3C9mDdLfkK4dSV4oMD79uXwi1TDoi2nvU96uK5Xgn3E=; b=Y
	cLOH8Pr8/n4ECUSY5hLktJWv+c+9Ydr/XQmEp5n6nfyb/mfflpOk4p4vKOczIx0u
	Cw14/uawkEu194ez95I8+IbizEj/eHKIMchNqRmi0T42yWXUYQeDSLOXONVcpHT8
	NWokbajNp0kpRBrKydXYT9xYmdoX4G1B9AiHm2o0As=
Received: from yxianyao$126.com ( [103.161.254.5] ) by ajax-webmail-wmsvr61
 (Coremail) ; Thu, 16 Feb 2023 09:24:56 +0800 (CST)
X-Originating-IP: [103.161.254.5]
Date: Thu, 16 Feb 2023 09:24:56 +0800 (CST)
From: "Yao,Yongxian" <yxianyao@126.com>
To: "Jan Kiszka" <jan.kiszka@siemens.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re:Re: about rcu_preempt detected stalls on CPUs/tasks
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 126com
In-Reply-To: <31d280a1-f7bd-fab6-2e37-fc9dbdaad400@siemens.com>
References: <502ffef0.6ee4.186548762d8.Coremail.yxianyao@126.com>
 <f2b91213-82a0-f78f-9948-3c7f9a13888b@siemens.com>
 <6cb72fb7.7353.18654c1e3da.Coremail.yxianyao@126.com>
 <31d280a1-f7bd-fab6-2e37-fc9dbdaad400@siemens.com>
X-NTES-SC: AL_QuycBPmav04i4CeRZukWmEsQju45WMW0uPwu3YZTOJs0oyrs5DIKcl1tLHXxz9mIKRmDkjq2UBV08Od7UYRyZ6BY6oDHl29kGqylrLYvb/ZX
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <40a7d44a.e85.18657d3155b.Coremail.yxianyao@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:PcqowADX37vohe1jFoUSAA--.7300W
X-CM-SenderInfo: p10lt0x1drqiyswou0bp/1tbibQsYs1pECrQW0QABsr
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkhpIEphbiwKCkF0IDIwMjMtMDItMTUgMjE6MDQ6MzQsICJKYW4gS2lzemthIiA8amFuLmtpc3pr
YUBzaWVtZW5zLmNvbT4gd3JvdGU6Cj5PbiAxNS4wMi4yMyAxMjowNywgWWFvLFlvbmd4aWFuIHdy
b3RlOgo+PiAKPj4gb24gMjAyMy0wMi0xNSAxODo0OToxMe+8jCJKYW4gS2lzemthIiA8amFuLmtp
c3prYUBzaWVtZW5zLmNvbT4gd3JvdGXvvJoKPj4+IE9uIDE1LjAyLjIzIDExOjAzLCBZYW8sWW9u
Z3hpYW4gd3JvdGU6Cj4+Pj4gIAo+Pj4+IEZvbGxvd2luZyBleGNlcHRpb25zIG9jY3VyIG9uIHRo
ZSBEZWJpYW4xMC4zIHVzaW5nIExpbnV4K3hlbm9tYWkga2VybmVsLsKgCj4+Pj4gUGxlYXNlIGdp
dmUgbWUgc29tZSBoaW50cy7CoAo+Pj4KPj4+IElzIHlvdXIgWGVub21haSBhcHBsaWNhdGlvbiBk
b21pbmF0aW5nIGEgQ1BVIGZvciBtb3JlIHRoYW4gYSBmZXcgZG96ZW5zCj4+PiBvZiBtaWxsaXNl
Y29uZHM/IERvIHlvdSBoYXZlIHRoZSBYZW5vbWFpIHdhdGNoZG9nIGVuYWJsZWQgKGl0IHdvdWxk
Cj4+PiBjYXRjaCBzdWNoIGNhc2VzLCBhZnRlciBzb21lIHNlY29uZHMpPyBJZiB5b3UgZG8gaGF2
ZSBzdWNoIGEgd29ya2xvYWQsCj4+PiBMaW51eCBjb21wbGFpbmluZyBhYm91dCBub3QgaGF2aW5n
IHRoZSB0aW1lIHRvICJicmVhdGgiIG9uIHN1Y2ggYSBDUFUgaXMKPj4+IG5vIHN1cnByaXNlLgo+
PiAKPj4gUmVhbC10aW1lIGFwcGxpY2F0aW9ucyB3aWxsIG5vdCBvY2N1cHkgQ1BVIGNvbnRpbnVv
dXNseSBmb3IgYSBsb25nIHRpbWUuCj4+IEFuZCB0aGUgeGVub21haSB3YXRjaGRvZyBoYXMgYmVl
biB0dXJuZWQgb24uCj4+IAo+PiBDT05GSUdfWEVOT19PUFRfV0FUQ0hET0c9eQo+PiBDT05GSUdf
WEVOT19PUFRfV0FUQ0hET0dfVElNRU9VVD0xCj4+IAo+Cj5PaywgdGhlbjoKPgo+IC0gQW55IG90
aGVyIGVycm9yIG1lc3NhZ2VzIGJlZm9yZSB0aGUgb25lIHlvdSBzaGFyZWQ/CgpUaGF0J3MgYWxs
IHRoZSBlcnJvciBtZXNzYWdlcy4KCj4gLSBBbHJlYWR5IHRyaWVkIGlmIHRoZSBpc3N1ZSBwZXJz
aXN0cyB3aXRoIGEgKG1vcmUpIHVwLXRvLWRhdGUga2VybmVsPwo+ICAgaXBpcGUtY29yZS00LjE5
LjI2Ni1jaXA4Ni14ODYtMjUgaXMgbGF0ZXN0IG9uIDQuMTksIGxhc3QgSS1waXBlIGlzCj4gICA1
LjQsIGFuZCB3ZSBoYXZlIHBsZW50eSBvZiBkb3ZldGFpbCBrZXJuZWxzCgpUaGUgY3VzdG9tZXIg
c2l0ZXMgbm93IHVzZSB0aGUgaXBpcGUtY29yZS00LjE5Ljg5LXg4Ni05LCB3aGljaCBpcyBkaWZm
aWN1bHQgdG8ga2VlcCBwYWNlIHdpdGggdGhlIHJlbGVhc2Ugb2YgdGhlIHhlbm9tYWkgY29tbXVu
aXR5LiAKV2UgYXJlIHBsYW5uaW5nIHRvIHVwZGF0ZSB0aGUgbmV3IGtlcm5lbC4KCj4gLSBBbnkg
ZGV0YWlscyBvbiBob3cgdGhpcyBjYW4gYmUgcmVwcm9kdWNlZD8KPgoKTWFueSBzaXRlcyBoYXZl
IGRlcGxveWVkIHRoaXMgdmVyc2lvbiBvZiB0aGUga2VybmVsLiBUaGlzIHByb2JsZW0gaGFzIG9u
bHkgb2NjdXJyZWQgb25jZSwgYW5kIHRoZXJlIGlzIG5vIHdheSB0byByZXByb2R1Y2UgaXQuCgpJ
biB5b3VyIG9waW5pb24sIHdoYXQgYXJlIHRoZSByZWFzb25zIGZvciB0aGlzIHByb2JsZW0/CgpU
aGFua3MuCgotLQpZYW8gWW9uZ3hpYW4K
