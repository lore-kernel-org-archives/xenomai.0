Resent-To: Xenomai help <Xenomai-help@domain.hid>
Resent-Message-Id: <4A9C1C7B.10907@domain.hid>
Message-ID: <4A9C1B11.70101@domain.hid>
Date: Mon, 31 Aug 2009 20:48:49 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <7a15153d0908281050l56343b26g45a8f66b87c839e9@domain.hid>	
	<4A981B54.4020908@domain.hid> <4A981C1E.8000904@domain.hid>	
	<7a15153d0908281209i5b133c53l4fa816993df7d0eb@domain.hid>	
	<4A982D08.4050802@domain.hid>	
	<7a15153d0908310753s68f36dffg817df3cb9a16db06@domain.hid>	
	<4A9BE7CF.3030406@domain.hid>
	<7a15153d0908311135o753de66ex90f835f14c506e9b@domain.hid>
In-Reply-To: <7a15153d0908311135o753de66ex90f835f14c506e9b@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [Xenomai-core] [PXA + Xenomai] Latency program
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Felipe Castro <felipecpc1@domain.hid>

Felipe Castro wrote:
> Ok i got ,
> 
> When i tried to run latency with 3 ms, it works but i received the message
> [149.437671] Xenomai: Switching display-321 to secondary modo after
> exception #5 from user-spcae at 0x9588 (pid 232)

You have compiled latency with FPU support. Contarily to what I told
you, it can not work. You MUST compile real-time applications with
-msoft-float.


-- 
					    Gilles.


