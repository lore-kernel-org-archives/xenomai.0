Message-ID: <43BD6CC1.7080103@domain.hid>
Date: Thu, 05 Jan 2006 20:00:17 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [PATCH,	RFC] nucleus:shared irq and possible
	ipipe problem
References: <b647ffbd0512310437x6e92487es@domain.hid>	<43B69CEC.1040606@domain.hid>	<b647ffbd0601021042h140c0f7dk@domain.hid>
	<b647ffbd0601021043n1e8704aco@domain.hid>
In-Reply-To: <b647ffbd0601021043n1e8704aco@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

Dmitry Adamushko wrote:
> 
> err... I have to orginize some issues next few days so I'll be out of my 
> notebook. Then I'll finilize the ipipe-irq-related patch so to be ready 
> for the .01 version.
>

Meanwhile, I have finished merging the shared IRQ infrastructure into 
the Adeos codebase for all supported archs. The Xenomai trunk/ has been 
upgraded accordingly too. x86-wise, please make sure to rebase your 
development on 1.1-02.

-- 

Philippe.

