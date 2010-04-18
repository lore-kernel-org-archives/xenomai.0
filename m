Message-ID: <4BCB3DA9.4060505@domain.hid>
Date: Sun, 18 Apr 2010 19:13:13 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
	<de921a67d4cbffda35e9b27d8cea25f8e6492b58.1271596367.git.Jan
	Kiszka jan.kiszka@domain.hid>
In-Reply-To: <de921a67d4cbffda35e9b27d8cea25f8e6492b58.1271596367.git.Jan
	Kiszka jan.kiszka@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH v3 17/24] rttest: Resolved test device
 conflicts via separate name spaces
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <"Jan Kiszka jan.kiszka"@web.de>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@domain.hid>
> 
> Usually, all devices of some RTDM class use the same naming scheme. But
> as test devices are different as they do not provide compatible APIs,
> let's give them separate name space for their device names. That finally
> resolves all the detection troubles that showed up once more than one
> test device was registered.
> 
> To allow addressing old drivers with new user space and vice versa, a
> config switch is added to the former to select the naming scheme, and
> the latter will try to open under both names.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>

Could we please have the devices named after the same name as the driver?
So switchtst -> switchtest
tmbench->timerbench


-- 
					    Gilles.

