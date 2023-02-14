Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB43C0BF
	for <xenomai@lists.linux.dev>; Tue, 14 Feb 2023 16:56:12 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20230214165605f10e7726d1ee683a65
        for <xenomai@lists.linux.dev>;
        Tue, 14 Feb 2023 17:56:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=esRx4EZACgLqjyz0fRRb23aiP00Em/+aKYMqypFg/94=;
 b=Cy5Oato7RaXwsNbt5eXi2wa/W16aj6/VX9NZ/8taotgZTFVwjZYQA+xWCGS8VPr/mlXnV1
 Au2BKUvDCUG88Fajnj9QxJvbecIimBXnXD/Koc+G0ra+TNZRyAL0DyMP5flEWmS81blQqEte
 hWZfzgFWOQ5KQMUt2yKvSLwD/InEQ=;
Message-ID: <252602b1508b13bc480f6c971e13b02ae7702071.camel@siemens.com>
Subject: Re: arm/arm-64 ipipe release
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Greg Gallagher <greg@embeddedgreg.com>, xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Date: Tue, 14 Feb 2023 17:56:04 +0100
In-Reply-To: <CALLqZ8T=c_ngHcuU5vkpLVfzbN4Kpfh-Aqzq2vKErCYqbzyQWQ@mail.gmail.com>
References: 
	<CALLqZ8T=c_ngHcuU5vkpLVfzbN4Kpfh-Aqzq2vKErCYqbzyQWQ@mail.gmail.com>
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

Hi Greg!

On Mon, 2023-02-13 at 23:01 -0500, Greg Gallagher wrote:
> Hi,
>    I'm almost ready to release the next arm and arm64 ipipe patch. I'm
> working on stable release 231 since it contains the patch that
> hopefully fixes the UART irq issue seen in CI.  If there's a problem
> with using 231 let me know.  Finishing my local test this week.

Thanks for letting us know. If there is a chance that you publish a
public available -rc somewhere, it would be possible to tweak our CI a
bit and trigger a full test run in our lab.

That should help us to identify any leftovers upfront.

Best regards,
Florian


>=20
> Thanks
>=20
> Greg
>=20

