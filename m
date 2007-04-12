From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <E1HbDyF-000442-DW@mailer.emlix.com>
References: <E1HbDyF-000442-DW@mailer.emlix.com>
Content-Type: text/plain
Date: Thu, 12 Apr 2007 10:51:31 +0200
Message-Id: <1176367891.5022.6.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Wrong example code in Native-API-Tour
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
To: Sebastian Smolorz <ssm@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2007-04-10 at 12:53 +0200, Sebastian Smolorz wrote:
> Hello Philippe,
> 
> on page 21 of Native-API-Tour-rev-C.pdf one gets the impression that 
> rt_intr_wait() returns 0 on success. However, it returns a positive value in 
> this case (as the API description states it right).
> 

Ok, will fix. Thanks.

-- 
Philippe.



