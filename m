Message-ID: <4F01C6FF.7090905@domain.hid>
Date: Mon, 02 Jan 2012 16:02:23 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <C3860BCA25804175ABD53E2F2B1A942A@TerryHP>
	<4EFCFF53.7040508@domain.hid> <4EFD910F.3080404@domain.hid>
	<3DFE8CE1F70D48ECB3CDD7F7795FCE8B@TerryHP>
In-Reply-To: <3DFE8CE1F70D48ECB3CDD7F7795FCE8B@TerryHP>
Content-Type: text/plain; charset=UTF-8
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
To: Terry Fryar <terry.fryar@domain.hid>
Cc: xenomai@xenomai.org

On 01/02/2012 03:27 PM, Terry Fryar wrote:
>     printk("<1>irqdrv: BASEPRIOR: %d  CURPRIOR: %d  EXECTIME: %ld  MODESW:
> %d  CTXSW:
> %d",info.bprio,info.cprio,info.exectime,info.modeswitches,info.ctxswitches);

exectime is a 64 bits variable, so, EXECTIME should use %lld or %Ld

-- 
					    Gilles.

