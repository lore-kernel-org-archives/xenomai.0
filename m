Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657ED1990C0
	for <xenomai@lists.linux.dev>; Fri,  1 Nov 2024 17:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730480411; cv=none; b=ui/w0LlJX0D6QrwKPQfYD5ENNrvbSfXwxG5u5JNvwJlJMOJu88GRHa1hmwMU2TZ7BRI381HeNQ2O0LL8NhJOU+EhF1A1iWw8aSLfocDZPcMXNV/iKxcr2cpvHm59N4Ilx2VtO4CnlEkTP1bEGbaz1hUBgfYZmBnUlu8iBzqjLbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730480411; c=relaxed/simple;
	bh=m5u/QcHSwDJsO8SMXhvmwvTI40+hm4HeMKwY43QM+3k=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDJAIEdZkJFeaUQLwVNf5wtSgcLrMk6uBxaFPxar0yA/kCVlBLhM2G3AZp/DZ52beBgDbkdycJO9sGzSzCXEcVkuCzK5ddFV8qs2OTuwC1v9TxqHeE4Q1DkYushQRPJ9WXPLyZMAH2uZwVmgPoPnzIR3YFQXnJ0wqcSlpz025ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=buL9dxYD; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buL9dxYD"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d808ae924so1220392f8f.0
        for <xenomai@lists.linux.dev>; Fri, 01 Nov 2024 10:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730480408; x=1731085208; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mB1zb2Hua/RHN5GUBwz2EevBhlojZyJXxn+2Byd1Xv0=;
        b=buL9dxYDyv8EcvUDQ/jmd/apY4hf+2SxLe+74aELwa5qiRoA6d15FKgs1pSCUWtfdM
         2AZFhTNKcby6+CgfURX+seX5phfq+GL0x34Avmnw36xE3hdqc25F5fE5ZbmZ70dqFj5F
         wFztFHQBvnbW1FaNu8ENvNwCaBuCwY9g1OzDLd1gGukAjNsjB5bAn1xoBPPCzWIcpZBP
         3vEaVOI0rBHsS9fuKErtJFQO+UBcsOGfzm7S++hswGXjoatLEcZZE2QvZCGPdjU4nVD+
         OW0ryMkdd+k0MEO8Ydz39nur1xg9OCuRUnXaXwSTCo8VT2wN1lMcNYB+7CaKLolXUDyJ
         Qy4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730480408; x=1731085208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mB1zb2Hua/RHN5GUBwz2EevBhlojZyJXxn+2Byd1Xv0=;
        b=CS8TEm4meFkpzBTBRz815+zjqZdBdM6X96a/FlUpy02e6jv7C0ZzVaOnsm/XxXDFbA
         CfBNCboaoHXGodEdJaXBUz7aTcvH2uzfHQcBgHVmKeNm7t9SP8sRSXgzic2/XZPjwFBW
         1S16z3O2l44A5uQISXhYvZbia+bY4+EHEtqquaS3qeRV3rHCTugCJVZPAwnfSYVN+7Fu
         SjRtydwpLjcWdb2cANa7JS9P4PGdLp1URPJ/1alaVz3vmvG1Njduf/Daz6uWgHA/dW/C
         xscroBMD0bXWcmHwB47n7XOZkUZGocwtLAbLJgwYaeEzarT/m13e+hSX7R9XyK6qEPHU
         JLew==
X-Forwarded-Encrypted: i=1; AJvYcCWRsHz6Exf2tAvnkyph+qwHzRuWZPzJfmsZkV3BYY/bo+ajrVxW2wdJZwwQCQn32Ln9ziBH0Fq/@lists.linux.dev
X-Gm-Message-State: AOJu0YziBT++gNTPQMCZWZNquuaWB7Svop4rszBGrhc/3lwNsswo1LRb
	pnvchzJ8+XKURn5vVAiICfvq1h4ruH/T6HyjIKa5tQfFnv2oektzDAO5mS/y
X-Google-Smtp-Source: AGHT+IE35jM0Gjh1cijbRuJ80Tiu5kV1w4DTasMvcStEW5nVyYxsSuDe6r/InXQJdDTCxKPmgYw6+g==
X-Received: by 2002:adf:eac9:0:b0:37d:4ebe:164c with SMTP id ffacd0b85a97d-38061200742mr17593639f8f.45.1730480407512;
        Fri, 01 Nov 2024 10:00:07 -0700 (PDT)
Received: from trex (228.red-79-144-190.dynamicip.rima-tde.net. [79.144.190.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e687sm5711454f8f.84.2024.11.01.10.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 10:00:07 -0700 (PDT)
From: "Jorge Ramirez-Ortiz, Gmail" <jorge.ramirez.ortiz@gmail.com>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Gmail" <JorgeRamirez-Ortiz>
Date: Fri, 1 Nov 2024 18:00:06 +0100
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Philippe Gerum <rpm@xenomai.org>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	xenomai@lists.linux.dev
Subject: Re: [libevl][PATCH 3/4] evl-test: Start evl-test with load by default
Message-ID: <ZyUJFhSxPyAcfSHI@trex>
References: <20240613134557.4013044-1-tobias.schaffner@siemens.com>
 <20240613134557.4013044-4-tobias.schaffner@siemens.com>
 <87jzisrkfo.fsf@xenomai.org>
 <dbe94d71-1fdf-41d5-bc84-76923a66bc2a@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbe94d71-1fdf-41d5-bc84-76923a66bc2a@siemens.com>

On 13/06/24 17:30:51, Jan Kiszka wrote:
> On 13.06.24 16:16, Philippe Gerum wrote:
> > 
> > Tobias Schaffner <tobias.schaffner@siemens.com> writes:
> > 
> >> Stress evl with a load command while running the tests. The load command
> >> may be set to an empty string to run tests without stressing the system.
> >>
> >> To align with xeno-test the -l command line argument was used for the load
> >> command. Listing of the unittests can now be done with --list and --List.
> >>
> > 
> > Nak. Compat with xeno-test is definitely not a requirement if this means
> > breaking the existing evl command line usage. Besides, --List looks
> > strange as an option. Let's pick a different option for the load command
> > instead.
> > 
> >> The load command is moved to its own process group to allow a clean
> >> teardown of the load process with all its subprocesses.
> >>
> >> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> >> ---
> >>  utils/evl-test | 71 +++++++++++++++++++++++++++++++++++++++++++-------
> >>  1 file changed, 61 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/utils/evl-test b/utils/evl-test
> >> index 5c1c3da..fb85f69 100644
> >> --- a/utils/evl-test
> >> +++ b/utils/evl-test
> >> @@ -6,33 +6,79 @@ if test \! -d $EVL_TESTDIR; then
> >>     exit 2
> >>  fi
> >>  
> >> -usage() {
> >> -   echo >&2 "usage: $(basename $1) [-l][-L][-k][-h][-u] [test-list]"
> >> -}
> >> -
> >>  keep_going=false
> >>  do_list=false
> >>  full_path=false
> >>  unittests_only=false
> >> +load_cmd="dohell 900"
> >> +load_cmd_pgid_file="/tmp/evl_test_load_cmd_$$"
> >> +
> >> +usage() {
> >> +   cat >&2 <<EOF
> >> +evl test -h
> >> +
> >> +This help text.
> >> +
> >> +evl test [ -l "load command" ] [ -k ] [ -u ] [ --list ] [ --List ]
> >> +
> >> +Run a basic test/benchmark of evl on your platform, by first starting a
> >> +few unit tests, then running the latency test under the load generated by
> >> +"load-command".
> >> +
> >> +By default, the load command is "dohell 900", which will generate load during
> >> +15 minutes. To generate a more realistic load see dohell help.
> >> +
> >> +This script accepts the -k option to tell the unit test loop to keep
> >> +going upon a failing test. Otherwise evl test stops immediately.
> >> +
> > 
> > To be fixed wrt the comment on the previous patch.
> > 
> >> +Use -u if you want to skip the latency test and only run the unittests.
> >> +
> >> +Use --list to output all the tests available. --List will print all the tests
> >> +with their full path.
> >> +
> >> +Example:
> >> +evl test -l "dohell -s 192.168.0.5 -m /mnt -l /ltp"
> >> +
> >> +Will generate load including network load using the server at IP address
> >> +192.168.0.5, some I/O under the moint point /mnt, and the LTP testsuite
> >> +installed under the /ltp directory, and use the latency test by measuring the
> >> +timer irq latency.
> > 
> > We should use stress-ng or something alike, instead of the obsolete
> > dohell script.
> 
> Fact is that dohell does better than stress-ng, at least in the configs
> of the latter that I've seen before.

just "dohell -s 192.168.0.5 -m /mnt -l /ltp" ? do you know after how
long (ie, did it take a few hours or just minutes?)

> 
> Jan
> 
> -- 
> Siemens AG, Technology
> Linux Expert Center
> 
> 
