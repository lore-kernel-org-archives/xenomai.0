Message-ID: <4E16F032.1050905@domain.hid>
Date: Fri, 08 Jul 2011 13:55:30 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4E160578.5020405@domain.hid>
In-Reply-To: <4E160578.5020405@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [PATCH] ipipe: Prevent unwritable pages after
	mprotect
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>, Philippe Gerum <rpm@xenomai.org>

On 07/07/2011 09:14 PM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@domain.hid>
> 
> Page protection changes issued via mprotect, e.g. to enable executable
> stacks, cause spurious minor faults as they remove the write permission
> from the modified range again. Avoid this by faking shared pages so that
> vm_get_page_prot returns the desired page permissions.

This looks dangerous to me. Have you checked that write to private heaps
will not end up corrupting shared data?

-- 
					    Gilles.

