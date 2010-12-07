Message-ID: <4CFE1FA4.2030501@domain.hid>
Date: Tue, 07 Dec 2010 12:51:00 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4CFE1E35.3020603@domain.hid>
In-Reply-To: <4CFE1E35.3020603@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Problem with gcc-4.5.1
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Anders Blomdell <anders.blomdell@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Anders Blomdell wrote:
> When compiling Xenomai on Fedora-14 with gcc-4.5.1 [version 4.5.1 
> 20100924 (Red Hat 4.5.1-4)], the loading of xeno_nucleus fails with the 
> attached kernel OOPS, a notable difference between the 4.5.1 compiled 
> version and a working one built with gcc-4.4.4 on the same system with 
> the same configuration, sis tthat __rthal_x86_nodiv_ullimd is not 
> inlined, is this anybody has seen before?

No, that is new, we need to see the disassembly of __rthal_x86_nodiv_ullimd

-- 
                                                                Gilles.

