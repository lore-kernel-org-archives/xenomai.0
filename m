Message-ID: <45706A0E.9050400@domain.hid>
Date: Fri, 01 Dec 2006 18:44:46 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] libnative versioning
References: <45704CAB.5060502@domain.hid> <1164992204.4952.109.camel@domain.hid>
In-Reply-To: <1164992204.4952.109.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> 
> The Xenomai ABI has been kept compatible between versions

I am afraid you are being optimistic: I for one made some changes in the
posix skin that break the kernel/user interface. Maybe we need an ABI
revision for each skin ?

-- 
                                                 Gilles Chanteperdrix

