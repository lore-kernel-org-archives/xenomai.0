Message-ID: <2ff1a98a0710230720v58765d5dtb2c3725aa6bd04ec@domain.hid>
Date: Tue, 23 Oct 2007 16:20:45 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <f970a6d60710221051q722238fbp2fd14743077a7cdc@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <f970a6d60710221051q722238fbp2fd14743077a7cdc@domain.hid>
Subject: Re: [Xenomai-core] edf in xenomai
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jose Augusto Matos Santos <jamsjr@domain.hid>
Cc: xenomai@xenomai.org

On 10/22/07, Jose Augusto Matos Santos <jamsjr@domain.hid> wrote:
> Hi,
>
> I want to know if Xenomai supports EDF scheduling.

No, Xenomai only supports fixed priority scheduling. But abstracting
the scheduler interface to allow several scheduling policy to be
implemented has been on the todo list for a long long time. So, if you
are ready to implement this, your contribution will be welcome.

-- 
                                               Gilles Chanteperdrix

