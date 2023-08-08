Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F4D160
	for <xenomai@lists.linux.dev>; Tue,  8 Aug 2023 06:32:33 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5222c5d71b8so7362832a12.2
        for <xenomai@lists.linux.dev>; Mon, 07 Aug 2023 23:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1691476351; x=1692081151;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pce+79XCyqGxMxXIUW33WZbFHoP2eUsK98cPdLpHcsQ=;
        b=R5DY9z9dlfi82t66kjxPMBwd2pdgSRVhJMv8W/s63NAuWYkUNv5BkfjRr6ceDYRwEs
         PpAiUNsSoEANJZbQCbZ1vJVkaFfScASlJ0XY26JR7P3GcXweLZ0wbdlfLTCEne28wUhG
         SsgEyHxt8sA+qMWVfFmN4NNVRV5+nsltX/UZJX4ZVxo82FhFghp1gDU7HBvH6KGd8mxz
         8XxfgwxOyKvLMNrqBpHG9LAvi+9N5PDXGkzxC981+YYWtRMqSJNz7KxC7oYDzO8SNH+p
         CURrsto0GaNg68na3isWdQrKDoXzNBoifcHKtldMtwyb3fDtV/R6Qc0Ck6ZXZ7halKwk
         IXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691476351; x=1692081151;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pce+79XCyqGxMxXIUW33WZbFHoP2eUsK98cPdLpHcsQ=;
        b=DrQKGo3CdsF/s+abmhiKiA9sfzZX0/UOlUuviCc0zWicyI1z3U2wfBZRsQqsH3Rfma
         B4AKI2fHvfGoTsDivcBvCff/OtPn+U12XHQja9kjf+ZLnKhW6ekrRuRXRh0Ry2G+Cnzy
         9BcxDVo5bT+LsBLQb4893lHo0or4IjRJ7huxpH0aArOsZjyASXUSmZqQkVeLi2wVeS7m
         K6k/5Y6RlUfIgrpXl3w4tgiGjUVFa8y1boWq9b9oJ9tDvNWr87Xwcam94rWAbtsWXUef
         orFD7FCZ45KRk661qSHNxyNlMigWXY4MyCPfjg6blacfhF8IDEJiZAV7qAR/LKXsqVkX
         lVeA==
X-Gm-Message-State: AOJu0Yzuy4J+G2L/lO7Wywx1bAl65RZ+cAySkU3AKSwEKW4Ng6elCCcB
	002+lNr58WOprMmjHMVby6wLmd62BlAoa7N7hag=
X-Google-Smtp-Source: AGHT+IEzTnfhBEJ4eN5Eos5UMjnwdEoP3qQbUDzfJAvP5DH7EJkwiHvSARJptd8kH6ngLMCfumyBLg==
X-Received: by 2002:aa7:c487:0:b0:523:47cf:5034 with SMTP id m7-20020aa7c487000000b0052347cf5034mr753822edq.34.1691476350929;
        Mon, 07 Aug 2023 23:32:30 -0700 (PDT)
Received: from mail ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id u6-20020aa7d986000000b005233f2635fbsm1467028eds.21.2023.08.07.23.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 23:32:30 -0700 (PDT)
Date: Tue, 8 Aug 2023 08:32:30 +0200
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@sigma-star.at
Subject: Latest Dovetail patch release?
Message-ID: <20230808063230.q46u55o7xjzy2dob@mail>
Mail-Followup-To: Aaron Marcher <aaron@sigma-star.at>,
	xenomai@lists.linux.dev, richard@sigma-star.at
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

currently it is a little bit confusing to identify the latest Dovetail
patch release:

	https://xenomai.org/downloads/dovetail/

lists the latest kernel 5.15 relase as 5.15.51
(patch-5.15.51-dovetail1.patch.bz2). While on

	https://source.denx.de/Xenomai/linux-dovetail/-/tags

the latest tag for kernel 5.15 is 5.15.119.
Where can one find the latest, stable & tested Dovetail patch?

Thanks,
Aaron

-- 
sigma star gmbh | Eduard-Bodem-Gasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y
