Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4E33C73F5
	for <xenomai@lists.linux.dev>; Mon, 23 Mar 2026 17:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774287003; cv=none; b=VCfjtUpt6JAhSWo8R6F8hqoFYdwi24praEFB32UoNPCRF3YcuxW5snY0eZHsnPcljCevN1ZT5IWl31akjBraypI2zxAV8LX5K9zm2SzpXxqAwqJyVjlH7IbNPMMhZIs0WP2U9te+A2morKa6Bhfw6SyYcwBXvz6cFeuO0OyrbWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774287003; c=relaxed/simple;
	bh=oUffQWNdGpFngHudVnrOC2rZ7hQtlxkTdvCw0Gq2vFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qqAV1tWZyBeKD6O+dwLj7QRlMUW9QYvFjnNkGQMfm88zJylX8eL67SypnvYjw2d0bXNxK9xCQtCAdMS+TfThiriE83G+WvxQ6q7W/nAokBFy3crDI5QdPjeaHaLl2TGrdhR/2kNEycHahOycTzM/HNgUZvCMKapn6zKbJWDx/tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8VR3SAD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8VR3SAD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC112C4CEF7;
	Mon, 23 Mar 2026 17:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774287003;
	bh=oUffQWNdGpFngHudVnrOC2rZ7hQtlxkTdvCw0Gq2vFQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=V8VR3SADmRm20bm4OyLaWOducJHvHQdhKCs1EwIQckevW+/B/oAMHSxof1fWl4S9m
	 aXib83uUf7H32IsTmuZQ3fC+yivS1U4hZ/K49P3641jj+k3ZOky6TzBaUhLTCUgf9L
	 o7dsHrYWz9UJ0RgcSkLLrbBXV/DvTdOt9xaEzdlVXSEN6sfzNNjI+qyq0JCtAk2fv4
	 GkyBOuQWBc0zNBXK5Nv9IMI1CqPzachM9Tr9K6fDmdNrw/AtGvQcFsOa/rneNNdMO+
	 PHncMl6mbpFOUOrpqtysDncNpvPc6ee7IS730Z1woA63mBeL1kNcmJ2mvSjmKeE6Ar
	 9PfyhsHuzJXlw==
Date: Mon, 23 Mar 2026 12:30:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>,
	xenomai@lists.linux.dev, rpm@xenomai.org,
	florian.bezdeka@siemens.com, Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH dovetail v5 00/12] riscv: Add dovetail support
Message-ID: <20260323173000.GA881254@bhelgaas>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a60fe6fc-3cd5-4dfb-820f-b5832900d53e@siemens.com>

On Mon, Mar 23, 2026 at 06:16:55PM +0100, Jan Kiszka wrote:
> On 23.03.26 16:53, Bjorn Helgaas wrote:
> > [+cc Thomas, irqchip driver maintainer, series at
> > https://lore.kernel.org/all/20260320213657.2210419-1-tobias.schaffner@siemens.com]
> > 
> > On Fri, Mar 20, 2026 at 10:36:45PM +0100, Tobias Schaffner wrote:
> >> Hi all,
> >>
> >> this series introduces initial support for Dovetail on RISC-V.
> > 
> > 02/12 mentions "the Dovetail/IRQ pipeline model used on other
> > architectures," but my quick grep for dovetail and IRQ pipelining
> > didn't find anything.
> > 
> 
> These patches are not targeting the upstream kernel.
> 
> I wonder how you got aware of them as I only see the Xenomai list in CC.

Oh, thanks for that!

I saw them because xenomai@lists.linux.dev is archived in
lore.kernel.org, and my lei query includes "dfn:drivers/pci", so I see
anything that touches drivers/pci/.

Bjorn
