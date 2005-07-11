Message-ID: <42D28B92.8050800@domain.hid>
Date: Mon, 11 Jul 2005 09:09:06 -0600
From: Jim Cromie <jcromie@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] loadable adeos module
References: <20050711062341.66344.qmail@domain.hid>
In-Reply-To: <20050711062341.66344.qmail@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: chatchai nanudorn <chatchai_tdm@domain.hid>
Cc: adeos-main@gna.org

chatchai nanudorn wrote:

>Hi 
>I 'm trying to build RTAI on FC3 for EMC2
>(linuxcnc.org).
>EMC2 ues laodable adeos, and follow by rtai module. I
>have build rtai and ran testsuit but I never got
>loadable 
>adeos modules (I got adeos.o, which can't be loaded
>with insmod). How to compliled for loadable adeos.ko?
>Thank for all help.
>Regard
>Chatchai 
>  
>
adeos is a patch to the kernel, and is built as a normal part of its 
build process.

[jimc@domain.hid linux-2.6.12-ska12c3]$ grep ADEOS .config
CONFIG_ADEOS=y
CONFIG_ADEOS_CORE=y
CONFIG_ADEOS_THREADS=y
# CONFIG_ADEOS_NOTHREADS is not set
CONFIG_ADEOS_PROFILING=y
# CONFIG_ADEOS_PREEMPT_RT is not set

If I change the 1st line to 'm', Id get the adeos.ko module that you seek.

