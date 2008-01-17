Message-ID: <478F30C2.5060104@domain.hid>
Date: Thu, 17 Jan 2008 11:41:06 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <478F28ED.1040104@domain.hid>	<2ff1a98a0801170222s3c4ebaet9b21384a98ae3db@domain.hid>
	<2ff1a98a0801170224m3832e2f5s1931bd7188778fdb@domain.hid>
In-Reply-To: <2ff1a98a0801170224m3832e2f5s1931bd7188778fdb@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] AC_PREFIX_DEFAULT
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai-core@domain.hid

Gilles Chanteperdrix wrote:
> On Jan 17, 2008 11:22 AM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>> On Jan 17, 2008 11:07 AM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>>> Hi,
>>>
>>> does anyone recall the reason for overwriting the default prefix in
>>> configure.in? If not, I would suggest to kill this for the sake of
>>> standard installation layout.
>> What standard installation layout ?
>> --prefix=/usr/local or --prefix=/usr ?
> 
> or --prefix=/opt/gnu/xenomai as mandated by the FHS ?
> 

Unless we know for sure that a certain path is The Right One, just
leaving the decision to autotools is what I suggest. [And that should be
/usr/local IIRC.]

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

