Message-ID: <42120A8F.4090806@domain.hid>
Date: Tue, 15 Feb 2005 15:43:27 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Adeos without Linux as Root Domain
References: <9C1918067C3BC14C9C351C206D8A84370DB8EE@rennsmail03.eu.thmulti.com>
In-Reply-To: <9C1918067C3BC14C9C351C206D8A84370DB8EE@rennsmail03.eu.thmulti.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Gonon Philippe <Philippe.Gonon@domain.hid>
Cc: adeos-main@gna.org

Gonon Philippe wrote:
> Is Adeos Linux dependent or Linux independent?

It's dependent on Linux regarding the current implementation which knows 
about the innards of the Linux kernel to take over the box properly; 
it's clearly not dependent design-wise.

> 
> I wonder if Adeos could be initialized by a RT nanokernel which call a linux free version of __adeos_init() function.
> What i saw in source code didn't bring me an answer.
> 
> 
> Thanks for the help,
> Philippe GONON
> 
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main


-- 

Philippe.

