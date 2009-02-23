Message-ID: <49A2E1D0.1010607@domain.hid>
Date: Mon, 23 Feb 2009 18:50:08 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <499EBF45.900@domain.hid> <49A290E8.5030400@domain.hid>
	<49A29871.90807@domain.hid> <49A29CBF.80701@domain.hid>
	<49A2A654.7040706@domain.hid> <49A2E00C.1090201@domain.hid>
In-Reply-To: <49A2E00C.1090201@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [PATCH] x86: Proper root domain state management
	for ipipe_handle_exception
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: rpm@xenomai.org
Cc: adeos-main <adeos-main@gna.org>

Jan Kiszka wrote:
> ...
> BTW, I'm currently failing to find the code path that enables hardware
> IRQs before calling the Linux handler. There's no related change in this
> particular patch, so I guess I'm just blind ATM.

Found it: We have to call into do_page_fault with IRQs disabled in order
to get the right CR2. So the callees need to be patched to enable hard
IRQs again, we can't do it earlier.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

