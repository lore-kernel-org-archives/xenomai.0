Received: from m1556.mail.126.com (m1556.mail.126.com [220.181.15.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DC01FA0
	for <xenomai@lists.linux.dev>; Tue, 17 Jan 2023 06:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=yb+ldaDZ8OSWtcS1whm1hBWwG3do5ebOAIFkDqEV4ww=; b=i
	/84VreAWUskwz6gFcDApE5Dq6IHkDhBmz5xRltlqjR7HxQcnk1RXU6R9gnCY4AUi
	5NH8W8PCFY64KsE0ufDr0dNOlV1ZilpMWwMusX+QwSyFPzK9gE/70mUhtIOzER0l
	UVaJO7JuZAT+3EIM8HqeJsDpMzbpVGX34Jbeg+f3SY=
Received: from yxianyao$126.com ( [103.161.254.5] ) by ajax-webmail-wmsvr56
 (Coremail) ; Tue, 17 Jan 2023 13:42:32 +0800 (CST)
X-Originating-IP: [103.161.254.5]
Date: Tue, 17 Jan 2023 13:42:32 +0800 (CST)
From: "Yao,Yongxian" <yxianyao@126.com>
To: "Greg Gallagher" <greg@embeddedgreg.com>, 
	"Jan Kiszka" <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re:Re: MSI NOT pipeline-safe & Internal error
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220708(c4627114)
 Copyright (c) 2002-2023 www.mailtech.cn 126com
In-Reply-To: <CALLqZ8TfhhP9AtsdFBk59WY61SEqii1kRQ8kbVTPmkCwc7cWtQ@mail.gmail.com>
References: <54b46bc9.4a08.185b9bc9cc4.Coremail.yxianyao@126.com>
 <dfa242d4-9ecd-0bb5-5de1-677128a90946@siemens.com>
 <CALLqZ8TfhhP9AtsdFBk59WY61SEqii1kRQ8kbVTPmkCwc7cWtQ@mail.gmail.com>
X-NTES-SC: AL_QuycAfWYu0ku5CORZOkWmEsQju45WMW0uPwu3YZTOJs0virE+C8mbE1EB3fY/fK0CxiUgiqYeglp7O9Fd49FeJN1d2iT2/UWI+GCL4hnr/vd
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <3311146d.2871.185be4022c8.Coremail.yxianyao@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:OMqowABHKDlINcZjzBQHAA--.56383W
X-CM-SenderInfo: p10lt0x1drqiyswou0bp/1tbiGAj5s1pEI-mhfQAAsC
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkhpIEdyZWcsIEphbiwKCkF0IDIwMjMtMDEtMTYgMjM6MTA6MzQsICJHcmVnIEdhbGxhZ2hlciIg
PGdyZWdAZW1iZWRkZWRncmVnLmNvbT4gd3JvdGU6Cj5PbiBNb24sIEphbiAxNiwgMjAyMyBhdCA5
OjQ0IEFNIEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+IHdyb3RlOgo+Pgo+PiBP
biAxNi4wMS4yMyAwOTo0MCwgWWFvLFlvbmd4aWFuIHdyb3RlOgo+PiA+Cj4+ID4gSGksCj4+ID4K
Pj4gPiBUaGUgZm9sbG93aW5nIGV4Y2VwdGlvbiBvY2N1cnJlZCB3aGVuIHJ1bm5pbmcgdGhlIGtl
cm5lbChMaW51eC01LjQuMTgwLCB4ZW5vbWFpLTMuMi4yKSBvbiBhYXJjaDY0IGNvbXB1dGVyLgo+
PiA+IEF0dGFjaG1lbnQgaXMgc3RhcnR1cCBpbmZvcm1hdGlvbiBhbmQga2VybmVsIGNvbmZpZ3Vy
YXRpb24uCj4+ID4KPj4gPiBXaGF0IGNhdXNlZCB0aGUgZXhjZXB0aW9uPyBQbGVhc2UgZ2l2ZSBt
ZSBzb21lIGhpbnRzIQo+Pgo+PiBNYXliZSBqdXN0IHNvbWV0aGluZyBsaWtlIHdlIGhhdmUgaW4g
RG92ZXRhaWwgYWxyZWFkeToKPj4KPj4gaHR0cHM6Ly9zb3VyY2UuZGVueC5kZS9YZW5vbWFpL2xp
bnV4LWRvdmV0YWlsLy0vY29tbWl0LzQyZjQ0Y2Y4NTllMzUyNWViMjZkYzA5MGZmZmE5N2JmYzM1
ZTg3MGMKPj4KPj4gSmFuCj4+Cj4+IC0tCj4+IFNpZW1lbnMgQUcsIFRlY2hub2xvZ3kKPj4gQ29t
cGV0ZW5jZSBDZW50ZXIgRW1iZWRkZWQgTGludXgKPgoKQWRkIHRoZSBJUlFDSElQXyBQSVBFTElO
RV8gU0FGRSBmbGFncywgdGhlIE1TSSBOT1QgcGlwZWxpbmUtc2FmZSBwcm9ibGVtIGhhcyBnb25l
LCAKYnV0IHRoZSBpbnRlcm5hbCBlcnJvciBwcm9ibGVtIHN0aWxsIGV4aXN0cy4KCj5IYXZlIHlv
dSBydW4gdGhlIGlwaXBlIG9uIHRoaXMgcGxhdGZvcm0gYmVmb3JlPyAgSXQgbG9va3MgbGlrZSB5
b3UKPmhhdmUgYW4gSVJRIHNvdXJjZSB0aGF0IGlzbid0IGlwaXBlIHNhZmUsIGl0IG1heSBiZSBj
YXVzaW5nIGlzc3Vlcwo+d2hlbiB0aGUgSVJRIGlzIHRyeWluZyB0byBiZSBoYW5kbGVkLiAgSSdt
IG5vdCBmYW1pbGlhciB3aXRoIHRoaXMKPnBsYXRmb3JtLiBEaWQgeW91IHBvcnQgaXQgdG8gaXBp
cGU/Cj4KCj4tR3JlZwoKSXQgaXMgdGhlIGZpcnN0IHRpbWUgdG8gdXNlIHhlbm9tYWkgb24gdGhp
cyBwbGF0Zm9ybSwgYW5kIEkgZG8gbm90IHBvcnQgaXQgdG8gaXBpcGUgeWV0LgoKClJlZ2FyZHMK
Cllvbmd4aWFuCgo=
