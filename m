Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4787C
	for <xenomai@lists.linux.dev>; Fri, 18 Nov 2022 08:21:59 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id BA2CA1BF20C;
	Fri, 18 Nov 2022 08:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1668759717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VmHozqDmdnYCRNia4lL8z57r29pV94s4XdYmfOA25wI=;
	b=nYm92RKdabzmKUWlDJfn8/iTFLcBSusNLv43cLhNyVJcqOyRmKFipcpxszNhnZ1CUt8CES
	CVwjLVSPvfXnkLLB06tHsPQb7UTZewdwugfHXmf6zy6IE+ilGXJxw0HM/o+DdjuQUSsfZ9
	3QDSBowzmNWlSG7YlR9pswSn6sqhKndDGD2UMKTd/Y61dwKDaaoR4dcTbwJgIxNHB4i+F7
	O+I/fldRfawXVaq/ojxTgsKew3U9OTB9xn3/1PVCJWCSIGdKq5QFtRuqI9p1Wr9hSJcGH1
	ZjYlDrubPKHZ4ialDSPc7h44+vBfvKcXMWi1pa3xkaA1vnuyuoZ5Hs3QXl5rYg==
References: <PH1P110MB1050AD875FCD924D827A0A54E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB10508DD9688B7D0E82AB30CDE23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB1050307D7FC58A2B99A40094E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <877d04dm52.fsf@xenomai.org>
 <PH1P110MB1050221E0BC34BD641127901E2009@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87leodn9kv.fsf@xenomai.org>
 <PH1P110MB105002FA12DD4C10060A7B59E2059@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87zgcs4ma1.fsf@xenomai.org>
 <PH1P110MB10500F942C9666D27F48E154E2049@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87v8ng3vv7.fsf@xenomai.org> <87edu2dh2j.fsf@xenomai.org>
 <PH1P110MB10505104BB0814A3F46A86BCE2079@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87tu2xbk5k.fsf@xenomai.org>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, Bryan Butler
 <Bryan.Butler@kratosdefense.com>, Shawn McManus
 <shawn.mcmanus@kratosdefense.com>
Subject: Re: [External] - Re: EVL Memory
Date: Fri, 18 Nov 2022 09:08:27 +0100
In-reply-to: <87tu2xbk5k.fsf@xenomai.org>
Message-ID: <87cz9kbrkr.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Philippe Gerum <rpm@xenomai.org> writes:

> Russell Johnson <russell.johnson@kratosdefense.com> writes:
>
>> [[S/MIME Signed Part:Undecided]]
>> Sounds good. Just let me know when you want me to test, and I will pull your
>> latest.
>>
>>
>
> Please try the -next branch, commit #b295ac3ad51b so that we can get a
> fresh status with the latest updates, and hopefully better trace dumps
> if an issue arises.
>

Two overnight tests passed here with this stack (octa-core xu4q/armv7
and quad-core x86 SoM), running loops of the condvar app you sent me,
and the EVL test suite in parallel. Although we may not be done yet,
this is a positive outcome given the amount of stress these tests impose
on the EVL core.

However, the evl ps display you sent me, showing a PI boost would
require some investigation if these threads would never switch back to
their normal priority, clearing the 'b' flag accordingly in the STAT
field.

-- 
Philippe.
