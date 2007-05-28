From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18011.7896.952588.610032@domain.hid>
Date: Mon, 28 May 2007 20:26:32 +0200
In-Reply-To: <f3es61$8a2$1@domain.hid>
References: <f3es61$8a2$1@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] add tut02-skeleton
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: trem <tremyfr@domain.hid>
Cc: xenomai@xenomai.org

trem wrote:
 > +	mlockall(MCL_CURRENT | MCL_FUTURE);

Please show people the right way to code, check the return value of
mlockall here.

 > +	if (rtdm_safe_copy_to_user(user_info, buf, buffer.data, size))
 > +		rtdm_printk("ERROR : can't copy data from driver\n");
 > +
 > +	/* clean the kernel buffer */
 > +	buffer.size = 0;
 > +
 > +	return size;

Same here, if rtdm_safe_copy_to_user returns an error, return that error
to user-space.



-- 


					    Gilles Chanteperdrix.

