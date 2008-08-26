Message-ID: <48B42D29.6030701@domain.hid>
Date: Tue, 26 Aug 2008 18:19:53 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48B3ED52.7080101@domain.hid> <48B3EFFC.8020408@domain.hid>
	<48B42A68.3020400@domain.hid>
In-Reply-To: <48B42A68.3020400@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RESEND][PATCH 6/6] Report registry slot usage
 via	/proc
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
Cc: xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Some customer ran into the problem of lacking registry slots without
>> prior warning. We are lacking some report mechanism, specifically for
>> unexported (anonymous) entries (every native user object requires one
>> for its handle).
>>
>> This patch introduces /proc/xenomai/registry_usage in the form
>>
> 
> Eeek. /proc/xenomai/registry/status or /usage. Otherwise, ok.

There was a reason, there was a reason... Ah! That subdir depends on
CONFIG_XENO_EXPORT_REGISTRY. Needs more refactoring then... :-]

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

