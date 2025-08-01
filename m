Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26602AEE4
	for <xenomai@lists.linux.dev>; Fri,  1 Aug 2025 09:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754039164; cv=none; b=U2LV8ugKT2vrPXKSOz1ghXMQqIyzkBjYGzdcq+qr+59SEHMwn44URLoMCoK31fk121RbY1T981XaUnFt8cMVu08kSTrEywU6mhO0JnvJ6QdX8Z+4m6PgAnZ+/8kgb4FdAB4S60kdbeYWoOSJDeMdrXYsO0p6l4P1HxVD5QMTIyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754039164; c=relaxed/simple;
	bh=8dCbkQ8utSvGFUzSokdF/w0yuiOuytMibAxAvLWqeqY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hkdX5t9LWwAruDpmULRwqIiEbSO+SuZ6ZOrtGILIJy5AuBBY7v63odPQ0hBulyr41dakiyF9ruRAbo4dPQPtlxjHavPfNx3pPvE+5Aln1TkQMS6H5H5VFiMqCnktVPJbY8+pKUbzL2o3ZpUkXQn3QCz9TiDvBOGg8TP7H7DPnfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=F5Rcsg/v; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="F5Rcsg/v"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 946F34327E;
	Fri,  1 Aug 2025 09:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1754039153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RUuc+fVPnwiDH5K8wvsPZHLI8Lde7W1DfTtsv0e58i8=;
	b=F5Rcsg/vA9wk0lhrSNVsUsp+Bvtxv9nY4b8R17wrcvb3orDgT5VBIszxpp34IPoYShWhGn
	2aJtePKnJGEA6xSjtD7eth4C3DS89txjKW5+GfeBL8kOwpLiHJlB0W1tCt88zfc5wEgtOY
	Fe8ZlWc+kffXaquBc0/TCe8xAQ6fPNurV+V7j3SqVURJYRkcMw9aBtIM1fmjAwqaKwlvjQ
	PG77QTXJ5IQz3SjTM7bydGa/prZF4porDWk8NPS1qycWgnqeCODp7SExmVkL1iO6ssFJZ/
	JThHfMh2PlTSal+cZkoTqZE2MdRQ8cmREjiYTxYWN/vztNuhD+fELqKt+oXK7A==
From: Philippe Gerum <rpm@xenomai.org>
To: "Xie, Nick" <nick.xie@festo.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: Error during libevl build and runtime settings failed
In-Reply-To: <AM5PR03MB2882726DD078E29EB76589518B27A@AM5PR03MB2882.eurprd03.prod.outlook.com>
	(Nick Xie's message of "Thu, 31 Jul 2025 22:10:22 +0000")
References: <AM5PR03MB2882F5ED2ADBA37FAA9562608B7DA@AM5PR03MB2882.eurprd03.prod.outlook.com>
	<AM5PR03MB2882F38E95A99A0760C60D1F8B27A@AM5PR03MB2882.eurprd03.prod.outlook.com>
	<AM5PR03MB2882726DD078E29EB76589518B27A@AM5PR03MB2882.eurprd03.prod.outlook.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Fri, 01 Aug 2025 11:05:49 +0200
Message-ID: <878qk3za1e.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdefvdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepvddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepnhhitghkrdigihgvsehfvghsthhordgtohhm
X-GND-Sasl: rpm@xenomai.org

"Xie, Nick" <nick.xie@festo.com> writes:

> Dear developers,
>
> I am building EVL for my application. I came across some errors. Please see below.
> Am 
> 1.	The EVL building was completed, but meson compile failed
> nick@nicklinux:~/libevl_build$ meson compile
> INFO: autodetecting backend as ninja
> INFO: calculating backend command to run: /usr/bin/ninja [11/222] Compiling C object lib/libevl.so.5.0.0.p/net.c.o
> FAILED: lib/libevl.so.5.0.0.p/net.c.o
> cc -Ilib/libevl.so.5.0.0.p -Ilib -I../libevl/lib -Iinclude -I../libevl/include -I../libevl/lib/arch/x86/include -fdiagnostics-color=always -D_FILE_OFFSET_BITS=64 -Wall -Winvalid-pch -Wextra -Wpedantic -Werror -std=gnu11 -O2 -g -pipe -Wstrict-aliasing -Wno-unused-parameter -Wno-pedantic -D_GNU_SOURCE -U_FORTIFY_SOURCE -Wshadow=local -Wstrict-prototypes -Wmissing-prototypes -fPIC -pthread '-DLIBVERSION="0.51"' -MD -MQ lib/libevl.so.5.0.0.p/net.c.o -MF lib/libevl.so.5.0.0.p/net.c.o.d -o lib/libevl.so.5.0.0.p/net.c.o -c ../libevl/lib/net.c
> ../libevl/lib/net.c: In function 'evl_net_solicit':

> ../libevl/lib/net.c:48:24: error: incompatible types when assigning to type 'struct __kernel_sockaddr_storage' from type 'struct sockaddr'
>    48 |         solicit.addr = *peer;
>       |                        ^
> [16/222] Compiling C object lib/libevl.so.5.0.0.p/heap.c.o
> ninja: build stopped: subcommand failed.
>

Please use 0.54, this bug was fixed in the meantime.
 
> ../libevl/tests/sched-quota-accuracy.c:213: FAILED: evl_control_sched(44, &p, &q, test_cpu) (=Operation not supported)
> sched-quota-accuracy: no kernel support
> ../libevl/tests/sched-tp-accuracy.c:222: FAILED: evl_control_sched(45, p, ((void *)0), test_cpu) (=Operation not supported)
> sched-tp-accuracy: no kernel support
> ../libevl/tests/sched-tp-overrun.c:220: FAILED: evl_control_sched(45,
> p, ((void *)0), test_cpu) (=Operation not supported)

You need to enable CONFIG_EVL_SCHED_QUOTA and CONFIG_EVL_SCHED_TP in the
kernel configuration for these tests to proceed.

-- 
Philippe.
