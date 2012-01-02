From: "Terry Fryar" <terry.fryar@domain.hid>
References: <C3860BCA25804175ABD53E2F2B1A942A@TerryHP>
	<4EFCFF53.7040508@domain.hid> <4EFD910F.3080404@domain.hid>
	<3DFE8CE1F70D48ECB3CDD7F7795FCE8B@TerryHP>
	<4F01C6FF.7090905@domain.hid>
In-Reply-To: <4F01C6FF.7090905@domain.hid>
Date: Mon, 2 Jan 2012 11:58:20 -0600
Message-ID: <CC925A00F8E0417DA50EFA3A453B8695@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Mode switches??
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: 'Gilles Chanteperdrix' <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Whoops...that was supposed to be a capital 'l'....


-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org] 
Sent: Monday, January 02, 2012 9:02 AM
To: Terry Fryar
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] Mode switches??

On 01/02/2012 03:27 PM, Terry Fryar wrote:
>     printk("<1>irqdrv: BASEPRIOR: %d  CURPRIOR: %d  EXECTIME: %ld  MODESW:
> %d  CTXSW:
> %d",info.bprio,info.cprio,info.exectime,info.modeswitches,info.ctxswit
> ches);

exectime is a 64 bits variable, so, EXECTIME should use %lld or %Ld

-- 
					    Gilles.


