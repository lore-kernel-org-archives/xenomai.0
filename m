Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD04200124
	for <xenomai@lists.linux.dev>; Tue,  3 Sep 2024 08:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725351173; cv=none; b=PGG68Mn5TSZ96dH6Z5g4Cdwa/164bGh2erYpsWdGb9rPQwa6PmuMhfyFkNxjugnsRmqVzSlIeAFP8XeH9BhxsNwNLfOm0EZWXAVz8Nn9StUmp/X+FaymGdG3Xge0OVeiJEqEh7d9EgpacFw7mxamjtkK5iwzMO8Zu7p5d0lCJ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725351173; c=relaxed/simple;
	bh=ol8T0YItQ7ODqVA4SxAx7hpo4biEaVFrmHXtR8Fbbtw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jQ/YMtLeR5DniQwdwfc5crpaL8tJQo7BINbL5uiQFiO+3iaZ5GVcumd/0E6RojJsa8x73x7Lf7wBYKCW0EouiKthZE96LvPP6pYuc6qTyjUSE0up19u5WnI1ZYPpbJcgw0+9fQM8uznw0lBuBw1WrsOA6gg8BGv/we+MwihDTV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42c79deb7c4so22140715e9.3
        for <xenomai@lists.linux.dev>; Tue, 03 Sep 2024 01:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725351170; x=1725955970;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+JRRLZ96LzXBN1VPD4Y2L2Shrcu5VSKP01oAtTL0do=;
        b=ge4lDP0A/f+1wdMHp3kXGnoIW+qcRn892UVTIoL5+8GQNAlrwjle22OhGaRMJbaTM+
         6PyGvZuqO/nErQSVSLmyG31EjhIZRMMiHPhPVNflGCqWj8YgNQ5LqPSSqLnBoo+5UVOr
         /z4ur1tppeQn+s368XdpjEVV2osR0B/QKOgxsHbugsjV4xPKRi8GJcWgxLP3x1N1T0pn
         cGQxjhDJY93kSCUNbdNvb2NeMHC1fzMftYGfSZ3MxWPwh/8Qc1S6x9xeHq/B76IrA0y3
         jgKYwqX5qRfzn6Ou9RQvjW25nfh59DkyDgdi6+mZdJ9KJLsJsooQ1S/8kVdIBc2BXgqB
         bAmA==
X-Gm-Message-State: AOJu0Yz4yNg2oObMX+V5S4KRbKK0pHVgGYELuln151K8N6wY/akh3Oi/
	tRHwfVL4MKiPY7fgj5BgP43Oi8GboaaYHWTUyulbKh/ZbqOS2yvY
X-Google-Smtp-Source: AGHT+IGmKFJY4++F+tsV3x+Uo4jXKz9Hnr+4nQAsDjLHFzWL/8E80roTJDKIZeEMiszjKGXS9+L8Eg==
X-Received: by 2002:a5d:460b:0:b0:368:5b0c:7d34 with SMTP id ffacd0b85a97d-374bf055fe2mr7335047f8f.22.1725351169618;
        Tue, 03 Sep 2024 01:12:49 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c6479514sm6487895f8f.93.2024.09.03.01.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 01:12:49 -0700 (PDT)
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: Dovetail: x86 compat syscall handling broken, missing backport
 in 6.6 and 6.1
In-Reply-To: <f5d625d498678060902ff7362d72b8b16387fee5.camel@siemens.com>
	(Florian Bezdeka's message of "Mon, 26 Aug 2024 09:36:47 +0200")
References: <f5d625d498678060902ff7362d72b8b16387fee5.camel@siemens.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Tue, 03 Sep 2024 10:12:48 +0200
Message-ID: <87plpl9mv3.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Hi Philippe,
>
> I think we found a missing backport in dovetail 6.6 and 6.1. Jan
> observed the kernel splat below while testing.
>
> I'm quite sure that [1] should be applied to both mentioned branches.
>

Merged, thanks.

-- 
Philippe.
