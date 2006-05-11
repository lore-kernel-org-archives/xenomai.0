Message-ID: <44632068.50105@domain.hid>
Date: Thu, 11 May 2006 13:30:48 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Kernel panic on rmmod xeno_vxworks
References: <200605102227.09892.niklaus.giger@domain.hid>	<17506.23072.289428.72701@domain.hid>
	<200605111315.19638.niklaus.giger@domain.hid>
In-Reply-To: <200605111315.19638.niklaus.giger@domain.hid>
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
To: niklaus.giger@domain.hid
Cc: xenomai-core <xenomai@xenomai.org>

Niklaus Giger wrote:

> Please apply the following patch:
> Index: ksrc/skins/vxworks/demos/satch.c
> ===================================================================
> --- ksrc/skins/vxworks/demos/satch.c    (Revision 1068)
> +++ ksrc/skins/vxworks/demos/satch.c    (Arbeitskopie)
> @@ -21,10 +21,10 @@
>  #include <vxworks/vxworks.h>
> 
>  #define CONSUMER_TASK_PRI    115
> -#define CONSUMER_STACK_SIZE  8192
> +#define CONSUMER_STACK_SIZE  24*1024
> 
>  #define PRODUCER_TASK_PRI    110
> -#define PRODUCER_STACK_SIZE  8192
> +#define PRODUCER_STACK_SIZE  24*1024
> 
>  #define CONSUMER_WAIT 150
>  #define PRODUCER_TRIG 40
> 

Applied, thanks.

-- 

Philippe.

