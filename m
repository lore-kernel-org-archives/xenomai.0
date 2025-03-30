Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A87E1876
	for <xenomai@lists.linux.dev>; Sun, 30 Mar 2025 08:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743322649; cv=none; b=kPs69B4fCQFSI0oOqlKrmO8GBZ7RAnPQTbOu4YsggWT5Q87DggB4yAcMYYVar+hjQQJ1eOifd373Y7Kp4NemnikgNOrd63q8Sxy4Nh4mAhWzrcgkOFPyuLMYhUF2awC4/v9zuR2KVj/48JvJD+VKkiztfCMNjN8JoFIcYET02T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743322649; c=relaxed/simple;
	bh=JF6c44oaIFSrKyQmRLDCaXX1UelyD5ZwTammQB//9tU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nnt+kbzAzNrtlPMxZFKyDRk9Tc03Qek9is2iABFnIQbFnXhy4WnJvvzH/yCtkTKib/ELgDAXoqNMWGVE10xmE1h816Ic7locaI9a0Tl5LYBJERXn7WsoRXqwrjG+AWtoOn+17FqHCE0W9W8RUYk1lZuN5gcjtps1pqeJLwcliok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=jan.kiszka@web.de header.b=b77AduMD; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jan.kiszka@web.de header.b="b77AduMD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1743322644; x=1743927444; i=jan.kiszka@web.de;
	bh=JF6c44oaIFSrKyQmRLDCaXX1UelyD5ZwTammQB//9tU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=b77AduMD/GnWRFUvwAjiH+VKMKrVvzC7VTCiCbIKl/+MLk8KY6QCAwnPhIx2bZ1/
	 l8odxrFbPaYQzF7ihZy6qrEmEwC2cKXkjsC+NYPtZPqyUoGoSfz6fujUQcDItUHtD
	 W5XBvncFxhDe0F5+msIIehMfsb9bScR0i5MYmZEDYFon1uCmPWxIyG1Pp3P/+GCXP
	 teGxwyVQj8SEAmFSG4wILG6FHa5vicJ8FJKpriSCpRglqnrh0p/MgPe77T57sKVjF
	 89lD1qmNpftkR6aj6/8oAOLs1JxsmgEOjLpwyS8qx7VVvJwD1nh4x3WqhG+B9CK+p
	 +pf6piz0aLb5m+aGYQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.31] ([82.83.170.15]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Melax-1tQq9J1lqv-00aUiV; Sun, 30
 Mar 2025 10:17:24 +0200
Message-ID: <5bbb0060-6d26-4b3a-9022-fea5b73c1a26@web.de>
Date: Sun, 30 Mar 2025 10:17:22 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Building SDK in xenomai-images
To: Pierre FICHEUX <pierre.ficheux@smile.fr>,
 Xenomai <xenomai@lists.linux.dev>
References: <CAFc1U0scz6GaCTgaoXFzq_KEtNw-GAeJNbQnMR5qeSw2Y0fOHg@mail.gmail.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@web.de>
Autocrypt: addr=jan.kiszka@web.de; keydata=
 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
In-Reply-To: <CAFc1U0scz6GaCTgaoXFzq_KEtNw-GAeJNbQnMR5qeSw2Y0fOHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ChKtPijH2Oc7uDh2SL6CuzGdFcnkFrrgqbSp9bEYTr3yyGjQcEa
 gjqe0rOMtP+kvVSVY78qBcs153T4EOddN6iJbNV63yA+D3vdl8VwJ1BPn5+kvl7nePX7df/
 FUkVdFicMt1Vw+fyhaqNm165L/ot7DTTgmpVw15FrKvqdK4LzIw/59KZRxNn8hlPGa6qKwh
 bfKkmoA2YL0fzw9FrkJFA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sqIL6unEoWQ=;DcBS0bTcNRo1wVNnG9gIQjYJR+/
 UbNKjmbXL1EgGeCIpQ3sTSciZcmP/TAb4dHSipcLVHKUYBxR8R5ATyCDWQZbCLjxk+vLZI63H
 cll8MQV9VZ+5A+Ia0zkGS3X8cXoZSlV0vac1wZ9k4olwe/Jknb6vRIYxTRB2yDNYBsaK6W5my
 uLX2/DtdoPmWB7xhaBdDrgZn4r++3wSDSKkY/4Biw/Bxwvx4pQCFERoDCXjTLxGRCD7lQeFY2
 u32C1/eLbJs8RVNKRwAZJWF9Z8IKomoBYpz1xSceQoKFE/qeCj206YikxPgpvy6/1LJgsT0Fe
 OFDFmdWxf9UxD7v26UFWD+sCwHIs/5WtZjz57kDd0OYxiJxuvVX31bBt9EtvXp8vbJzmOKZK3
 nb67adKbOrkt5KsscdYTLJOyVhbHvdEU/tq0xPnFXBmnN8z79fXFcNm4n/KyYxAALN+1GXOIS
 PzqMGAgVUlyHyMxabM/zW705J7/zYto67s1mENdco6YGAW2jiFUw0d5Xzy8IC5xZmlyDn2+Z8
 /npHXY6QNmQsG2FzCsLRwkmFMyj3W9H5P2sbMCTREhHITq+TqngXY2mGpNpjd/fLx9gAPnYGV
 ZKKoSUhOhPRnTxegk3OTQkfZ9QVkMtI4cYMEgrwvK19074pAevjEZfExA5byXqGKTeYH4jN6B
 Zw31OJGc2WHhQ8wXPtdsYHh7hOnJbAAMYv0lrtN7Gvqc3M8ViJ39syynNHCsM+QV/cik+bt9p
 XUWXWqv3bVdDT13vQEjPSXlixXJ9c3wytmOGDjCudW9xB6TkKTvsk3R51YjSi94kVehSq6vSx
 uGonOVWHzvSZAmEvFPWSBcupFZyB76QBnQ+FNyDBbgZ+9dNnmfjb8c7pMt05CO0VgjeMZfmku
 4gxqn9LkF0aRrYENk5hktyBNebxZaUHD/CXVK7TXARTrBIh3eTFbPfyDu8GRKeFZE49mcXmFD
 UgDSoFopl0CO7Qkl1GHgq1L3swiAst2QMwzrXLiB2InzDS32GMmroOcaslO2poyWq+FLQ3K8a
 n+dYnP4+alKWUsVyn11LTPbrjdlK56AEcYzPxvw8Hl3ssMuM3so029SRVagMgP5+MZd4OSkr1
 /AtBpy6JXdCzpmtrL/VvicmR9LEGWXdkMeIXcF/AVO2Ca8TT2o7SpN5TCACJ8QfLJMxIwSaZ5
 WQ+Pkbl7lB4jaMWnQa8znGNsT8lHjojtbzLixUrSf8k3xWaTGBBcciXrAvb8jSzib2OwAF9yZ
 +HdpUbnrYXe43sZiQJ8HAEl1Iv/EFvlHb0Y+Aq6k1bVwz0pS0tbvpmrUzarzOa0vMX1+Jr1Jw
 lESLVOSAhkVDlxHuDDRCL3KPB0rn5oJsbtmru2Ld+oUZNcJekNd7K1oHIKTjwweVjl8eBu0+/
 qE0C08V95C66JWxbn4fF1dc5p0+72/XVFg1n3CN73KIKPxDyjLlOnvRJ5KNoQJbVJ7pZ4U2Av
 FsN3d2g==

On 30.03.25 09:20, Pierre FICHEUX wrote:
> Hi,
>
> Is there a way to build a SDK for the target selected in
> xenomai-images? Such as the following command in Yocto :
>
> $ bitbake -c populate_sdk <image-recipe>
>

Not tested yet, but something like this will likely be needed:

diff --git a/conf/distro/xenomai-demo.conf b/conf/distro/xenomai-demo.conf
index d1b24b7..a113a54 100644
=2D-- a/conf/distro/xenomai-demo.conf
+++ b/conf/distro/xenomai-demo.conf
@@ -23,6 +23,9 @@ PREFERRED_VERSION_libevl ?=3D "4%"

 KERNEL_NAME =3D "xenomai-${XENOMAI_MAJOR_VERSION}"

+SDK_INSTALL +=3D "linux-headers-${KERNEL_NAME}"
+SDK_INSTALL +=3D "${@'libevl' if d.getVar('XENOMAI_MAJOR_VERSION') =3D=3D=
 '4' else 'libxenomai-dev'}"
+
 WKS_FILE =3D "${MACHINE}.wks"

 USERS +=3D "root"


Jan
