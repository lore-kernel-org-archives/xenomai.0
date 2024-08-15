Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456D11714B2
	for <xenomai@lists.linux.dev>; Thu, 15 Aug 2024 09:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723714795; cv=none; b=B5z3O/KKU5UfKx3VFDjI5O3VX/HmffkVBceDK9xpw1kCmDWo+nBU6jCQ3Lj2U36Iiq9MFsg4S0/aNDRnvu9KSVsTchoxAhuP3z4aDH3hfox266tuHimNLqGBxWXwEYqZDui7Lnoask25TaPeak7yk5KQUM/4X+0/9jhGYN1h2Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723714795; c=relaxed/simple;
	bh=eu3Mc3iZui5wBcGeQedHwWah1z2WelNzbo58EBbGw6c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OI/wES5KECLPlOsaSU1X91AoPzYmIyxGDc3GVHUmPvbAtbbBkqoSB3WMZaxPgeZBcFA0zdMyB1pANSlykIU4jiAfsGkqdANJHdOmCkjLLI7nChO/3TH7xlOGKojMnUUFkPuJyiGl0A6GvYDYuowffVAO98exiWknaqSfIXOkFdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-429da8b5feaso6333725e9.2
        for <xenomai@lists.linux.dev>; Thu, 15 Aug 2024 02:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723714791; x=1724319591;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QUZJHahwaJirABHTxxLOHfWHoDO6SBQB2ij98RmFcgQ=;
        b=TlU2AHt52zEEUOoBvB+Vt5WJkcZRwcwcZNNwxfB3QYwcS0nQirl13I6LwSzkqiUk9O
         ixjNQiZ4CKOhvvpzVlq9FIzC5xXoOT2oEpA6ml6h3dGx5OgiJ4+2lOVbZMuPikH3xRmB
         xeAl0GvUSi9KYdGwtYO1uMfGgn5Yz4nZ8DJ6758AzbUNw2JtnmxPqDK85Lw6DZC2CUo0
         WYStL5DUgiGWKkmZhnWoiiBQF63So/EIIe8RFn5C73twa8doPVFNhPWfeN7/NRUQw/av
         KF8WjigRf254szm1BJrL80TUNKNjp4WswsACNFUfneIUxvWIp91wp5cOC4cy74oC036p
         gXIw==
X-Forwarded-Encrypted: i=1; AJvYcCWrLHg3kBFYqroZKI2tVzq0YY8Ht252MV79V4CXIHWn4Tn+vj5NsyMXEq1/KwbcFQTd7Tr6in7HzT/g4027v/ezNa2hQ9TIRw==
X-Gm-Message-State: AOJu0YwyNqvqx2fZ6b8SFcv++kCyKK6+Co0fR5uFsw7/76jr23tqEOJ9
	TrLpCXx50Jb+xUlrOnSJ5UBS5txeb5EA03BraAQp+/4eKTZVFo/yzA/VUICt
X-Google-Smtp-Source: AGHT+IHwV5VqrnzaobfKCLG7lGTbKDnQOuxN/Gc6HZu31iL7IsbEsEQrotcPpV7oQahTFzE0Zmse0Q==
X-Received: by 2002:adf:f1ca:0:b0:368:6564:751b with SMTP id ffacd0b85a97d-371777793cdmr4116890f8f.32.1723714791203;
        Thu, 15 Aug 2024 02:39:51 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898b83c6sm1042317f8f.111.2024.08.15.02.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 02:39:50 -0700 (PDT)
From: Philippe Gerum <rpm@xenomai.org>
To: Steve Rosenbluth <stever8@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,  Norbert Lange
 <nolange79@gmail.com>,  Florian Bezdeka <florian.bezdeka@siemens.com>,
  xenomai@lists.linux.dev
Subject: Re: Dowload URL for ipipe patches?
In-Reply-To: <CAExw09CJA3ydfAti47czAi4QM7xvtqPQzrvR48JVhWcVGUEj5w@mail.gmail.com>
	(Steve Rosenbluth's message of "Wed, 14 Aug 2024 13:15:08 -0700")
References: <CADYdroMJCeW_UNvc6K1p_2dc2-hCDWyATXcDq6iHL5pVSrFknA@mail.gmail.com>
	<207f29ba1fe51a1656c5f72cb719ba0fab5b2e6d.camel@siemens.com>
	<5f546c94-440f-4641-9549-f6c27652caf7@siemens.com>
	<CADYdroPpqtYYwvAgmpH=E4a3u0-C4chaBqwioe658kN8Tx5BFQ@mail.gmail.com>
	<b54d8394-da9d-40a9-9320-3bab5ced2da0@siemens.com>
	<CAExw09CJA3ydfAti47czAi4QM7xvtqPQzrvR48JVhWcVGUEj5w@mail.gmail.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Thu, 15 Aug 2024 11:39:45 +0200
Message-ID: <87mslei0pq.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Steve Rosenbluth <stever8@gmail.com> writes:

> On Fri, May 31, 2024 at 7:04=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.co=
m> wrote:
>>
>> On 31.05.24 15:53, Norbert Lange wrote:
>> > Am Fr., 31. Mai 2024 um 15:00 Uhr schrieb Jan Kiszka <jan.kiszka@sieme=
ns.com>:
>> >>
>> >> On 31.05.24 09:11, Florian Bezdeka wrote:
>> >>> Hi Norbert,
>> >>>
>> >>> On Thu, 2024-05-23 at 09:32 +0200, Norbert Lange wrote:
>> >>>> Hello,
>> >>>>
>> >>>> the older URL's dont work, and I did not find any reference to the
>> >>>> replacement, even rather recent releases have non-working URLs [0].
>> >>>> So the links dont work, and the gitlab repository doesnt offer them
>> >>>> either, eg  [1].
>> >>>>
>> >>>> Whats the plan going forward?
>> >>>
>> >>> the main point is: I-Pipe is "dead" / in maintenance only mode. The
>> >>> last supported Linux version was 5.4. We have dovetail for modern
>> >>> kernels, so the way forward is "use dovetail".
>> >>>
>> >>> That said, we have a downloads archive [2] here. That might help to
>> >>> some degree, "newer" I-Pipe versions are available through the
>> >>> architecture specific ipipe git repositories, so no "ready for
>> >>> download" patches anymore (as far as I know). For x86 it's [3].
>> >>>
>> >>
>> >> Right, we are no longer having infrastructure in place to format those
>> >> individual patches and push them somewhere on a static page. None of
>> >> that is technically impossible, but given the current demand for
>> >> restoring this (you are the first to ask for it, TBH), we were not ve=
ry
>> >> motivated to do the required work (likely more than some hour on a ra=
iny
>> >> Friday afternoon).
>> >
>> > My  main point being that *all the docs* still refer to the old URL,
>> > and the method
>> > of using an upstream-kernel + i-pipe patch.
>> > I don't have a problem using git repos but I would like to use the
>> > correct infrastructure.
>>
>> We may need a friendly janitor to update the docs in this regard...
>>
>> >
>> > As far being the first to ask, first we have all we need stored
>> > locally, so we can still
>> > build our past versions. 5.4 LTS should have still a year+ of support =
ahead.
>> > Changing to dovetail is not really an option without RT-capable
>> > network drivers, and would
>> > be anything but a simple change. Is there even a plan how to support
>> > for ex. reading PTP Clocks
>> > from realtime?
>> >
>> > FWIW, given how thin the RT-driver support is with Dovetail I dont get
>> > the point of using a hard RT
>> > OS without getting your IO in hard RT. I get that someone has to do
>> > the work, I get that the old ipipe was hard to maintain,
>> > but this replaced a much more "complete" framework.
>>
>> First, I-pipe support is not completely dead yet, 3.2.x still has it,
>> and we are updating 4.19 and 5.4 in principle (needs a kick, though).
>> Second, dovetail does not imply moving to Xenomai 4 / EVL. You can
>> continue to use Xenomai 3 with the driver supported there.
>>
>> PTP clock access is an interesting topic, though. You get it "for free"
>> if you sync the system clock against one PTP clock with all dovetail
>> kernels. Precision should not be affected by the fact that Linux
>> organizes the sync. However, there are no plans to provide other kind of
>> accesses so far, specifically if there are multiples clock or if there
>> is no synchronization to the host.
>>
>> Jan
>
> We definitely support xeno3.2 ipipe patches being published on the
> web, though I understand Xenomai's roadmap.
> Most industrial "long term" programs are 10 years, it seems a shame to
> take down small static files from FTP after just a few years. Such a
> file requires little storage space.
>
> I found this latest patch
> ipipe-core-5.4.253-x86-14.patch
> at https://ftp.denx.de/pub/xenomai/ipipe/v5.x/x86/
> But I only found up to the 5.4.239 patch at
> https://source.denx.de/Xenomai/download-archive/-/tree/main/ipipe/v5.x/x86
>
> I am currently building the ipipe patch for kernel 5.4.281 from a
> clone of the ipipe-x86 git repo. Thank you for that!
>

For the record, no file was taken down voluntarily. Such unfortunate
event might happen when the project infrastructure has to migrate to
another host.

[1] was a tentative replacement for the former xenomai.org/downloads
URL, where generated patches of the latest I-pipe releases could land
at. [2] is a frozen archive of the former xenomai.org/downloads URL,
created when the migration took place (updating [2] could be done, but
not in a flexible way ATM).

However, the reason to have those patches around in this day and age
became unclear long ago, when all releases those patches are generated
from could be easily accessed from the kernel git repository where the
I-pipe is maintained, e.g. at [3] for the x86 architecture. For this
reason, updates to [1] may lag behind availability in [3], mostly
because we did not automate the publication of new patches after the
migration. Machines hardly forget doing things, we might.

At the end of the day, keeping [1] around may be more confusing than
helpful, so removing it entirely may be the best option provided we
significantly improve the documentation about accessing the legacy
I-pipe code from [3]. Unless somebody makes a good case about publishing
patches in time again.

[1] https://source.denx.de/Xenomai/download-archive
[2] https://ftp.denx.de/pub/xenomai/
[3] https://source.denx.de/Xenomai/ipipe-x86

--=20
Philippe.
