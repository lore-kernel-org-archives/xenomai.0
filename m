Message-ID: <42D33650.7000005@domain.hid>
Date: Mon, 11 Jul 2005 21:17:36 -0600
From: Jim Cromie <jcromie@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] loadable adeos module
References: <20050712024731.72790.qmail@domain.hid>
In-Reply-To: <20050712024731.72790.qmail@domain.hid>
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

>Hi Jim Cromie 
>
>Umm, I try what you suggest but I got complie error
>when I change 
>adeos suppport to "m".
>I would like to ask you what .o different .ko , I
>don't understand it, and 
>Can I use "insmod" with adeos.o (I have tried, but
>failed)
>Thank and regard
>Chatchai
>Thailand
>
>  
>
.ko is a 2.6 kernel object, ie a module.
it differs from .o by having been linked with the kernel module
interfacing routines that support module_init, module_exit, etc.

did you run make xconfig, and change it that way ?
followed by make ?
doing this is proper way to care for dependencies. (I dont think there 
are any, but..)

you should use modprobe rather than insmod,
it knows the dependencies, and knows where modules are installed.
insmod fullpath/to/adeos.ko works when its not installed yet,
provided it matches the running kernel.

you should explain precisely what youve tried
(w suitably edited copy-paste), or I can only guess.

