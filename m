Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DF72F530A
	for <xenomai@lists.linux.dev>; Fri, 14 Nov 2025 06:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763102807; cv=none; b=QIA7to59PA4m7FcG5xfwTW8/Z8aSo4grjzP9HK8HS09LwBdqK4d0nuIIrFWVcOaqU8aOF3y/rTyan3/d10e0blGRqrByVqdIUzRNx5Ebk+uA9K0skQyPVlYjuVC8+auVYN+ErJ9pLEpZYWwTkmQU09lZ8cm2O59vh7TLKPNoXhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763102807; c=relaxed/simple;
	bh=24bU3HvtRU9ASmG8W9lb++IHt5DjFlGTulA/y8g2sOg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=cJ7wdcsqird1Z2HFsMBNtSoCyEq3a4fPkOnUOY5XFspCKL5mqPjs+eQki7lVWdB1Bk191uboaVcoHMKpZEF6J2O2PxATj7x9XqqaFaUl6uyTnDeZI3vF8vqL/EWVO1K8124PqSCrtcC+ZvyZjeWhalH0MZKnzwief1W9WZ6Zdso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=Fl4KYnNN; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="Fl4KYnNN"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-37a415a22ecso13460351fa.0
        for <xenomai@lists.linux.dev>; Thu, 13 Nov 2025 22:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1763102803; x=1763707603; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KFO0eupcnukprfIcP1oLGTDk9+7CQwb79uf7sIXzr64=;
        b=Fl4KYnNNUNWS8AAnmjbSutHbH3XWv0EKKU8OuOXDtNZjxHJU6cAYB8c8SGG512Ma3c
         ASE+aLYLeP2jlndXW18S/PZI7QgKWIHPndHWeontai/LdZ2KWWeUntKInv1G+YZ3D5kY
         /5yGpb7BLxgZTePHFqwzSIB5EVy28J7e4yzFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763102803; x=1763707603;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KFO0eupcnukprfIcP1oLGTDk9+7CQwb79uf7sIXzr64=;
        b=HrByHn2t9GiNSS6Ny1THpULX+kKviQcHbZjgw30tpbQj8w9kmrEHcd9fdg0tUJuitu
         qDaTBpVylfkMW8KWfMZy58UQrfDaqlZ4daHkOR/EOGnpr4RvFOX2g556L9rvMvlD4oHs
         VMMB0lTiJuEon8jiLZULmfE221p5nvaw9UqHZyOhBzD+sXaWv0YtM+ryVL6AtQNBKV4P
         r7VuasgUjJRytpqQu/Hwm4jVJDiMPoIZyvYdp8igmYXchXmurFiz0CpZKuySEHat2rZI
         CdiHG+dD2ldnoe8DBjHI+m5i5natz0bgZt1T4cCZgHpSKubU0weVH95IaPosS0YPwBW2
         XE+A==
X-Gm-Message-State: AOJu0YxN0+ja2ULv2bfq0YnU/TQ8jjtnaCj4pYJ0rW10+It6pC6cSA/t
	/9x6ofCCb/ubIMhgiZfhgWsB2iMtYxJKtvPG7BNwkCGCDNtuVPp3nW2sMmu+GVDfM104g9eYOm1
	1lEn3FcfxKZZjmjEzMKvcYSZYd3Q+9CJ/J1Fkc02xIju7emFFbhZ3fuE=
X-Gm-Gg: ASbGncvoMBotfvg4TQEWGJAm3Oy9DxMd83RIPv+2/VdTHG41zWDMLmwiKN6y1s8J+v7
	DX4YEOuLv8UEi+DN8x26G0FRQhGU3Hn512Pw9rzCrVW4lr6NoZoKbegp1STv84TVGDO51oKuooL
	h3O77P6g9GozhzJoTlVNZGYSfKc02rHZRRv+5vdmsQ7nFMS5qgEFiGHdr1lkkfnwxX5G2b2wVtM
	NJ9FvFUEgW0GsMy39eN4RwW2d6qEQZCxFbWGqjNr136GUooiOqkRIrGTJuon3jPfgDoskZ5Ts0d
	CDTCBPn7FktBpsoD1fJ//bidelCO9zyYgI9ibnZSzFe3ugKT3jNEOvk7ERTO32c36lL9mcegJRx
	hXvjFvdXeZyDX5wjqW6nZHIJj2xEkXY10hKAbcw==
X-Google-Smtp-Source: AGHT+IGJwjfd+WYJTiJ7zbjoT7SMvyNIPBbBN2f7WfoakWp0yQWlBZNBiubRnai0VeStLtS0ixiiLWmU3XuutrcJiNs=
X-Received: by 2002:a05:651c:f06:b0:366:ef7d:bab3 with SMTP id
 38308e7fff4ca-37baaf4b144mr6197331fa.1.1763102802861; Thu, 13 Nov 2025
 22:46:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Fri, 14 Nov 2025 07:46:28 +0100
X-Gm-Features: AWmQ_blN2wOfcxgugrgBLa3qvq4y32T-GBG6BwF9SIcJ1R5sfyyXuTCtPjDbT00
Message-ID: <CAFc1U0vT7a_qcGQwfuFUibL+eSv8uktTFNAz+uQB+UO0HkvKrQ@mail.gmail.com>
Subject: DENX is shutting down
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi,

I think you're aware of this, but just in case:

https://www.denx.de/


-- 
Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
