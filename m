Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE23182A7
	for <xenomai@lists.linux.dev>; Wed,  3 Jan 2024 08:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFU5jSbL"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2cd1919f0acso2996101fa.0
        for <xenomai@lists.linux.dev>; Wed, 03 Jan 2024 00:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704272098; x=1704876898; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9osPw9aEHVVZ9usW2ZDxXNs4C/JIQKV3QqWHDJIFHWc=;
        b=bFU5jSbLO47pxrXJbQUXJePPinP9dG/6nITw2AAQc8AA4DvqHw2w1wkLlu5AWgOmeK
         7O5GGPSKvSjHLsE+Nny+moM63ga4E8auJM2/SzC3YllXh4oPlM5K7RVLteJi1XVWhFE+
         FyDu2G7iSpK36NxnKyErbQNdohS1xiKCeNY5cjpCcAvBFrt9e4y6Tok28Up+xh7kYZ7G
         L4tdH5ea6iYkLlCQ6PlMThZfu8ukY+OLmPx7yiD1YE0seJQFtgfAJp2gQzHyDsh2LsdZ
         ivC8mXtieuSeKMFHma36TxJWIQOHwD3h4Kh/6dbhSPE4AWcubB4n7+kIPgjF+Z/4lgNv
         ou7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704272098; x=1704876898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9osPw9aEHVVZ9usW2ZDxXNs4C/JIQKV3QqWHDJIFHWc=;
        b=XecKKIbmntJREJN1oH2epNcsyL3Os9ZoxB01HBW0At5OYueFC7qSehFMCXj7SEPKJ4
         du2t8OrvafaezHGhAUDRvpUSABQPbABoJPEqKbkzLZIoBDSeCmQbtCF7dahHw36B5oM4
         tXLRudlkEHhSOMKrLm0k/dYV83nhtU1pAl3LVLBSJl0lOhc0tICWO5vJWRd9prLZq+aU
         vS1LX+7UFrlpgyEPH+nTQnEwQS/I6AZolBWyKi1H+eNAUrlCkkRgVXsG4R7ANji8kIKC
         EO5DzKSOQ1OVIScOwQlNlwwSljl8oTR5tRZ0cboSHqj8GdUKMBY/UVhwo/zfXWcgLCv1
         wa7Q==
X-Gm-Message-State: AOJu0YyhRaw7MWPJqkVxfOgp2U9g+sdyeJSHGOfZy57xQlk/LYS1qrqR
	uB4fKe79spmch0nORfRKQTjIU8zVaDQVLm7cXBk=
X-Google-Smtp-Source: AGHT+IHZTkKBBy8m1m01H4Bt3OQdrMUhHgEQeCCQDsbeDKkrlmoTzP0Ws20mynd2iSptIiLvjgTys0I9z4P0EXCVr2A=
X-Received: by 2002:a2e:8606:0:b0:2cc:65dd:3320 with SMTP id
 a6-20020a2e8606000000b002cc65dd3320mr8032609lji.27.1704272098132; Wed, 03 Jan
 2024 00:54:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <56c4c74c-d971-4cd3-88b4-0cf1ef50c4f4@siemens.com> <36aaafd1-85a6-42aa-b3fd-9e2d430074b6@siemens.com>
In-Reply-To: <36aaafd1-85a6-42aa-b3fd-9e2d430074b6@siemens.com>
From: Kristian Rahbek <kri.rahbek@gmail.com>
Date: Wed, 3 Jan 2024 09:54:46 +0100
Message-ID: <CAE6EeqCLNq8uegVmf1JzWZrSGEyTOKLj68XCPYX6049CysbgLQ@mail.gmail.com>
Subject: Re: [Call for Participation] Xenomai Community Meet-Up in Wuxi
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>, "Chen, Hongzhan" <hongzhan.chen@intel.com>, 
	"Wang, Rick Y" <rick.y.wang@intel.com>, Daniel Bovensiepen <daniel.bovensiepen@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gU3VuLCBPY3QgMjIsIDIwMjMgYXQgNjowNeKAr1BNIEphbiBLaXN6a2EgPGphbi5raXN6a2FA
c2llbWVucy5jb20+IHdyb3RlOg0KPg0KPiBXZSBhcmUgaGFwcHkgdG8gYW5ub3VuY2UgdGhhdCB0
aGUgYWdlbmRhIGZvciBvdXIgbWVldC11cCBvbiBOb3ZlbWJlcg0KPiAzMHRoIGhhcyBiZWVuIHdp
ZGVseSBmaW5hbGl6ZWQuIFJlZ2lzdHJhdGlvbiBpcyBub3cgb3BlbiBhcyB3ZWxsLg0KPg0KPiBZ
b3UgY2FuIGZpbmQgYm90aCB1bmRlcjoNCj4gaHR0cHM6Ly9vcGVuc291cmNlLnNpZW1lbnMuY29t
L2V2ZW50cy8yMDIzY24teGVub21haQ0KPg0KPiDmiJHku6zlvojpq5jlhbTlnLDlrqPluIPvvJox
MeaciDMw5pel6IGa5Lya55qE5pel56iL5bey57uP5pWy5a6a77yB5oql5ZCN5Lmf5bey5byA5pS+
44CCDQo+IOaCqOWPr+S7pemAmui/h+iuv+mXruWmguS4i+mTvuaOpeiOt+WPlu+8mg0KPiBodHRw
czovL29wZW5zb3VyY2Uuc2llbWVucy5jb20vZXZlbnRzLzIwMjNjbi14ZW5vbWFpDQo+DQo+IFBs
ZWFzZSBub3RlIHRoYXQgd2UgYXJlIGxpbWl0ZWQgaW4gY2FwYWNpdHkgYW5kIHdvdWxkIGxpa2Ug
dG8gcGxhbiBsdW5jaA0KPiByZWFsaXN0aWNhbGx5LiBJbiBjYXNlIHlvdSBoYXZlIHJlZ2lzdGVy
ZWQgYnV0IGNhbm5vdCBtYWtlIGl0LCBwbGVhc2UNCj4gbGV0IHVzIGtub3cuDQo+DQo+IOivt+az
qOaEj++8jOeUseS6juWcuuWcsOWuuemHj+aJgOmZkO+8jOaIkeS7rOmcgOaPkOWJjeWuieaOkuWN
iOmkkOetieS6i+mhueOAgg0KPiDlpoLmgqjlt7LnmbvorrDkvYbmnKrog73liLDlnLrvvIzor7fl
j4rml7borqnmiJHku6znn6XmmZPjgIINCj4NCj4gTG9va2luZyBmb3J3YXJkIHRvIHNlZWluZyB5
b3UhDQo+IOacn+W+heS4juaCqOebuOingSENCj4NCj4gSmFuLCBIb25nemhhbiwgUmljaywgRGFu
aWVsDQo+DQo+IE9uIDEyLjA5LjIzIDE4OjU1LCBKYW4gS2lzemthIHdyb3RlOg0KPiA+IFRoZSBY
ZW5vbWFpIGNvbW11bml0eSBpcyBwbGFubmluZyB0byBob2xkIGFuIGluLXBlcnNvbiBtZWV0LXVw
IHdpdGgNCj4gPiBwcmVzZW50YXRpb25zIGFuZCBsaXZlIGRpc2N1c3Npb25zIG9uIE5vdmVtYmVy
IDMwdGggaW4gV3V4aSwgQ2hpbmEuDQo+ID4gQXR0ZW5kYW5jZSB3aWxsIGJlIGZyZWUgZm9yIGV2
ZXJ5b25lLCBqdXN0IGEgcmVnaXN0cmF0aW9uIHdpbGwgYmUgbmVlZGVkDQo+ID4gYmVjYXVzZSB3
ZSBoYXZlIGxpbWl0ZWQgY2FwYWNpdHkuIE1vcmUgZGV0YWlscyB3aWxsIGZvbGxvdy4NCj4gPg0K
PiA+IFhlbm9tYWnnpL7ljLrmraPorqHliJLkuL7ooYzkuIDmrKHpnaLlr7npnaLnmoTogZrkvJrm
vJTorrLlkoznjrDlnLrorqjorrrvvIwNCj4gPiDorqHliJLkuo4xMeaciDMw5pel5Zyo5Lit5Zu9
5peg6ZSh5Li+6KGM44CC5q+P5Liq5Lq65Y+q6ZyA5rOo5YaM5Y2z5Y+v5YWN6LS55Y+C5Yqg44CC
DQo+ID4g55Sx5LqO6IO95Yqb5omA6ZmQ77yM5pu05aSa57uG6IqC5bCG6ZqP5ZCO5YWs5biD44CC
DQo+ID4NCj4gPiBTZXNzaW9ucyB3aWxsIGJlIGxpdmUtdHJhbnNsYXRlZCBhbmQgYWxzbyByZWNv
cmRlZCB0byBzaGFyZSB0aGVtDQo+ID4gYWZ0ZXJ3YXJkcy4gT25lIHNlc3Npb24gd2lsbCBiZSBn
aXZlbiBieSB0aGUgWGVub21haSBtYWludGFpbmVyIG9uDQo+ID4gdGhlIGxhdGVzdCBuZXdzIGFu
ZCBwbGFucyBvZiB0aGUgcHJvamVjdC4gV2Ugd2lsbCBmdXJ0aGVybW9yZSBoYXZlIGENCj4gPiBz
bG90IHdpdGggUSZBIGFuZCBvcGVuIGRpc2N1c3Npb25zLiBCZXlvbmQgdGhhdCwgd2UgYXJlIGxv
b2tpbmcgZm9yDQo+ID4gdGFsa3MgZnJvbSB0aGUgY29tbXVuaXR5LCBpbiBDaGluZXNlIG9yIEVu
Z2xpc2g6DQo+ID4NCj4gPiAtIEhvdyBhcmUgeW91IHVzaW5nIFhlbm9tYWk/DQo+ID4gLSBBcmUg
eW91IHdvcmtpbmcgb24gcG9ydHMgb3IgZXh0ZW5zaW9ucyBvZiBpdD8NCj4gPiAtIERvIHlvdSBo
YXZlIGJlc3QgcHJhY3RpY2VzIHRvIHNoYXJlPw0KPiA+IC0gV2hhdCBkbyB5b3UgZXhwZWN0IGZy
b20gWGVub21haSBpbiB0aGUgZnV0dXJlPw0KPiA+DQo+ID4g5Lya6K6u5bCG6L+b6KGM546w5Zy6
57+76K+R5ZKM5b2V6Z+z77yM5Lul5L6/5LmL5ZCO5YiG5Lqr44CCDQo+ID4g5YW25Lit5LiA6aG5
5pel56iL5bCG55SxWGVub21haee7tOaKpOiAheaPkOS+m+mhueebrueahOacgOaWsOa2iOaBr+WS
jOiuoeWIkuOAgg0KPiA+IOS5i+WQjui/mOS8muaPkOS+m+mXruetlOWSjOWFrOW8gOiuqOiuuueO
r+iKguOAgg0KPiA+IOmZpOatpOS5i+Wklu+8jOaIkeS7rOS5n+WcqOWvu+aJvuadpeiHquekvuWM
uueahOa8lOiusu+8jOWGheWuueS4reiLseWdh+WPrzoNCj4gPg0KPiA+IC0g5L2g5piv5aaC5L2V
5L2/55SoWGVub21haeeahD8NCj4gPiAtIOS9oOS7rOWcqOWBmuenu+akjeaIluiAheaJqeWxleWQ
lz8NCj4gPiAtIOacieacgOS9s+Wunui3teWPr+S7peWIhuS6q+WQlz8NCj4gPiAtIOS9oOWvuVhl
bm9tYWnmnKrmnaXmnInku4DkuYjmnJ/lvoU/DQo+ID4NCj4gPiBQbGVhc2Ugc2VuZCB5b3VyIHBy
b3Bvc2FscyBjb25zaXN0aW5nIG9mIGEgdGl0bGUgYW5kIHNob3J0IGFic3RyYWN0IHRvDQo+ID4g
amFuLmtpc3prYUBzaWVtZW5zLmNvbSBhbmQgaG9uZ3poYW4uY2hlbkBpbnRlbC5jb20uDQo+ID4N
Cj4gPiDor7flsIbmgqjnmoTmj5DmoYjvvIzljIXmi6zmoIfpopjlkoznroDnn63mkZjopoHlj5Hp
gIHliLANCj4gPiBqYW4ua2lzemthQHNpZW1lbnMuY29t5ZKMaG9uZ3poYW4uY2hlbkBpbnRlbC5j
b23jgIINCj4gPg0KPiA+IEltcG9ydGFudCBkYXRlczoNCj4gPg0KPiA+IC0gQ0ZQIGNsb3Nlczog
ICAgICAgICAgICBTdW5kYXksIE9jdG9iZXIgOCwgMjAyMw0KPiA+IC0gQ0ZQIG5vdGlmaWNhdGlv
bnM6ICAgICBXZWRuZXNkYXksIE9jdG9iZXIgMTEsIDIwMjMNCj4gPiAtIFNjaGVkdWxlIGFubm91
bmNlbWVudDogRnJpZGF5LCBPY3RvYmVyIDEzLCAyMDIzDQo+ID4gLSBFdmVudDogICAgICAgICAg
ICAgICAgIFRodXJzZGF5LCBOb3ZlbWJlciAzMCwgMjAyMw0KPiA+DQo+ID4g6YeN6KaB5pel5pyf
Og0KPiA+DQo+ID4gLSDmj5DmoYjlvoHpm4bmiKrmraLvvJoyMDIz5bm0MTDmnIg45pel5pif5pyf
5pelDQo+ID4gLSDmj5DmoYjnu5PmnpzpgJrnn6XvvJoyMDIz5bm0MTDmnIgxMeaXpeaYn+acn+S4
iQ0KPiA+IC0g5pel56iL5YWs5ZGKOiAgICAyMDIz5bm0MTDmnIgxM+aXpeaYn+acn+S6lA0KPiA+
IC0g5rS75YqoOiAgICAgICAgMjAyM+W5tDEx5pyIMzDml6XvvIzmmJ/mnJ/lm5sNCj4gPg0KPiA+
IExvb2tpbmcgZm9yd2FyZCB0byBzZWVpbmcgeW91IGF0IHRoZSBtZWV0LXVwIQ0KPiA+IOacn+W+
heS4juaCqOebuOinge+8gQ0KPiA+DQo+ID4gSmFuLCBIb25nemhhbiwgUmljaw0KPiA+DQo+DQo+
DQoNCkFyZSB0aGVyZSBhbnkgdmlkZW8gcmVjb3JkaW5ncyBhdmFpbGFibGUgZnJvbSB0aGUgc2Vz
c2lvbnM/DQoNCktyaXN0aWFuDQo=
