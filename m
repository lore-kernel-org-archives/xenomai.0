Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1EA1DFFC
	for <xenomai@lists.linux.dev>; Thu, 13 Jun 2024 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718288592; cv=none; b=QNckbx172OlZ9JCtZCvf/qHneeZDO9TZ/61Zs6+dZIA7KBSnQ7wh8dNSgS8OKdeyUeQsA0wfeWU+cbBVVYEEQ3fnxBwOsiivo1G2jELXW7bbllOrAbf/ooaj5dDll4f02soh8dn/3ZpKCF0YYl+Vza52Cs6m/hiYoJji5wzOdyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718288592; c=relaxed/simple;
	bh=96Dg7oxDpLI9fWh0/ZZTYwec1NmDooC7gZcfJQH5t3k=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=iYJiUcBhqoq1s4zum3JH2x575u3UCFmK1ykcbrXcb9BT542CmmD8YZyfnGFOITWjieCRJdJw2XTzitBzNTEfu3lCobJfeGfKObwgSJd9yGswmLt1QMxsFeROzlw5gNjdoMAJ+8JkQNZXfz2AfAyGFe/wVPGccEo7KI+wsaRzTe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4230366ad7bso5044925e9.1
        for <xenomai@lists.linux.dev>; Thu, 13 Jun 2024 07:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718288589; x=1718893389;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRWOMqGhqfJ3V+AT02wmdfsYGE18QzJ/mIEgMo7toE8=;
        b=WMRL9FdsXyYK42r9vDCHLgJJi4agEtLvAfBizhRSq4UIWRCDkH0g53ZVCTCHFVPABC
         E+OSvQA9ucFDmsu7iGAk7X6Ux3NXV8d1+mxFUPTIwjy1/uvJBldo4Tx4xnBfmgG9fcVn
         qN8PEKMyI2xVvhqyT0vEoqbR/cjaD3Q2ce/erIqqKAux75dXsD+/P3cURvxiBvS/OVuf
         d8I6/XE56A4XmWTEK00qZEBRBMq1WXCYEabMbkVSKpoKP3uexPpLmFR11d+VAQ+4CKbH
         M1z1uXHHbp0vVyBwBrKcgegbOQj7TiKNucgXpLXZgLA6a0iN65QxX2wTAr9oAzZP1SDq
         dbiA==
X-Gm-Message-State: AOJu0YwcHyZpeaW7rbhyzfl9M7OIKZYxAAzfdiPlEBY4OhSgOk5ne/ya
	FOA6EivKmI9c/QTxsnxnmA514HesiwRFMvQZ0OvagDHIMOrItieKEcr7PI+H
X-Google-Smtp-Source: AGHT+IGJQekTX+6G6MMVPPkfJGUODvX1pIk5bLgiaYoQ4U983ItKOsnIE1VoSkSGKfPMvmyAGTUuoQ==
X-Received: by 2002:a05:600c:500e:b0:421:7f07:92cf with SMTP id 5b1f17b1804b1-422867c00c0mr64793455e9.36.1718288589048;
        Thu, 13 Jun 2024 07:23:09 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f6320bd8sm26404975e9.32.2024.06.13.07.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 07:23:08 -0700 (PDT)
References: <20240613134557.4013044-1-tobias.schaffner@siemens.com>
 <20240613134557.4013044-4-tobias.schaffner@siemens.com>
User-agent: mu4e 1.10.5; emacs 29.3
From: Philippe Gerum <rpm@xenomai.org>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Subject: Re: [libevl][PATCH 3/4] evl-test: Start evl-test with load by default
Date: Thu, 13 Jun 2024 16:16:13 +0200
In-reply-to: <20240613134557.4013044-4-tobias.schaffner@siemens.com>
Message-ID: <87jzisrkfo.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Tobias Schaffner <tobias.schaffner@siemens.com> writes:

> Stress evl with a load command while running the tests. The load command
> may be set to an empty string to run tests without stressing the system.
>
> To align with xeno-test the -l command line argument was used for the load
> command. Listing of the unittests can now be done with --list and --List.
>

Nak. Compat with xeno-test is definitely not a requirement if this means
breaking the existing evl command line usage. Besides, --List looks
strange as an option. Let's pick a different option for the load command
instead.

> The load command is moved to its own process group to allow a clean
> teardown of the load process with all its subprocesses.
>
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  utils/evl-test | 71 +++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 61 insertions(+), 10 deletions(-)
>
> diff --git a/utils/evl-test b/utils/evl-test
> index 5c1c3da..fb85f69 100644
> --- a/utils/evl-test
> +++ b/utils/evl-test
> @@ -6,33 +6,79 @@ if test \! -d $EVL_TESTDIR; then
>     exit 2
>  fi
>  
> -usage() {
> -   echo >&2 "usage: $(basename $1) [-l][-L][-k][-h][-u] [test-list]"
> -}
> -
>  keep_going=false
>  do_list=false
>  full_path=false
>  unittests_only=false
> +load_cmd="dohell 900"
> +load_cmd_pgid_file="/tmp/evl_test_load_cmd_$$"
> +
> +usage() {
> +   cat >&2 <<EOF
> +evl test -h
> +
> +This help text.
> +
> +evl test [ -l "load command" ] [ -k ] [ -u ] [ --list ] [ --List ]
> +
> +Run a basic test/benchmark of evl on your platform, by first starting a
> +few unit tests, then running the latency test under the load generated by
> +"load-command".
> +
> +By default, the load command is "dohell 900", which will generate load during
> +15 minutes. To generate a more realistic load see dohell help.
> +
> +This script accepts the -k option to tell the unit test loop to keep
> +going upon a failing test. Otherwise evl test stops immediately.
> +

To be fixed wrt the comment on the previous patch.

> +Use -u if you want to skip the latency test and only run the unittests.
> +
> +Use --list to output all the tests available. --List will print all the tests
> +with their full path.
> +
> +Example:
> +evl test -l "dohell -s 192.168.0.5 -m /mnt -l /ltp"
> +
> +Will generate load including network load using the server at IP address
> +192.168.0.5, some I/O under the moint point /mnt, and the LTP testsuite
> +installed under the /ltp directory, and use the latency test by measuring the
> +timer irq latency.

We should use stress-ng or something alike, instead of the obsolete
dohell script.

-- 
Philippe.
