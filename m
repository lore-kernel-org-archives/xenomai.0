Received: from out203-205-251-36.mail.qq.com (out203-205-251-36.mail.qq.com [203.205.251.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F0F2CA7
	for <xenomai@lists.linux.dev>; Wed,  9 Aug 2023 08:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1691571004; bh=ufDahTQuwW5Ig5waVoDKvkVC8TniVZR+/S1gi63yLbo=;
	h=From:To:Subject:Date;
	b=gPR3tba7nNQDmJMOCzH4RDBlrGDF+X2BxIzszEO07DONWmjeQNWMUzBBuvZHi4Jic
	 9mioPjPVB7evuobRtdYPAAkVqOJSr5oniiSNPQdOEaL45IYgrVI4PAO805p2M19t52
	 fcnv55g8JNm8CMZ3jcOQSqqWOGdeLfVstan+Z6Dk=
X-QQ-FEAT: 8OvYDnhju3OQsUIL6qJB65l12xlHSA6h
X-QQ-SSF: 0000000000000050000000000000
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-XMAILINFO: OQMBNeBHw6SkTSMPflN/MP/mI0GGJ2Ceh9qZqwMq+QbWoX0MYQCGgPWsskvqKw
	 fE+wvbSoy0LTOFTvyKmm9CGFFhQLQviqjKLK+wBd9PaNvOogcnaHDfAaIKRPfmwBYrsRfXvr39ITz
	 TRlC93Xb/gcB1mW8/DnB8mbT3vsXS6Z9imVVIdHFxN2H+rrjexGt76UnoIxy5hzT9h4uQEh4gEefn
	 SbsgBoFLM9w7SHipatPzPdp1yu0fTboSfpkEfrXL9lux0SmDYuqGfC8OT3hLfNXp/WdvgVwADTXnx
	 wxR4Bbprp57XL/+sPsDYmRuikPQ2u/8WC3+y57m1q+URP+Ket3BbHM2/TodfIdemqm7NpXx7yCElO
	 HRdSiARyup6fOLmjNSUhlWBVFecFIY0tJM8mTt5FAZd8q4cSyQ58kF0OI7ixmt7POI5UZPA7llFc7
	 Ni0/y3r1RcxRZeRHXFBqhaJckZxb6wRv4uSPmS0kMQmez+k7ym8p5MbdDZygwjs4RZoFcD4cdPxzp
	 tdT1tFg1qE7r910CBHd171N/o4cpy8wlIcrIZGdNvVxQ8xJFWaYpg2fAfFkFW7k1R0htSuPgDOA+P
	 IqcqbC8G/3BrtuTuVO/MuOCIK9x2gHqT/HBJWZjoZqal2AnTP/0qlueGMXvJi0k/bKWfTd69Ikh/O
	 OwXQnSH08lHDxbZRQKSyGZ+EQBigR00HSSSFd7i0CFB731NgegZvEs6rGEOkX8ZAUPMrF2YZ4n2WI
	 OzU1jbzqrf6JY0EirfcsxZMautmVpYtylFq5WCG2IKWMx2SOhoXCt3qfoGSM7YJX2okdm2xH1/pns
	 oi87alR6jkTP02ViRJmEFFvwr6Ad/tWky0F+QH/TRqmp/rMhNGp3aVwgi2yY1VyvuFM+N3G2HbFk/
	 zXEV5J5hXvb6N+4wploSH+oHzXHanpNlhCLHWjJhmm5qYrEUxXVTFPnBo3QXe7IptQ4jWTsXrzCdi
	 zg+svBd3rCkG3abvP4cNpqxtQ4pQw=
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 183.46.193.126
X-QQ-STYLE: 
X-QQ-mid: webmail447t1691570558t2503319
From: "=?ISO-8859-1?B?MA==?=" <taobingzhiwang@qq.com>
To: "=?ISO-8859-1?B?eGVub21haQ==?=" <xenomai@lists.linux.dev>
Subject: about porting xenomai to nuc972
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64
Date: Wed, 9 Aug 2023 16:42:38 +0800
X-Priority: 3
Message-ID: <tencent_18511CB838B5A6CAC92E57F0E1EC88A69E08@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x

UmVjZW50bHksIEkgcG9ydGVkIHhlbm9tYWkzIHRvIG51Yzk3Mi4KVGhlIGtlcm5lbCBpcyA0
LjQsIHdoZW4gSSBydW4gdGhlIHhlbm9tYWkgYnVpbHQtaW4gZGVtbywgCnByb21wdCBwdGhy
ZWFkX2NyZWF0ZSBlcnJvciwgcmV0dXJuIC0xLCAKc2NoZWRfc2V0c2NoZWR1bGVyIGFsc28g
cHJvbXB0IGZhaWx1cmUsCiBub3cgSSBkb24ndCBrbm93IHdoYXQgdG8gZG8gbmV4dApIZXJl
IGFyZSB0aGUgY2hhbmdlcyBJIG1hZGUgd2l0aCBrZXJuZWw6CjEuYXJjaC9hcm0vbWFjaC1u
dWM5NzAvdGltZS5jICAgICBhZGQgaXBpcGUgdGltZXIgY29uZmlnCjIuYXJjaC9hcm0va2Vy
bmVsL2lwaXBlX3RzY19hc20uYyBhcmNoL2FybS9rZXJuZWwvaXBpcGVfdHNjLmMgICAgICAg
IGFkZCAgZnVuYyAgIF9faXBpcGVfZnJlZXJ1bm5pbmdfMjQKCm9uIHBjOgpjZCB4ZW5vbWFp
c2NyaXB0cy9wcmVwYXJlLWtlcm5lbC5zaCAtLWxpbnV4PS4uL2xpbnV4LTQuNC1udWM5NzIg
LS1hcmNoPWFybQouL2NvbmZpZ3VyZSAtLWhvc3Q9YXJtLWxpbnV4IC0tcHJlZml4PS9vcHQv
YXJtL3hlbm9tYWkgLS1idWlsZD1pNjg2LXBjLWxpbnV4LWdudSAtLXdpdGgtY29yZT1jb2Jh
bHQgQ0M9L3Vzci9sb2NhbC9hcm0tMjAxNC4wNS9iaW4vYXJtLWxpbnV4LWdjYyBMRD0vdXNy
L2xvY2FsL2FybS0yMDE0LjA1L2Jpbi9hcm0tbGludXgtbGQKbWFrZQptYWtlIGluc3RhbGwK
Y2QgL29wdC9hcm10YXIgY3Z6ZiB4ZW5vbWFpLnRneiB4ZW5vbWFpCnNjcCB4ZW5vbWFpLnRn
eiAxOTIuMTY4LjEuMTAxOi9yb290L2FwcAoKb24gYXJtLWxpbnV4Ogpbcm9vdEBwb2xlXSQg
dGFyIHh2ZiB4ZW5vbWFpLnRnegpbcm9vdEBwb2xlXSRsIG4gLXMmbmJzcDsgL3Jvb3QvYXBw
L3hlbm9tYWkgL29wdC9hcm0veGVub21haQoKW3Jvb3RAcG9sZV0kIC9vcHQvYXJtL3hlbm9t
YWkvZGVtby9jeWNsaWN0ZXN0CmVpdGhlciBydW4gYXMgcm9vdCBvciBqb2luIHJlYWx0aW1l
IGdyb3VwCgpbcm9vdEBwb2xlXSQgL29wdC9hcm0veGVub21haS9kZW1vL3hkZHAtZWNobwpw
dGhyZWFkX2NyZWF0ZTogT3BlcmF0aW9uIG5vdCBwZXJtaXR0ZWQ=

