Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2ABE266F0D
	for <xenomai@lists.linux.dev>; Mon, 24 Mar 2025 18:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742842749; cv=none; b=X1FNYxnI767vLqyxufQQFpb1e4bfooHPHqNH1Yg8ozo3DF67uBLjr+T6OwjOKzIh8UiGv4CSu9LGT9bFIFOgCIx3BatTbPre1Fe8amZdV9coRFanz1nlJIVeC5qs2QjWk8UxzZxTolMYJXGmZYRJDRF2KQF8HzDPMSVtNkbGlp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742842749; c=relaxed/simple;
	bh=N4cH/uGdiuyFXvBTaQO9GL8GYWdiOwAc6TjITrWefx8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ICm6hPcw3i0G+XRbru9qvxAz5Y5+ob/LsJx/J5bsXtCaXrbSmF8n0Rcpsn1l1p3sTtzJEv71qDd/eTDrW2c9NyrYuYl0ITex8mXBFJg1FDXNEtBXU6CyQjVzkApm/+pmFCyngt8TQlNtT8ZjI8KIaV1zxjI4yBbGcaFiT+UI3pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=I8oqIc1h; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="I8oqIc1h"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20250324185856400b5faa41c3fa429a
        for <xenomai@lists.linux.dev>;
        Mon, 24 Mar 2025 19:58:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=6K8N7l3j/+oOq4kYtAmiotFcaqfNitskR++7w2podb4=;
 b=I8oqIc1hdaH9L0jbIouM8vyNOjYCOb92EMKTbBdfj/BhSH+EuQnEBcqq+IpLLhL10FCVOn
 +q+tZblWiD7bXJ49YTqDNbI7Bp/svzgVe+kRKdKMKQezcaSwNI8U1ybanABa/alS2LnL17FW
 tMmNSjDUW3g2ZQKhEIZZp1dN3ZAeu2C5dfHC1rIwQkhjYyBg5wTEtuirHcvMdhjwL115H52/
 v94xxF7w1Ztr99RlXdCh5A1wGx9sjg0KcsF/dVfGKtC06FvtJsP8eY/Xce7yXcaxLvyNGDmo
 bzvhIS0ExlWqclrDmso21nCTOrFV0wTnAEPFE/fXKby5R3G4I0CgIO0Q==;
Message-ID: <7f2b87b4adc233af649d06e4ba2e1a97e25bc1d2.camel@siemens.com>
Subject: Re: [PATCH] x86: dovetail: Fix inverted debug check in
 lock_vector_lock
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>, 
 Xenomai <xenomai@lists.linux.dev>
Date: Mon, 24 Mar 2025 19:58:56 +0100
In-Reply-To: <e9a4daa3-7a28-45b3-89cb-76c6484a44af@siemens.com>
References: <e9a4daa3-7a28-45b3-89cb-76c6484a44af@siemens.com>
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

On Mon, 2025-03-24 at 18:18 +0100, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> Code and comment were no in line, but the comment actually make more
                        ^^ not                               ^^ makes

> sense here, given that unlock_vector_lock will unconditionally reenable
> hard IRQs.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  arch/x86/kernel/apic/vector.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.=
c
> index a08b0dff066ac..af60f138d590b 100644
> --- a/arch/x86/kernel/apic/vector.c
> +++ b/arch/x86/kernel/apic/vector.c
> @@ -142,7 +142,7 @@ void lock_vector_lock(void)
>  	 * entry. In addition, we assume that hard irqs are on as well
>  	 * (which is the regular case).
>  	 */
> -	WARN_ON_ONCE(irq_pipeline_debug() && !hard_irqs_disabled());
> +	WARN_ON_ONCE(irq_pipeline_debug() && hard_irqs_disabled());
>  	hard_cond_local_irq_disable();
>  	/* Used to the online set of cpus does not change
>  	 * during assign_irq_vector.
> --=20
> 2.43.0

