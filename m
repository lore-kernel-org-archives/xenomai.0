Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9602C6AF
	for <xenomai@lists.linux.dev>; Sat,  3 Aug 2024 08:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722674070; cv=none; b=ohi+AnlTjmdEz16r4z0rWjJPqzTO2tuUUuDGmcbdAEVjPGlGG8Q3czStyfxY5YqcdynExTPmvEBrowB7pJVU/AyJqemIZNdYDC1vbmxXUu9Y2jhCPN/ncPwZMzuR0XEvQfHw1SNdaE/hN8iT4HpJ1pcFji8VeIlrKVSt5YAFUw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722674070; c=relaxed/simple;
	bh=zNC0y2rG4w0sT7z6QVGcQn25KpodBB1IwWYLPclK7aw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rUerKzDZfHND6fIczewOm1e1+8HAznxbmgKe8IXmOz5TNrdwA52IzempiB8f+G+p/k5Yi9gbG0LiAioVrA0gVgWoaWAo8nmMMfohdHVKHuypfhozlGDfI+wVo6N1xjaBucaTHslbo6+LAZbj/KjI1SpIzQPczT7stoex7+NSCJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52f04150796so14126733e87.3
        for <xenomai@lists.linux.dev>; Sat, 03 Aug 2024 01:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722674066; x=1723278866;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4I4LFyAVlDyUuGRAx7LV1YSq7qO+0U0CCSt1h8Yysc=;
        b=MHB6lc5M+oe/z4bImn6dVhkBy6SBTMizDIQab9cmHlli4yMvxYdHDR2RDw0iA/f0Tk
         HLXCTpCssz8C/4r8CZ6eVizz3O/BhN8GOXbYkQCD69v2xlrxcD4LkohvkuUNgVjj1Jst
         CDGwQqF2jClLQ7Ri8JzilVYDLWJ1aK5HABK1+Ba39H4JdYQWddSjAL3ZN8rsCYgZN110
         XOqTbOb1+JLkZt1/C1Il0D5n5Q7e6GvKj5FhZ4cF+W6Z1OcFBWx06q1Tzn+pQ4zDGI86
         GkZTGd7pZv6A/QkACntYonS8s87iXkRzvjIRYXR7WBOqPxLAqSlzHgzpBzs2Q68cUX8r
         CUsg==
X-Gm-Message-State: AOJu0Yw5jaO0/U7Tdfjcq49CxBuQwlqmQxt3jEfotwS2zDnt4zaLe4C3
	KBZTuKT1tXsFuIgp59Ud5gHF0EteVe+02mG8bRQ1WJNwkluR1GC6VLbpjA==
X-Google-Smtp-Source: AGHT+IE5zSv1lN+BHbrZYGIoNpzjZGl1YKRA4e1trcjS53EPjJcbLSGOZ5u/fHh+uabVIpDaq5+umA==
X-Received: by 2002:a05:6512:3baa:b0:52c:dbe7:cfd5 with SMTP id 2adb3069b0e04-530bb387535mr3565246e87.32.1722674065865;
        Sat, 03 Aug 2024 01:34:25 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd0269ffsm3785811f8f.58.2024.08.03.01.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 01:34:25 -0700 (PDT)
From: Philippe Gerum <rpm@xenomai.org>
To: "Nechita, Ionut" <ionut.nechita@intel.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: WARN Kernel v6.9-evl-rebase - EVL: invalid out-of-band syscall
 <0x43564d41> - Firefox browser
In-Reply-To: <87le1jqdvc.fsf@xenomai.org> (Philippe Gerum's message of "Tue,
	30 Jul 2024 14:10:47 +0200")
References: <PH0PR11MB59493E21636F9CA955E2DE8BF4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
	<87wmnmq8v9.fsf@xenomai.org>
	<PH0PR11MB59491C18ADB51F5FEAEF4B3FF4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
	<PH0PR11MB59490B50D2D2717B8155EFCDF4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
	<87h6eprhbg.fsf@xenomai.org>
	<PH0PR11MB5949B24CB222FBB2D387BF24F4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
	<87cypdr5fm.fsf@xenomai.org>
	<PH0PR11MB5949453FBEBCA4520CAF80A2F4B42@PH0PR11MB5949.namprd11.prod.outlook.com>
	<871q3g3qva.fsf@xenomai.org>
	<PH0PR11MB5949E741DE6A97AF6E1A741DF4B72@PH0PR11MB5949.namprd11.prod.outlook.com>
	<87y15kff0y.fsf@xenomai.org>
	<PH0PR11MB5949AE14DD34B53E647A0896F4B72@PH0PR11MB5949.namprd11.prod.outlook.com>
	<87ttg7qkx7.fsf@xenomai.org> <87le1jqdvc.fsf@xenomai.org>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Sat, 03 Aug 2024 10:34:19 +0200
Message-ID: <87ed76yph0.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Philippe Gerum <rpm@xenomai.org> writes:

> Philippe Gerum <rpm@xenomai.org> writes:
>
>> "Nechita, Ionut" <ionut.nechita@intel.com> writes:
>>
>>> Hi Philippe,
>>>
>>> My .config kernel configuration:
>>>
>>
>> Ok, this is reproducible locally now, thanks. Will fix.
>
> Unfortunately, we have a conflict between some regular prctl(2) command
> codes and the Dovetail oob syscall marker (PR_SET_VMA at least). The
> proper fix is going to cause an ABI breakage when it comes to oob
> syscall encoding when the prctl() (sys)call form is used to issue
> requests to the real-time core.

Fixed upstream, branches v6.1.y-rebase, v6.6.y-rebase and
v6.10-rebase. You will need to switch to libevl r49 as well.

This ABI update only affects real-time cores already relying on the
prctl(2) syscall form for issuing out-of-band requests, like
Xenomai4/evl. The Xenomai3/cobalt core which still relies on the legacy
out-of-band syscall range is not impacted by this change.

-- 
Philippe.
