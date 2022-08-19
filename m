Received: from camel.birch.relay.mailchannels.net (camel.birch.relay.mailchannels.net [23.83.209.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F605CB1
	for <xenomai@lists.linux.dev>; Fri, 19 Aug 2022 09:55:39 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 1338D5616F3
	for <xenomai@lists.linux.dev>; Fri, 19 Aug 2022 09:49:25 +0000 (UTC)
Received: from pdx1-sub0-mail-a306.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id A9F83561C6A
	for <xenomai@lists.linux.dev>; Fri, 19 Aug 2022 09:49:24 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1660902564; a=rsa-sha256;
	cv=none;
	b=kg8csSEtA2mDDI40+I+LJfQRTRdE7yfpoMm3uy6uH6p5fr/h75tFD5QFkmBhQguvFsDozn
	KI5zlmSobHRFg9SCXpMraHOWlvEnoVeBl2qCWeOv7JLjosyKYOGytLycge+KtSlFj5/Q3P
	6EuDaENDR1FrVqK6wTb1JgNdbKYs1nj03yoltiVHFJaq3k0OZtoPUeE8kfF38QrUG+ZQWF
	eUHKr4l/ob5cgWV+e+6GetcD+qExaZurIPiha2nJPhRMDiLBxK0DrJRb+FJ4ix996zaWTJ
	Wrd8bwGIXb2hPh7maUTpUvZ3Ssk3yAuQXJq6sIzWScdzmNLeTzFgdL1y6iPBaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1660902564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=xG8Of51QE++Y2ljBhYLAdZEAbAqkJZtIik9xuoEw85Q=;
	b=J/qMCWy47gfAeyrJpufKqKDFz3dy9tSj8bIL8RJPETq1EQyI2QFKexRGbCEX3WmyWE/XpH
	lfc4BBfhG9sywFCNgrCGewD8o0ORkyUEws3wdTEj54xQvQwUq6LmebPY9re2UnE2cZhp8b
	xopnW8cE3KP3ksdxMaWn/tQlLOvohOCiwY91mDKr5oI1s1dkt7kHJWlVU/d1ANqvYyN2Da
	YdDe/s2WP04m/3XwwKn+qpIqMsZ1e4x4XpVAb3u2It9CuU1zMIegezPQIlEpSzrBhX6uYM
	EBhXExs6T6Zj9r5YWfBXzWxghHJpbXcvGQwa9bRsMQlrxH6bp7XK6qHX93lORQ==
ARC-Authentication-Results: i=1;
	rspamd-769cfffc99-q7m2w;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=giulio@bela.io
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|giulio@bela.io
X-MailChannels-Auth-Id: dreamhost
X-Duck-Suffer: 298da044267024db_1660902564913_3720569866
X-MC-Loop-Signature: 1660902564913:3435022045
X-MC-Ingress-Time: 1660902564913
Received: from pdx1-sub0-mail-a306.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.115.45.14 (trex/6.7.1);
	Fri, 19 Aug 2022 09:49:24 +0000
Received: from [192.168.1.77] (unknown [5.179.190.120])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: giulio@bela.io)
	by pdx1-sub0-mail-a306.dreamhost.com (Postfix) with ESMTPSA id 4M8H5w0bF1z4h
	for <xenomai@lists.linux.dev>; Fri, 19 Aug 2022 02:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bela.io;
	s=dreamhost; t=1660902564;
	bh=xG8Of51QE++Y2ljBhYLAdZEAbAqkJZtIik9xuoEw85Q=;
	h=From:Subject:To:Date:Content-Type:Content-Transfer-Encoding;
	b=ayMRyUVYmi4YJv6b1R7O54QcWwdnf+NfnKAeT+zb5ttjqBDNNEHfIaMFvwShuZri2
	 mA42RAwX2EFBuvYPo+ht65mUB7nRPCjokxjDQRvc10ZPhgZpBJg6+V0b2mtYqyISoD
	 cdslFmz5RQKI1+LNwrIdCQvcBBpf9/6+d3ETNT9abbwK0UJWlOlqw6p8RekbWkxkEb
	 LOcStIZ+U2tZmWhO1+bIWPTdIjzb616Q6j9y+NpkRaZaD2EgJZAnA1Iztnj7EXrTp7
	 e22Xow1PlQhAyWgEied5Rh6uaYL/nWSXXE5IqavKKFaetQ6jhrHnUE+lISezrG+7zo
	 QJlSwKiCijuJQ==
From: Giulio Moro <giulio@bela.io>
Subject: Re: [PATCH] selinux: incrementing the count of known PFs.
To: xenomai@lists.linux.dev
References: <2eba63d2-9560-b62f-b283-194b99692c30@bela.io>
 <c5cdd1fd-7d2f-5276-bcc7-3000a6efbe04@siemens.com>
Message-ID: <696f43b5-c61a-2e94-2840-7a6b06dc2c1b@bela.io>
Date: Fri, 19 Aug 2022 11:49:22 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Firefox/60.0 SeaMonkey/2.53.4
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <c5cdd1fd-7d2f-5276-bcc7-3000a6efbe04@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[resending because it bounced back from the list]

> Which dovetail kernel versions is this targeting?

This was applied and tested on https://source.denx.de/Xenomai/xenomai4/linux-evl/-/tree/vendor/ti/v5.10.120 but it should be equally required and work equally well to https://source.denx.de/Xenomai/xenomai4/linux-evl/-/tree/v5.10.y-evl-rebase and probably any containing the same commit  'selinux: dovetail: declare oob socket class'


Jan Kiszka wrote on 18/08/2022 14:50:
> On 17.08.22 18:59, Giulio Moro wrote:
>> This was needed for my bindep-pkg build. Not sure what config option
>> requires it.
>>
>> ---
>>
>>  From 62063ad20509ba448f5601343b44647a00f5fcc2 Mon Sep 17 00:00:00 2001
>> From: Giulio Moro <giuliomoro@yahoo.it>
>> Date: Wed, 17 Aug 2022 15:50:52 +0000
>> Subject: [PATCH] selinux: incrementing the count of known PFs.
>>
>> Fixup for a24b313bd77a4b3e15168d8115a8d661113fac0b
>>    'selinux: dovetail: declare oob socket class'
>>
>> Signed-off-by: Giulio Moro <giuliomoro@yahoo.it>
>> ---
>>   security/selinux/include/classmap.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/security/selinux/include/classmap.h
>> b/security/selinux/include/classmap.h
>> index 8605d5fa893f..2112f07c36c7 100644
>> --- a/security/selinux/include/classmap.h
>> +++ b/security/selinux/include/classmap.h
>> @@ -257,6 +257,6 @@ struct security_class_mapping secclass_map[] = {
>>       { NULL }
>>     };
>>
>> -#if PF_MAX > 46
>> +#if PF_MAX > 47
>>   #error New address family defined, please update secclass_map.
>>   #endif
>> -- 
>> 2.25.1
>>
>>
> 
> Which dovetail kernel versions is this targeting?
> 
> Jan
> 
