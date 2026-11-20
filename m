Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795167503;
	b=BrSqGzmcNntDODprUFayA3f/H9chRp28Osx6eV+gmfCf8/M3q6kUDHHurOWT3KvcTEVG
	 T2I7FfGyIiX/Y2lHxxJzKitqTDe/h5RfxJ83H3W3L0QHdmrhW/Bb/YLlGIIAUepMZksla
	 FLJstyNYrjbNP1qXUcklWYrHqCbY8HO4LQEYTnGT8ma+olTzqK2h7JQbxDEGW4bYhAq2i
	 GiZMRiecmt1kZuL0kIRQQLCQZbb1WYaRr4HdFj99l1GSAO8d3+1zZT1KAo5ZjYTjgQ3W7
	 9BIkUu2O5iMD09FggIC0uowSkQuTYkVSEZ0Z2GMJJvsF0tckkVcwUORpsvLjr9xTO6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795167503;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-GND-Sasl:X-GND-Score:X-GND-Cause:
	 X-GND-State;
	bh=A2eCIDvGZ5L4WeqHhberSYz4fvX/ifIaGic4SN5uVjs=;
	b=ppp3rxn3YPXCwN/OVEbmx2vDtDnBKm6acP2HcUPPNqnAbsNDF/cdT0mdFl8ZRYqFOsDR
	 HNFJIigkyjiT8I/JAOVzeHtZIUTzQ2kBT0r1x1OOgi5EgOs2lrz7XzcdGOXwSv48rlmUD
	 owXrXN0WwXQ/WSBpAaWuFnmbeVmeJFrTARTMjY2YF037DZiIQjHhUX9eW8JMutN8wCl57
	 DfCt3h6pKsj6WkmmWzTcsxzjHpzL2BxSk+QtvdHpGi4zHxTChiFB7vnMa2K7veExZCxlq
	 bidXZg0MW8hmiabDe5hJEzVhfbspUQG29adXdM2EI+ewnkEDXYwu1fE6hPBrNjcYJRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xenomai.org;
	spf=pass smtp.mailfrom=xenomai.org;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=PlYtE27G;
	arc=none smtp.remote-ip=217.70.183.198
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9AC606A320
	for <xenomai@lists.linux.dev>; Fri, 20 Nov 2026 09:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F9AC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=PlYtE27G
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0DBBA3E9BB;
	Fri, 20 Nov 2026 09:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1795167495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A2eCIDvGZ5L4WeqHhberSYz4fvX/ifIaGic4SN5uVjs=;
	b=PlYtE27GZlAMuybd5AsOnnlk1Y43p+4ysSvpt93oyWMxJgrIkIAG0w4Qiw3ro2lvmYc0ii
	b1FT4Cu2SyzinzRwtEuy/UucQTBKImKV8Cigxv6smELYqavFlWl05d3CTnTN3bZf7tVhRy
	0pdumOJlCmjqJ7yuV5+F+nCW0G2QVzdzhT/zIIy+T/FJ0ApGbG953EwCWWQ2OMNhLBEeH+
	ndTnKucCvXxkUZ3WYYGhmRyNfKLsVRUZ7swJm2Cs2ANvTbqHeg/cYMrQ4pTwJkJA8O1694
	r+ampeMLodHfuSLQWep3omJ4xZ6WWC86AKA4PJhN3npIUIgS8BXgHrgQZF7olQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: Dovtail: Question regarding stop_machine
In-Reply-To: <951a56b5307da18a8326bc07e84a6faf3c109c93.camel@siemens.com>
	(Florian Bezdeka's message of "Thu, 19 Nov 2026 20:42:36 +0100")
References: <951a56b5307da18a8326bc07e84a6faf3c109c93.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 20 Nov 2026 10:38:14 +0100
Message-ID: <87wlq79721.fsf@xenomai.org>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: dmFkZTF2niRswLyeTntV95tqP4bIDwuwfy8XbOz0yemMmLuMbv8OzdbaGYGrg9zVTBqOlA7RIvyvhWSTXUNdjpJHJiKcGi42yQ2ilsxml46e1tnG7xwMjQyDES05vN8XwKpAB82TL0cHbNiqZ0KWlL7JEvEE8sX6VkKrauaNfKAYgPGc/TDHXti1XBwXSH1jfHGeTOOsTaPKRJotkY6YT8eMwyANTqpArizig9cTe9m51awBsbAYGG9NPYgU134f9MVk0EQ0VzT9NB1WfPlaCKQx7FpqUITuJXA+0UiiuE6SQ6Rv15Y6QcXXFboDcqp1D1JBpqFgy1LaomaZr6+DI+Mlbuaal0pGuCwpM2T2/RhIL785Tyj1nK5mDeYZenfh58463tBBY5wsINgo6R9VUbxSmdrjb5aLrDsXwSZLUBl7xfWAjWa5oMzKvyOp9Kk0S+8b1oIE+FoJxXKSOjwm7QUnxyF5FuI3uUPJYlZw6UAL9soSNnA0yDZhXhPSTieZ2/Bm5Yw/GW+fs2opEXnOfyKWO8XNCASjKa/2aZYDyx/GkYq/Bo+ysoYTxJBzFEzbS7aBqcJ9TrdiWPaWQut6i//5aCMux6BRuyvaRXbutsObATgN7ZNavDz29z+kjw1PcrPW/NnsOZ+gta9eB/WBXbZYVyJIWRQDY1F4Cq+lFqBAhx34TA
X-GND-State: clean

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Hi Philippe,
>
> while cleaning up my todo list I came along the following thread:
>
> https://lore.kernel.org/xenomai/1207-6aed9780-55-3e404bc0@80379430/T/#t
>

Mm, this one slipped through the cracks too.

> Seems that you handled that with=C2=A0
>
> 5c39a0e4f186 ("stop_machine: irq_pipeline: preserve hard irq state in loc=
al stop context")
>
> already (which sneaked in within the last days).
>
> Meanwhile, I would have migrated to local_irq_{save,restore}_full(),
> mainly because we touch the code already and it saves us one long at the
> stack.
>
> That should also work, no?
>

This would be equivalent, however the _full() variants are
stage-adaptive, so we'd have a couple of useless conditional branches
checking for oob context although the stop_machine trampoline always
runs in-band.

--=20
Philippe.
