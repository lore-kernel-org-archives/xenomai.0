Subject: Re: [Adeos-main] What's the purpose of ADEOS_USER_EVENT?
From: Philippe Gerum <rpm@xenomai.org>
Reply-To: rpm@xenomai.org
In-Reply-To: <20040729125028.GA9378@domain.hid>
References: <20040729125028.GA9378@domain.hid>
Content-Type: text/plain
Message-Id: <1091105785.1466.4.camel@domain.hid>
Mime-Version: 1.0
Date: Thu, 29 Jul 2004 14:56:25 +0200
Content-Transfer-Encoding: 7bit
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: Marc Kleine-Budde <kleine-budde@domain.hid>
Cc: adeos-main@gna.org, rtai-dev <rtai-dev@domain.hid>

On Thu, 2004-07-29 at 14:50, Marc Kleine-Budde wrote:
> Hi Philippe.
> 
> What's the purpose of ADEOS_USER_EVENT?
> User defined event?

Yes. Free to use by sending it through adeos_handle_event().

> 
> Marc
-- 

Philippe.


