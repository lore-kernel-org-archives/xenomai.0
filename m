Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE781A5A2
	for <xenomai@lists.linux.dev>; Tue,  9 Apr 2024 12:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712667034; cv=none; b=F9AvMLyyX0b91T1T2IZ3pCU+8uuSerzKG5aTd5nX+eQMV23nczlFty3yeqadF/EluHK1AD2US2CYTBBf4rWhmuks4y57xEBFsylE48t7kHDDkUHmlx6gYCSzgDaQCW+IJ6auqXYlZ8adcq40g0moSqDgqWK8B5g+ZrSsoXRVwxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712667034; c=relaxed/simple;
	bh=n5sbaxFui7VHo2fxmEMDDKGwcgyhKbz0gAMt2QGK/7A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qPa6HbPWgDFW52ZRdNK2uU1pzdwArIFfM/BJpOQgz0OsP/D5GkE5/SubZV6mzuS+O4G25f3WHwRWZjfrku3XHGT3OyoR/uPSfQee9hJjJmg7ky4FYsqmoyIuh6D0tlYS0WoC8RfQaS/KA9HqQ2gj+h8g3hxkXza7x35raXINUTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=TkM6C04P; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="TkM6C04P"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202404091250247bca7d6e1988ed8a74
        for <xenomai@lists.linux.dev>;
        Tue, 09 Apr 2024 14:50:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=prtMh9c5rdz9aRY2oN+4tNZIHMFQ/UwumZ3A02XdIF4=;
 b=TkM6C04PlxZepDEn6T9tpmtIbAIMsJ246iPdGD/9Fb115Z+0ylQkYC4BPMu+u699y3e7x1
 ZLfyXoOTgsmxRbulApOwwjghGWUfLs0ykpcdnZkGOmveB3LG9K1cDjDiJhXWzNlMHN7FWiX7
 RegSFTAEh5lzbP/nIdV5bflYtDxCQ=;
Message-ID: <6583550933fa564d2ba433387093f10f774af0ef.camel@siemens.com>
Subject: Re: RFC: Improve tooling support, move away from function wrapping
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Cc: Clara Kowalsky <clara.kowalsky@siemens.com>
Date: Tue, 09 Apr 2024 14:50:22 +0200
In-Reply-To: <5aa4e1d6-ac3d-43a2-ad51-4986cc224730@siemens.com>
References: <97d031173f62c694001f166abbd756d4b1cb6390.camel@siemens.com>
	 <5aa4e1d6-ac3d-43a2-ad51-4986cc224730@siemens.com>
Autocrypt: =?US-ASCII?Q?addr=3Dflorian.bezdeka@siemen?=
 =?US-ASCII?Q?s.com;_prefer-encrypt=3Dmutual?=
 =?US-ASCII?Q?;_keydata=3DmQENBFwsf8QBCAC2f4AQWu92LZC4bKyUYRxWIpWqGz790s?=
 =?US-ASCII?Q?pcYkXO7M8kfea4iC8qMxv2hT4HT0LTncRP6WiovVN2PeoOBfN5BSa5z?=
 =?US-ASCII?Q?LIrZGVXh7KmbdKhwhVU+ynoTq9G5uaO2Kos7Vv7nNCuatIq8tSNILuoB?=
 =?US-ASCII?Q?DFTAZnJW3y1V7YOwhDCPl5gbLSYqUY3OE0yksbtCcVI5istT4ED6mjQ?=
 =?US-ASCII?Q?9W+3uH1LrgFeEF0oxTjrEPxO5ZYATz0f/TYC8WiM0sMrV+n0eMDntlzA?=
 =?US-ASCII?Q?63D6lcRi5mNp2jPsJkq3tbWqyCrAe1sKPVJB44ekFwCk0kDIuhR13Q3R?=
 =?US-ASCII?Q?HE4Or/9sznhMUQjYueWXvTZfzH/VsQJHABEBAAG0LUZsb3JpYW4gQmV6?=
 =?US-ASCII?Q?ZGVrYSA8Zmxvcmlhbi5iZXpkZWthQHNpZW1lbnMuY29tPokBVAQTAQg?=
 =?US-ASCII?Q?APhYhBAzL4P3jiTHdthsq4cj0O1fnOEBVBQJcLH/FAhsDBQkB4TOABQs?=
 =?US-ASCII?Q?JCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEMj0O1fnOEBVc6YIAJ8oO4x?=
 =?US-ASCII?Q?TjOCpjxaS8XQE6VW50HE9I6ShbQVWUEGhF4qzJaACTQDjdg/aio7qNRa?=
 =?US-ASCII?Q?mnAy83Hy9sAxKVhXs+1R1fstN+JO8zgD3tJspucUkCiXlYu+Qcv2d6C?=
 =?US-ASCII?Q?ostv+h4nv8fkSoeLfsQu3GJt6W0RN7t+8H/9fUMXyuB8GWo4bhaZcti6?=
 =?US-ASCII?Q?78CotGLs6UGZpYEGiAMto8+9zVO/tdY1BkREM6bCVeQ9FnnpTRQy/tU5?=
 =?US-ASCII?Q?xemMWJI64UUP92TUIbQ3TZKAz4iG/Mle+YjiHBGrJM7TxjE3sDg5J2Fa?=
 =?US-ASCII?Q?HX4wmZPKGdB6wANKupf6HMMt2y7gduVmMKzgb8PDMLPZwWBSvjELQqz?=
 =?US-ASCII?Q?hiZAQ0EYLSqZwEIAIR4HMTQC4F4YxatIl6MIDY03zD4M3ZQpgyQ6QFL9?=
 =?US-ASCII?Q?Dq0I+PGc7A6z5rsGl76+D8pDFSN2BBJiLLlQadxKc3ZyTTlRp4bc=09bf?=
 =?US-ASCII?Q?FZRmsAXwVfLtBauXxGo9pkyhk8Vcjb2EJm6XR8PH99buGOXlFfTLsmeA?=
 =?US-ASCII?Q?ji/F4jU3qlUnwZMBvHZwRSFqOGdwKPMvW3FppfmREQ0o4xJ4b/bxGXx?=
 =?US-ASCII?Q?ko21uyR/S5rEJx6X8Ukw95h3JinXHx/g2cjbKHrWBDKoqtX9IZCamDny?=
 =?US-ASCII?Q?R+sfLWQbOKOrLNYLwLAQwOTVlZWTgue10G1q6Zi0r8RQ2T1Uy+ZLYagv?=
 =?US-ASCII?Q?Cbzp/lT7p3mv3ba68llX896c0AEQEAAbQ/QmV6ZGVrYSwgRmxvcmlhbj?=
 =?US-ASCII?Q?sgQmV6ZGVrYSBGbG9yaWFuIDxmbG9yaWFuLmJlemRla2FAc2llbWVuc?=
 =?US-ASCII?Q?y5jb20+iQEcBBABCAAGBQJgtKpnAAoJEEoHyE9rG1dPpJYH+gPnqpu7h?=
 =?US-ASCII?Q?4fsWOxco38e74MsazoUdfndTYP5tgaYTVE51ZhOZBl+4jYaywsmmFm9g?=
 =?US-ASCII?Q?6N4Tw3GiMEDB4YU1X7gQZ60fDKpYL5SnCu5qZirJ4RCV4LDA0789ir+6?=
 =?US-ASCII?Q?8/zfwXBTV5QoMH0+MkXB4BL+Km3f7X/GdN5oRoItAyKDBcEfGJo6afT?=
 =?US-ASCII?Q?PtcUdI9n7ExCSfJwb0SBvvkvUsdNppFDGOOHSioINbEHBs2VUvE43toM?=
 =?US-ASCII?Q?4mPLfhFIAtDcn5Byt80/kotU8v3Iyf86NYCa+0h77xTsKHcCUqe8Rvow?=
 =?US-ASCII?Q?bCIbig9GGbbd54TasfqQQOiAkn/WeGl33+UIVX1Q8zo7eyMJHzLJQ3I=3D?=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Mon, 2024-04-08 at 23:54 +0200, Jan Kiszka wrote:
> On 08.04.24 17:56, Florian Bezdeka wrote:
> > Hi all,
> >=20
> > as mentioned in one of the community talks I'm currently looking into
> > increasing the tooling support of Xenomai. We had that on our internal
> > wish list for some time now. It's time to look at that.
> >=20
> > The initial feature request was talking about valgrind support, so I
> > started with that but stopped further investigations because a lot of
> > code annotations were necessary. Main pain point was that all memory
> > writes done on the kernel side were not properly detected out of the
> > box and had to be annotated manually to avoid "invalid read" reports.
> >=20
> > In addition I did not like that we would have to build two versions of
> > each library. One with the annotations inside - useful for debugging -
> > and the prod version, without annotations because of possible side
> > effects or performance issues. (I did never actually measure it...)
> >=20
> > So I moved on and looked into using the gcc sanitizers.
> >=20
> > First major pain point: libasan (ther library behind the gcc address
> > sanitizer) intercepts posix services/functions. That does not work in
> > combination with the function wrapping done by libcobalt.
> >=20
> > To make that work we would have to walk away from function wrapping and
> > implement an interception mechanism that works similar to the libasan
> > implementation. That works - at least technically inside as small test
> > application.
> >=20
> > Function wrapping (in Xenomai) "defines" the following three
> > symbols/functions for each function that is wrapped. I'm using
> > pthread_create() as example here:
> >=20
> >   __cobalt_pthread_create(): The RT/Xenomai implementation
> >   __real_pthread_create():   The libc implementation
> >   __wrap_pthread_create():   A weak alias to __cobalt_pthread_create()
> >                              Can be overwritten by the application.
> >                              Usage of __RT() and __STD() allows to call
> >                              the cobalt or libc implementation.
> >=20
> > For backward compatibility we must keep the interface, especially the=
=20
> > possibility to overwrite __wrap_*().=20
> >=20
> > The demo library/application (see attachment) shows that moving a way
> > from function wrapping allows to keep this "API" and allow usage of
> > libasan / address sanitizer. Some details:
> >=20
> > - We could move from function wrapping to our own "interception"=20
> >   mechanism. Highly inspired by the libasan implementation.
> >=20
> > - We could change the COBALT_IMPL() macro to implement such an
> >   mechanism.
> >=20
> > - Overwriting of __wrap_() still works
> >=20
> > - For each function we want to intercept we do the following:
> >   (see library.c)
> >  =20
> >   - Declare (not define!) a weak symbol
> >   - Introduce a trampoline function (__cobalt_t_*) that calls (jmp)
> >     the __wrap_*(), which is itself a weak alias for the __cobalt_*()
> >     implementation
> >=20
> > With that, most things work already. There is one missing piece: The
> > __STD() macro would no longer work, as there is no __real_*() symbol
> > anymore.
> >=20
> > To make that work, we have to search for the original symbol using
> > dlsym() in the library init phase, and remember the address of the
> > symbol / function.
> >=20
> > In case libasan is active, searching for the posix service (like
> > pthread_create) delivers the address of the interceptor. Nice.
> >=20
> >=20
> >=20
> > Before I start the real integration into Xenomai, what do you think?
> > Any feedback is highly appreciated.
> >=20
> >=20
> >=20
> > Topics I will have to look into:
> >=20
> > - Performance. I have some bad feelings regarding the trampoline
> >   function. Maybe there is a better way in libasan already.
> >=20
> > - I'm looking for a way to get the init stuff (__cobalt_init() of
> >   the attached demo) automated.
> >=20
> > - Architecture support. I don't like the ASM part of the current
> >   demo. But I fear there is no other way. At least arm64 and arm
> >   should not be a problem. Some bad feelings about i386...
> >=20
> > - Clarification needed: Is there really an application out there
> >   that overwrote one of the services by implementing __wrap_*()?
> >   Maybe we can remove that feature?
>=20
> I'm not aware of any, and I could imagine dropping this "feature" along
> such a change. We would get rid of the trampoline this way?

The trampoline would still be necessary, but we could simplify the
redirection mechanism a bit.=20

>=20
> >=20
> > - Other sanitizers: I only played around with -fsanitize=3Daddress
> >   so far.
> >=20
> > Feedback / ideas highly appreciated.
> >=20
>=20
> Besides the interesting new feature to have asan support, avoiding all
> those --wrap options for linker and the *.wrappers would be a value as we=
ll.
>=20
> But there is one catch: The linker-based wrapping so far allows to
> assemble a binary where some objects use libcobalt and others remain
> unwrapped. To my understanding, libasan's interception always works for
> all parts of a binary, no fine-grained control possible per object as
> those boundaries are removed during linking. Correct?

Function wrapping is a linker feature, so the redirection happens when
linking the final library or executable. That's the reason why the
xeno-config tool forwards the necessary flags to "users".=20

I think the situation would regarding granularity would not change. I
will keep an eye on it while playing around with the idea.

>=20
> Jan
>=20

