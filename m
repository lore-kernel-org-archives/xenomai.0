Message-ID: <43DFDA6E.5000700@domain.hid>
Date: Tue, 31 Jan 2006 22:45:18 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG] racy xnshadow_harden under CONFIG_PREEMPT
References: <43D21144.8040005@domain.hid>	
	<b647ffbd0601220010x3cc023an@domain.hid>	
	<fd6a47a90601220819n3f4cd382t@domain.hid>	
	<E1F16LA-0001ku-C4@domain.hid> <43D52BA3.6020005@domain.hid>	
	<43DE27E5.3010206@domain.hid> <43DE3243.8080603@domain.hid>
	<fd6a47a90601311309i18d2ab31i@domain.hid>
In-Reply-To: <fd6a47a90601311309i18d2ab31i@domain.hid>
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
To: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

Jeroen Van den Keybus wrote:
>     And now, Ladies and Gentlemen, with the patches attached.
> 
>  
> I've installed both patches and the problem seems to have disappeared. 
> I'll try it on another machine tomorrow, too. Meanwhile: thanks very 
> much for the assistance !
>

Actually, the effort you made to provide a streamlined testcase that triggered the 
bug did most of the job, so you are the one to thank here. The rest was only a 
matter of dealing with my own bugs, which is a sisyphean activity I'm rather 
familiar with.

> Jeroen.
>  


-- 

Philippe.

