Received: from azn-pfx2.northeurope.cloudapp.azure.com (azn-pfx2.northeurope.cloudapp.azure.com [40.113.70.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26B53DEAC8
	for <xenomai@lists.linux.dev>; Thu,  5 Mar 2026 17:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.113.70.242
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772732029; cv=fail; b=QV6kW3xrepfdMlFsexMmxW1tg62ZG9eGow7P90uP9RQjOkKyDBL0fm84sszO4qRE1vCOn+h6QRGNsvtXg5ogofflRjZ4VmEbSXj7y7DLDBjnW9bjpJeGS+xmjk93u52E7ntEjtAVFysVcUDCM2S3Wdb1uSIUK8/HCYyY8sIgT9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772732029; c=relaxed/simple;
	bh=33zFuzyqxh1FeLJKh++OOSASw66a+JCxiBIu/4L3ohc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version:Cc; b=d2XJBZNCGqMYWdQZW8RI9CjuO0yQLXxg085KvSt7ByQFcPJqISV//tGwk1SAEVow/dQBwqfQVProMXeY3CVFePwcfyhPdmM6Pq56PYR+IrDY9dgMyury/dwlzR9Dnu3kWHoSpnujCqENb5BzpNC2L69ufoCoBylWFsMIt5o1Fe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adige.it; spf=pass smtp.mailfrom=adige.it; dkim=pass (1024-bit key) header.d=adige.it header.i=@adige.it header.b=jvNFkAzF; dkim=fail (2048-bit key) header.d=blmgroup.it header.i=@blmgroup.it header.b=N/oYq6ut reason="signature verification failed"; arc=fail smtp.client-ip=40.113.70.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adige.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adige.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=adige.it header.i=@adige.it header.b="jvNFkAzF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=blmgroup.it header.i=@blmgroup.it header.b="N/oYq6ut"
Received: by azn-pfx2.northeurope.cloudapp.azure.com (Postfix, from userid 1001)
	id 57ABD18015F5; Thu,  5 Mar 2026 18:33:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 azn-pfx2.northeurope.cloudapp.azure.com 57ABD18015F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adige.it;
	s=selector3; t=1772732025;
	bh=33zFuzyqxh1FeLJKh++OOSASw66a+JCxiBIu/4L3ohc=;
	h=From:To:Subject:Date:References:In-Reply-To:Cc:From;
	b=jvNFkAzFv4VGdKKv4UM8whHjg2uUfzcsNuTGqu6No4nTPmJaQidqXCAIxkCxJPrEF
	 aZkXeZAMk5Hx8fYkKqdVM0XMEUG+QhS4kcfFXbxFx5Y2W2WaZULenOa6npfiJpQ0//
	 i48GUMf5ZiFjh54m7n+i8S1uYt09SUkjugYJgaog=
Received: from DUZPR08CU001.outbound.protection.outlook.com (mail-duzpr08cu00104.outbound.protection.outlook.com [40.93.64.68])
	by azn-pfx2.northeurope.cloudapp.azure.com (Postfix) with ESMTPS id 0984D18015CD
	for <xenomai@lists.linux.dev>; Thu,  5 Mar 2026 18:33:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 azn-pfx2.northeurope.cloudapp.azure.com 0984D18015CD
Authentication-Results: azn-pfx2.northeurope.cloudapp.azure.com;
	dkim=pass (2048-bit key, unprotected) header.d=blmgroup.it header.i=@blmgroup.it header.a=rsa-sha256 header.s=selector2 header.b=N/oYq6ut
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBtB1N1pa5xpPlKjZqHbcYRGtR6+eJskTeuRAkrvIeWYpDnrc/I0qmqHVY1OoTbMSX8VxhFpjTsPPXQA6+M5dNNRMKb9r5mfHRJoyu0gVayP/ErC+OJ7iG9MjyGcWuC0j+YUZ4qELVSqfUmnbhoQgf4lSTcTQeVj+QatkRnXk6ApBM9d1UwQ/jxUF9jJT1p0obXra+VILrCUnkAEhOv7MOXleFAwD5CaevUcAPjgbssX6tKqe3gE0TtLTWhPpP9adb9hgx+zSPQ94mALbExrfFEQyDVneBib9Te2BBbvk/4DdYIDPxhTzxjRjGldAFgwWGCbv1btBJ1vaseIseYoOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33zFuzyqxh1FeLJKh++OOSASw66a+JCxiBIu/4L3ohc=;
 b=n8397uvmyYaViDhfR75SxUrWEmbVFzuFPGdmDrUpbyQeioqaWQRd3nkJrFi8nvsYKQjfwmAeoDgEhcVwOp2xmqCcta85irGrhYbrFP0mzE/RzLk3s2esIb5DhisrOuwd5Sdr7xDux7zSRiU+CI/uamLQ6n4yqQiPE2scyqHbjSrtO+PX9VSSmRm16c1UhENwxcJ4mEcimfWKPu34dADkxntqbYy3TMVnd4s7t0L00ZaHVdD+LSacDojGADH+h67/YapiekjEJpVcgHT6uARNr4t/+wNdjhYjE8MPPp+VieJcDQhAbv9I6VXhYxoUJTg3kS68/jsL9qnzMCfvSNSD1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blmgroup.it; dmarc=pass action=none header.from=blmgroup.it;
 dkim=pass header.d=blmgroup.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=blmgroup.it;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33zFuzyqxh1FeLJKh++OOSASw66a+JCxiBIu/4L3ohc=;
 b=N/oYq6utWwp+A0z6FIS/3m7oy5e+ZlQmifLPJhPWa8vVVCOC6uyGLR91SLmj2stZVQTHTc40uQPCkSGl48qFMbpJRjqG3p93N4eeDEX3souEs7K83tjMD24Xse3l4Xs5UdlQO6HVYmM81AE0gpgzHLGCmF0NBs6v+TLLhAM93UTDfkKLRNGwgO0dr42mLNrXWD1qBKjHLYyHA/wX7KD3DSMXDQIbhFT0jI1EV7dtFJNTYi861iz1zy4RuSIx0d/Cn5FLtql0A7aCrfenaMQQTVEw0dDZJhtmzHqIIZvOAjj0KhEwGQP34v3bQsqI7XXCa2AAyf15fKHVE9QWveoW2g==
Received: from AM9P195MB0885.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1ce::14)
 by BESP195MB2849.EURP195.PROD.OUTLOOK.COM (2603:10a6:b10:f0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 17:33:43 +0000
Received: from AM9P195MB0885.EURP195.PROD.OUTLOOK.COM
 ([fe80::bcfa:ef0a:9c6a:485f]) by AM9P195MB0885.EURP195.PROD.OUTLOOK.COM
 ([fe80::bcfa:ef0a:9c6a:485f%7]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 17:33:43 +0000
From: davide gandolfi <lasertech@adige.it>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Xenomai 3.1 application compatibility with newer kernels
Thread-Topic: Xenomai 3.1 application compatibility with newer kernels
Thread-Index: AQHcrL2PJqEHJzeZi0C3qS5ELQ8M+bWgMpcA
Date: Thu, 5 Mar 2026 17:33:43 +0000
Message-ID:
 <AM9P195MB0885C2567A22284ACB34BD1CE07DA@AM9P195MB0885.EURP195.PROD.OUTLOOK.COM>
References:
 <AM9P195MB08852B8E9DE3958539FA4EABE07DA@AM9P195MB0885.EURP195.PROD.OUTLOOK.COM>
In-Reply-To:
 <AM9P195MB08852B8E9DE3958539FA4EABE07DA@AM9P195MB0885.EURP195.PROD.OUTLOOK.COM>
Accept-Language: it-IT, en-US
Content-Language: it-IT
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=blmgroup.it;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9P195MB0885:EE_|BESP195MB2849:EE_
x-ms-office365-filtering-correlation-id: f237eac7-1201-4c43-edd5-08de7add5910
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 w0lkZUT3OH4LNHTbL1QPdOK4GuY7LcYC0rWQy/HVol1drQF/XjPUtPstJiZ9DzDtghqu6xMNYnIhBGqg1XCiutD67sOg/YyCYeF4RDO+FImy1vSl3spLkKqkWy8R0wBYwGSlFTYtRzxYFP03HnpeLKmbtLTx13oArLufHdhehwLN1FdZ0cGm7r2+erJ49EIrsLffTJWqzbTDbAd6ofth74NTTnb/1JgUov/XA+VOG71R5zrZad2gAQxhlb6lpor6XvHIFHyEFhDmV0oic99FVkNJckd1Gd4D7OOMlHSgg++5rYKicbVCsB50TBVYr3I908p9pICfYyvuDZPvCGtiSFtM7x4pWc1U7qjt25I+YbQ0aE3MRDUMnr7uQe+/O30LfkDl0fUYmAD24LiUSDNmeusbVCdph7ZFnpHMEsYxWS/mJ/fHDXjOqS48E6JABv3Sk9eoHUzPicRUwDrHLwE4DzNKWXr4qJPvGJJdYEyD/rpCSCP/IA2+tjDbevo1NNK2+PLseCIKXd8Cbutn0vndd+Es56ufbZh/nrtHN6NMaviD4zvMS35ZLmgUvdjHGkO8qaq6Tb6y0yO5562P4juYXeRX78IHmqkdC90u0sIBIHexX7zOBEK0R8KWzc0zU2nLm+/3vjdDrdLDsgAD0IyQ6ajGJfagm9H0C5taM9hrcXyw0A+0mw4twFFn3VeRzU4E0CRrjD9PrrWMwmB3Wibu16Vfc97isjFwxafYTxRGpak=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P195MB0885.EURP195.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ccUa/fcn88VUhoWAUZkbqSuY9GFQqZ38mBV1wWUzJXrXvyvQw1i33w6t1V?=
 =?iso-8859-1?Q?w6OSgH2wn5JGqg8neaNQc6Y1CO+TCdHOxsIudcpWbW9YHGR81ddi506XDR?=
 =?iso-8859-1?Q?uA6cda3hdoaNZoSzai63nzNbto3VJr2Kf+IfIhOP8r0M2W7WNRh0EHvAFD?=
 =?iso-8859-1?Q?zAMrL8wW2k3WcuRUqlKuyiXL4YffckbP0Rb2lTlfQEMLnONu6vaVy/nZ/r?=
 =?iso-8859-1?Q?QnTUb5BWd4Wa5KRdwQT8dBPIHkMhY58ZG+58s5oraEr5SOc/1RezmJOcxQ?=
 =?iso-8859-1?Q?R2WAMKIV0J+Mw+/pVKsnQmJi8WRZ4lt/8Bh5mCh7gaHptM4quFGm0BD1sG?=
 =?iso-8859-1?Q?IS14c5GwFixYqvjn39Xs7WK6SO1R5IiG2Au8rZ4b1YojUhminjdS8UkmCW?=
 =?iso-8859-1?Q?bGryKnNAyfCTpWWxDI9BTAEElSt0SvrLtk8nzSg1rHuhZVGBtfh2WFYYL+?=
 =?iso-8859-1?Q?ViaRMJPwssjGHYr0Qv32BlDvBihcITBXz8QQn7dxhPQqddx8W0a2YRjeVo?=
 =?iso-8859-1?Q?8urZt02muwUYI/MFeFnDufBhKEx1T1NhhqgM7V6HnDloa4DRlTKVG2C+sy?=
 =?iso-8859-1?Q?zJlEo7buVKpwulEwmONn+E+EgGtSZwczgEG9GblFR6w3dtf0VpHsFOR8O6?=
 =?iso-8859-1?Q?dJVZmziHPT8vTQIDIbJN+LcC+axB+Bb7TPgbwA/PsKSl7VrkV9qxPwBoyF?=
 =?iso-8859-1?Q?T3q8U2928yfucBj+YlQTgssQI+M+1Svaf6WrQ0Py4kk7t1BxSaUT55mqbr?=
 =?iso-8859-1?Q?EHPLIyDj+vPT5Mr94HkCSCYDvm6vwyTII58KvHGRF+vYKWbEl0jM8n9RRV?=
 =?iso-8859-1?Q?CQVmAiS14uIGGT2XnLIqlK4FD4TtYy5ybFeSDAxTNoYlfEBJngUOhch8/z?=
 =?iso-8859-1?Q?7eZrlmaVtnkRG7bJenmC/EwsNpq5H9KMZDbiadDv0aebslS5VDbHTnfZW/?=
 =?iso-8859-1?Q?zjDK+Fito/6QmhsS/21gBEt2jVpJQXHy/3sbWJiH5buwcyX7CPkuee8oL/?=
 =?iso-8859-1?Q?qjVB+l2/Fh2voJ2HMvxaWdtSYLrPcW2E7s8ZjEU8zbfLYLXa9egIenn3qV?=
 =?iso-8859-1?Q?GceDK0jgy+mwBEBPW8CovK2NQKn3+Fk0dg0CfvotZh2oph6TJ+mgNkias9?=
 =?iso-8859-1?Q?us0GFMFX1xaYrBU5pA1lhe/AwBB9DCg50RNykdRnQ32G5WOEOt7+GjdJl+?=
 =?iso-8859-1?Q?Iz99GlibnWOP1S0IN3JzQGTwIVUPp2sMBWHbi9S9N1mwmknb2p0yvNl5dQ?=
 =?iso-8859-1?Q?yNjtn376P0+Hb6qx56ws9ndxQau6k6t3ppUVkI+ZS2oniEzHc8RLRam0JE?=
 =?iso-8859-1?Q?VCMpj1GENuuUttzvumrYUxZ/fjuK9Oy4asLyhxjKyBg3Uf67eXx3bfj2sn?=
 =?iso-8859-1?Q?6dVY+dlXl7LNE4b9LWMxXUqGvxEh1OAhSm+tvmQSPaQttZMXao3+dq75sB?=
 =?iso-8859-1?Q?xud26APCLdKSuZiihrimVQlsnIKfWBhgyO9f1cbNkCjKn3HXfVfLOhD+ep?=
 =?iso-8859-1?Q?4OmBYCjMXgn2CS0A7Ow8LrnqOyPOszyTnWIZlu4AyLJ6MECTDOmsRnd6N5?=
 =?iso-8859-1?Q?VdduLC3N/q1qnf5UPhGtXvsnNqjfNDepoRME6YvLFCXr6FDGpHtiVsNKcg?=
 =?iso-8859-1?Q?viAu6nBMNGfN4tuHS+TV4QN1X0FSfbvejSm200ZHBkz1u0YuAHATEC7ixp?=
 =?iso-8859-1?Q?VmSYTjIoA7Qc3xzk1Ise9wRvhnl2AIhf7lVept8G5xSs+2drYkG55O5RoA?=
 =?iso-8859-1?Q?SssEO9rL8ciSuioLEypql1gCwuV+FAQnlhQDiclOIVP3AXPT1Wlbxn19fP?=
 =?iso-8859-1?Q?iktrWvin9A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	oDjX47RaiAY4Qopg/gOWCsLTOkEFuRClM8DyRO73xvbTpKT+BaTgyMfoXTALUaU8qyKQ06KLwnrCfnYfh1Q1q8uFG6ir9SN1bO+Gcax08dOLbVrlTruNNZxAVBbxr6/F+neUEQOETR/C1v1iEtF0vmJcLc4ANuLfSNASq14vkROicuJ3/XmfL14xnb8192wQmYLMrqf4znRr0IrtEpeX3PO+qkuu5fqSXXDMeTwrvWj6jmX0s5UnVOgOq0A31rw+FsFzLtYRzKy/WR66DOgY9CqW5pbD3A9P6dVgsutWXZvPveP1vWhISqXvpxOVemjESzwqwUFRrHcCXJc0yJOdcQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GqpOHqQduEFNIeDDOCEt/fUT85WyQQCb25GLnlVPz5wc/ufnsg5rT49tlSrNUyoeWgKq4YcefqOCIbzIS0QHH7HS59/i5y4F08EhtmXdLoT5wUxBcd6q298UaLqHfPFXYHdubzVkJZmGsjqCFRnaF+psOAtxrymd8FfkTsxnmhpGpeZZtMweol1TxU4mA8Egrc5YKqI4nOK4SsQzlnxqEUQaH/hJbDgSMBJ/B18+fz9+kN2gimGWj4FUFC8dEiAzEMrGa1sUJdaiA7ejm63LR5zoUFDTeglxQp56wb6qRCYc7Pa2xDzkz5Oa3uuL2CZqIcZzXgw65pOFPMnrQMe/regWwSoVP/mfvGKYKlGj1MkGtdt7FUuF8K0D+b/7XVy5g7jnx7pUHWEQuISo2PES2D9NRdnS5Y5QiXdvKPmbWgi6Xr5bZ67kKomJ8FDlRaxtUwYv1ssfNynBUYik6GmS/Lh6lrkeySKUV+ftkF1D/pmmgv7ukULeoxr0xppkhLg60YXCJ1009zSLVgCVMteS7LO/3WlOSJucnwiTncUXV1VShqmDr1EAV/N7n7QhnYIXZzKYAGgih6QjwdSLGSDHGjRvcGhFSpzAyInp4uRjMHOCyfuLcscotLaNnN6Z9O8LUR8OKkBODwxWz+hD5T0jyw==
X-OriginatorOrg: blmgroup.it
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P195MB0885.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f237eac7-1201-4c43-edd5-08de7add5910
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 17:33:43.3797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f7c75bcb-c343-421d-900e-e426af0269ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yztOO0UX0HVsSkAIWx7qmNadDHLYCFiB/uFQMnSw8YXsok5r+3Rl4sSCSLyMySlcXf+ZJWUq7J+xmoaR3UtMmGrb8maPjCu8i6KxNqkvBDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESP195MB2849
Cc: 

Dear community,

I have an application (a library) that is linked against Xenomai 3.1 (I bet=
 using the Posix skin), and runs fine with kernel 4.19.114-cip24. In partic=
ular, it uses RtNet drivers.
Now I need to update the hardware, and most solutions on the market have ne=
wer cpus not supported by that kernel. What are my best options?

On the ipipe-x86 repository, I see that kernel 5.4 is supported, but it is =
not clear to me if Xenomai 3.1 supports it. Moreover, 5.4 is still too old =
for Alder Lake or newer processors.
Then, we have the dovetail repository, which is the most updated, but I thi=
nk it does not fit with Xenomai 3.1, am I correct?
Lastly, I could update Xenomai to 3.3.x and use the latest dovetail kernel.=
 This is what I did and the system works fine with basic tests (like "laten=
cy"), but works horribly with my old library.
In particular, I have several spurious relaxes and mode switches on the thr=
ead that, I guess, is responsible of calling the RtNet driver (not 100% sur=
e on that because the library is closed source).=A0

What are your thoughts? Is it expected that the API, in particular for RtNe=
t, changed from Xenomai 3.1 to 3.3? Please note that I don't have any segme=
ntation fault or crash, the application seems to work fine, just not "realt=
ime". Shall I expect better compatibility if using Xenomai 3.2 or it is not=
 worth trying?

Thank you for your help

Davide Gandolfi
Laser Technology Development Engineer
ADIGE S.P.A.
www.blmgroup.com
