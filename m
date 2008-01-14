Message-ID: <478BCA51.3030006@domain.hid>
Date: Mon, 14 Jan 2008 21:47:13 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <BF58A8AFB316514587D61EADBFBF4C41DB1FC4@domain.hid>
In-Reply-To: <BF58A8AFB316514587D61EADBFBF4C41DB1FC4@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] Fix typo bug in ipipe_pin_range
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Kyle Howell <khowell@domain.hid>
Cc: xenomai@xenomai.org

Kyle Howell wrote:
> 
> Hi,
> 
> Ran across these typos in ipipe_pin_pud_range and ipipe_pin_pmd_range. 
> On large vmas, they cause a lot of extra iteration and may cause some 
> page table corruption.
> 

Oops. Will merge, thanks.

--
Philippe.


