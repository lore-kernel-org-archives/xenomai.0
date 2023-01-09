Received: from mta-out-02.tin.it (mta-out-02.tin.it [217.169.118.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A555221
	for <xenomai@lists.linux.dev>; Mon,  9 Jan 2023 21:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tin.it; s=20211207; t=1673299000; 
        bh=7r0RzU9V6a3RR3s7sdDa74k8FbtgClm+Xrbt/ufmMqo=;
        h=To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:From:Date;
        b=N70Gk/V9lfjkXN1bIKi6TvWRhOIQyAvjEcwa8+PWO3jL8sjOxOg30qIn/4hAuOo+2/sX+5RSgbcAj6v/nue9UKpC9OkzXliKRrB8RlJZbAIzI9AfvMGRRxMdqiBRZhjK7cFlHQVTl+vp+yRGJBZb7zwZjtWj8ueFnRYrMFI6UKkZn6jjS3udJjPIzr80+KBerk5BJNvCm6MLh3Q7qrDW1p4CrQ6ztPHjDWoOz6JphuEvp3DMNEHDcQ984P4acj0U+7pelGlkkbD6QhvtfMaLG39SsJ/su1a+yTRHJxJAahBwBtIZOFw7D7eS58H5uq9DPRZgg8XB4LPdZFipjvsQIg==
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvhedrkeeigddugedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuvffgnffgvefqoffkvfetnffktedpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepvffkjghfufggtgfgfghihfffsehtqhertddtreejnecuhfhrohhmpeforghurhhouceomhgruhdrshgrlhhvihesthhinhdrihhtqeenucggtffrrghtthgvrhhnpefgiedufffhledvgfehteelleehudeluddvtdfgteeiveekiedtgfdvhffgueehudenucfkphepuddtrdeivddrudekjedrgeeipdduleehrdefvddruddviedrudelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehugidqshhuihhtvgdqtdelrdgvuhhrohhpvgdqfigvshhtgedqtgdrtgdrthhimhdqtggutgdqphhrugdqtghutddttddttddttdeirhefqdhlledrihhnthgvrhhnrghlpdhinhgvthepuddtrdeivddrudekjedrgeeipdhmrghilhhfrhhomhepmhgruhdrshgrlhhvihesthhinhdrihhtpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepjhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhmpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdpoffvtefjohhstheprhgriihorhdqohhuthdqthhinhdqtddv
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from ux-suite-09.europe-west4-c.c.tim-cdc-prd-cu00000006r3-l9.internal (10.62.187.46) by mta-out-02.tin.it (5.8.812)
        id 635A3C8607C44884; Mon, 9 Jan 2023 22:13:31 +0100
Received: from [195.32.126.193]
	by webmail.tim.it with HTTP; Mon, 9 Jan 2023 22:13:30 +0100
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Message-ID: <4fca16d5.2373f.18598619815.Webtop.46@tin.it>
In-Reply-To: <adcd0951-2bef-64b3-62ff-de30641538fb@siemens.com>
References: <adcd0951-2bef-64b3-62ff-de30641538fb@siemens.com>
Subject: R: Re: "failed to allocate main tcb" error
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed; delsp=no
Content-Transfer-Encoding: quoted-printable
User-Agent: OWM Mail 3
X-SID: 46
X-Originating-IP: 195.32.126.193:33178
From: Mauro <mau.salvi@tin.it>
Date: Mon, 9 Jan 2023 22:13:30 +0100 (CET)

    ------ Messaggio Originale ------
    Da: jan.kiszka@siemens.com
    A: mau.salvi@tin.it; xenomai@lists.linux.dev
    Inviato: luned=C3=AC 9 gennaio 2023 20:30
    Oggetto: Re: "failed to allocate main tcb" error

  ---8<----

  We are leaking the main tcb on the shared heap. That heap - and I also
  regularly forget this - is not tracked by the kernel but purely in
  userspace. Enable the registry, and you can watch /var/run/xenomai
  /root/test/system/heaps going up with every secondary call. This seems
  to be needed because the normal pthread-key cleanup handler is not
  called on main exits:

  diff --git a/lib/copperplate/threadobj.c b/lib/copperplate/threadobj.c
  index f4588a17a8..56d0f1b231 100644
  --- a/lib/copperplate/threadobj.c
  +++ b/lib/copperplate/threadobj.c
  @@ -1770,6 +1770,11 @@ int threadobj_set_schedprio(struct threadobj=20
*thobj, int priority)
   =09return threadobj_set_schedparam(thobj, policy, =C2=B6m_ex);
   }

  +static void main_exit(void)
  +{
  +=09threadobj_free(threadobj_current());
  +}
  +
   static inline int main_overlay(void)
   {
   =09struct threadobj_init_data idata;
  @@ -1806,6 +1811,8 @@ static inline int main_overlay(void)
   =09threadobj_prologue(tcb, NULL);
   =09pthread_setcanceltype(PTHREAD_CANCEL_DEFERRED, NULL);

  +=09atexit(main_exit);
  +
   =09return 0;
   }

  Jan



Thank you very much Jan.

Regards

--=20
Mauro S.


