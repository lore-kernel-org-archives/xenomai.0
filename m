Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A6C125B0
	for <xenomai@lists.linux.dev>; Tue,  8 Aug 2023 12:52:45 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-99bcf2de59cso823696266b.0
        for <xenomai@lists.linux.dev>; Tue, 08 Aug 2023 05:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1691499163; x=1692103963;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7UVqPreziB8yRfj1FPXNt3GHX8h+kqIJjAcy8reKPIM=;
        b=Z+JCbEMnC2YzASnZrHw704qbv4oYp5BO6OlWQzgy9EOqrn0VwOjIK0ITKeKjQuKS8y
         bZhY37JmJEEcLE7XQqCStlG1A+BPJ4vuJQjSZHy6dL9Td/0MWkbT+5udRUv3DQV1YU7t
         XFc7vOMUkeQhJJ8i21lMpmpvu9vP7eChCdn5kbh2CCQrWyvvAQ3pLSqfFbRnJYqDk3IW
         7Aaceuv1W55mLK6tnaGriH0FsJwJe29R+f7HG7ziZUDPZ0UC0wsEBk8WetCyz9yzV8JE
         IUJpKmKEgAtadIVbzbpz/K+lh1O0Xj68VMV5bWTb3P1tykNisZ0QQEt4bOlXxZIhXNvj
         i72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691499163; x=1692103963;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7UVqPreziB8yRfj1FPXNt3GHX8h+kqIJjAcy8reKPIM=;
        b=WbWWnacXH+2huB6lY7smjIpHVyEoIF02Wtb4lQ/XjTjwPHIq/mSwEsaH8nJ7+1hnJl
         MH7jisJNDBBrKbuhUOVl+vOwxT7xIV/IgJ5UDX4/CHi7iSnyDJcmNsAUKFLOPDow5gfD
         ywjyqNrg/RuVwt0SbuoQlXpp/LhesPKwtqMC7+lrRBeKUx5KM7Agawnv21twj8mHomws
         2SHxuDlZqXOs93ej7lrl8rDL1BjHTX0pMRbreqsM2XSXy6QSsgEoOyn9/DLVoFWiGwtn
         n5peERiwmZGQ4+Bb0jOCNWEWZvviivz8q26ExClkLipxiIRheNftl9SEEOjJri/i7tr0
         03nw==
X-Gm-Message-State: AOJu0Yxxuxigz82XpAJIQ5H4cHcNXEyROYqhbGHmTWvo4zaHehOM313R
	YgGa7t67HG7lm7luIf7W5fnqMg==
X-Google-Smtp-Source: AGHT+IGBhnqCxJgvufiyiM+fODgIw+CCOFdJ3QRBSyoOK6l4JiHpnZS5g91fVI4e0d4SlhsOga9nyw==
X-Received: by 2002:a17:906:cc14:b0:99b:4b4f:c9de with SMTP id ml20-20020a170906cc1400b0099b4b4fc9demr10697309ejb.36.1691499163528;
        Tue, 08 Aug 2023 05:52:43 -0700 (PDT)
Received: from mail ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id s5-20020a170906168500b00999bb1e01dfsm6595973ejd.52.2023.08.08.05.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 05:52:43 -0700 (PDT)
Date: Tue, 8 Aug 2023 14:52:41 +0200
From: Aaron Marcher <aaron@sigma-star.at>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev, richard@sigma-star.at
Subject: Re: Latest Dovetail patch release?
Message-ID: <20230808125241.imtt6vqp3lekepj5@mail>
Mail-Followup-To: Aaron Marcher <aaron@sigma-star.at>,
	Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev,
	richard@sigma-star.at
References: <20230808063230.q46u55o7xjzy2dob@mail>
 <07b6a1c3-b341-60a5-23aa-9338cc8be501@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <07b6a1c3-b341-60a5-23aa-9338cc8be501@siemens.com>

On Tue, Aug 08, 2023 at 02:45:43PM +0200, Jan Kiszka wrote:
> With Xenomai 3, we are testing v{5.10,5.15,6.1}.y-dovetail-rebase as
> well as latest v6.x-dovetail-rebase, always the head revisions.

That's what i thought. Thanks for confirming, Jan.

> Regarding patches, I would refrain from looking at
> https://xenomai.org/downloads/dovetail/ as it stalled last year. Use the
> linux-dovetail repo.

Thanks for the information. Maybe this can be added to the documentation
anywhere or as a README file to the (old) download location to prevent
further confusion?

Aaron

-- 
sigma star gmbh | Eduard-Bodem-Gasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y
