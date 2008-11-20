Message-ID: <49256843.1090303@domain.hid>
Date: Thu, 20 Nov 2008 14:38:11 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <200811190056.12595.berlemont.hauw@domain.hid>
In-Reply-To: <200811190056.12595.berlemont.hauw@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Unstable driver integration policy
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Alexis Berlemont <berlemont.hauw@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Hi Alexis,

Alexis Berlemont wrote:
> Hi,
> 
> I would like to find a way to populate the Comedi drivers set.
> 
> However, I am stuck by a simple fact: I have no acquisition board to validate 
> a least driver...
> 
> Starting from here, I am trying to find out what should be the proper method 
> to provide non-validated drivers to anybody inclined to test them. 
> 
> Do you think creating a specific subversion branch for this stuff would be a 
> good idea ?

Given the well-known fact that (too) few people look beyond what we
deliver as releases and also assuming that your drivers should have no
side-effects (unless when actually used), I would rather suggest to
develop for SVN head, merge and deliver, but mark each driver
"experimental" until people with real hw confirm that it works as expected.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2 ES-OS
Corporate Competence Center Embedded Linux

