Message-ID: <4E173093.1070309@domain.hid>
Date: Fri, 08 Jul 2011 18:30:11 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4E1722AB.3030900@domain.hid>
In-Reply-To: <4E1722AB.3030900@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Install xenomai with vxWorks Skin on Ubuntu 11.04
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Binh An Tran <tranb@domain.hid>
Cc: xenomai@xenomai.org

On 07/08/2011 05:30 PM, Binh An Tran wrote:
> i am new to Xenomai so please forgive me if my question is silly
> 
> i have installed xenomai 2.4.8 in my ubuntu 11.04 with the command
> 
>      apt-get install libxenomai-dev
> 
> Now i want test a simple vxWorks program, but when i compile my program, 
> i receive this message
> 
>      Xenomai: vxworks skin or CONFIG_XENO_OPT_PERVASIVE disabled
>      (modprobe xeno_vxworks?)
> 
> and output of modprobe xeno_vxworks is
> 
>      FATAL: Module xeno_vxworks not found
> 
> My question is, how can i eanble xeno_vxworks module ?

You need to patch and recompile a kernel. See:
http://www.xenomai.org/index.php/Building_Debian_packages

-- 
					    Gilles.

