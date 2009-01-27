Message-ID: <497F4227.2020406@domain.hid>
Date: Tue, 27 Jan 2009 17:19:35 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <497F3E29.6050303@domain.hid> <497F40F3.3010801@domain.hid>
In-Reply-To: <497F40F3.3010801@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] xnpipe: Fix minor number management
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> As for the find_first_bit, why not simply taking the nklock

in

> xnpipe_minor_free ? This is a first masking section, so this should not
> matter a lot.

a short masking section

-- 
                                                 Gilles.

